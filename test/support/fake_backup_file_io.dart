import 'dart:async';
import 'dart:typed_data';

import 'package:ink_lab/ui/pages/settings/backup_file_io.dart';

/// A [BackupFileIo] that records what is shared and hands out a prepared
/// pick, so no test opens a share sheet or a file picker.
class FakeBackupFileIo implements BackupFileIo {
  Uint8List? sharedBytes;
  String? sharedName;

  /// Holds the share sheet open until it completes.
  Completer<void>? shareGate;
  Object? shareError;

  /// What the picker returns; `null` is a cancelled picker.
  BackupFilePick? pick;
  int picks = 0;

  @override
  Future<void> shareBackup(Uint8List bytes, String fileName) async {
    sharedBytes = bytes;
    sharedName = fileName;
    if (shareError != null) throw shareError!;
    await shareGate?.future;
  }

  @override
  Future<BackupFilePick?> pickBackup() async {
    picks++;
    return pick;
  }
}

/// A pick of [bytes], as the picker would report it.
BackupFilePick pickOf(Uint8List bytes, {int? length}) => BackupFilePick(
  name: 'backup.zip',
  length: length ?? bytes.length,
  read: () async => bytes,
);
