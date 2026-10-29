import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ink_lab/ai/open_router_client.dart';

import 'ai_test_support.dart';

void main() {
  group('OpenRouterClient', () {
    test('rejects a non-HTTPS base URL', () {
      expect(
        () => OpenRouterClient(
          client: MockClient((_) async => http.Response('', 200)),
          baseUrl: 'http://openrouter.ai/api/v1',
        ),
        throwsArgumentError,
      );
    });

    test('exposes a fixed HTTPS default base URL', () {
      final client = OpenRouterClient(
        client: MockClient((_) async => http.Response('{}', 200)),
      );
      expect(client.baseUrl, OpenRouterClient.defaultBaseUrl);
      expect(client.baseUrl, startsWith('https://'));
    });

    test(
      'fetchModels filters by free/paid and reports capability flags',
      () async {
        final client = OpenRouterClient(
          client: MockClient(
            (_) async => jsonResponse({
              'data': [
                {
                  'id': 'free-model:free',
                  'name': 'Free Model',
                  'pricing': {'prompt': '0', 'completion': '0'},
                  'architecture': {
                    'input_modalities': ['text'],
                    'output_modalities': ['text'],
                    'modality': 'text->text',
                  },
                },
                {
                  'id': 'paid-model',
                  'name': 'Paid Model',
                  'pricing': {'prompt': '0.000001', 'completion': '0.000002'},
                  'architecture': {
                    'input_modalities': ['text', 'image'],
                    'output_modalities': ['text'],
                    'modality': 'text+image->text',
                  },
                },
              ],
            }),
          ),
        );

        final free = await client.fetchModels(filter: AiModelFilter.free);
        expect(free.map((model) => model.id), ['free-model:free']);
        expect(free.single.isFree, isTrue);
        expect(free.single.supportsTextInput, isTrue);
        expect(free.single.supportsTextOutput, isTrue);
        expect(free.single.supportsVision, isFalse);

        final paid = await client.fetchModels(filter: AiModelFilter.paid);
        expect(paid.map((model) => model.id), ['paid-model']);
        expect(paid.single.supportsImageInput, isTrue);
        expect(paid.single.promptPricePerToken, isNotNull);

        final both = await client.fetchModels(filter: AiModelFilter.both);
        expect(both.map((model) => model.id), [
          'free-model:free',
          'paid-model',
        ]);
      },
    );

    test(
      'sends the key only in the Authorization header, never the URL',
      () async {
        const key = 'sk-or-abcdef1234567890';
        late http.Request captured;
        final client = OpenRouterClient(
          client: MockClient((request) async {
            captured = request;
            return completionResponse('{}');
          }),
        );

        await client.completeJson(
          apiKey: key,
          model: 'some/model',
          temperature: 0.5,
          maxTokens: 100,
          systemPrompt: 'system',
          userPrompt: 'user',
        );

        expect(captured.url.toString(), isNot(contains(key)));
        expect(captured.url.query, isEmpty);
        expect(captured.headers['Authorization'], 'Bearer $key');
        expect(captured.body, isNot(contains(key)));
        expect(captured.body, contains('response_format'));
      },
    );

    test(
      'maps an HTTP error to a typed exception with a redacted message',
      () async {
        const key = 'sk-or-abcdef1234567890';
        final client = OpenRouterClient(
          client: MockClient(
            (_) async => errorResponse('invalid key $key', 401),
          ),
        );

        await expectLater(
          client.completeJson(
            apiKey: key,
            model: 'm',
            temperature: 0.5,
            maxTokens: 100,
            systemPrompt: 's',
            userPrompt: 'u',
          ),
          throwsA(
            isA<OpenRouterHttpException>()
                .having((error) => error.statusCode, 'statusCode', 401)
                .having(
                  (error) => error.message,
                  'message',
                  isNot(contains(key)),
                ),
          ),
        );
      },
    );

    test('maps a transport failure to a network exception', () async {
      final client = OpenRouterClient(
        client: MockClient((_) async => throw http.ClientException('no route')),
      );

      await expectLater(
        client.completeJson(
          apiKey: 'k',
          model: 'm',
          temperature: 0.5,
          maxTokens: 1,
          systemPrompt: 's',
          userPrompt: 'u',
        ),
        throwsA(isA<OpenRouterNetworkException>()),
      );
    });

    test(
      'retries once without response_format when the model rejects it',
      () async {
        var calls = 0;
        final client = OpenRouterClient(
          client: MockClient((request) async {
            calls++;
            if (calls == 1) {
              return errorResponse(
                'response_format json_object is not supported',
                400,
              );
            }
            expect(request.body, isNot(contains('response_format')));
            return completionResponse('{"palette":[{"code":"B315"}]}');
          }),
        );

        final content = await client.completeJson(
          apiKey: 'k',
          model: 'm',
          temperature: 0.5,
          maxTokens: 1,
          systemPrompt: 's',
          userPrompt: 'u',
        );

        expect(content, contains('B315'));
        expect(calls, 2);
      },
    );

    test('rejects an unreadable completion body', () async {
      final client = OpenRouterClient(
        client: MockClient((_) async => http.Response('not json', 200)),
      );

      await expectLater(
        client.completeJson(
          apiKey: 'k',
          model: 'm',
          temperature: 0.5,
          maxTokens: 1,
          systemPrompt: 's',
          userPrompt: 'u',
        ),
        throwsA(isA<OpenRouterFormatException>()),
      );
    });
  });

  group('redactSecret', () {
    test('removes the exact secret, bearer tokens and sk- keys', () {
      const secret = 'sk-or-abc123456';
      final redacted = redactSecret(
        'key=$secret header=Bearer $secret other=sk-zzz999999',
        secret,
      );
      expect(redacted, isNot(contains(secret)));
      expect(redacted, isNot(contains('sk-zzz999999')));
      expect(redacted, contains('[redacted]'));
    });
  });
  group('OpenRouterClient hardening', () {
    Future<String> complete(OpenRouterClient c) => c.completeJson(
      apiKey: 'sk-or-v1-SECRETKEY123456',
      model: 'm',
      temperature: 0.5,
      maxTokens: 1,
      systemPrompt: 's',
      userPrompt: 'u',
    );

    test('pins the host and rejects userinfo, query, fragment, port', () {
      for (final url in [
        'https://evil.example/api/v1',
        'https://openrouter.ai.evil.example/api/v1',
        'https://user:pw@openrouter.ai/api/v1',
        'https://openrouter.ai/api/v1?x=1',
        'https://openrouter.ai/api/v1#f',
        'https://openrouter.ai:8443/api/v1',
      ]) {
        expect(
          () => OpenRouterClient(
            client: MockClient((_) async => http.Response('', 200)),
            baseUrl: url,
          ),
          throwsArgumentError,
          reason: url,
        );
      }
      expect(
        OpenRouterClient(
          client: MockClient((_) async => http.Response('', 200)),
          baseUrl: 'https://openrouter.ai:443/api/v1/',
        ).baseUrl,
        'https://openrouter.ai:443/api/v1',
      );
    });

    test(
      'allowedHostForTesting permits another host and builds endpoints',
      () async {
        Uri? seen;
        final client = OpenRouterClient(
          client: MockClient((request) async {
            seen = request.url;
            return completionResponse('{"palette":[]}');
          }),
          baseUrl: 'https://test.example:9443/v1/',
          allowedHostForTesting: 'test.example',
        );
        await complete(client);
        expect(
          seen.toString(),
          'https://test.example:9443/v1/chat/completions',
        );
      },
    );

    test(
      'disables redirects and treats 3xx as an error without echoing it',
      () async {
        bool? follow;
        final client = OpenRouterClient(
          client: MockClient((request) async {
            follow = request.followRedirects;
            return http.Response(
              'moved sk-or-v1-SECRETKEY123456',
              302,
              headers: {'location': 'https://evil.example/?k=SECRET'},
            );
          }),
        );
        await expectLater(
          complete(client),
          throwsA(
            isA<OpenRouterHttpException>()
                .having((e) => e.statusCode, 'status', 302)
                .having((e) => e.toString(), 'text', isNot(contains('evil')))
                .having((e) => e.toString(), 'text', isNot(contains('SECRET'))),
          ),
        );
        expect(follow, isFalse);

        follow = null;
        final models = OpenRouterClient(
          client: MockClient((request) async {
            follow = request.followRedirects;
            return http.Response('', 307);
          }),
        );
        await expectLater(
          models.fetchModels(),
          throwsA(isA<OpenRouterHttpException>()),
        );
        expect(follow, isFalse);
      },
    );

    test('aborts an oversized chat response while streaming', () async {
      final chunk = List<int>.filled(512 * 1024, 0x61);
      final client = OpenRouterClient(
        client: MockClient.streaming((request, _) async {
          return http.StreamedResponse(
            Stream.fromIterable(List.generate(6, (_) => chunk)),
            200,
          );
        }),
      );
      await expectLater(
        complete(client),
        throwsA(isA<OpenRouterFormatException>()),
      );
    });

    test('rejects an oversized declared content length', () async {
      final client = OpenRouterClient(
        client: MockClient.streaming((request, _) async {
          return http.StreamedResponse(
            const Stream<List<int>>.empty(),
            200,
            contentLength: 9 * 1024 * 1024,
          );
        }),
      );
      await expectLater(
        client.fetchModels(),
        throwsA(isA<OpenRouterFormatException>()),
      );
    });

    group('free detection', () {
      AiModelDescriptor? parse(Map<String, dynamic> json) =>
          AiModelDescriptor.fromOpenRouter(json);

      test(
        'free needs both prices at exactly zero; the :free suffix alone is not',
        () {
          expect(
            parse({
              'id': 'a/b',
              'pricing': {'prompt': '0', 'completion': '0'},
            })!.isFree,
            isTrue,
          );
          expect(parse({'id': 'a/b:free'})!.isFree, isFalse);
          expect(
            parse({
              'id': 'a/b:free',
              'pricing': {'prompt': '0.1', 'completion': '0.1'},
            })!.isFree,
            isFalse,
          );
          // Prompt free, completion paid.
          expect(
            parse({
              'id': 'a/b',
              'pricing': {'prompt': '0', 'completion': '0.000002'},
            })!.isFree,
            isFalse,
          );
          // Missing or unparsable prices are not free.
          expect(parse({'id': 'a/b'})!.isFree, isFalse);
          expect(
            parse({
              'id': 'a/b',
              'pricing': {'prompt': '0'},
            })!.isFree,
            isFalse,
          );
        },
      );

      test('routers with variable pricing (-1) are not free', () async {
        final client = OpenRouterClient(
          client: MockClient(
            (_) async => jsonResponse({
              'data': [
                {
                  'id': 'openrouter/auto',
                  'name': 'Auto Router (Beta)',
                  'pricing': {'prompt': '-1', 'completion': '-1'},
                },
                {
                  'id': 'nvidia/switchyard',
                  'name': 'NVIDIA: Switchyard',
                  'pricing': {'prompt': '-1', 'completion': '-1'},
                },
                {
                  'id': 'meta/real:free',
                  'name': 'Real free',
                  'pricing': {'prompt': '0', 'completion': '0'},
                },
              ],
            }),
          ),
        );
        final free = await client.fetchModels(filter: AiModelFilter.free);
        expect(free.map((m) => m.id), ['meta/real:free']);
        final paid = await client.fetchModels(filter: AiModelFilter.paid);
        // Routers are not free, but they are not offered either.
        expect(paid, isEmpty);
        final catalog = await client.fetchModelCatalog(
          filter: AiModelFilter.both,
        );
        expect(catalog.totalCount, 3);
        expect(catalog.models.map((m) => m.id), ['meta/real:free']);
      });
    });

    test('catalog ids and names are display-sanitized', () async {
      final client = OpenRouterClient(
        client: MockClient(
          (_) async => jsonResponse({
            'data': [
              {
                'id': 'a/b:free',
                'name': 'Na\u0007me   \u2066x\u2069 \n ${'z' * 200}',
                'pricing': {'prompt': '0', 'completion': '0'},
              },
            ],
          }),
        ),
      );
      final models = await client.fetchModels();
      expect(models.single.id, 'a/b:free');
      expect(models.single.name.length, lessThanOrEqualTo(80));
      expect(models.single.name, startsWith('Name x z'));
      expect(models.single.name, isNot(contains('\u202E')));
    });

    test('ids that are not plain model slugs are dropped at parse time', () {
      AiModelDescriptor? parse(String id) =>
          AiModelDescriptor.fromOpenRouter({'id': id, 'name': 'n'});
      expect(parse('google/gemini-2.5-flash-lite:free'), isNotNull);
      expect(parse('a/b\u202E:free'), isNull);
      expect(parse('a b'), isNull);
      expect(parse('a/b"; drop'), isNull);
      expect(parse('<script>'), isNull);
      expect(parse('a/${'x' * 130}'), isNull);
      expect(parse(''), isNull);
      expect(parse('a' * 120), isNotNull);
    });
  });
}
