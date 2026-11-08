import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Shared location for the diary document and its private photo folder.
Future<Directory> artworkDocumentsDirectory() =>
    getApplicationDocumentsDirectory();

/// Raw diary documents. Validation and recovery belong to the repository.
abstract interface class ArtworkDiaryStorage {
  Future<String?> read({bool backup = false});
  Future<void> write(String json, {bool backup = false});
}

/// Replaces documents atomically, without ever truncating the live file.
///
/// The blending recipes keep their own document in the same folder with the
/// same guarantees, so [name] can name another file (the diary's by default).
final class FileArtworkDiaryStorage implements ArtworkDiaryStorage {
  FileArtworkDiaryStorage({
    FutureOr<Directory> Function()? directory,
    this.name = fileName,
  }) : _directory = directory ?? artworkDocumentsDirectory;

  static const String fileName = 'artwork_diary.json';

  /// The file name of the document inside the folder.
  final String name;
  final FutureOr<Directory> Function() _directory;
  static int _nextTemporary = 0;

  Future<File> _file(bool backup) async =>
      File('${(await _directory()).path}/$name${backup ? '.bak' : ''}');

  @override
  Future<String?> read({bool backup = false}) async {
    final file = await _file(backup);
    if (!await file.exists()) return null;
    return file.readAsString();
  }

  @override
  Future<void> write(String json, {bool backup = false}) async {
    final file = await _file(backup);
    await file.parent.create(recursive: true);
    final temporary = File(
      '${file.path}.${DateTime.now().microsecondsSinceEpoch}.'
      '${_nextTemporary++}.tmp',
    );
    try {
      await temporary.writeAsString(json, flush: true);
      await temporary.rename(file.path);
    } finally {
      if (await temporary.exists()) await temporary.delete();
    }
  }
}

/// Isolated storage for previews and repository tests, without platform I/O.
final class InMemoryArtworkDiaryStorage implements ArtworkDiaryStorage {
  String? _document;
  String? _backup;

  @override
  Future<String?> read({bool backup = false}) async =>
      backup ? _backup : _document;

  @override
  Future<void> write(String json, {bool backup = false}) async {
    if (backup) {
      _backup = json;
    } else {
      _document = json;
    }
  }
}
