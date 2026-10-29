import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';

import 'fixtures.dart';

/// A hand-written sample in the Kotlin plain-backup shape: the envelope keys,
/// the `version` field and the model field names the Kotlin `BackupCodec`
/// plain variant wrote.
const kotlinSample = '''
{
  "version": 1,
  "appSettings": {
    "brand": "ohuhu_oahu",
    "scope": "MixedBrands",
    "packSelectionMode": "Compare",
    "selectedCoreSetIds": ["classic_160", "classic_80"],
    "selectedAddonSetIds": ["skin_36"],
    "ownedMarkerCodes": ["R1"],
    "favorites": ["R1", "decotime:01"],
    "nameDisplayMode": "Both",
    "onboardingCompleted": true
  },
  "savedPalettes": {
    "ohuhu_oahu": [
      {
        "id": "sp1",
        "brandId": "ohuhu_oahu",
        "name": "Forest",
        "baseCode": "G1",
        "baseName": "Green",
        "mode": "Triad",
        "paletteSize": 3,
        "createdAtEpochMs": 1793190000000,
        "colorCodes": ["G1", "B1", "R1"],
        "isCustom": false
      }
    ],
    "decotime": [
      {
        "id": "sp2",
        "brandId": "decotime",
        "name": "Deco mix",
        "baseCode": "01",
        "baseName": "Blue",
        "mode": "Complementary",
        "paletteSize": 2,
        "createdAtEpochMs": 1793190000001,
        "colorCodes": ["01", "02"]
      }
    ]
  },
  "colorMatchHistory": [
    {
      "id": "cm1",
      "sampledHex": "aabbcc",
      "matchedCode": "R1",
      "matchedName": "Red",
      "matchedHex": "aabbcd",
      "deltaE": 1.5,
      "createdAtEpochMs": 1793190000000
    }
  ],
  "aiSettings": {
    "enabled": true,
    "provider": "openRouter",
    "textModel": "m/text",
    "temperature": 0.3,
    "maxTokens": 2048
  }
}
''';

Future<Harness> populated() async {
  final h = await harness();
  await h.appSettings.setBrand(MarkerBrand.decoTime);
  await h.appSettings.setScope(BrandScope.mixedBrands);
  await h.appSettings.setOwnedSetIds({'classic_80', 'classic_40', 'skin_36'});
  await h.appSettings.setExtraMarkerIds({'R1', 'decotime:02'});
  await h.appSettings.setMatchSuggestUnowned(false);
  await h.appSettings.setFavorites({'decotime:01', 'ohuhu_oahu:R3'});
  await h.appSettings.setNameDisplayMode(NameDisplayMode.newOnly);
  await h.appSettings.setOnboardingCompleted(true);
  await h.appSettings.setThemeMode(AppThemeMode.dark);
  await h.savedPalettes.save(palette(id: 'o1', name: 'Ohuhu one'));
  await h.savedPalettes.save(
    palette(id: 'd1', brandId: 'decotime', name: 'Deco one'),
  );
  await h.history.record(pick(id: 'h1'));
  await h.history.record(pick(id: 'h2', matchedCode: 'G1'));
  await h.aiSettings.setEnabled(true);
  await h.aiSettings.setProvider(AiProvider.openRouter);
  await h.aiSettings.setTextModel('m/text');
  await h.aiSettings.setTemperature(0.4);
  return h;
}

