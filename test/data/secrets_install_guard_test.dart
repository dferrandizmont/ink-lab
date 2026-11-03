import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ai/api_key_provider.dart' show openRouterApiKeyName;
import 'package:ink_lab/data/data.dart';

/// A secret store whose delete always fails.
final class _FailingDelete implements SecretStore {
  @override
  Future<String?> read(String name) async => 'old-key';

  @override
  Future<void> write(String name, String value) async {}

  @override
  Future<void> delete(String name) async =>
      throw const SecretStoreException('delete');
}

void main() {
  group('clearSecretsLeftByEarlierInstall', () {
    test('a fresh install drops the key a deleted copy left behind', () async {
      final store = InMemoryKeyValueStore();
      final secrets = InMemorySecretStore({openRouterApiKeyName: 'old-key'});

      await clearSecretsLeftByEarlierInstall(store: store, secrets: secrets);

      expect(await secrets.read(openRouterApiKeyName), isNull);
      expect(await store.containsKey(secretsInstallMarkerKey), isTrue);
    });

    test('later launches keep the key saved in this install', () async {
      final store = InMemoryKeyValueStore();
      final secrets = InMemorySecretStore();
      await clearSecretsLeftByEarlierInstall(store: store, secrets: secrets);
      await secrets.write(openRouterApiKeyName, 'new-key');

      await clearSecretsLeftByEarlierInstall(store: store, secrets: secrets);

      expect(await secrets.read(openRouterApiKeyName), 'new-key');
    });

    test('a failed delete leaves no marker, so it is tried again', () async {
      final store = InMemoryKeyValueStore();
      final secrets = _FailingDelete();

      await clearSecretsLeftByEarlierInstall(store: store, secrets: secrets);

      expect(await store.containsKey(secretsInstallMarkerKey), isFalse);
    });
  });
}
