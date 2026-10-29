import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ink_lab/ai/ai.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/palette_advisor.dart' show PaletteAdvisorRequest;
import 'package:ink_lab/data/data.dart';

import 'ai_test_support.dart';
import 'fake_on_device_platform.dart';

const String _key = 'sk-or-v1-abcdef0123456789abcdef0123456789';

AiSettings settings({
  bool enabled = true,
  AiProvider provider = AiProvider.openRouter,
  String textModel = 'model-a',
}) => AiSettings(enabled: enabled, provider: provider, textModel: textModel);

StoredAiSettingsRepository repository({AiSettings? value}) {
  final repo = StoredAiSettingsRepository(InMemoryKeyValueStore());
  if (value != null) repo.replace(value);
  return repo;
}

AiService serviceFor(
  AiSettingsRepository settings,
  SecretStore secrets,
  http.Client client,
) => AiService(
  aiSettings: settings,
  secrets: secrets,
  clientFactory: () => client,
);

PaletteAdvisorRequest request() => PaletteAdvisorRequest(
  availableColors: collection,
  baseColor: collection.first,
  paletteSize: 3,
  brand: MarkerBrand.ohuhuOahu,
);

void main() {
  group('buildAdvisor', () {
    test('returns the local advisor when disabled', () async {
      var called = false;
      final client = MockClient((_) async {
        called = true;
        return completionResponse(
          paletteJson([
            {'code': 'R101'},
          ]),
        );
      });
      final service = serviceFor(
        repository(value: settings(enabled: false)),
        InMemorySecretStore({openRouterApiKeyName: _key}),
        client,
      );

      final advisor = await service.buildAdvisor();

      expect(advisor, isA<LocalPaletteAdvisor>());
      final advice = await advisor.advise(request());
      expect(advice, isA<PaletteAdviceSuccess>());
      expect(called, isFalse);
    });

    test('returns the local advisor when the provider is local', () async {
      final service = serviceFor(
        repository(value: settings(provider: AiProvider.local)),
        InMemorySecretStore({openRouterApiKeyName: _key}),
        MockClient((_) async => completionResponse('{}')),
      );

      expect(await service.buildAdvisor(), isA<LocalPaletteAdvisor>());
    });

    test('returns the local advisor when no key is stored', () async {
      var called = false;
      final client = MockClient((_) async {
        called = true;
        return completionResponse('{}');
      });
      final service = serviceFor(
        repository(value: settings()),
        InMemorySecretStore(),
        client,
      );

      final advisor = await service.buildAdvisor();

      expect(advisor, isA<LocalPaletteAdvisor>());
      await advisor.advise(request());
      expect(called, isFalse);
    });

    test(
      'wraps the cloud advisor in the fallback advisor with a key',
      () async {
        final client = MockClient(
          (_) async => completionResponse(
            paletteJson([
              {'code': 'R101', 'role': 'Shadow', 'reason': 'deep'},
            ]),
          ),
        );
        final service = serviceFor(
          repository(value: settings(textModel: 'model-a')),
          InMemorySecretStore({openRouterApiKeyName: _key}),
          client,
        );

        final advisor = await service.buildAdvisor();
        expect(advisor, isA<FallbackPaletteAdvisor>());

        final advice = await advisor.advise(request());
        final success = advice as PaletteAdviceSuccess;
        expect(
          success.suggestions.map((s) => s.color.newCode),
          contains('R101'),
        );
        expect(success.modelUsed, 'model-a');
        expect(success.usedFallback, isFalse);
      },
    );

    test(
      'each advisor and suggestion reads the settings at that moment',
      () async {
        final models = <String>[];
        final client = MockClient((request) async {
          models.add(jsonDecode(request.body)['model'] as String);
          return completionResponse(
            paletteJson([
              {'code': 'R101', 'role': 'Shadow', 'reason': 'deep'},
            ]),
          );
        });
        final repo = repository(value: settings(textModel: 'model-a'));
        final service = serviceFor(
          repo,
          InMemorySecretStore({openRouterApiKeyName: _key}),
          client,
        );

        // One advisor built early and reused must still follow the repository.
        final early = await service.buildAdvisor();
        await early.advise(request());
        await repo.setTextModel('model-b');
        await early.advise(request());
        await (await service.buildAdvisor()).advise(request());
        await repo.setTextModel('');
        await (await service.buildAdvisor()).advise(request());

        expect(models, [
          'model-a',
          'model-b',
          'model-b',
          AiSettings.recommendedTextModel,
        ]);
      },
    );

    test('key availability is checked on every call', () async {
      final repo = repository(value: settings());
      final secrets = InMemorySecretStore();
      final service = serviceFor(
        repo,
        secrets,
        MockClient((_) async => completionResponse('{}')),
      );
      expect(await service.isAiAvailable(), isFalse);
      await secrets.write(openRouterApiKeyName, _key);
      expect(await service.isAiAvailable(), isTrue);
      await repo.setEnabled(false);
      expect(await service.isAiAvailable(), isFalse);
    });

    test('is not available while disabled, local or keyless', () async {
      final enabled = serviceFor(
        repository(value: settings()),
        InMemorySecretStore({openRouterApiKeyName: _key}),
        MockClient((_) async => completionResponse('{}')),
      );
      expect(await enabled.isAiAvailable(), isTrue);

      final disabled = serviceFor(
        repository(value: settings(enabled: false)),
        InMemorySecretStore({openRouterApiKeyName: _key}),
        MockClient((_) async => completionResponse('{}')),
      );
      expect(await disabled.isAiAvailable(), isFalse);

      final keyless = serviceFor(
        repository(value: settings()),
        InMemorySecretStore(),
        MockClient((_) async => completionResponse('{}')),
      );
      expect(await keyless.isAiAvailable(), isFalse);
    });
  });

  group('testConnection', () {
    test('reports success with the model count', () async {
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
      final service = serviceFor(
        repository(value: settings()),
        InMemorySecretStore({openRouterApiKeyName: _key}),
        client,
      );

      final result = await service.testConnection();

      expect(result, isA<AiConnectionOk>());
      expect((result as AiConnectionOk).modelCount, 2);
    });

    test('maps a 401 without leaking the key', () async {
      final service = serviceFor(
        repository(value: settings()),
        InMemorySecretStore({openRouterApiKeyName: _key}),
        MockClient((_) async => errorResponse('invalid key $_key', 401)),
      );

      final result = await service.testConnection();

      expect(result, isA<AiConnectionFailure>());
      final failure = result as AiConnectionFailure;
      expect(failure.reason, PaletteFailureReason.unauthorized);
      expect(failure.message, isNot(contains(_key)));
    });

    test('maps a transport failure to a network error', () async {
      final service = serviceFor(
        repository(value: settings()),
        InMemorySecretStore({openRouterApiKeyName: _key}),
        MockClient((_) async => throw http.ClientException('down')),
      );

      final result = await service.testConnection();

      expect(
        (result as AiConnectionFailure).reason,
        PaletteFailureReason.networkError,
      );
    });

    test('reports a missing key without touching the network', () async {
      var called = false;
      final client = MockClient((_) async {
        called = true;
        return jsonResponse({'data': <Object>[]});
      });
      final service = serviceFor(
        repository(value: settings()),
        InMemorySecretStore(),
        client,
      );

      final result = await service.testConnection();

      expect(
        (result as AiConnectionFailure).reason,
        PaletteFailureReason.missingKey,
      );
      expect(called, isFalse);
    });
  });

  group('with the AI off', () {
    test('testConnection and loadModels make no request', () async {
      var requests = 0;
      final service = serviceFor(
        repository(value: settings(enabled: false)),
        InMemorySecretStore({openRouterApiKeyName: _key}),
        MockClient((_) async {
          requests++;
          return jsonResponse({'data': <Object>[]});
        }),
      );

      final connection = await service.testConnection();
      final models = await service.loadModels();

      expect(
        (connection as AiConnectionFailure).reason,
        PaletteFailureReason.disabled,
      );
      expect((models as AiModelsFailure).reason, PaletteFailureReason.disabled);
      expect(requests, 0);
    });

    test('they read no key either', () async {
      final service = serviceFor(
        repository(value: settings(enabled: false)),
        _CountingSecretStore(),
        MockClient((_) async => jsonResponse({'data': <Object>[]})),
      );

      await service.testConnection();
      await service.loadModels();

      expect(_CountingSecretStore.reads, 0);
    });

    test('they work again once the AI is turned on', () async {
      final repo = repository(value: settings(enabled: false));
      var requests = 0;
      final service = serviceFor(
        repo,
        InMemorySecretStore({openRouterApiKeyName: _key}),
        MockClient((_) async {
          requests++;
          return jsonResponse({'data': <Object>[]});
        }),
      );
      await service.testConnection();
      expect(requests, 0);

      await repo.replace(settings(enabled: true));

      expect(await service.testConnection(), isA<AiConnectionOk>());
      expect(requests, 1);
    });
  });

  group('turning the AI off during a model download', () {
    test('cancels the tracker and tells the platform', () async {
      final repo = repository(value: settings(provider: AiProvider.onDevice));
      final live = StreamController<OnDeviceDownloadEvent>();
      addTearDown(live.close);
      final platform = FakeOnDevicePlatform(
        currentStatus: OnDeviceStatus.downloadable,
      )..downloadController = live;
      final service = AiService(
        aiSettings: repo,
        secrets: InMemorySecretStore(),
        onDevice: platform,
      );
      addTearDown(service.dispose);

      service.onDeviceDownload.start();
      await Future<void>.delayed(Duration.zero);
      expect(service.onDeviceDownload.active, isTrue);

      // An unrelated edit while on leaves the download alone.
      await repo.replace(settings(provider: AiProvider.onDevice));
      await Future<void>.delayed(Duration.zero);
      expect(service.onDeviceDownload.active, isTrue);
      expect(platform.cancelDownloads, 0);

      await repo.replace(
        settings(enabled: false, provider: AiProvider.onDevice),
      );
      await Future<void>.delayed(Duration.zero);

      expect(service.onDeviceDownload.active, isFalse);
      expect(platform.cancelDownloads, 1);
      expect(live.hasListener, isFalse);
    });

    test('cancelling with no download asks ML Kit nothing', () async {
      final repo = repository(value: settings(provider: AiProvider.onDevice));
      final platform = FakeOnDevicePlatform();
      final service = AiService(
        aiSettings: repo,
        secrets: InMemorySecretStore(),
        onDevice: platform,
      );
      addTearDown(service.dispose);

      await repo.replace(
        settings(enabled: false, provider: AiProvider.onDevice),
      );
      await Future<void>.delayed(Duration.zero);

      expect(platform.cancelDownloads, 0);
      expect(platform.statusCalls, 0);
      expect(platform.downloads, 0);
    });
  });

  group('loadModels', () {
    test('returns the filtered catalog', () async {
      final service = serviceFor(
        repository(value: settings()),
        InMemorySecretStore({openRouterApiKeyName: _key}),
        MockClient(
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
        ),
      );

      final free = await service.loadModels(AiModelFilter.free);
      expect((free as AiModelsSuccess).models.map((m) => m.id), ['a:free']);

      final both = await service.loadModels(AiModelFilter.both);
      expect((both as AiModelsSuccess).models, hasLength(2));
    });

    test('reports a missing key without a request', () async {
      var called = false;
      final service = serviceFor(
        repository(value: settings()),
        InMemorySecretStore(),
        MockClient((_) async {
          called = true;
          return jsonResponse({'data': <Object>[]});
        }),
      );

      final result = await service.loadModels();

      expect(
        (result as AiModelsFailure).reason,
        PaletteFailureReason.missingKey,
      );
      expect(called, isFalse);
    });

    test('maps a server error', () async {
      final service = serviceFor(
        repository(value: settings()),
        InMemorySecretStore({openRouterApiKeyName: _key}),
        MockClient((_) async => errorResponse('boom', 503)),
      );

      final result = await service.loadModels();

      expect(
        (result as AiModelsFailure).reason,
        PaletteFailureReason.serverError,
      );
    });
  });
}

/// A secret store that counts reads, to prove the key is never touched.
final class _CountingSecretStore implements SecretStore {
  static int reads = 0;

  @override
  Future<String?> read(String name) async {
    reads++;
    return _key;
  }

  @override
  Future<void> write(String name, String value) async {}

  @override
  Future<void> delete(String name) async {}
}