void main() {
  test('export -> import -> export is byte-identical', () async {
    final source = await populated();
    final exported = source.backup().exportJson();

    final target = await harness();
    await target.backup().importJson(exported);
    final reExported = target.backup().exportJson();

    // Import never switches the AI on, so that is the one intended difference.
    final expected = jsonDecode(exported) as Map<String, dynamic>;
    (expected['aiSettings'] as Map<String, dynamic>)['enabled'] = false;
    expect(jsonDecode(reExported), expected);
    expect((expected['appSettings'] as Map)['themeMode'], 'Dark');
    expect(target.appSettings.themeMode, AppThemeMode.dark);
  });

  test('a backup without themeMode imports with the System default', () async {
    final h = await harness();
    await h.appSettings.setThemeMode(AppThemeMode.dark);
    await h.backup().importJson(kotlinSample);
    expect(h.appSettings.themeMode, AppThemeMode.system);
  });

  test('imports a hand-written Kotlin-format sample', () async {
    final h = await harness();
    await h.backup().importJson(kotlinSample);

    expect(h.appSettings.brand, MarkerBrand.ohuhuOahu);
    expect(h.appSettings.scope, BrandScope.mixedBrands);
    // Older backups are migrated: compare mode = every pack is owned.
    expect(h.appSettings.settings.ownedSetIds, {
      'classic_160',
      'classic_80',
      'skin_36',
    });
    expect(h.appSettings.settings.extraMarkerIds, {'ohuhu_oahu:R1'});
    expect(h.appSettings.state.matchSuggestUnowned, isTrue);
    expect(h.appSettings.favorites, {'ohuhu_oahu:R1', 'decotime:01'});
    expect(h.appSettings.nameDisplayMode, NameDisplayMode.both);
    expect(h.appSettings.onboardingCompleted, isTrue);

    expect(h.savedPalettes.exportByBrand().keys, ['ohuhu_oahu', 'decotime']);
    expect(
      h.savedPalettes.palettesOf(MarkerBrand.ohuhuOahu).single.name,
      'Forest',
    );
    expect(
      h.savedPalettes.palettesOf(MarkerBrand.decoTime).single.name,
      'Deco mix',
    );

    expect(h.history.entries.single.id, 'cm1');
    expect(h.history.entries.single.brandId, 'ohuhu_oahu');
    expect(h.history.entries.single.deltaE, 1.5);

    expect(h.aiSettings.value.enabled, isFalse);
    expect(h.aiSettings.value.provider, AiProvider.openRouter);
    expect(h.aiSettings.value.textModel, 'm/text');
    expect(h.aiSettings.value.temperature, 0.3);
    expect(h.aiSettings.value.maxTokens, 2048);
    expect(h.aiSettings.value.autoFallback, isTrue);
  });

  test('import never switches the AI on', () async {
    final h = await harness();
    await h.aiSettings.setEnabled(true);
    await h.backup().importJson(
      jsonEncode({
        'version': 1,
        'aiSettings': {'enabled': true, 'provider': 'openRouter'},
      }),
    );
    expect(h.aiSettings.value.enabled, isFalse);
    expect(h.aiSettings.value.provider, AiProvider.openRouter);
  });

  test('missing sections are left untouched, unknown fields ignored', () async {
    final h = await harness();
    await h.appSettings.setBrand(MarkerBrand.decoTime);
    await h.aiSettings.setProvider(AiProvider.onDevice);

    await h.backup().importJson(
      '{"version":1,"futureSection":{"nested":[1,2,3]}}',
    );

    expect(h.appSettings.brand, MarkerBrand.decoTime);
    expect(h.aiSettings.value.provider, AiProvider.onDevice);
    expect(h.aiSettings.value.enabled, isFalse);
  });

  test('rejects invalid documents with a typed error', () async {
    final h = await harness();
    final backup = h.backup();

    for (final source in [
      'not json at all',
      '[]',
      '42',
      '"a string"',
      '{"version":"1"}',
      '{"version":42}',
      '{"version":0}',
      '{"appSettings":[]}',
      '{"savedPalettes":{"ohuhu_oahu":"nope"}}',
      '{"savedPalettes":{"ohuhu_oahu":[42]}}',
      '{"colorMatchHistory":[{}]}',
      '{"aiSettings":[]}',
    ]) {
      await expectLater(
        backup.importJson(source),
        throwsA(isA<BackupFormatException>()),
        reason: source,
      );
    }
  });

  test('never exports a secret even when the input carries one', () async {
    final h = await harness();
    await h.backup().importJson(
      jsonEncode({
        'version': 1,
        'aiSettings': {
          'enabled': true,
          'apiKey': 'sk-live-do-not-export',
          'api_key': 'sk-live-do-not-export',
          'token': 'sk-live-do-not-export',
        },
      }),
    );
    expect(h.aiSettings.value.enabled, isFalse);

    final exported = h.backup().exportJson();
    expect(exported, isNot(contains('sk-live-do-not-export')));
    expect(exported, isNot(contains('apiKey')));
    expect(exported, isNot(contains('api_key')));
    expect(exported, isNot(contains('token')));
  });

  test('pretty export has the same data as the compact one', () async {
    final h = await populated();
    final backup = h.backup();
    final compact = jsonDecode(backup.exportJson());
    final pretty = jsonDecode(backup.exportJson(pretty: true));
    expect(pretty, compact);
    expect(
      backup.exportJson(pretty: true),
      contains('"version": ${BackupService.currentVersion}'),
    );
  });
}
