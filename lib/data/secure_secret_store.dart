import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'secret_store.dart';

/// Why a secure-storage operation failed, so callers can pick a user message.
enum SecretStoreFailure {
  /// The stored value could not be read or decrypted (for example the Android
  /// Keystore key was reset or invalidated). Callers should ask the user to
  /// re-enter the key.
  unreadable,

  /// Any other failure.
  other,
}

/// A secure-storage operation failed.
///
/// Carries only the operation name and the platform error *type*; never the
/// secret value, the secret name, or the platform message (which could echo
/// either).
final class SecretStoreException implements Exception {
  const SecretStoreException(
    this.operation, {
    this.cause,
    this.failure = SecretStoreFailure.other,
  });

  /// Failure kind; [SecretStoreFailure.unreadable] for failed reads.
  final SecretStoreFailure failure;

  /// `read`, `write` or `delete`.
  final String operation;

  /// Runtime type name of the underlying error, for diagnostics only.
  final String? cause;

  @override
  String toString() =>
      'SecretStoreException: secure storage $operation failed'
      '${cause == null ? '' : ' ($cause)'}';
}

/// Production [SecretStore] backed by the platform keystore.
///
/// - Android: values are AES-GCM encrypted; the AES key is wrapped by an RSA
///   key held in the Android Keystore (no biometric / user-auth). Auto Backup / device transfer are disabled for this data in the
///   manifest and the XML rules.
/// - iOS: Keychain, `first_unlock_this_device` (readable after first unlock,
///   never migrated to another device or backup) and not iCloud-synchronised.
///
/// Values are never logged and never included in thrown errors.
final class SecureSecretStore implements SecretStore {
  SecureSecretStore({FlutterSecureStorage? storage})
    : _storage = storage ?? defaultStorage;

  /// Hardened default configuration.
  static const FlutterSecureStorage defaultStorage = FlutterSecureStorage(
    // A Keystore RSA-OAEP key wraps a random AES key; values are AES-GCM. Do
    // NOT use KeyCipherAlgorithm.AES_GCM_NoPadding: the plugin treats it as
    // the biometric key cipher and runs an auth-required migration (needing
    // USE_BIOMETRIC) on first use.
    aOptions: AndroidOptions(
      resetOnError: true,
      migrateOnAlgorithmChange: true,
      keyCipherAlgorithm:
          KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
      synchronizable: false,
    ),
  );

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read(String name) async {
    try {
      return await _storage.read(key: name);
    } on Object catch (error) {
      throw SecretStoreException(
        'read',
        cause: error.runtimeType.toString(),
        failure: SecretStoreFailure.unreadable,
      );
    }
  }

  @override
  Future<void> write(String name, String value) async {
    try {
      await _storage.write(key: name, value: value);
    } on Object catch (error) {
      throw SecretStoreException('write', cause: error.runtimeType.toString());
    }
  }

  @override
  Future<void> delete(String name) async {
    try {
      await _storage.delete(key: name);
    } on Object catch (error) {
      throw SecretStoreException('delete', cause: error.runtimeType.toString());
    }
  }

  @override
  String toString() => 'SecureSecretStore()';
}
