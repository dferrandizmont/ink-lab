import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';

import '../core/app_version.dart';
import '../core/models.dart';
import 'artwork_photo_store.dart';
import 'backup_service.dart';
import 'data_exceptions.dart';

/// Export and import of the user data as a ZIP file that carries the artwork
/// diary photos with it.
///
/// The archive holds three kinds of entry:
///
/// - `manifest.json`: the format id, the format version, the app version and
///   the number of photos;
/// - `backup.json`: exactly the document [BackupService.exportJson] writes,
///   the same one the clipboard backup carries;
/// - `photos/<name>`: the photos the diary entries refer to, under the names
///   they have on the device.
///
/// An archive that comes from outside is hostile until it is checked: every
/// entry name, every size and every byte is checked before anything is
/// written, so an archive that is refused leaves the data the user has
/// exactly as it was, photos included. The photos are written before the
/// document, and undone when one of them fails, so an import is never half
/// done.
final class BackupArchiveService {
  BackupArchiveService({
    required this.backup,
    required this.photos,
    this.maxArchiveBytes = defaultMaxArchiveBytes,
    this.maxEntryBytes = defaultMaxEntryBytes,
    this.maxTotalBytes = defaultMaxTotalBytes,
    this.maxEntries = defaultMaxEntries,
  });

  /// The backup document the archive carries.
  final BackupService backup;

  /// Where the diary photos live.
  final ArtworkPhotoStore photos;

  /// The biggest archive the app reads, in bytes.
  ///
  /// The archive holds the backup document and the photos of the diary, and
  /// photos do not compress; a bigger file than this is refused instead of
  /// read, so a hostile file cannot make the app walk an unbounded amount of
  /// data.
  final int maxArchiveBytes;

  /// The biggest single entry the app reads, uncompressed, in bytes.
  ///
  /// A photo taken with a phone camera is a few megabytes; this leaves room
  /// for a very big one and refuses the rest.
  final int maxEntryBytes;

  /// The biggest total of uncompressed entries the app reads, in bytes.
  ///
  /// This is what a ZIP bomb runs into: the file is small, but what it holds
  /// is not.
  final int maxTotalBytes;

  /// The most entries the app reads.
  ///
  /// A diary holds a handful of photos; the limit is far above what the app
  /// writes and bounds what a hostile file can make it walk.
  final int maxEntries;

  /// The default of [maxArchiveBytes]: 100 MB.
  ///
  /// The archive and what is unpacked from it are in memory together, so the
  /// limit is kept low enough for a phone that is short of it.
  static const int defaultMaxArchiveBytes = 100 * 1024 * 1024;

  /// The default of [maxEntryBytes]: 32 MB.
  static const int defaultMaxEntryBytes = 32 * 1024 * 1024;

  /// The default of [maxTotalBytes]: 100 MB.
  static const int defaultMaxTotalBytes = 100 * 1024 * 1024;

  /// The default of [maxEntries]: 2000.
  static const int defaultMaxEntries = 2000;

  /// The id the manifest carries: this is an Ink Lab backup archive.
  static const String formatId = 'ink-lab-backup';

  /// The version of the archive format this build reads and writes.
  static const int formatVersion = 1;

  /// The name of the manifest entry.
  static const String manifestEntryName = 'manifest.json';

  /// The name of the backup document entry.
  static const String backupEntryName = 'backup.json';

  /// The folder the photo entries live in.
  static const String photosFolder = 'photos';

