import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ink_lab/ai/ai.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/palette_advisor.dart' show PaletteAdvisorRequest;
import 'package:ink_lab/data/ai_settings.dart';

import 'ai_test_support.dart';

const String _key = 'sk-or-test-key-1234567890';

http.Response _message(Map<String, Object?> message) => jsonResponse({
  'choices': [
    {'message': message, 'finish_reason': 'stop'},
  ],
});

String _modelOf(http.Request request) =>
    RegExp(r'"model":"([^"]+)"').firstMatch(request.body)!.group(1)!;

void main() {
  PaletteAdvisorRequest request() => PaletteAdvisorRequest(
    availableColors: collection,
    paletteSize: 3,
    mode: PaletteMode.recommended,
    brand: MarkerBrand.ohuhuOahu,
  );

  OpenRouterPaletteAdvisor advisor(MockClient client, {AiSettings? settings}) =>
      OpenRouterPaletteAdvisor(
        client: OpenRouterClient(client: client),
        settings: () =>
            settings ??
            AiSettings(enabled: true, textModel: 'model-a', autoFallback: true),
        apiKey: () => _key,
      );

  Future<List<String>> codesFor(http.Response response) async {
    final result = await advisor(MockClient((_) async => response))
        .advise(request());
    expect(result, isA<PaletteAdviceSuccess>(), reason: '$result');
    return (result as PaletteAdviceSuccess).suggestions
        .map((s) => s.color.newCode)
        .toList();
  }

  const body =
      '{"palette":[{"code":"B315","role":"Shadow","reason":"deep"},'
      '{"code":"R101","role":"Accent","reason":"warm"}],"tips":["blend"]}';

  group('response variants', () {
    test('plain JSON object', () async {
      expect(await codesFor(completionResponse(body)), ['B315', 'R101']);
    });

    test('JSON inside a ```json fence', () async {
      expect(await codesFor(completionResponse('```json\n$body\n```')), [
        'B315',
        'R101',
      ]);
    });

    test('prose before and after the JSON, with stray braces', () async {
      final text =
          'Sure! Here is the {palette} you asked for:\n$body\n'
          'Hope {this} helps.';
      expect(await codesFor(completionResponse(text)), ['B315', 'R101']);
    });

    test('braces and brackets inside JSON strings are not structure', () async {
      const tricky =
          '{"palette":[{"code":"B315","role":"Shadow",'
          '"reason":"use } and ] sparingly {"}]}';
      final result = await advisor(
        MockClient((_) async => completionResponse('Answer: $tricky done')),
      ).advise(request());
      final success = result as PaletteAdviceSuccess;
      expect(success.suggestions.single.color.newCode, 'B315');
      expect(success.suggestions.single.reason, contains('sparingly'));
    });

    test('content as a list of parts', () async {
      final response = _message({
        'role': 'assistant',
        'content': [
          {'type': 'text', 'text': 'Here you go:'},
          {'type': 'text', 'text': '```json\n$body\n```'},
        ],
      });
      expect(await codesFor(response), ['B315', 'R101']);
    });

    test('empty content with the JSON in reasoning', () async {
      final response = _message({
        'role': 'assistant',
        'content': '',
        'reasoning': 'Thinking about colours... final answer: $body',
      });
      expect(await codesFor(response), ['B315', 'R101']);
    });

    test('content without JSON but JSON in reasoning_content', () async {
      final response = _message({
        'role': 'assistant',
        'content': 'Done.',
        'reasoning_content': body,
      });
      expect(await codesFor(response), ['B315', 'R101']);
    });

    test('JSON in reasoning_details', () async {
      final response = _message({
        'role': 'assistant',
        'content': null,
        'reasoning_details': [
          {'type': 'reasoning.text', 'text': body},
        ],
      });
      expect(await codesFor(response), ['B315', 'R101']);
    });

    test('schema keys in any letter case', () async {
      const shouty =
          '{"Palette":[{"CODE":"G202","Role":"Mid","Reason":"green"}],'
          '"TIPS":["tip"]}';
      final result = await advisor(
        MockClient((_) async => completionResponse(shouty)),
      ).advise(request());
      final success = result as PaletteAdviceSuccess;
      expect(success.suggestions.single.color.newCode, 'G202');
      expect(success.suggestions.single.reason, 'green');
      expect(success.suggestions.single.role, 'Midtone');
      expect(success.tips, ['tip']);
    });

    test('a bare array and a single-code object', () async {
      expect(await codesFor(completionResponse('[{"code":"B303"},"Y404"]')), [
        'B303',
        'Y404',
      ]);
      expect(
        await codesFor(completionResponse('{"code":"N505","role":"Neutral"}')),
        ['N505'],
      );
    });

    test('skips an unrelated JSON object before the palette', () async {
      final text = 'Meta: {"thinking":true}\n$body';
      expect(await codesFor(completionResponse(text)), ['B315', 'R101']);
    });

    test('invented codes are still dropped after lenient parsing', () async {
      const text = '```json\n{"palette":[{"code":"ZZ9"},{"code":"R101"}]}\n```';
      expect(await codesFor(completionResponse(text)), ['R101']);
    });
  });

  group('unreadable responses', () {
    Future<PaletteAdviceFailure> failureFor(http.Response response) async {
      final result = await advisor(MockClient((_) async => response))
          .advise(request());
      return result as PaletteAdviceFailure;
    }

    test('reasoning-only prose is a typed invalidJson error', () async {
      final failure = await failureFor(
        _message({
          'role': 'assistant',
          'content': '',
          'reasoning': 'The user wants colours. Let me think about blues.',
        }),
      );
      expect(failure.reason, PaletteFailureReason.invalidJson);
    });

    test('prose without any JSON is invalidJson', () async {
      final failure = await failureFor(
        completionResponse('I cannot help with that.'),
      );
      expect(failure.reason, PaletteFailureReason.invalidJson);
    });

    test('truncated JSON is invalidJson', () async {
      final failure = await failureFor(
        completionResponse('{"palette":[{"code":"B315","role":"Sh'),
      );
      expect(failure.reason, PaletteFailureReason.invalidJson);
    });

    test('parseable JSON with no codes is not a success', () {
      expect(
        () => parsePaletteContent('{"palette":[],"tips":[]}'),
        throwsA(isA<OpenRouterFormatException>()),
      );
    });

    test('an empty message is a format error from the client', () async {
      final client = OpenRouterClient(
        client: MockClient(
          (_) async => _message({'role': 'assistant', 'content': ''}),
        ),
      );
      await expectLater(
        client.completeJson(
          apiKey: _key,
          model: 'm',
          temperature: 0.5,
          maxTokens: 10,
          systemPrompt: 's',
          userPrompt: 'u',
        ),
        throwsA(isA<OpenRouterFormatException>()),
      );
    });
  });

  group('response_format retry', () {
    test(
      'retries once without it when the 400 mentions response_format',
      () async {
        var calls = 0;
        final client = OpenRouterClient(
          client: MockClient((request) async {
            calls++;
            if (calls == 1) {
              expect(request.body, contains('response_format'));
              return errorResponse('response_format is not supported', 400);
            }
            expect(request.body, isNot(contains('response_format')));
            return completionResponse(body);
          }),
        );
        final content = await client.completeJson(
          apiKey: _key,
          model: 'm',
          temperature: 0.5,
          maxTokens: 10,
          systemPrompt: 's',
          userPrompt: 'u',
        );
        expect(content, contains('B315'));
        expect(calls, 2);
      },
    );

    test('retries on a 422 that mentions structured outputs or JSON', () async {
      for (final message in [
        'Structured outputs unsupported',
        'Invalid JSON mode',
      ]) {
        var calls = 0;
        final client = OpenRouterClient(
          client: MockClient((request) async {
            calls++;
            return calls == 1
                ? errorResponse(message, 422)
                : completionResponse(body);
          }),
        );
        await client.completeJson(
          apiKey: _key,
          model: 'm',
          temperature: 0.5,
          maxTokens: 10,
          systemPrompt: 's',
          userPrompt: 'u',
        );
        expect(calls, 2, reason: message);
      }
    });

    test(
      'does not retry a 400 or 422 that is unrelated to the format',
      () async {
        for (final status in [400, 422]) {
          var calls = 0;
          final client = OpenRouterClient(
            client: MockClient((_) async {
              calls++;
              return errorResponse('Provider returned error', status);
            }),
          );
          await expectLater(
            client.completeJson(
              apiKey: _key,
              model: 'm',
              temperature: 0.5,
              maxTokens: 10,
              systemPrompt: 's',
              userPrompt: 'u',
            ),
            throwsA(isA<OpenRouterHttpException>()),
          );
          expect(calls, 1, reason: '$status');
        }
      },
    );

    test('does not loop: a second 400 surfaces as an HTTP error', () async {
      var calls = 0;
      final client = OpenRouterClient(
        client: MockClient((_) async {
          calls++;
          return errorResponse('response_format rejected', 400);
        }),
      );
      await expectLater(
        client.completeJson(
          apiKey: _key,
          model: 'm',
          temperature: 0.5,
          maxTokens: 10,
          systemPrompt: 's',
          userPrompt: 'u',
        ),
        throwsA(isA<OpenRouterHttpException>()),
      );
      expect(calls, 2);
    });
  });

  group('fallback models', () {
    test(
      'an unreadable primary response falls through to the fallback',
      () async {
        final models = <String>[];
        final client = MockClient((request) async {
          final model = _modelOf(request);
          models.add(model);
          return model == 'model-a'
              ? completionResponse('Sorry, no JSON today.')
              : completionResponse(body);
        });
        final result = await advisor(
          client,
          settings: AiSettings(
            enabled: true,
            textModel: 'model-a',
            textFallbacks: ['model-b'],
          ),
        ).advise(request());

        final success = result as PaletteAdviceSuccess;
        expect(models, ['model-a', 'model-b']);
        expect(success.modelUsed, 'model-b');
        expect(success.usedFallback, isTrue);
      },
    );

    test('all models unreadable: clear failure message', () async {
      final failure = await advisor(
        MockClient((_) async => completionResponse('no json')),
        settings: AiSettings(
          enabled: true,
          textModel: 'model-a',
          textFallbacks: ['model-b'],
        ),
      ).advise(request());
      expect(failure, isA<PaletteAdviceFailure>());
      expect(
        (failure as PaletteAdviceFailure).message,
        'The provider returned an unreadable response.',
      );
    });

    test('with no text model set the recommended defaults are tried', () async {
      final models = <String>[];
      final client = MockClient((request) async {
        models.add(_modelOf(request));
        return completionResponse('nothing useful');
      });
      await advisor(
        client,
        settings: AiSettings(enabled: true),
      ).advise(request());
      expect(models, [
        AiSettings.recommendedTextModel,
        ...AiSettings.recommendedTextFallbacks,
      ]);
    });
  });
}
