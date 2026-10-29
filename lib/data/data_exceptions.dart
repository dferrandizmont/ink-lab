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
final class BackupFormatException implements Exception {
  const BackupFormatException(this.message, {this.field});

  final String message;

  /// Top-level field the failure relates to, when known.
  final String? field;

  @override
  String toString() =>
      'BackupFormatException: $message${field == null ? '' : ' (field: $field)'}';
}
