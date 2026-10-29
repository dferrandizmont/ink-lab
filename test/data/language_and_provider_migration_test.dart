import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/data/data.dart';

import 'fixtures.dart';

void main() {
  group('app language', () {
    test('defaults to following the system', () async {
      final h = await harness();
      expect(h.appSettings.language, AppLanguage.system);
      expect(h.appSettings.state.toJson()['language'], 'system');
    });

    test('is stored and survives a reopen', () async {
      final h = await harness();
      await h.appSettings.setLanguage(AppLanguage.spanish);
      expect(h.appSettings.language, AppLanguage.spanish);

      final reopened = StoredAppSettingsRepository(h.store);
      await reopened.load();
      expect(reopened.language, AppLanguage.spanish);

      await h.appSettings.setLanguage(AppLanguage.english);
      await reopened.load();
      expect(reopened.language, AppLanguage.english);
      expect(reopened.state, h.appSettings.state);
    });

    test('an old install without the key keeps working (System)', () async {
      final h = await harness();
      await h.store.setString('theme_mode', 'Dark');
      final reopened = StoredAppSettingsRepository(h.store);
      await reopened.load();
      expect(reopened.language, AppLanguage.system);
      expect(reopened.themeMode, AppThemeMode.dark);
    });

    test('decoding is lenient and never throws', () {
      expect(AppLanguage.fromJson('es'), AppLanguage.spanish);
      expect(AppLanguage.fromJson('ES'), AppLanguage.spanish);
      expect(AppLanguage.fromJson('English'), AppLanguage.english);
      expect(AppLanguage.fromJson('en'), AppLanguage.english);
      expect(AppLanguage.fromJson('system'), AppLanguage.system);
      expect(AppLanguage.fromJson('klingon'), AppLanguage.system);
      expect(AppLanguage.fromJson(null), AppLanguage.system);
      expect(AppLanguage.fromJson(42), AppLanguage.system);
      expect(AppLanguage.spanish.languageCode, 'es');
      expect(AppLanguage.system.languageCode, isNull);
    });

    test('is part of the backup and restores', () async {
      final source = await harness();
      await source.appSettings.setLanguage(AppLanguage.spanish);
      final exported = source.backup().exportJson();
      expect(
        (jsonDecode(exported)
            as Map<String, dynamic>)['appSettings']['language'],
        'es',
      );

      final target = await harness();
      expect(target.appSettings.language, AppLanguage.system);
      await target.backup().importJson(exported);
      expect(target.appSettings.language, AppLanguage.spanish);

      // The restored value is also what the store holds.
      final reopened = StoredAppSettingsRepository(target.store);
      await reopened.load();
      expect(reopened.language, AppLanguage.spanish);
    });

    test(
      'a backup without a language imports with the System default',
      () async {
        final h = await harness();
        await h.appSettings.setLanguage(AppLanguage.english);
        await h.backup().importJson(
          jsonEncode(<String, dynamic>{
            'version': 1,
            'appSettings': <String, dynamic>{'brand': 'ohuhu_oahu'},
          }),
        );
        expect(h.appSettings.language, AppLanguage.system);
      },
    );
  });

  group('AI provider survives updates', () {
    Future<Harness> withStoredAi(Map<String, dynamic> json) async {
      final h = await harness();
      await h.store.setString(StoredAiSettingsRepository.key, jsonEncode(json));
      return h;
    }

    test('the canonical spellings are read as they are', () {
      for (final AiProvider provider in AiProvider.values) {
        expect(AiProvider.fromJson(provider.wireId), provider);
        expect(AiProvider.needsMigration(provider.wireId), isFalse);
      }
    });

    test('older or hand-written spellings still resolve to the provider', () {
      const Map<String, AiProvider> spellings = <String, AiProvider>{
        'on_device': AiProvider.onDevice,
        'on-device': AiProvider.onDevice,
        'OnDevice': AiProvider.onDevice,
        'ondevice': AiProvider.onDevice,
        'ON_DEVICE': AiProvider.onDevice,
        'On-device': AiProvider.onDevice,
        'geminiNano': AiProvider.onDevice,
        'open_router': AiProvider.openRouter,
        'OpenRouter': AiProvider.openRouter,
        'open-router': AiProvider.openRouter,
        'Local': AiProvider.local,
        'colourTheory': AiProvider.local,
        'colour_theory': AiProvider.local,
        'colorTheory': AiProvider.local,
      };
      spellings.forEach((String raw, AiProvider expected) {
        expect(AiProvider.fromJson(raw), expected, reason: raw);
      });
    });

    test('unknown or missing values fall back to the local engine', () {
      expect(AiProvider.fromJson('mystery'), AiProvider.local);
      expect(AiProvider.fromJson(null), AiProvider.local);
      expect(AiProvider.fromJson(7), AiProvider.local);
      expect(AiProvider.needsMigration('mystery'), isFalse);
      expect(AiProvider.needsMigration(null), isFalse);
    });

    test('a stored legacy value is migrated on load and kept', () async {
      final h = await withStoredAi(<String, dynamic>{
        'enabled': true,
        'provider': 'on_device',
        'textModel': 'google/gemini-2.5-flash-lite',
      });

      await h.aiSettings.load();
      expect(h.aiSettings.value.provider, AiProvider.onDevice);
      expect(h.aiSettings.value.enabled, isTrue);
      expect(h.aiSettings.value.textModel, 'google/gemini-2.5-flash-lite');

      // The stored JSON was rewritten with the canonical id...
      final stored = jsonDecode(
        (await h.store.getString(StoredAiSettingsRepository.key))!,
      ) as Map<String, dynamic>;
      expect(stored['provider'], 'onDevice');
      expect(stored['enabled'], isTrue);

      // ...so a fresh start keeps the selection.
      final reopened = StoredAiSettingsRepository(h.store);
      await reopened.load();
      expect(reopened.value.provider, AiProvider.onDevice);
    });

    test('a canonical stored value is left byte-for-byte alone', () async {
      final h = await withStoredAi(<String, dynamic>{
        'enabled': true,
        'provider': 'onDevice',
      });
      final before = await h.store.getString(StoredAiSettingsRepository.key);
      await h.aiSettings.load();
      expect(h.aiSettings.value.provider, AiProvider.onDevice);
      expect(await h.store.getString(StoredAiSettingsRepository.key), before);
    });

    test(
      'a legacy spelling in a backup imports as the right provider',
      () async {
        final h = await harness();
        await h.backup().importJson(
          jsonEncode(<String, dynamic>{
            'version': 1,
            'aiSettings': <String, dynamic>{
              'provider': 'On-device',
              'enabled': true,
            },
          }),
        );
        expect(h.aiSettings.value.provider, AiProvider.onDevice);
        // Import never switches the AI on by itself.
        expect(h.aiSettings.value.enabled, isFalse);
      },
    );
  });
}
