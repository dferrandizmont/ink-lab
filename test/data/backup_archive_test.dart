import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/app_version.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';

import 'fixtures.dart';

/// Bytes that look like a JPEG, so the archive takes them for a photo.
Uint8List photoBytes([int length = 64]) => Uint8List.fromList(<int>[
  0xFF,
  0xD8,
  0xFF,
  0xE0,
  ...List<int>.filled(length, 0),
]);

/// A diary entry with the photos it refers to.
ArtworkEntry entry({
  String id = 'e1',
  String title = 'A painting',
  List<String> photos = const <String>[],
}) => ArtworkEntry(
  id: id,
  title: title,
  date: DateTime(2026, 10, 30),
  photos: photos,
  createdAtEpochMs: 1,
);

/// The archive of [entries], as a ZIP file.
Uint8List zipOf(Map<String, List<int>> entries) {
  final Archive archive = Archive();
  for (final MapEntry<String, List<int>> file in entries.entries) {
    archive.addFile(ArchiveFile.bytes(file.key, file.value));
  }
  return ZipEncoder().encodeBytes(archive);
}

/// The manifest of an archive.
String manifestJson({
  String format = BackupArchiveService.formatId,
  int version = BackupArchiveService.formatVersion,
  int photos = 1,
}) => jsonEncode(<String, Object>{
  'format': format,
  'version': version,
  'appVersion': appVersion,
  'photos': photos,
});

/// A backup document with one diary entry that refers to [photo].
String documentWith(String photo) => jsonEncode(<String, Object>{
  'version': 1,
  'artworkDiary': <Object>[
    <String, Object>{
      'id': 'e1',
      'title': 'A painting',
      'date': '2026-10-30',
      'photos': <String>[photo],
      'createdAtEpochMs': 1,
    },
  ],
});

/// An archive with a manifest, a backup document and one photo.
Uint8List archiveOf({
  String? manifest,
  String? document,
  Map<String, List<int>> photos = const <String, List<int>>{'a.jpg': _photo},
}) => zipOf(<String, List<int>>{
  'manifest.json': utf8.encode(manifest ?? manifestJson()),
  'backup.json': utf8.encode(document ?? documentWith('a.jpg')),
  for (final MapEntry<String, List<int>> photo in photos.entries)
    'photos/${photo.key}': photo.value,
});

/// The bytes of a photo, for the defaults above.
const List<int> _photo = <int>[0xFF, 0xD8, 0xFF];

/// The archive service of [h].
BackupArchiveService service(Harness h) =>
    BackupArchiveService(backup: h.backup(), photos: h.photos);

/// A matcher for the archives the app refuses.
Matcher refused(BackupArchiveReason reason) => throwsA(
  isA<BackupArchiveException>().having(
    (BackupArchiveException e) => e.reason,
    'reason',
    reason,
  ),
);