  /// The archive with the backup document, the diary photos and a manifest.
  ///
  /// The photos are the ones the diary entries refer to and that are still on
  /// the device: a photo whose file is missing is left out, so the archive is
  /// the diary as it really is.
  ///
  /// Throws a [BackupArchiveException] when the diary holds more photos than
  /// an archive may carry: an archive this build cannot read back is not
  /// worth writing.
  Future<Uint8List> exportArchive() async {
    final Map<String, Uint8List> diaryPhotos = await _readDiaryPhotos();
    final String document = backup.exportJson();
    if (document.length > BackupService.maxDocumentLength) {
      throw BackupArchiveException(
        'the data makes a document of ${document.length} characters, more '
        'than the ${BackupService.maxDocumentLength} a backup carries',
        reason: BackupArchiveReason.tooLarge,
      );
    }
    final int total = diaryPhotos.values.fold<int>(
      document.length,
      (int sum, Uint8List bytes) => sum + bytes.length,
    );
    for (final MapEntry<String, Uint8List> photo in diaryPhotos.entries) {
      if (photo.value.length > maxEntryBytes) {
        throw BackupArchiveException(
          'the photo "${photo.key}" is ${photo.value.length} bytes, more than '
          'the $maxEntryBytes an archive carries',
          reason: BackupArchiveReason.entryTooLarge,
          field: photo.key,
        );
      }
    }
    if (total > maxTotalBytes) {
      throw BackupArchiveException(
        'the diary holds $total bytes of photos, more than the '
        '$maxTotalBytes an archive carries',
        reason: BackupArchiveReason.tooLarge,
      );
    }

    final Archive archive = Archive()
      ..addFile(
        ArchiveFile.string(
          manifestEntryName,
          _manifestJson(diaryPhotos.length),
        ),
      )
      ..addFile(ArchiveFile.string(backupEntryName, document));
    for (final MapEntry<String, Uint8List> photo in diaryPhotos.entries) {
      archive.addFile(
        ArchiveFile.bytes('$photosFolder/${photo.key}', photo.value),
      );
    }
    final Uint8List encoded = ZipEncoder().encodeBytes(archive);
    if (encoded.length > maxArchiveBytes) {
      throw BackupArchiveException(
        'the archive is ${encoded.length} bytes, more than the '
        '$maxArchiveBytes this build reads',
        reason: BackupArchiveReason.tooLarge,
      );
    }
    return encoded;
  }

  /// Restores the data of [bytes], the diary photos included.
  ///
  /// The whole archive is read and checked before anything is written: an
  /// archive that is refused leaves the data the user has exactly as it was.
  /// The photos are written first and undone when one of them fails, so the
  /// document is only imported once every photo is in place.
  ///
  /// The photos of the entries that the import replaces are deleted, the same
  /// way the clipboard import deletes them. When the document cannot be
  /// imported after the photos were written, the photos are put back as they
  /// were and the error is thrown again.
  ///
  /// Throws a [BackupArchiveException] for anything that is not a readable
  /// archive of this format.
  Future<void> importArchive(Uint8List bytes) async {
    final _ArchiveContents contents = _readArchive(bytes);
    final Set<String>? wanted = _readDocument(contents.backupJson);
    final _WrittenPhotos written = await _writePhotos(
      _photosToWrite(contents.photos, wanted),
    );
    try {
      await backup.importJson(contents.backupJson);
    } catch (_) {
      // The document is not atomic and may have failed half way, but the
      // photos this import wrote must not be left behind.
      await _undoPhotos(written);
      rethrow;
    }
  }

  /// The photos of the diary entries, of the blending recipes and of the
  /// markers that are still on the device, by name.
  ///
  /// A photo that is missing, or whose name is not safe, is left out.
  Future<Map<String, Uint8List>> _readDiaryPhotos() async {
    final Map<String, Uint8List> found = <String, Uint8List>{};
    final List<String> names = <String>[
      for (final ArtworkEntry entry in backup.artworkDiary.entries)
        ...entry.photos,
      // The blending recipes keep their photo in the same folder.
      for (final BlendRecipe recipe
          in backup.recipes?.recipes ?? const <BlendRecipe>[])
        ?recipe.photo,
      // The swatch photos of the markers travel in the same folder.
      ...?backup.markerExtras?.photoNames.values,
    ];
    for (final String name in names) {
      if (!isSafePhotoName(name) || found.containsKey(name)) continue;
      final Uint8List? bytes = await photos.read(name);
      if (bytes == null) continue;
      found[name] = bytes;
    }
    return found;
  }

  /// The manifest of the archive: a small JSON object with the format id, the
  /// format version, the app version and the number of photos.
  String _manifestJson(int photoCount) => jsonEncode(<String, Object>{
    'format': formatId,
    'version': formatVersion,
    'appVersion': appVersion,
    'photos': photoCount,
  });

