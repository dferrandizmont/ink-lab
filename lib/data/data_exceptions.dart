/// Typed failures raised by the local storage layer.
///
/// The repositories never throw bare `FormatException`/`TypeError` for data
/// they own: callers get one of these so a UI layer can show a plain-language
/// message without string matching.
library;

/// Corrupt or malformed data found in the local key/value store.
final class DataStoreException implements Exception {
  const DataStoreException(this.message, {this.key});

  final String message;

  /// Storage key the bad payload came from, when known.
  final String? key;

  @override
  String toString() =>
      'DataStoreException: $message${key == null ? '' : ' (key: $key)'}';
}

/// Invalid, unsupported or structurally wrong backup document.
class BackupFormatException implements Exception {
  const BackupFormatException(this.message, {this.field});

  final String message;

  /// Top-level field the failure relates to, when known.
  final String? field;

  @override
  String toString() =>
      'BackupFormatException: $message${field == null ? '' : ' (field: $field)'}';
}

/// What happened to a backup archive, when it is one of the known reasons.
///
/// A screen maps a reason to its message without reading the text of the
/// failure, the same way it maps the fields of a backup document.
enum BackupArchiveReason {
  /// The file is not a readable ZIP archive.
  notAnArchive,

  /// The archive is bigger than the app accepts.
  tooLarge,

  /// The archive holds more entries than the app accepts.
  tooManyEntries,

  /// The archive holds an entry with a name the app does not accept.
  badEntryName,

  /// The archive holds the same entry twice.
  duplicateEntry,

  /// An entry of the archive is bigger than the app accepts.
  entryTooLarge,

  /// The manifest is missing, unreadable or of another version.
  unsupportedFormat,

  /// A photo is not a JPEG, a PNG or a WebP.
  notAPhoto,

  /// The photos could not be written.
  writeFailed,
}

/// A backup archive that was refused, or whose photos could not be written.
///
/// It is a [BackupFormatException], so the code that already handles a
/// refused clipboard backup handles this one too.
class BackupArchiveException extends BackupFormatException {
  const BackupArchiveException(super.message, {this.reason, super.field});

  /// What happened, when it is one of the known reasons.
  final BackupArchiveReason? reason;

  @override
  String toString() =>
      'BackupArchiveException: $message${field == null ? '' : ' (field: $field)'}';
}