void main() {
  test(
    'ZIP preserves a migrated file diary and persists the restored diary',
    () async {
      final temp = Directory.systemTemp.createTempSync('ink_lab_backup_diary');
      addTearDown(() => temp.deleteSync(recursive: true));
      final sourceStorage = FileArtworkDiaryStorage(
        directory: () => Directory('${temp.path}/source'),
      );
      final source = await harness({
        StoredArtworkDiaryRepository.storageKey: jsonEncode([
          entry(photos: ['a.jpg']).toJson(),
        ]),
      }, sourceStorage);
      source.photos.put('a.jpg', photoBytes());
      expect(
        await source.store.containsKey(StoredArtworkDiaryRepository.storageKey),
        isFalse,
      );
      final archive = await service(source).exportArchive();
      final document = jsonDecode(
        utf8.decode(
          ZipDecoder().decodeBytes(archive).find('backup.json')!.content,
        ),
      ) as Map<String, dynamic>;
      final Map<String, dynamic> diary =
          (document['artworkDiary'] as List).single as Map<String, dynamic>;
      expect(diary['id'], 'e1');

      final targetStorage = FileArtworkDiaryStorage(
        directory: () => Directory('${temp.path}/target'),
      );
      final target = await harness(null, targetStorage);
      await service(target).importArchive(archive);
      final reloaded = StoredArtworkDiaryRepository(
        target.store,
        photos: target.photos,
        storage: targetStorage,
      );
      await reloaded.load();
      expect(reloaded.entries, source.artworkDiary.entries);
      expect(await reloaded.photoBytes('a.jpg'), photoBytes());
      expect(
        await target.store.containsKey(StoredArtworkDiaryRepository.storageKey),
        isFalse,
      );
    },
  );
  group('the backup archive', () {
    test('carries the document, the manifest and the diary photos', () async {
      final Harness source = await harness();
      await source.artworkDiary.save(entry(photos: <String>['a.jpg']));
      source.photos.put('a.jpg', photoBytes());

      final Uint8List archive = await service(source).exportArchive();
      final Archive read = ZipDecoder().decodeBytes(archive);
      expect(
        read.files.map((ArchiveFile f) => f.name),
        containsAll(<String>['manifest.json', 'backup.json', 'photos/a.jpg']),
      );

      final Map<String, dynamic> manifest = jsonDecode(
        utf8.decode(read.find('manifest.json')!.content),
      ) as Map<String, dynamic>;
      expect(manifest['format'], 'ink-lab-backup');
      expect(manifest['version'], 1);
      expect(manifest['appVersion'], appVersion);
      expect(manifest['photos'], 1);

      // The document inside is the one the clipboard backup carries.
      expect(
        utf8.decode(read.find('backup.json')!.content),
        source.backup().exportJson(),
      );
    });

    test('comes back with the diary and the photos', () async {
      final Harness source = await harness();
      await source.artworkDiary.save(entry(photos: <String>['a.jpg']));
      source.photos.put('a.jpg', photoBytes());
      final Uint8List archive = await service(source).exportArchive();

      final Harness target = await harness();
      await service(target).importArchive(archive);

      expect(target.artworkDiary.entries.single.id, 'e1');
      expect(target.artworkDiary.entries.single.photos, <String>['a.jpg']);
      expect(await target.photos.read('a.jpg'), photoBytes());
    });

    test('leaves out the photo whose file is missing', () async {
      final Harness source = await harness();
      await source.artworkDiary.save(
        entry(photos: <String>['a.jpg', 'gone.jpg']),
      );
      source.photos.put('a.jpg', photoBytes());

      final Uint8List archive = await service(source).exportArchive();
      final Archive read = ZipDecoder().decodeBytes(archive);
      expect(read.find('photos/a.jpg'), isNotNull);
      expect(read.find('photos/gone.jpg'), isNull);
    });

    test('deletes the photos of the entries it replaces', () async {
      final Harness source = await harness();
      await source.artworkDiary.save(entry(photos: <String>['a.jpg']));
      source.photos.put('a.jpg', photoBytes());
      final Uint8List archive = await service(source).exportArchive();

      final Harness target = await harness();
      await target.artworkDiary.save(
        entry(id: 'old', photos: <String>['o.jpg']),
      );
      target.photos.put('o.jpg', photoBytes());

      await service(target).importArchive(archive);
      expect(target.artworkDiary.entries.single.id, 'e1');
      expect(await target.photos.read('a.jpg'), photoBytes());
      expect(await target.photos.read('o.jpg'), isNull);
    });

    test('keeps the diary as it was when a photo cannot be written', () async {
      final Harness source = await harness();
      await source.artworkDiary.save(entry(photos: <String>['a.jpg', 'b.jpg']));
      source.photos.put('a.jpg', photoBytes());
      source.photos.put('b.jpg', photoBytes());
      final Uint8List archive = await service(source).exportArchive();

      final Harness target = await harness();
      await target.artworkDiary.save(
        entry(id: 'old', photos: <String>['o.jpg']),
      );
      target.photos.put('o.jpg', photoBytes());

      final BackupArchiveService failing = BackupArchiveService(
        backup: target.backup(),
        photos: RefusingPhotoStore(target.photos, <String>{'b.jpg'}),
      );
      await expectLater(
        failing.importArchive(archive),
        refused(BackupArchiveReason.writeFailed),
      );
      // Nothing was imported: the diary is as it was and so are the photos.
      expect(target.artworkDiary.entries.single.id, 'old');
      expect(target.photos.names, <String>{'o.jpg'});
    });

    test('puts the photos back when the document cannot be imported', () async {
      final Harness source = await harness();
      await source.artworkDiary.save(entry(photos: <String>['a.jpg', 'b.jpg']));
      source.photos.put('a.jpg', photoBytes(8));
      source.photos.put('b.jpg', photoBytes(8));
      final Uint8List archive = await service(source).exportArchive();

      final Harness target = await harness();
      // The photo 'a.jpg' exists with other bytes, and must come back as it
      // was; 'b.jpg' is new, and must go.
      final Uint8List mine = photoBytes(3);
      target.photos.put('a.jpg', mine);
      final StoredArtworkDiaryRepository failingDiary =
          StoredArtworkDiaryRepository(
            target.store,
            photos: target.photos,
            storage: RefusingDiaryStorage(),
          );
      await failingDiary.load();
      final BackupArchiveService failing = BackupArchiveService(
        backup: BackupService(
          appSettings: target.appSettings,
          savedPalettes: target.savedPalettes,
          history: target.history,
          aiSettings: target.aiSettings,
          ownColors: target.ownColors,
          wishlist: target.wishlist,
          dried: target.dried,
          artworkDiary: failingDiary,
          ideaFavorites: target.ideaFavorites,
        ),
        photos: target.photos,
      );
      await expectLater(failing.importArchive(archive), throwsA(anything));

      expect(await target.photos.read('a.jpg'), mine);
      expect(await target.photos.read('b.jpg'), isNull);
      expect(target.photos.names, <String>{'a.jpg'});
    });
  });

  group('the archive that is refused', () {
    test('a file that is not a ZIP', () async {
      final Harness h = await harness();
      await expectLater(
        service(h).importArchive(Uint8List.fromList(utf8.encode('not a zip'))),
        refused(BackupArchiveReason.notAnArchive),
      );
    });

    test('an archive bigger than the limit', () async {
      final Harness h = await harness();
      final BackupArchiveService small = BackupArchiveService(
        backup: h.backup(),
        photos: h.photos,
        maxArchiveBytes: 16,
      );
      await expectLater(
        small.importArchive(archiveOf()),
        refused(BackupArchiveReason.tooLarge),
      );
    });

    test('an archive with too many entries', () async {
      final Harness h = await harness();
      final BackupArchiveService few = BackupArchiveService(
        backup: h.backup(),
        photos: h.photos,
        maxEntries: 2,
      );
      await expectLater(
        few.importArchive(archiveOf()),
        refused(BackupArchiveReason.tooManyEntries),
      );
    });

    test('a ZIP bomb, before it is unpacked', () async {
      final Harness h = await harness();
      final Uint8List bomb = zipOf(<String, List<int>>{
        'manifest.json': utf8.encode(manifestJson()),
        'backup.json': utf8.encode(documentWith('bomb.jpg')),
        'photos/bomb.jpg': Uint8List(40 * 1024 * 1024),
      });
      // The file is tiny; what it holds is not.
      expect(bomb.length, lessThan(1024 * 1024));
      await expectLater(
        service(h).importArchive(bomb),
        refused(BackupArchiveReason.entryTooLarge),
      );
    });

    test('a link or another special file, before it is unpacked', () async {
      final Harness h = await harness();
      final Uint8List plain = zipOf(<String, List<int>>{
        'manifest.json': utf8.encode(manifestJson()),
        'backup.json': utf8.encode(documentWith('a.jpg')),
        // 20 MB of zeros: small once packed, big when it is unpacked.
        'photos/a.jpg': Uint8List(20 * 1024 * 1024),
      });
      expect(plain.length, lessThan(1024 * 1024));
      for (final int mode in <int>[0xA1FF, 0x41ED, 0x11A4, 0x21A4, 0x61A4]) {
        final Uint8List archive = markUnix(plain, 'photos/a.jpg', mode);
        await expectLater(
          service(h).importArchive(archive),
          refused(BackupArchiveReason.badEntryName),
          reason: 'mode ${mode.toRadixString(16)} should be refused',
        );
      }
    });

    test('a link is never unpacked, not even to be refused', () async {
      final Harness h = await harness();
      final Uint8List plain = zipOf(<String, List<int>>{
        'manifest.json': utf8.encode(manifestJson()),
        'backup.json': utf8.encode(documentWith('a.jpg')),
        'photos/a.jpg': Uint8List(1024 * 1024),
      });
      // The packed bytes of the entry are broken: unpacking them would end in
      // a different refusal (an unreadable archive), so being refused as a
      // link proves nothing was unpacked.
      final Uint8List broken = breakData(plain, 'photos/a.jpg');
      await expectLater(
        service(h).importArchive(broken),
        refused(BackupArchiveReason.notAnArchive),
      );
      await expectLater(
        service(h).importArchive(markUnix(broken, 'photos/a.jpg', 0xA1FF)),
        refused(BackupArchiveReason.badEntryName),
      );
    });

    test('a regular file made on a Unix system is accepted', () async {
      final Harness h = await harness();
      final Uint8List archive = markUnix(archiveOf(), 'photos/a.jpg', 0x81A4);
      await service(h).importArchive(archive);
      expect(await h.photos.read('a.jpg'), isNotNull);
    });

    test('an entry whose local name is not the one that was checked', () async {
      final Harness h = await harness();
      final Uint8List plain = zipOf(<String, List<int>>{
        'manifest.json': utf8.encode(manifestJson()),
        'backup.json': utf8.encode(documentWith('a.jpg')),
        'photos/a.jpg': photoBytes(),
        'photos/b.jpg': photoBytes(),
      });
      // Only the local header is changed, so the central directory, which is
      // what the checks read, still names the entry 'photos/b.jpg'.
      for (final String name in <String>['photos/c.jpg', 'photos/a.jpg']) {
        await expectLater(
          service(h)
              .importArchive(renameLocalEntry(plain, 'photos/b.jpg', name)),
          refused(BackupArchiveReason.badEntryName),
          reason: 'a local header named "$name" should be refused',
        );
      }
      expect(h.photos.names, isEmpty);
    });

    test('an entry name that points outside the folder', () async {
      final Harness h = await harness();
      for (final String name in <String>[
        'photos/../evil.jpg',
        'photos/./evil.jpg',
        '/etc/passwd',
        'evil.jpg',
        'photos/',
        'photos',
        'photos/sub/evil.jpg',
      ]) {
        final Uint8List archive = zipOf(<String, List<int>>{
          'manifest.json': utf8.encode(manifestJson()),
          'backup.json': utf8.encode(documentWith('a.jpg')),
          name: photoBytes(),
        });
        await expectLater(
          service(h).importArchive(archive),
          refused(BackupArchiveReason.badEntryName),
          reason: 'the entry "$name" should be refused',
        );
      }
    });

    test('an entry name with a backslash', () async {
      final Harness h = await harness();
      // The ZIP writer turns a backslash into a slash, so the name is put
      // back the way a hostile file would have it.
      final Uint8List archive = renameEntry(
        zipOf(<String, List<int>>{
          'manifest.json': utf8.encode(manifestJson()),
          'backup.json': utf8.encode(documentWith('a.jpg')),
          'photos/a.jpg': photoBytes(),
        }),
        'photos/a.jpg',
        r'photos\a.jpg',
      );
      await expectLater(
        service(h).importArchive(archive),
        refused(BackupArchiveReason.badEntryName),
      );
    });

    test('the same entry twice', () async {
      final Harness h = await harness();
      final Uint8List archive = renameEntry(
        zipOf(<String, List<int>>{
          'manifest.json': utf8.encode(manifestJson()),
          'backup.json': utf8.encode(documentWith('a.jpg')),
          'photos/a.jpg': photoBytes(),
          'photos/b.jpg': photoBytes(),
        }),
        'photos/b.jpg',
        'photos/a.jpg',
      );
      await expectLater(
        service(h).importArchive(archive),
        refused(BackupArchiveReason.duplicateEntry),
      );
    });

    test('a photo that is not an image', () async {
      final Harness h = await harness();
      final Uint8List archive = archiveOf(
        photos: <String, List<int>>{
          'a.jpg': utf8.encode('this is not a photo'),
        },
      );
      await expectLater(
        service(h).importArchive(archive),
        refused(BackupArchiveReason.notAPhoto),
      );
    });

    test('a manifest of another version', () async {
      final Harness h = await harness();
      await expectLater(
        service(h).importArchive(archiveOf(manifest: manifestJson(version: 2))),
        refused(BackupArchiveReason.unsupportedFormat),
      );
    });

    test('a manifest of another format', () async {
      final Harness h = await harness();
      await expectLater(
        service(h).importArchive(
          archiveOf(manifest: manifestJson(format: 'somebody-else')),
        ),
        refused(BackupArchiveReason.unsupportedFormat),
      );
    });

    test('an archive without a manifest', () async {
      final Harness h = await harness();
      final Uint8List archive = zipOf(<String, List<int>>{
        'backup.json': utf8.encode(documentWith('a.jpg')),
        'photos/a.jpg': photoBytes(),
      });
      await expectLater(
        service(h).importArchive(archive),
        refused(BackupArchiveReason.unsupportedFormat),
      );
    });

    test('a document this build does not read', () async {
      final Harness h = await harness();
      await h.artworkDiary.save(entry(id: 'old', photos: <String>['o.jpg']));
      h.photos.put('o.jpg', photoBytes());

      await expectLater(
        service(h).importArchive(archiveOf(document: '{"version": 99}')),
        refused(BackupArchiveReason.unsupportedFormat),
      );
      // Nothing was written: the diary and the photos are as they were.
      expect(h.artworkDiary.entries.single.id, 'old');
      expect(h.photos.names, <String>{'o.jpg'});
    });
  });

  test('the clipboard JSON still imports', () async {
    final Harness source = await harness();
    await source.savedPalettes.save(palette(id: 'p1'));
    await source.artworkDiary.save(entry(id: 'd1', title: 'Forest page'));
    final String json = source.backup().exportJson();

    final Harness target = await harness();
    await target.backup().importJson(json);
    expect(target.savedPalettes.palettesOf(MarkerBrand.ohuhuOahu), isNotEmpty);
    expect(target.artworkDiary.entries.single.title, 'Forest page');
  });
}