  /// Reads the archive and checks it whole.
  ///
  /// Nothing is written here: an archive that does not pass leaves the data
  /// the user has alone.
  _ArchiveContents _readArchive(Uint8List bytes) {
    if (bytes.length > maxArchiveBytes) {
      throw BackupArchiveException(
        'the archive is ${bytes.length} bytes, more than the $maxArchiveBytes '
        'this build reads',
        reason: BackupArchiveReason.tooLarge,
      );
    }
    if (!_looksLikeZip(bytes)) {
      throw const BackupArchiveException(
        'the file is not a ZIP archive',
        reason: BackupArchiveReason.notAnArchive,
      );
    }

    // The central directory is read first, and every header is checked before
    // a single byte of an entry is unpacked: the package would unpack a
    // symbolic link as soon as the archive is decoded, and what it declares
    // is not to be trusted.
    final ZipDirectory directory = ZipDirectory();
    try {
      directory.read(InputMemoryStream(bytes));
    } on ArchiveException catch (error) {
      throw BackupArchiveException(
        'the file is not a readable ZIP archive: ${error.message}',
        reason: BackupArchiveReason.notAnArchive,
      );
    } on FormatException {
      throw const BackupArchiveException(
        'the file is not a readable ZIP archive',
        reason: BackupArchiveReason.notAnArchive,
      );
    } on RangeError {
      throw const BackupArchiveException(
        'the file is not a readable ZIP archive',
        reason: BackupArchiveReason.notAnArchive,
      );
    }

    final List<ZipFileHeader> headers = directory.fileHeaders;
    if (headers.length > maxEntries) {
      throw BackupArchiveException(
        'the archive holds ${headers.length} entries, more than the '
        '$maxEntries this build reads',
        reason: BackupArchiveReason.tooManyEntries,
      );
    }

    final Set<String> seen = <String>{};
    int declared = 0;
    for (final ZipFileHeader header in headers) {
      final String name = header.filename;
      if (!seen.add(name)) {
        throw BackupArchiveException(
          'the archive holds "$name" twice',
          reason: BackupArchiveReason.duplicateEntry,
          field: name,
        );
      }
      if (!_isAllowedName(name)) {
        throw BackupArchiveException(
          'the archive holds an entry this build does not accept: "$name"',
          reason: BackupArchiveReason.badEntryName,
          field: name,
        );
      }
      if (!_isRegularFile(header)) {
        throw BackupArchiveException(
          'the entry "$name" is a link or another kind of file this build '
          'does not accept',
          reason: BackupArchiveReason.badEntryName,
          field: name,
        );
      }
      // The size the archive declares is checked before anything is read, so
      // a file that holds far more than it says is never unpacked.
      if (header.uncompressedSize > maxEntryBytes) {
        throw BackupArchiveException(
          '"$name" holds ${header.uncompressedSize} bytes uncompressed, more '
          'than the $maxEntryBytes this build reads',
          reason: BackupArchiveReason.entryTooLarge,
          field: name,
        );
      }
      declared += header.uncompressedSize;
      if (declared > maxTotalBytes) {
        throw BackupArchiveException(
          'the archive holds more than the $maxTotalBytes this build reads',
          reason: BackupArchiveReason.tooLarge,
        );
      }
    }

    final Map<String, Uint8List> contents = _readContents(headers);
    final Uint8List? manifestBytes = contents[manifestEntryName];
    if (manifestBytes == null) {
      throw const BackupArchiveException(
        'the archive does not carry a manifest',
        reason: BackupArchiveReason.unsupportedFormat,
        field: manifestEntryName,
      );
    }
    _readManifest(manifestBytes);
    _checkPhotos(contents);
    return _ArchiveContents(
      backupJson: _readBackupDocument(contents),
      photos: _photosIn(contents),
    );
  }

  /// The bytes of every entry of the archive, checked as they are read.
  ///
  /// The size of what comes out is checked against the limits too, and not
  /// only the size the archive declares: what is really there is what counts.
  ///
  /// The name in the local header of an entry has to be the one the central
  /// directory gave it, the one that was checked: otherwise an entry could
  /// pass the checks as one file and be read as another. The entries are read
  /// straight from their headers, so the package keeps no second copy of what
  /// it unpacks.
  Map<String, Uint8List> _readContents(List<ZipFileHeader> headers) {
    final Map<String, Uint8List> contents = <String, Uint8List>{};
    int total = 0;
    for (final ZipFileHeader header in headers) {
      final String name = header.filename;
      final ZipFile? file = header.file;
      if (file == null || file.filename != name) {
        throw BackupArchiveException(
          'the entry "$name" is not the one its header names',
          reason: BackupArchiveReason.badEntryName,
          field: name,
        );
      }
      final Uint8List data;
      try {
        data = file.getStream().toUint8List();
      } on ArchiveException catch (error) {
        throw BackupArchiveException(
          'the entry "$name" could not be read: ${error.message}',
          reason: BackupArchiveReason.notAnArchive,
          field: name,
        );
      } on FormatException {
        throw BackupArchiveException(
          'the entry "$name" could not be read',
          reason: BackupArchiveReason.notAnArchive,
          field: name,
        );
      } on RangeError {
        throw BackupArchiveException(
          'the entry "$name" could not be read',
          reason: BackupArchiveReason.notAnArchive,
          field: name,
        );
      }
      if (data.length > maxEntryBytes) {
        throw BackupArchiveException(
          '"$name" holds ${data.length} bytes, more than the '
          '$maxEntryBytes this build reads',
          reason: BackupArchiveReason.entryTooLarge,
          field: name,
        );
      }
      total += data.length;
      if (total > maxTotalBytes) {
        throw BackupArchiveException(
          'the archive holds more than the $maxTotalBytes this build reads',
          reason: BackupArchiveReason.tooLarge,
        );
      }
      contents[name] = data;
    }
    return contents;
  }

