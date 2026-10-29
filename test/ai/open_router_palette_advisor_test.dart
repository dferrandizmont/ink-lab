import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ink_lab/ai/ai.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/palette_advisor.dart' show PaletteAdvisorRequest;
import 'package:ink_lab/data/ai_settings.dart';

import 'ai_test_support.dart';

void main() {
  AiSettings buildSettings({
    String textModel = 'model-a',
    List<String> fallbacks = const [],
    bool autoFallback = true,
    bool enabled = true,
  }) => AiSettings(
    enabled: enabled,
    textModel: textModel,
    textFallbacks: fallbacks,
    autoFallback: autoFallback,
    temperature: 0.7,
    maxTokens: 500,
  );

  OpenRouterPaletteAdvisor buildAdvisor(
    MockClient client, {
    AiSettings? withSettings,
    String? key = 'sk-or-test-key-1234567890',
    int maxTextCandidates = 48,
  }) => OpenRouterPaletteAdvisor(
    client: OpenRouterClient(client: client),
    settings: () => withSettings ?? buildSettings(),
    apiKey: () => key,
    maxTextCandidates: maxTextCandidates,
  );

  PaletteAdvisorRequest buildRequest({
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

  MockClient okClient(String content) =>
      MockClient((_) async => completionResponse(content));

  test('returns validated suggestions on success', () async {
    final content = paletteJson([
      {'code': 'B315', 'role': 'Highlight', 'reason': 'bright'},
      {'code': 'R101', 'role': 'Shadow', 'reason': 'deep'},
    ]);

    final result = await buildAdvisor(okClient(content)).advise(buildRequest());

    expect(result, isA<PaletteAdviceSuccess>());
    final success = result as PaletteAdviceSuccess;
    expect(success.suggestions.map((s) => s.color.newCode), ['B315', 'R101']);
    expect(success.suggestions.first.reason, 'bright');
    expect(success.suggestions.first.role, 'Highlight');
    expect(success.suggestions.last.reason, 'deep');
    expect(success.suggestions.last.role, 'Shadow');
    expect(success.modelUsed, 'model-a');
    expect(success.usedFallback, isFalse);
  });

  test('drops returned codes that are not in the active collection', () async {
    final content = paletteJson([
      {'code': 'ZZ999', 'role': 'Accent', 'reason': 'invented'},
      {'code': 'R101', 'role': 'Shadow', 'reason': 'deep'},
    ]);

    final result = await buildAdvisor(okClient(content)).advise(buildRequest());

    final success = result as PaletteAdviceSuccess;
    expect(success.suggestions.map((s) => s.color.newCode), ['R101']);
  });

  test('excludes the base colour from the suggestions', () async {
    final base = collection.first; // B315
    final content = paletteJson([
      {'code': 'B315', 'role': 'Base', 'reason': 'should drop'},
      {'code': 'R101', 'role': 'Shadow', 'reason': 'deep'},
    ]);

    final result = await buildAdvisor(okClient(content))
        .advise(buildRequest(base: base));

    final success = result as PaletteAdviceSuccess;
    expect(success.suggestions.map((s) => s.color.newCode), ['R101']);
  });

  test('respects palette size', () async {
    final content = paletteJson([
      {'code': 'B315'},
      {'code': 'R101'},
      {'code': 'G202'},
      {'code': 'B303'},
    ]);

    final result = await buildAdvisor(okClient(content))
        .advise(buildRequest(paletteSize: 2));

    final success = result as PaletteAdviceSuccess;
    expect(success.suggestions.length, 2);
  });

  test(
    'uses the fallback model when the first yields no valid codes',
    () async {
      final client = MockClient((request) async {
        final model =
            (jsonDecode(request.body) as Map<String, dynamic>)['model'];
        if (model == 'model-a') {
          return completionResponse(
            paletteJson([
              {'code': 'ZZ999'},
            ]),
          );
        }
        return completionResponse(
          paletteJson([
            {'code': 'G202'},
          ]),
        );
      });

      final result = await buildAdvisor(
        client,
        withSettings: buildSettings(fallbacks: ['model-b']),
      ).advise(buildRequest());

      final success = result as PaletteAdviceSuccess;
      expect(success.usedFallback, isTrue);
      expect(success.modelUsed, 'model-b');
      expect(success.suggestions.single.color.newCode, 'G202');
    },
  );

  test('does not try fallback models when autoFallback is off', () async {
    final client = MockClient(
      (_) async => completionResponse(
        paletteJson([
          {'code': 'ZZ999'},
        ]),
      ),
    );

    final result = await buildAdvisor(
      client,
      withSettings: buildSettings(fallbacks: ['model-b'], autoFallback: false),
    ).advise(buildRequest());

    expect(result, isA<PaletteAdviceFailure>());
    expect(
      (result as PaletteAdviceFailure).reason,
      PaletteFailureReason.noValidSuggestions,
    );
  });

  group('maps provider errors', () {
    final expected = {
      401: PaletteFailureReason.unauthorized,
      402: PaletteFailureReason.paymentRequired,
      429: PaletteFailureReason.rateLimited,
      500: PaletteFailureReason.serverError,
      503: PaletteFailureReason.serverError,
      418: PaletteFailureReason.httpError,
    };

    for (final entry in expected.entries) {
      test('HTTP ${entry.key}', () async {
        final client = MockClient(
          (_) async => errorResponse('provider says no', entry.key),
        );

        final result = await buildAdvisor(
          client,
          withSettings: buildSettings(autoFallback: false),
        ).advise(buildRequest());

        expect(result, isA<PaletteAdviceFailure>());
        expect((result as PaletteAdviceFailure).reason, entry.value);
        expect(result.message, entry.value.userMessage);
      });
    }

    test('network failure', () async {
      final client = MockClient(
        (_) async => throw http.ClientException('down'),
      );

      final result = await buildAdvisor(
        client,
        withSettings: buildSettings(autoFallback: false),
      ).advise(buildRequest());

      expect(
        (result as PaletteAdviceFailure).reason,
        PaletteFailureReason.networkError,
      );
    });

    test('unreadable JSON', () async {
      final result = await buildAdvisor(
        okClient('this is not json'),
        withSettings: buildSettings(autoFallback: false),
      ).advise(buildRequest());

      expect(
        (result as PaletteAdviceFailure).reason,
        PaletteFailureReason.invalidJson,
      );
    });
  });

  test('reports disabled and missing key before any request', () async {
    var called = false;
    final client = MockClient((_) async {
      called = true;
      return completionResponse(
        paletteJson([
          {'code': 'B315'},
        ]),
      );
    });

    final disabled = await buildAdvisor(
      client,
      withSettings: buildSettings(enabled: false),
    ).advise(buildRequest());
    expect(
      (disabled as PaletteAdviceFailure).reason,
      PaletteFailureReason.disabled,
    );

    final noKey = await buildAdvisor(client, key: null).advise(buildRequest());
    expect(
      (noKey as PaletteAdviceFailure).reason,
      PaletteFailureReason.missingKey,
    );
    expect(called, isFalse);
  });

  test('never exposes the key in a failure message', () async {
    const key = 'sk-or-super-secret-key-999';
    final client = MockClient(
      (_) async => errorResponse('the key $key is invalid', 401),
    );

    final result = await buildAdvisor(
      client,
      key: key,
      withSettings: buildSettings(autoFallback: false),
    ).advise(buildRequest());

    final failure = result as PaletteAdviceFailure;
    expect(failure.message, isNot(contains(key)));
    expect(failure.reason, PaletteFailureReason.unauthorized);
  });

  test(
    'caps the candidate list and excludes the base from the prompt',
    () async {
      final base = marker('C000', '101010');
      final many = [
        base,
        for (var i = 1; i < 30; i++)
          marker(
            'C${i.toString().padLeft(3, '0')}',
            (i * 98765 % 0xffffff).toRadixString(16).padLeft(6, '0'),
          ),
      ];

      late String prompt;
      final client = MockClient((request) async {
        final body = jsonDecode(request.body) as Map<String, dynamic>;
        final messages = body['messages'] as List;
        prompt = (messages.last as Map)['content'] as String;
        return completionResponse(
          paletteJson([
            {'code': 'C001'},
          ]),
        );
      });

      await buildAdvisor(
        client,
        maxTextCandidates: 10,
      ).advise(buildRequest(colors: many, base: base));

      final available = prompt.split('AVAILABLE_COLORS=').last;
      expect(available.split(',').length, lessThanOrEqualTo(10));
      expect(available, isNot(contains('C000#')));
      expect(prompt, contains('BASE_CODE=C000'));
    },
  );

  test('sanitizes model-supplied role, reason and tips', () async {
    final content = paletteJson(
      [
        {
          'code': 'R101',
          'role': 'Sha\u202Edow\u0000 ${'r' * 100}',
          'reason': 'deep\n\n  tone\u2066 ${'x' * 400}',
        },
      ],
      tips: [for (var i = 0; i < 8; i++) 'tip\u200B $i \u202E${'t' * 300}'],
    );

    final result = await buildAdvisor(okClient(content)).advise(buildRequest());

    final success = result as PaletteAdviceSuccess;
    final reason = success.suggestions.single.reason;
    expect(success.suggestions.single.role, 'Shadow');
    expect(reason, startsWith('deep tone xxxx'));
    expect(reason, isNot(contains('\u202E')));
    expect(reason, isNot(contains('\n')));
    expect(reason.length, lessThanOrEqualTo(200));
    expect(success.tips, hasLength(5));
    for (final tip in success.tips) {
      expect(tip.length, lessThanOrEqualTo(200));
      expect(tip, isNot(contains('\u202E')));
      expect(tip, isNot(contains('\u200B')));
    }
  });
}