/// Copies [bytes] with every [from] replaced by [to], which must be as long.
Uint8List renameEntry(Uint8List bytes, String from, String to) {
  final List<int> needle = utf8.encode(from);
  final List<int> replacement = utf8.encode(to);
  expect(replacement, hasLength(needle.length));
  final Uint8List copy = Uint8List.fromList(bytes);
  for (int i = 0; i + needle.length <= copy.length; i++) {
    bool matches = true;
    for (int j = 0; j < needle.length; j++) {
      if (copy[i + j] != needle[j]) {
        matches = false;
        break;
      }
    }
    if (matches) copy.setRange(i, i + needle.length, replacement);
  }
  return copy;
}

/// Copies [bytes] with the first [from] replaced by [to], which must be as
/// long: the local header of an entry comes before its data and before the
/// central directory, so this renames the entry in the local header only.
Uint8List renameLocalEntry(Uint8List bytes, String from, String to) {
  final List<int> needle = utf8.encode(from);
  expect(utf8.encode(to), hasLength(needle.length));
  final Uint8List copy = Uint8List.fromList(bytes);
  final int at = indexOf(copy, needle);
  expect(at, greaterThan(0));
  copy.setRange(at, at + needle.length, utf8.encode(to));
  return copy;
}

/// Where [needle] first appears in [bytes], from [start]; -1 when it does not.
int indexOf(Uint8List bytes, List<int> needle, [int start = 0]) {
  for (int i = start; i + needle.length <= bytes.length; i++) {
    bool matches = true;
    for (int j = 0; j < needle.length; j++) {
      if (bytes[i + j] != needle[j]) {
        matches = false;
        break;
      }
    }
    if (matches) return i;
  }
  return -1;
}

