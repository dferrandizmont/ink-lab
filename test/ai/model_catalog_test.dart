import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:ink_lab/ai/open_router_client.dart';
import 'package:ink_lab/data/ai_settings.dart';

import 'ai_test_support.dart';

Map<String, Object?> _model(
  String id,
  String name, {
  List<String> input = const ['text'],
  List<String> output = const ['text'],
  Object? context = 128000,
  List<String> params = const ['temperature', 'response_format'],
  String prompt = '0.000001',
  String completion = '0.000002',
}) => {
  'id': id,
  'name': name,
  'context_length': context,
  'architecture': {
    'modality': '${input.join('+')}->${output.join('+')}',
    'input_modalities': input,
    'output_modalities': output,
  },
  'pricing': {'prompt': prompt, 'completion': completion},
  'supported_parameters': params,
};

/// A small but realistic slice of the OpenRouter catalog.
final List<Map<String, Object?>> _catalog = [
  _model(
    'google/gemini-2.5-flash-lite',
    'Google: Gemini 2.5 Flash Lite',
    input: ['text', 'image', 'file'],
    params: ['structured_outputs'],
  ),
  _model(
    'openai/gpt-4o-mini',
    'OpenAI: GPT-4o mini',
    input: ['text', 'image'],
    params: ['structured_outputs', 'tools'],
  ),
  _model(
    'anthropic/claude-sonnet',
    'Anthropic: Claude Sonnet',
    params: ['response_format', 'tools'],
  ),
  _model('mistralai/old-chat', 'Mistral: Old Chat', params: ['temperature']),
  _model(
    'meta/llama-free:free',
    'Meta: Llama (free)',
    prompt: '0',
    completion: '0',
    params: ['response_format'],
  ),
  _model(
    'acme/zeta-free:free',
    'Acme: Zeta (free)',
    prompt: '0',
    completion: '0',
    params: ['temperature'],
  ),
  // Unsuitable entries.
  _model('black-forest/flux', 'Flux Image', output: ['image']),
  _model('openai/gpt-image', 'GPT Image', output: ['image', 'text']),
  _model('openai/whisper', 'Whisper', input: ['audio']),
  _model('openai/tts', 'Speech', output: ['audio']),
  _model('acme/tiny', 'Acme Tiny', context: 4096),
  _model(
    'openrouter/auto',
    'Auto Router',
    prompt: '-1',
    completion: '-1',
    context: 2000000,
  ),
  _model('acme/smart-pick', 'Acme Router', context: 200000),
  _model(
    'nvidia/switchyard',
    'NVIDIA: Switchyard',
    prompt: '-1',
    completion: '-1',
  ),
  _model('acme/auto', 'Acme Pick', context: 200000),
];

OpenRouterClient _client(List<Map<String, Object?>> data) => OpenRouterClient(
  client: MockClient((_) async => jsonResponse({'data': data})),
);

void main() {
  group('model catalog filtering', () {
    test('keeps only text-in text-out, non-router, >= 8k context', () async {
      final catalog = await _client(_catalog)
          .fetchModelCatalog(filter: AiModelFilter.both);
      final ids = catalog.models.map((m) => m.id).toSet();
      expect(ids, {
        'google/gemini-2.5-flash-lite',
        'openai/gpt-4o-mini',
        'anthropic/claude-sonnet',
        'mistralai/old-chat',
        'meta/llama-free:free',
        'acme/zeta-free:free',
      });
      expect(catalog.totalCount, _catalog.length);
      for (final model in catalog.models) {
        expect(model.isSuitable, isTrue);
      }
    });

    test('sorts recommended, then structured-capable, then by name', () async {
      final catalog = await _client(_catalog)
          .fetchModelCatalog(filter: AiModelFilter.both);
      expect(catalog.models.map((m) => m.id).toList(), [
        // Recommended first (by name: Google before OpenAI).
        'google/gemini-2.5-flash-lite',
        'openai/gpt-4o-mini',
        // Declares response_format / structured_outputs, by name.
        'anthropic/claude-sonnet',
        'meta/llama-free:free',
        // The rest, by name.
        'acme/zeta-free:free',
        'mistralai/old-chat',
      ]);
      expect(AiSettings.recommendedTextModel, 'google/gemini-2.5-flash-lite');
      expect(catalog.models.first.isRecommended, isTrue);
      expect(catalog.structuredCount, 4);
      final old = catalog.models.firstWhere(
        (m) => m.id == 'mistralai/old-chat',
      );
      expect(old.declaresJsonSupport, isFalse);
    });

    test('the free/paid filter applies on top of suitability', () async {
      final client = _client(_catalog);
      final free = await client.fetchModels(filter: AiModelFilter.free);
      expect(free.map((m) => m.id), [
        'meta/llama-free:free',
        'acme/zeta-free:free',
      ]);
      final paid = await client.fetchModels(filter: AiModelFilter.paid);
      expect(paid.map((m) => m.id), isNot(contains('meta/llama-free:free')));
      expect(paid.map((m) => m.id), isNot(contains('openrouter/auto')));
    });

    test('routers are detected by id, name and variable pricing', () {
      AiModelDescriptor d(Map<String, Object?> json) =>
          AiModelDescriptor.fromOpenRouter(json)!;
      expect(d(_model('openrouter/auto', 'Auto Router')).isRouter, isTrue);
      expect(d(_model('foo/auto', 'Foo')).isRouter, isTrue);
      expect(d(_model('foo/bar', 'Smart Router')).isRouter, isTrue);
      expect(d(_model('foo/model-router', 'Foo')).isRouter, isTrue);
      expect(
        d(
          _model(
            'nvidia/switchyard',
            'Switchyard',
            prompt: '-1',
            completion: '-1',
          ),
        ).isRouter,
        isTrue,
      );
      expect(d(_model('foo/bar', 'Bar')).isRouter, isFalse);
    });

    test('context window boundary and unknown values', () {
      AiModelDescriptor d(Object? context) => AiModelDescriptor.fromOpenRouter(
        _model('a/b', 'B', context: context),
      )!;
      expect(d(7999).isSuitable, isFalse);
      expect(d(8000).isSuitable, isTrue);
      expect(d('16000').contextLength, 16000);
      // Unknown window: not excluded.
      expect(d(null).isSuitable, isTrue);
    });

    test('modalities: image or audio output and non-text input are out', () {
      AiModelDescriptor d({
        List<String> input = const ['text'],
        List<String> output = const ['text'],
      }) => AiModelDescriptor.fromOpenRouter(
        _model('a/b', 'B', input: input, output: output),
      )!;
      expect(d().isSuitable, isTrue);
      expect(d(input: ['text', 'image']).isSuitable, isTrue);
      expect(d(output: ['image']).isSuitable, isFalse);
      expect(d(output: ['text', 'image']).isSuitable, isFalse);
      expect(d(output: ['audio']).isSuitable, isFalse);
      expect(d(input: ['audio']).isSuitable, isFalse);
      expect(d(input: ['image']).isSuitable, isFalse);
    });

    test('an entry without modality details is not excluded for it', () {
      final model = AiModelDescriptor.fromOpenRouter({'id': 'a/b'})!;
      expect(model.isSuitable, isTrue);
      expect(model.declaresJsonSupport, isFalse);
    });
  });
}
