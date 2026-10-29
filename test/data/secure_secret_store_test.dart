import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/data/data.dart';

const _secret = 'sk-or-v1-SUPERSECRETVALUE1234567890';

final class _ThrowingStorage extends FlutterSecureStorage {
  const _ThrowingStorage();

  @override
  Future<String?> read({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async => throw PlatformException(code: 'x', message: 'leak $_secret');

  @override
  Future<void> write({
    required String key,
    required String? value,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async => throw PlatformException(code: 'x', message: 'leak $value');

  @override
  Future<void> delete({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async => throw PlatformException(code: 'x', message: 'leak $_secret');
}

void main() {
  test('write, read, overwrite and delete round-trip', () async {
    FlutterSecureStorage.setMockInitialValues(<String, String>{});
    final store = SecureSecretStore();
    expect(await store.read('k'), isNull);
    await store.write('k', _secret);
    expect(await store.read('k'), _secret);
    await store.write('k', 'other');
    expect(await store.read('k'), 'other');
    await store.delete('k');
    expect(await store.read('k'), isNull);
  });

  test('default options are hardened', () {
    final ios = SecureSecretStore.defaultStorage.iOptions.toMap();
    expect(
      ios['accessibility'],
      KeychainAccessibility.first_unlock_this_device.name,
    );
    expect(ios['synchronizable'], 'false');
  });

  test('platform errors become typed exceptions without the value', () async {
    final store = SecureSecretStore(storage: const _ThrowingStorage());
    final ops = <Future<void> Function()>[
      () => store.read('k'),
      () => store.write('k', _secret),
      () => store.delete('k'),
    ];
    for (final op in ops) {
      try {
        await op();
        fail('expected SecretStoreException');
      } on SecretStoreException catch (e) {
        expect(e.toString(), isNot(contains('SUPERSECRET')));
        expect(e.toString(), isNot(contains('leak')));
        expect(e.toString(), contains('PlatformException'));
      }
    }
  });

  test('android options use non-biometric RSA-wrapped AES-GCM', () {
    final android = SecureSecretStore.defaultStorage.aOptions.toMap();
    expect(
      android['keyCipherAlgorithm'],
      'RSA_ECB_OAEPwithSHA_256andMGF1Padding',
    );
    expect(android['enforceBiometrics'], 'false');
    expect(android['storageCipherAlgorithm'], 'AES_GCM_NoPadding');
  });

  test('read failure is flagged unreadable, others are not', () async {
    final store = SecureSecretStore(storage: const _ThrowingStorage());
    try {
      await store.read('k');
      fail('expected SecretStoreException');
    } on SecretStoreException catch (e) {
      expect(e.failure, SecretStoreFailure.unreadable);
      expect(e.toString(), isNot(contains('SUPERSECRET')));
    }
    try {
      await store.write('k', _secret);
      fail('expected SecretStoreException');
    } on SecretStoreException catch (e) {
      expect(e.failure, SecretStoreFailure.other);
    }
  });

  test('toString never exposes stored values', () async {
    FlutterSecureStorage.setMockInitialValues(<String, String>{});
    final store = SecureSecretStore();
    await store.write('k', _secret);
    expect(store.toString(), isNot(contains('SUPERSECRET')));
  });
}