/// Where the central directory header of the entry [name] starts.
int centralHeaderOf(Uint8List bytes, String name) {
  const List<int> signature = <int>[0x50, 0x4B, 0x01, 0x02];
  int at = indexOf(bytes, signature);
  while (at >= 0) {
    final int nameLength = bytes[at + 28] | (bytes[at + 29] << 8);
    final String found = utf8.decode(
      bytes.sublist(at + 46, at + 46 + nameLength),
    );
    if (found == name) return at;
    at = indexOf(bytes, signature, at + 4);
  }
  fail('no central directory header for $name');
}

/// Copies [bytes] with the entry [name] marked, in the central directory, as
/// made on a Unix system with the file mode [mode] (type and permissions).
Uint8List markUnix(Uint8List bytes, String name, int mode) {
  final Uint8List copy = Uint8List.fromList(bytes);
  final int at = centralHeaderOf(copy, name);
  // "Version made by": the upper byte is the system, 3 for Unix.
  copy[at + 5] = 3;
  // The external attributes: the mode in the upper 16 bits.
  copy[at + 38] = 0;
  copy[at + 39] = 0;
  copy[at + 40] = mode & 0xFF;
  copy[at + 41] = (mode >> 8) & 0xFF;
  return copy;
}

/// Copies [bytes] with the packed data of the entry [name] overwritten with
/// bytes no deflate stream can start with.
Uint8List breakData(Uint8List bytes, String name) {
  final Uint8List copy = Uint8List.fromList(bytes);
  final int at = centralHeaderOf(copy, name);
  final int packed =
      copy[at + 20] |
      (copy[at + 21] << 8) |
      (copy[at + 22] << 16) |
      (copy[at + 23] << 24);
  expect(packed, greaterThan(0));
  // The local header: 30 bytes, then the name, then the extra field.
  final int local =
      copy[at + 42] |
      (copy[at + 43] << 8) |
      (copy[at + 44] << 16) |
      (copy[at + 45] << 24);
  final int nameLength = copy[local + 26] | (copy[local + 27] << 8);
  final int extraLength = copy[local + 28] | (copy[local + 29] << 8);
  final int start = local + 30 + nameLength + extraLength;
  copy.fillRange(start, start + packed, 0xFF);
  return copy;
}

/// A diary document store that refuses writes, like a full disk.
final class RefusingDiaryStorage implements ArtworkDiaryStorage {
  @override
  Future<String?> read({bool backup = false}) async => null;

  @override
  Future<void> write(String json, {bool backup = false}) async {
    throw const FileSystemException('the disk is full');
  }
}

/// A photo store that refuses to write the photos whose name it was given.
final class RefusingPhotoStore implements ArtworkPhotoStore {
  RefusingPhotoStore(this.inner, this.failures);

  final ArtworkPhotoStore inner;
  final Set<String> failures;

  @override
  Future<String> save(Uint8List bytes) => inner.save(bytes);

  @override
  Future<Uint8List?> read(String name) => inner.read(name);

  @override
  Future<void> delete(String name) => inner.delete(name);

  @override
  Future<void> restore(String name, Uint8List bytes) async {
    if (failures.contains(name)) {
      throw FileSystemException('the disk is full', name);
    }
    await inner.restore(name, bytes);
  }
}