  /// Whether the entry of [header] is a plain file.
  ///
  /// A ZIP file made on a Unix system carries the file type in the upper half
  /// of the external attributes: a symbolic link, a pipe or a device is not
  /// something this build restores. A link is refused whatever system the
  /// archive says it was made on.
  bool _isRegularFile(ZipFileHeader header) {
    final int type = (header.externalFileAttributes >> 16) & 0xF000;
    if (type == _unixSymbolicLink) return false;
    final bool madeOnUnix = (header.versionMadeBy >> 8) == _unixCreator;
    if (!madeOnUnix) return true;
    return type == 0 || type == _unixRegularFile;
  }

  /// Whether [name] is one of the entries this build reads.
  bool _isAllowedName(String name) {
    if (name == manifestEntryName || name == backupEntryName) return true;
    if (!name.startsWith('$photosFolder/')) return false;
    return isSafePhotoName(name.substring(photosFolder.length + 1));
  }

  /// The manifest of the archive, checked.
  void _readManifest(Uint8List bytes) {
    final Object? decoded;
    try {
      decoded = jsonDecode(utf8.decode(bytes));
    } on FormatException {
      throw const BackupArchiveException(
        'the manifest is not readable',
        reason: BackupArchiveReason.unsupportedFormat,
        field: manifestEntryName,
      );
    }
    if (decoded is! Map) {
      throw const BackupArchiveException(
        'the manifest is not an object',
        reason: BackupArchiveReason.unsupportedFormat,
        field: manifestEntryName,
      );
    }
    final Map<String, dynamic> manifest = decoded.cast<String, dynamic>();
    if (manifest['format'] != formatId) {
      throw BackupArchiveException(
        'the archive is not an Ink Lab backup (its format is '
        '"${manifest['format']}")',
        reason: BackupArchiveReason.unsupportedFormat,
        field: manifestEntryName,
      );
    }
    final Object? version = manifest['version'];
    if (version is! int || version != formatVersion) {
      throw BackupArchiveException(
        'the archive format version $version is not one this build reads '
        '(it reads $formatVersion)',
        reason: BackupArchiveReason.unsupportedFormat,
        field: manifestEntryName,
      );
    }
  }

  /// The backup document of the archive, as text.
  String _readBackupDocument(Map<String, Uint8List> contents) {
    final Uint8List? bytes = contents[backupEntryName];
    if (bytes == null) {
      throw const BackupArchiveException(
        'the archive does not carry a backup document',
        reason: BackupArchiveReason.unsupportedFormat,
        field: backupEntryName,
      );
    }
    try {
      return utf8.decode(bytes);
    } on FormatException {
      throw const BackupArchiveException(
        'the backup document is not readable text',
        reason: BackupArchiveReason.unsupportedFormat,
        field: backupEntryName,
      );
    }
  }

  /// The photo names the document's diary entries and swatch photos refer
  /// to.
  ///
  /// The whole document is read and checked, exactly as the clipboard import
  /// checks it, so a document that is refused is refused here too.
  Set<String>? _readDocument(String json) {
    try {
      return backup.readPhotoNames(json);
    } on BackupFormatException catch (error) {
      throw BackupArchiveException(
        'the backup document is not one this build reads: ${error.message}',
        reason: BackupArchiveReason.unsupportedFormat,
        field: backupEntryName,
      );
    }
  }

