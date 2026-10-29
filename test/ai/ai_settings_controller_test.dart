import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ink_lab/ai/ai.dart';
import 'package:ink_lab/data/data.dart';

import 'ai_test_support.dart';

const String _key = 'sk-or-v1-abcdef0123456789abcdef0123456789';

/// A store whose reads always fail as "unreadable".
final class _UnreadableSecretStore implements SecretStore {
  const _UnreadableSecretStore();

  @override
  Future<String?> read(String name) async => throw const SecretStoreException(
    'read',
    failure: SecretStoreFailure.unreadable,
  );

  @override
  Future<void> write(String name, String value) async {}

  @override
  Future<void> delete(String name) async {}
}

/// A store whose writes always fail.
final class _UnwritableSecretStore implements SecretStore {
  const _UnwritableSecretStore();

  @override
  Future<String?> read(String name) async => null;

  @override
  Future<void> write(String name, String value) async =>
      throw const SecretStoreException('write');

  @override
  Future<void> delete(String name) async {}
}

AiSettingsController buildController({
  StoredAiSettingsRepository? repo,
  SecretStore? secrets,
  http.Client? client,
}) {
  final StoredAiSettingsRepository resolvedRepo =
      repo ?? StoredAiSettingsRepository(InMemoryKeyValueStore());
  final SecretStore resolvedSecrets = secrets ?? InMemorySecretStore();
  final AiService service = AiService(
    aiSettings: resolvedRepo,
    secrets: resolvedSecrets,
    clientFactory: () =>
        client ?? MockClient((_) async => jsonResponse({'data': <Object>[]})),
  );
  final AiSettingsController controller = AiSettingsController(
    settings: resolvedRepo,
    secrets: resolvedSecrets,
    service: service,
  );
  addTearDown(controller.dispose);
  return controller;
}

