import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

/// Where the artwork diary keeps its photos: a private folder on the device.
///
/// Photos are addressed by a bare file name (never a path), so what the
/// diary stores stays valid if the app's folder moves. Nothing here reads the
/// network.
abstract interface class ArtworkPhotoStore {
  /// Keeps [bytes] and returns the file name they were saved under.
  Future<String> save(Uint8List bytes);

  /// The bytes saved under [name], or `null` when there is no such photo
  /// (never saved, deleted, or a name that is not a safe file name).
  Future<Uint8List?> read(String name);

  /// Deletes the photo; a missing one is ignored.
  Future<void> delete(String name);
}

/// Whether [name] is a bare, safe file name the store may touch: letters,
/// digits, dots, dashes and underscores, not starting with a dot. Anything
/// else (a path, `..`) is refused, so a name from a restored backup can never
/// point outside the folder.
bool isSafePhotoName(String name) =>
    RegExp(r'^[A-Za-z0-9][A-Za-z0-9._-]{0,127}$').hasMatch(name) &&
    !name.contains('..');

/// The extension for [bytes]: `png` for a PNG file, `jpg` otherwise.
String photoExtension(Uint8List bytes) =>
    bytes.length > 4 &&
        bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47
    ? 'png'
    : 'jpg';

String _newPhotoName(Uint8List bytes, Random random) {
  final String time = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
  final String salt = random.nextInt(1 << 31).toRadixString(36);
  return '$time-$salt.${photoExtension(bytes)}';
}

/// [ArtworkPhotoStore] on a folder of the file system.
///
/// The app wires it to `artworks/` inside the private documents directory;
/// tests give it a temporary folder. The folder is created on the first save.
final class DirectoryArtworkPhotoStore implements ArtworkPhotoStore {
  DirectoryArtworkPhotoStore(this._directory, {Random? random})
    : _random = random ?? Random.secure();

  /// Resolves the folder (the documents directory is only known
  /// asynchronously).
  final FutureOr<Directory> Function() _directory;
  final Random _random;

  Future<File> _file(String name) async =>
      File('${(await _directory()).path}${Platform.pathSeparator}$name');

  @override
  Future<String> save(Uint8List bytes) async {
    final Directory directory = await _directory();
    await directory.create(recursive: true);
    final String name = _newPhotoName(bytes, _random);
    await File('${directory.path}${Platform.pathSeparator}$name')
        .writeAsBytes(bytes, flush: true);
    return name;
  }

  @override
  Future<Uint8List?> read(String name) async {
    if (!isSafePhotoName(name)) return null;
    try {
      final File file = await _file(name);
      if (!await file.exists()) return null;
      return await file.readAsBytes();
    } on FileSystemException {
      return null;
    }
  }

  @override
  Future<void> delete(String name) async {
    if (!isSafePhotoName(name)) return;
    try {
      final File file = await _file(name);
      if (await file.exists()) await file.delete();
    } on FileSystemException {
      // Best effort: a file that cannot be removed is not worth failing for.
    }
  }
}

/// [ArtworkPhotoStore] in memory, for tests and previews.
final class InMemoryArtworkPhotoStore implements ArtworkPhotoStore {
  InMemoryArtworkPhotoStore({Random? random}) : _random = random ?? Random();

  final Random _random;
  final Map<String, Uint8List> _files = <String, Uint8List>{};

  /// The names currently stored.
  Set<String> get names => _files.keys.toSet();

  /// Puts a photo under an exact [name] (for tests that seed an entry).
  void put(String name, Uint8List bytes) => _files[name] = bytes;

  @override
  Future<String> save(Uint8List bytes) async {
    final String name = _newPhotoName(bytes, _random);
    _files[name] = Uint8List.fromList(bytes);
    return name;
  }

  @override
  Future<Uint8List?> read(String name) async =>
      isSafePhotoName(name) ? _files[name] : null;

  @override
  Future<void> delete(String name) async {
    if (isSafePhotoName(name)) _files.remove(name);
  }
}