  /// The photos of the archive, by name.
  Map<String, Uint8List> _photosIn(Map<String, Uint8List> contents) {
    final Map<String, Uint8List> found = <String, Uint8List>{};
    for (final MapEntry<String, Uint8List> entry in contents.entries) {
      if (!entry.key.startsWith('$photosFolder/')) continue;
      found[entry.key.substring(photosFolder.length + 1)] = entry.value;
    }
    return found;
  }

  /// Every photo of the archive has to look like an image.
  void _checkPhotos(Map<String, Uint8List> contents) {
    for (final MapEntry<String, Uint8List> entry in contents.entries) {
      if (!entry.key.startsWith('$photosFolder/')) continue;
      if (_looksLikePhoto(entry.value)) continue;
      final String name = entry.key.substring(photosFolder.length + 1);
      throw BackupArchiveException(
        'the photo "$name" is not a JPEG, a PNG or a WebP',
        reason: BackupArchiveReason.notAPhoto,
        field: name,
      );
    }
  }

  /// The photos of the archive that the imported diary refers to.
  ///
  /// A photo no entry uses is left out: it would be an orphan on the device.
  Map<String, Uint8List> _photosToWrite(
    Map<String, Uint8List> archivePhotos,
    Set<String>? wanted,
  ) {
    if (wanted == null) return <String, Uint8List>{};
    final Map<String, Uint8List> toWrite = <String, Uint8List>{};
    for (final MapEntry<String, Uint8List> photo in archivePhotos.entries) {
      if (!wanted.contains(photo.key)) continue;
      toWrite[photo.key] = photo.value;
    }
    return toWrite;
  }

  /// Writes the photos of the archive, undoing them when one of them fails.
  ///
  /// A photo that cannot be written leaves the device as it was: the ones
  /// already written are put back as they were, and the ones that were new
  /// are removed again. What is returned is what it takes to undo the lot
  /// later.
  Future<_WrittenPhotos> _writePhotos(Map<String, Uint8List> toWrite) async {
    final _WrittenPhotos written = _WrittenPhotos();
    try {
      for (final MapEntry<String, Uint8List> photo in toWrite.entries) {
        written.before[photo.key] = await photos.read(photo.key);
        await photos.restore(photo.key, photo.value);
        written.names.add(photo.key);
      }
    } catch (error) {
      await _undoPhotos(written);
      throw BackupArchiveException(
        'the photos could not be written: $error',
        reason: BackupArchiveReason.writeFailed,
      );
    }
    return written;
  }

  /// Puts the photos in [written] back as they were: the ones that replaced
  /// a photo get it back, and the new ones are removed.
  ///
  /// Every photo is tried, even when one of them cannot be put back.
  Future<void> _undoPhotos(_WrittenPhotos written) async {
    for (final String name in written.names.reversed) {
      try {
        final Uint8List? previous = written.before[name];
        if (previous == null) {
          await photos.delete(name);
        } else {
          await photos.restore(name, previous);
        }
      } catch (_) {
        // Nothing more can be done for this one; the others still can.
      }
    }
  }
}

/// The photos an import has written, and what they replaced.
final class _WrittenPhotos {
  /// The names written, in the order they were written.
  final List<String> names = <String>[];

  /// What each name held before: `null` when there was no photo.
  final Map<String, Uint8List?> before = <String, Uint8List?>{};
}

/// What an archive holds, once it has been read and checked.
final class _ArchiveContents {
  const _ArchiveContents({required this.backupJson, required this.photos});

  final String backupJson;
  final Map<String, Uint8List> photos;
}

/// The creator system a Unix ZIP writer puts in the upper byte of the
/// "version made by" field.
const int _unixCreator = 3;

/// The file type bits, in the Unix mode, of a symbolic link.
const int _unixSymbolicLink = 0xA000;

/// The file type bits, in the Unix mode, of a regular file.
const int _unixRegularFile = 0x8000;

/// Whether [bytes] start like a ZIP file: the signature of a local file
/// header, which every archive with entries begins with.
bool _looksLikeZip(Uint8List bytes) =>
    bytes.length >= 4 &&
    bytes[0] == 0x50 &&
    bytes[1] == 0x4B &&
    bytes[2] == 0x03 &&
    bytes[3] == 0x04;

/// Whether [bytes] start like a JPEG, a PNG or a WebP image.
///
/// The app only ever puts photos in an archive, so an entry that is not an
/// image is refused instead of written to the photo folder.
bool _looksLikePhoto(Uint8List bytes) => looksLikePhotoBytes(bytes);
