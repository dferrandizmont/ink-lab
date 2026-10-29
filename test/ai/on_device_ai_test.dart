import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ai/ai.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/palette_advisor.dart' show PaletteAdvisorRequest;
import 'package:ink_lab/data/data.dart';

import 'ai_test_support.dart';
import 'fake_on_device_platform.dart';

const MethodChannel _methods = MethodChannel('ink_lab/on_device_ai');
const EventChannel _events = EventChannel('ink_lab/on_device_ai/download');

PaletteAdvisorRequest _request({
  List<MarkerColor>? colors,
  MarkerColor? base,
  int paletteSize = 3,
}) => PaletteAdvisorRequest(
  availableColors: colors ?? collection,
  baseColor: base,
  paletteSize: paletteSize,
  mode: PaletteMode.recommended,
  brand: MarkerBrand.ohuhuOahu,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final TestDefaultBinaryMessenger messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  tearDown(() {
    messenger.setMockMethodCallHandler(_methods, null);
    messenger.setMockStreamHandler(_events, null);
  });

  group('MethodChannelOnDeviceAi', () {
    test('status maps every wire value, unknown ones to unavailable', () async {
      final MethodChannelOnDeviceAi platform = MethodChannelOnDeviceAi();
      for (final MapEntry<String, OnDeviceStatus> entry
          in <String, OnDeviceStatus>{
            'unavailable': OnDeviceStatus.unavailable,
            'downloadable': OnDeviceStatus.downloadable,
            'downloading': OnDeviceStatus.downloading,
            'available': OnDeviceStatus.available,
            'something-new': OnDeviceStatus.unavailable,
          }.entries) {
        messenger.setMockMethodCallHandler(_methods, (MethodCall call) async {
          expect(call.method, 'status');
          return entry.key;
        });
        expect(await platform.status(), entry.value, reason: entry.key);
      }
    });

    test(
      'status never throws: errors and a missing plugin are unavailable',
      () async {
        final MethodChannelOnDeviceAi platform = MethodChannelOnDeviceAi();
        // No handler at all: MissingPluginException.
        expect(await platform.status(), OnDeviceStatus.unavailable);

        messenger.setMockMethodCallHandler(_methods, (MethodCall call) async {
          throw PlatformException(code: 'boom');
        });
        expect(await platform.status(), OnDeviceStatus.unavailable);
      },
    );

    test('generate sends the prompt and returns the text', () async {
      String? received;
      messenger.setMockMethodCallHandler(_methods, (MethodCall call) async {
        expect(call.method, 'generate');
        received = call.arguments as String;
        return '{"palette":[]}';
      });

      final String text = await MethodChannelOnDeviceAi().generate('hello');

      expect(received, 'hello');
      expect(text, '{"palette":[]}');
    });

    test('generate maps native error codes to typed failures', () async {
      for (final MapEntry<String, OnDeviceGenerateFailure> entry
          in <String, OnDeviceGenerateFailure>{
            'timeout': OnDeviceGenerateFailure.timeout,
            'unavailable': OnDeviceGenerateFailure.unavailable,
            'cancelled': OnDeviceGenerateFailure.cancelled,
            'generate_failed': OnDeviceGenerateFailure.failed,
            'weird': OnDeviceGenerateFailure.failed,
          }.entries) {
        messenger.setMockMethodCallHandler(_methods, (MethodCall call) async {
          throw PlatformException(code: entry.key, message: 'secret prompt');
        });
        await expectLater(
          MethodChannelOnDeviceAi().generate('p'),
          throwsA(
            isA<OnDeviceAiException>().having(
              (OnDeviceAiException e) => e.failure,
              'failure',
              entry.value,
            ),
          ),
          reason: entry.key,
        );
      }
    });

    test('generate gives up when the native side never answers', () async {
      final List<String> calls = <String>[];
      messenger.setMockMethodCallHandler(_methods, (MethodCall call) async {
        calls.add(call.method);
        if (call.method == 'generate') {
          // Never answers.
          return Completer<Object?>().future;
        }
        return null;
      });

      final MethodChannelOnDeviceAi platform = MethodChannelOnDeviceAi(
        backstopGrace: const Duration(milliseconds: 20),
      );
      await expectLater(
        platform.generate('p', timeout: const Duration(milliseconds: 20)),
        throwsA(
          isA<OnDeviceAiException>().having(
            (OnDeviceAiException e) => e.failure,
            'failure',
            OnDeviceGenerateFailure.timeout,
          ),
        ),
      );
      await Future<void>.delayed(Duration.zero);
      // A late answer is cancelled natively, so it cannot pile up.
      expect(calls, containsAllInOrder(<String>['generate', 'cancel']));
    });

    test('download streams progress and completes', () async {
      messenger.setMockMethodCallHandler(_methods, (MethodCall call) async {
        expect(call.method, 'download');
        return 'started';
      });
      messenger.setMockStreamHandler(
        _events,
        MockStreamHandler.inline(
          onListen: (Object? arguments, MockStreamHandlerEventSink sink) {
            sink.success(<String, Object>{'type': 'started'});
            sink.success(<String, Object>{
              'type': 'progress',
              'bytes': 1048576,
            });
            sink.success(<String, Object>{'type': 'completed'});
          },
        ),
      );

      final List<OnDeviceDownloadEvent> events = await MethodChannelOnDeviceAi()
          .download()
          .toList();

      expect(events, hasLength(3));
      expect(events[0], isA<OnDeviceDownloadStarted>());
      expect((events[1] as OnDeviceDownloadProgress).bytes, 1048576);
      expect(events[2], isA<OnDeviceDownloadCompleted>());
    });

    test('download reports a failure when the platform refuses', () async {
      messenger.setMockMethodCallHandler(_methods, (MethodCall call) async {
        throw PlatformException(code: 'unavailable');
      });
      messenger.setMockStreamHandler(
        _events,
        MockStreamHandler.inline(onListen: (_, _) {}),
      );

      final List<OnDeviceDownloadEvent> events = await MethodChannelOnDeviceAi()
          .download()
          .toList();

      expect(events.single, isA<OnDeviceDownloadFailed>());
    });
  });

  group('UnsupportedOnDeviceAi (iOS stub)', () {
    test('always reports unavailable and fails closed', () async {
      const UnsupportedOnDeviceAi platform = UnsupportedOnDeviceAi();
      expect(await platform.status(), OnDeviceStatus.unavailable);
      expect(await platform.download().single, isA<OnDeviceDownloadFailed>());
      await expectLater(
        platform.generate('p'),
        throwsA(isA<OnDeviceAiException>()),
      );
    });

    test('is chosen off Android', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      addTearDown(() => debugDefaultTargetPlatformOverride = null);
      expect(defaultOnDeviceAiPlatform(), isA<UnsupportedOnDeviceAi>());
    });

    test('the channel is chosen on Android', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      addTearDown(() => debugDefaultTargetPlatformOverride = null);
      expect(defaultOnDeviceAiPlatform(), isA<MethodChannelOnDeviceAi>());
    });
  });

  group('PlatformOnDevicePaletteAdvisor', () {
    PlatformOnDevicePaletteAdvisor advisorOver(
      FakeOnDevicePlatform platform, {
      Duration timeout = const Duration(milliseconds: 50),
    }) => PlatformOnDevicePaletteAdvisor(platform: platform, timeout: timeout);

    test(
      'returns validated, normalised suggestions tagged on-device',
      () async {
        final FakeOnDevicePlatform platform = FakeOnDevicePlatform(
          output: paletteJson(
            <Map<String, String>>[
              {
                'code': 'b315',
                'role': 'highlights',
                'reason': 'Shadow: bright',
              },
              {'code': 'R101', 'role': 'Shadow', 'reason': 'deep'},
              {
                'code': 'ZZ999',
                'role': 'Accent',
                'reason': 'not in the collection',
              },
            ],
            tips: <String>['  keep it simple  '],
          ),
        );

        final PaletteAdvice advice = await advisorOver(platform)
            .advise(_request());

        final PaletteAdviceSuccess success = advice as PaletteAdviceSuccess;
        expect(success.suggestions.map((s) => s.color.newCode), <String>[
          'B315',
          'R101',
        ]);
        expect(success.suggestions.first.role, 'Highlight');
        expect(success.suggestions.first.reason, 'bright');
        expect(success.modelUsed, onDeviceModelId);
        expect(success.usedFallback, isFalse);
        expect(success.tips, <String>['keep it simple']);
        expect(platform.prompts, hasLength(1));
      },
    );

    test(
      'only codes of the active collection survive and the base is excluded',
      () async {
        final FakeOnDevicePlatform platform = FakeOnDevicePlatform(
          output: paletteJson(<Map<String, String>>[
            {'code': 'B315', 'role': 'Base', 'reason': 'the base itself'},
            {'code': 'G202', 'role': 'Accent', 'reason': 'fresh'},
          ]),
        );

        final PaletteAdviceSuccess success = await advisorOver(
          platform,
        ).advise(_request(base: collection.first)) as PaletteAdviceSuccess;

        expect(success.suggestions.map((s) => s.color.newCode), <String>[
          'G202',
        ]);
      },
    );

    test('a reply with no valid code is a typed failure', () async {
      final FakeOnDevicePlatform platform = FakeOnDevicePlatform(
        output: paletteJson(<Map<String, String>>[
          {'code': 'ZZ999', 'role': 'Accent', 'reason': 'x'},
        ]),
      );

      final PaletteAdvice advice = await advisorOver(platform)
          .advise(_request());

      expect(
        (advice as PaletteAdviceFailure).reason,
        PaletteFailureReason.noValidSuggestions,
      );
    });

    test('malformed output is a typed failure, not a throw', () async {
      final FakeOnDevicePlatform platform = FakeOnDevicePlatform(
        output: 'Sure! Here are some lovely colours for you.',
      );

      final PaletteAdvice advice = await advisorOver(platform)
          .advise(_request());

      expect(
        (advice as PaletteAdviceFailure).reason,
        PaletteFailureReason.invalidJson,
      );
    });

    test('a model that never answers times out', () async {
      final FakeOnDevicePlatform platform = FakeOnDevicePlatform(hang: true);

      final PaletteAdvice advice = await advisorOver(platform)
          .advise(_request());

      expect(
        (advice as PaletteAdviceFailure).reason,
        PaletteFailureReason.timeout,
      );
    });

    test('a missing model is reported without generating', () async {
      final FakeOnDevicePlatform platform = FakeOnDevicePlatform(
        currentStatus: OnDeviceStatus.downloadable,
      );

      final PaletteAdvice advice = await advisorOver(platform)
          .advise(_request());

      expect(
        (advice as PaletteAdviceFailure).reason,
        PaletteFailureReason.onDeviceUnavailable,
      );
      expect(platform.prompts, isEmpty);
      expect(await advisorOver(platform).isAvailable(), isFalse);
    });

    test('keeps the candidate list small for the on-device context', () async {
      final List<MarkerColor> many = <MarkerColor>[
        for (int i = 1; i <= 120; i++)
          marker(
            'B${(100 + i)}',
            (i * 2000 + 0x100000).toRadixString(16).padLeft(6, '0'),
          ),
      ];
      final FakeOnDevicePlatform platform = FakeOnDevicePlatform(
        output: paletteJson(<Map<String, String>>[
          {'code': 'B101', 'role': 'Accent', 'reason': 'x'},
        ]),
      );

      await advisorOver(platform).advise(_request(colors: many));

      final List<String> lines = platform.prompts.single.split('\n');
      final int start = lines.indexWhere((String l) => l.startsWith('COLORS'));
      final List<String> listed = lines
          .skip(start + 1)
          .takeWhile((String l) => !l.startsWith('FORMAT'))
          .toList();
      expect(listed.length, lessThanOrEqualTo(40));
      expect(listed, isNotEmpty);
    });
  });

  group('AiService with the on-device provider', () {
    AiService serviceOver(
      FakeOnDevicePlatform platform, {
      bool enabled = true,
      AiProvider provider = AiProvider.onDevice,
    }) {
      final StoredAiSettingsRepository repo = StoredAiSettingsRepository(
        InMemoryKeyValueStore(),
      );
      repo.replace(AiSettings(enabled: enabled, provider: provider));
      return AiService(
        aiSettings: repo,
        // No key anywhere and no HTTP: anything that touches either fails.
        secrets: InMemorySecretStore(),
        clientFactory: () => throw StateError('on-device must not use HTTP'),
        onDevice: platform,
      );
    }

    test('is available only when the model is downloaded', () async {
      expect(
        await serviceOver(
          FakeOnDevicePlatform(currentStatus: OnDeviceStatus.available),
        ).isAiAvailable(),
        isTrue,
      );
      for (final OnDeviceStatus status in <OnDeviceStatus>[
        OnDeviceStatus.unavailable,
        OnDeviceStatus.downloadable,
        OnDeviceStatus.downloading,
      ]) {
        expect(
          await serviceOver(FakeOnDevicePlatform(currentStatus: status))
              .isAiAvailable(),
          isFalse,
          reason: status.name,
        );
      }
      expect(
        await serviceOver(
          FakeOnDevicePlatform(),
          enabled: false,
        ).isAiAvailable(),
        isFalse,
      );
    });

    test('answers from the model without a key or a network', () async {
      final FakeOnDevicePlatform platform = FakeOnDevicePlatform(
        output: paletteJson(<Map<String, String>>[
          {'code': 'R101', 'role': 'Accent', 'reason': 'warm'},
        ]),
      );

      final PaletteAdvisor advisor = await serviceOver(platform).buildAdvisor();
      final PaletteAdvice advice = await advisor.advise(
        _request(base: collection.first),
      );

      final PaletteAdviceSuccess success = advice as PaletteAdviceSuccess;
      expect(success.modelUsed, onDeviceModelId);
      // One valid colour is kept first; colour theory completes the palette.
      expect(success.suggestions.first.color.newCode, 'R101');
      expect(success.aiCount, 1);
      expect(success.isPartial, isTrue);
    });

    test('malformed output falls back to the local engine', () async {
      final FakeOnDevicePlatform platform = FakeOnDevicePlatform(
        output: 'not json at all',
      );

      final PaletteAdvisor advisor = await serviceOver(platform).buildAdvisor();
      final PaletteAdvice advice = await advisor.advise(
        _request(base: collection.first),
      );

      final PaletteAdviceSuccess success = advice as PaletteAdviceSuccess;
      expect(success.usedFallback, isTrue);
      expect(success.modelUsed, isEmpty);
      expect(success.suggestions, isNotEmpty);
    });

    test('a platform failure falls back to the local engine', () async {
      final FakeOnDevicePlatform platform = FakeOnDevicePlatform(
        failure: OnDeviceGenerateFailure.failed,
      );

      final PaletteAdvisor advisor = await serviceOver(platform).buildAdvisor();
      final PaletteAdvice advice = await advisor.advise(
        _request(base: collection.first),
      );

      expect((advice as PaletteAdviceSuccess).usedFallback, isTrue);
    });

    test('without a ready model the local advisor is used and nothing is generated', () async {
      final FakeOnDevicePlatform platform = FakeOnDevicePlatform(
        currentStatus: OnDeviceStatus.downloadable,
      );

      final PaletteAdvisor advisor = await serviceOver(platform).buildAdvisor();
      final PaletteAdvice advice = await advisor.advise(
        _request(base: collection.first),
      );

      expect(advice, isA<PaletteAdviceSuccess>());
      expect((advice as PaletteAdviceSuccess).modelUsed, isEmpty);
      expect(platform.prompts, isEmpty);
    });
  });

  group('AiSettingsController on-device state', () {
    AiSettingsController controllerOver(FakeOnDevicePlatform platform) {
      final StoredAiSettingsRepository repo = StoredAiSettingsRepository(
        InMemoryKeyValueStore(),
      );
      final InMemorySecretStore secrets = InMemorySecretStore();
      final AiService service = AiService(
        aiSettings: repo,
        secrets: secrets,
        clientFactory: () => throw StateError('no HTTP'),
        onDevice: platform,
      );
      return AiSettingsController(
        settings: repo,
        secrets: secrets,
        service: service,
      );
    }

    test('hides the provider while unavailable', () async {
      final AiSettingsController controller = controllerOver(
        FakeOnDevicePlatform(currentStatus: OnDeviceStatus.unavailable),
      );
      addTearDown(controller.dispose);
      await controller.initialize();
      expect(controller.onDeviceSupported, isFalse);
    });

    test('shows the provider and downloads the model with progress', () async {
      final FakeOnDevicePlatform platform = FakeOnDevicePlatform(
        currentStatus: OnDeviceStatus.downloadable,
        downloadEvents: const <OnDeviceDownloadEvent>[
          OnDeviceDownloadStarted(),
          OnDeviceDownloadProgress(2 * 1024 * 1024),
          OnDeviceDownloadCompleted(),
        ],
      );
      final AiSettingsController controller = controllerOver(platform);
      addTearDown(controller.dispose);
      await controller.initialize();
      expect(controller.onDeviceSupported, isTrue);
      expect(controller.onDeviceStatus, OnDeviceStatus.downloadable);

      await controller.downloadOnDevice();

      expect(platform.downloads, 1);
      expect(controller.onDeviceBytes, 2 * 1024 * 1024);
      expect(controller.onDeviceStatus, OnDeviceStatus.available);
      expect(controller.onDeviceDownloadFailed, isFalse);
    });

    test(
      'a failed download is reported and the model stays downloadable',
      () async {
        final FakeOnDevicePlatform platform = FakeOnDevicePlatform(
          currentStatus: OnDeviceStatus.downloadable,
          downloadEvents: const <OnDeviceDownloadEvent>[
            OnDeviceDownloadStarted(),
            OnDeviceDownloadFailed('network'),
          ],
        );
        final AiSettingsController controller = controllerOver(platform);
        addTearDown(controller.dispose);
        await controller.initialize();

        await controller.downloadOnDevice();

        expect(controller.onDeviceDownloadFailed, isTrue);
        expect(controller.onDeviceStatus, OnDeviceStatus.downloadable);
      },
    );
  });
}
