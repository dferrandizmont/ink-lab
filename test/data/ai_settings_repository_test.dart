import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/data/data.dart';

import 'fixtures.dart';

void main() {
  test('fromJson validates and clamps imported values', () {
    final settings = AiSettings.fromJson({
      'textModel': 'a' * 101,
      'visionModel': 'ok/model:free',
      'textFallbacks': [for (var i = 0; i < 9; i++) 'm$i', 'bad id', 'ctl'],
      'visionFallbacks': ['x' * 101, 'y'],
      'temperature': 9,
      'maxTokens': 999999,
    });
    expect(settings.textModel, isEmpty);
    expect(settings.visionModel, 'ok/model:free');
    expect(settings.textFallbacks, hasLength(5));
    expect(settings.visionFallbacks, ['y']);
    expect(settings.temperature, 1.0);
    expect(settings.maxTokens, 4096);
    final low = AiSettings.fromJson({'temperature': -3, 'maxTokens': 0});
    expect(low.temperature, 0.0);
    expect(low.maxTokens, 1);
  });

  test('defaults are the safe, local-first configuration', () async {
    final h = await harness();
    final value = h.aiSettings.value;
    expect(value.enabled, isFalse);
    expect(value.provider, AiProvider.local);
    expect(value.textModel, isEmpty);
    expect(value.visionModel, isEmpty);
    expect(value.textFallbacks, isEmpty);
    expect(value.temperature, 0.7);
    expect(value.maxTokens, 1200);
    expect(value.autoFallback, isTrue);
    expect(value.catalogFilter, isEmpty);
  });

  test('setters persist and survive a reopen', () async {
    final h = await harness();
    await h.aiSettings.setEnabled(true);
    await h.aiSettings.setProvider(AiProvider.openRouter);
    await h.aiSettings.setTextModel('text/model');
    await h.aiSettings.setVisionModel('vision/model');
    await h.aiSettings.setTextFallbacks(['a', 'b']);
    await h.aiSettings.setVisionFallbacks(['c']);
    await h.aiSettings.setTemperature(0.2);
    await h.aiSettings.setMaxTokens(4096);
    await h.aiSettings.setAutoFallback(false);
    await h.aiSettings.setCatalogFilter('free');

    final reopened = StoredAiSettingsRepository(h.store);
    await reopened.load();
    expect(reopened.value, h.aiSettings.value);
    expect(reopened.value.provider, AiProvider.openRouter);
    expect(reopened.value.textFallbacks, ['a', 'b']);
    expect(reopened.value.autoFallback, isFalse);
  });

  test('changes replays the current value then emits updates', () async {
    final h = await harness();
    final seen = <AiSettings>[];
    final subscription = h.aiSettings.changes.listen(seen.add);
    await pumpEventQueue();
    expect(seen, hasLength(1));
    await h.aiSettings.setProvider(AiProvider.onDevice);
    await pumpEventQueue();
    expect(seen, hasLength(2));
    expect(seen.last.provider, AiProvider.onDevice);
    await subscription.cancel();
  });

  test('unknown enum and wrong types fall back to defaults', () {
    expect(AiProvider.fromJson('nonsense'), AiProvider.local);
    expect(AiProvider.fromJson(null), AiProvider.local);
    final settings = AiSettings.fromJson({
      'provider': 'nonsense',
      'temperature': 'hot',
      'maxTokens': 1.5,
      'enabled': 'yes',
      'textFallbacks': ['ok', 42],
    });
    expect(settings.provider, AiProvider.local);
    expect(settings.temperature, 0.7);
    expect(settings.maxTokens, 1200);
    expect(settings.enabled, isFalse);
    expect(settings.textFallbacks, ['ok']);
  });

  test('secret-looking keys are never read back or exported', () async {
    final h = await harness({
      StoredAiSettingsRepository.key: jsonEncode({
        'enabled': true,
        'provider': 'openRouter',
        'apiKey': 'sk-do-not-store',
        'api_key': 'sk-do-not-store',
        'token': 'sk-do-not-store',
      }),
    });
    expect(h.aiSettings.value.enabled, isTrue);
    expect(h.aiSettings.value.provider, AiProvider.openRouter);
    final serialised = jsonEncode(h.aiSettings.value.toJson());
    expect(serialised, isNot(contains('sk-do-not-store')));
    for (final forbidden in AiSettings.forbiddenKeys) {
      expect(h.aiSettings.value.toJson().containsKey(forbidden), isFalse);
    }
  });

  test('in-memory secret store satisfies the contract', () async {
    final secrets = InMemorySecretStore();
    expect(await secrets.read('apiKey'), isNull);
    await secrets.write('apiKey', 'sk-temp');
    expect(await secrets.read('apiKey'), 'sk-temp');
    await secrets.delete('apiKey');
    expect(await secrets.read('apiKey'), isNull);
  });
}