void main() {
  group('key handling', () {
    test('rejects an implausible key without storing or echoing it', () async {
      final secrets = InMemorySecretStore();
      final controller = buildController(secrets: secrets);

      expect(await controller.saveKey('not-a-key'), isFalse);
      expect(controller.keyError, AiKeyError.invalid);
      expect(controller.hasStoredKey, isFalse);
      expect(await secrets.read(openRouterApiKeyName), isNull);
    });

    test('stores a valid key and exposes only its mask', () async {
      final secrets = InMemorySecretStore();
      final controller = buildController(secrets: secrets);

      expect(await controller.saveKey('  $_key  '), isTrue);
      expect(controller.hasStoredKey, isTrue);
      expect(controller.keyJustSaved, isTrue);
      expect(controller.keyError, isNull);
      expect(controller.maskedKey, endsWith('6789'));
      expect(controller.maskedKey, isNot(contains('abcdef')));
      expect(await secrets.read(openRouterApiKeyName), _key);
    });

    test('reports an unreadable store at initialization', () async {
      final controller = buildController(
        secrets: const _UnreadableSecretStore(),
      );

      await controller.initialize();

      expect(controller.keyError, AiKeyError.unreadable);
      expect(controller.hasStoredKey, isFalse);
      expect(controller.maskedKey, isNull);
    });

    test('maps a write failure to a storage error', () async {
      final controller = buildController(
        secrets: const _UnwritableSecretStore(),
      );

      expect(await controller.saveKey(_key), isFalse);
      expect(controller.keyError, AiKeyError.storage);
    });

    test('removes the stored key', () async {
      final secrets = InMemorySecretStore({openRouterApiKeyName: _key});
      final controller = buildController(secrets: secrets);
      await controller.initialize();
      expect(controller.hasStoredKey, isTrue);

      await controller.removeKey();

      expect(controller.hasStoredKey, isFalse);
      expect(await secrets.read(openRouterApiKeyName), isNull);
    });
  });

  group('settings delegation', () {
    test('enabled, provider and primary model reach the repository', () async {
      final repo = StoredAiSettingsRepository(InMemoryKeyValueStore());
      final controller = buildController(repo: repo);

      await controller.setEnabled(true);
      await controller.setProvider(AiProvider.openRouter);
      await controller.selectPrimaryModel('model-a');

      expect(repo.value.enabled, isTrue);
      expect(repo.value.provider, AiProvider.openRouter);
      expect(repo.value.textModel, 'model-a');
    });

    test('toggles fallbacks up to the cap', () async {
      final repo = StoredAiSettingsRepository(InMemoryKeyValueStore());
      final controller = buildController(repo: repo);
      await controller.selectPrimaryModel('primary');

      await controller.toggleFallback('f1');
      expect(repo.value.textFallbacks, ['f1']);
      await controller.toggleFallback('f1');
      expect(repo.value.textFallbacks, isEmpty);

      for (var i = 0; i < AiSettings.maxFallbacks + 2; i++) {
        await controller.toggleFallback('f$i');
      }
      expect(repo.value.textFallbacks, hasLength(AiSettings.maxFallbacks));
    });
  });

  group('recommended defaults', () {
    test(
      'apply while no text model is set and are materialised on edit',
      () async {
        final repo = StoredAiSettingsRepository(InMemoryKeyValueStore());
        final controller = buildController(repo: repo);

        expect(controller.usingRecommendedDefaults, isTrue);
        expect(controller.textModel, AiSettings.recommendedTextModel);
        expect(controller.textFallbacks, AiSettings.recommendedTextFallbacks);
        expect(repo.value.textModel, isEmpty);

        await controller.toggleFallback('extra');
        expect(repo.value.textModel, AiSettings.recommendedTextModel);
        expect(repo.value.textFallbacks, [
          ...AiSettings.recommendedTextFallbacks,
          'extra',
        ]);
      },
    );

    test('a chosen model replaces the defaults', () async {
      final repo = StoredAiSettingsRepository(InMemoryKeyValueStore());
      final controller = buildController(repo: repo);
      await controller.selectPrimaryModel('mine');
      await pumpEventQueue();

      expect(controller.usingRecommendedDefaults, isFalse);
      expect(controller.textModel, 'mine');
      expect(controller.textFallbacks, isEmpty);
    });
  });

  group('connection and catalog', () {
    // These calls only go out while the AI is on.
    StoredAiSettingsRepository enabledRepo() {
      final repo = StoredAiSettingsRepository(InMemoryKeyValueStore());
      repo.replace(AiSettings(enabled: true));
      return repo;
    }

    test('testConnection exposes the typed result', () async {
      final client = MockClient(
        (_) async => jsonResponse({
          'data': [
            {
              'id': 'a:free',
              'pricing': {'prompt': '0', 'completion': '0'},
            },
          ],
        }),
      );
      final controller = buildController(
        repo: enabledRepo(),
        secrets: InMemorySecretStore({openRouterApiKeyName: _key}),
        client: client,
      );

      final result = await controller.testConnection();

      expect(result, isA<AiConnectionOk>());
      expect(controller.lastConnection, isA<AiConnectionOk>());
      expect(controller.testingConnection, isFalse);
    });

    test('loadModels fills the picker and records the filter', () async {
      final client = MockClient(
        (_) async => jsonResponse({
          'data': [
            {
              'id': 'a:free',
              'pricing': {'prompt': '0', 'completion': '0'},
            },
            {
              'id': 'b',
              'pricing': {'prompt': '1', 'completion': '1'},
            },
          ],
        }),
      );
      final controller = buildController(
        repo: enabledRepo(),
        secrets: InMemorySecretStore({openRouterApiKeyName: _key}),
        client: client,
      );

      controller.setModelFilter(AiModelFilter.both);
      await controller.loadModels();

      expect(controller.modelsLoaded, isTrue);
      expect(controller.availableModels.map((m) => m.id), ['a:free', 'b']);
      expect(controller.modelsError, isNull);
    });

    test('loadModels records a typed failure', () async {
      final controller = buildController(
        repo: enabledRepo(),
        secrets: InMemorySecretStore({openRouterApiKeyName: _key}),
        client: MockClient((_) async => errorResponse('nope', 401)),
      );

      await controller.loadModels();

      expect(controller.availableModels, isEmpty);
      expect(controller.modelsError, PaletteFailureReason.unauthorized);
    });
  });
}
