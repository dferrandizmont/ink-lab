import 'dart:io';
import 'dart:typed_data';

import 'package:file_selector/file_selector.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// A backup file the user picked, not read yet.
final class BackupFilePick {
  const BackupFilePick({
    required this.name,
    required this.length,
    required this.read,
    this.discard = _keep,
  });

  /// The file name the picker reported.
  final String name;

  /// The size of the file in bytes, known before it is read so a file that is
  /// far too big is refused without reading it.
  final int length;

  /// Reads the whole file.
  final Future<Uint8List> Function() read;

  /// Deletes any copy the picker made for the app; called once the restore
  /// is over, whatever its outcome.
  final Future<void> Function() discard;

  static Future<void> _keep() async {}
}

/// What the backup file needs from the system: the share sheet that hands the
/// ZIP to Files, Drive and the like, and the file picker that finds it again.
/// The app uses [SystemBackupFileIo]; tests give it a fake.
abstract interface class BackupFileIo {
  /// Writes [bytes] to a temporary file named [fileName] and opens the share
  /// sheet with it; completes when the sheet closes.
  Future<void> shareBackup(Uint8List bytes, String fileName);

  /// Opens the system file picker for a ZIP; `null` when the user cancels.
  Future<BackupFilePick?> pickBackup();
}

/// The name of the backup file written on [date]: `ink-lab-backup-2026-11-01.zip`.
String backupFileName(DateTime date) {
  String two(int value) => value.toString().padLeft(2, '0');
  return 'ink-lab-backup-${date.year.toString().padLeft(4, '0')}-'
      '${two(date.month)}-${two(date.day)}.zip';
}

/// [BackupFileIo] on `share_plus` and `file_selector`.
///
/// The ZIP is written to the temporary folder of the app, which is cache the
/// system may clear at any time. The older backup files left there are
/// deleted before a new one is written. The file is not deleted when the
/// share sheet closes: the app the user picked may still be reading it.
final class SystemBackupFileIo implements BackupFileIo {
  const SystemBackupFileIo();

  static const String _prefix = 'ink-lab-backup-';

  /// The file types the picker offers: ZIP, by extension, MIME type and
  /// (iOS) uniform type identifier.
  static const XTypeGroup _zip = XTypeGroup(
    label: 'ZIP',
    extensions: <String>['zip'],
    mimeTypes: <String>['application/zip', 'application/x-zip-compressed'],
    uniformTypeIdentifiers: <String>[
      'public.zip-archive',
      'com.pkware.zip-archive',
    ],
  );

  @override
  Future<void> shareBackup(Uint8List bytes, String fileName) async {
    final Directory folder = await getTemporaryDirectory();
    await _deleteOldBackups(folder);
    final File file = File('${folder.path}${Platform.pathSeparator}$fileName');
    await file.writeAsBytes(bytes, flush: true);
    await SharePlus.instance.share(
      ShareParams(
        files: <XFile>[
          XFile(file.path, mimeType: 'application/zip', name: fileName),
        ],
        fileNameOverrides: <String>[fileName],
      ),
    );
  }

  @override
  Future<BackupFilePick?> pickBackup() async {
    final XFile? file = await openFile(
      acceptedTypeGroups: const <XTypeGroup>[_zip],
    );
    if (file == null) return null;
    return BackupFilePick(
      name: file.name,
      length: await file.length(),
      read: file.readAsBytes,
      discard: () => _deletePickedCopy(file.path),
    );
  }

  /// The Android picker copies the chosen file into the app's cache, in a
  /// folder of its own, and never deletes it. Only a copy inside the
  /// temporary folder is removed, never the user's original.
  static Future<void> _deletePickedCopy(String path) async {
    if (path.isEmpty) return;
    try {
      final Directory temp = await getTemporaryDirectory();
      final File copy = File(path);
      if (!copy.absolute.path.startsWith(temp.absolute.path)) return;
      final Directory parent = copy.parent;
      if (await copy.exists()) await copy.delete();
      if (parent.absolute.path != temp.absolute.path &&
          await parent.exists() &&
          await parent.list().isEmpty) {
        await parent.delete();
      }
    } on FileSystemException {
      // A copy that cannot be deleted stays in the cache the system clears.
    }
  }

  static Future<void> _deleteOldBackups(Directory folder) async {
    try {
      await for (final FileSystemEntity entity in folder.list()) {
        final String name = entity.uri.pathSegments.isEmpty
            ? ''
            : entity.uri.pathSegments.last;
        if (entity is File &&
            name.startsWith(_prefix) &&
            name.endsWith('.zip')) {
          await entity.delete();
        }
      }
    } on FileSystemException {
      // An old file that cannot be deleted is overwritten or left behind.
    }
  }
}
