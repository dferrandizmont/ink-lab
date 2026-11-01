import 'dart:convert';
import 'dart:typed_data';

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
  await h.ownColors.set('R1', 'aabbcc');
  await h.ownColors.set('decotime:02', '123456');
  await h.appSettings.setUseOwnColors(false);
  await h.wishlist.add('R5');
  await h.wishlist.add('decotime:07');
  await h.dried.add('R1');
  await h.aiSettings.setEnabled(true);
  await h.aiSettings.setProvider(AiProvider.openRouter);
  await h.aiSettings.setTextModel('m/text');
  await h.aiSettings.setTemperature(0.4);
  return h;
}

void main() {
  test('Copic collection, favourites, palettes, matches and own colours survive backup', () async {
    final source = await populated();
    // Backup restore deliberately disables AI; this test covers collection data.
    await source.aiSettings.setEnabled(false);
    await source.appSettings.setBrand(MarkerBrand.copic);
    await source.appSettings.setExtraMarkerIds({
      'copic:0',
      'copic:BV04',
      'decotime:02',
      'ohuhu_oahu:R1',
    });
    await source.appSettings.setFavorites({'copic:BV04', 'decotime:01'});
    await source.ownColors.set('copic:BV04', 'abcdef');
    await source.savedPalettes.save(
      palette(
        id: 'cp1',
        brandId: 'copic',
        baseCode: 'BV04',
        baseName: 'Blue Berry',
        colorCodes: ['BV04', 'R29', 'B05'],
      ),
    );
    await source.history.record(
      pick(id: 'cpick', brandId: 'copic', matchedCode: 'BV04'),
    );
    final exported = source.backup().exportJson();
    final target = await harness();
    await target.backup().importJson(exported);
    expect(target.backup().exportJson(), exported);
    expect(target.appSettings.brand, MarkerBrand.copic);
    expect(
      target.appSettings.settings.extraMarkerIds,
      source.appSettings.settings.extraMarkerIds,
    );
    expect(target.appSettings.favorites, {'copic:BV04', 'decotime:01'});
    expect(target.ownColors.hexOf('copic:BV04'), 'abcdef');
    expect(target.savedPalettes.palettesOf(MarkerBrand.copic).single.id, 'cp1');
    expect(target.history.entries.any((p) => p.brandId == 'copic'), isTrue);
    // Existing brand data remains independent.
    expect(
      target.savedPalettes.palettesOf(MarkerBrand.decoTime).single.id,
      'd1',
    );
    expect(
      target.appSettings.settings.ownedSetIds,
      source.appSettings.settings.ownedSetIds,
    );
  });

  test('the artwork diary goes in the backup, without any photo', () async {
    final source = await harness();
    final String photo = await source.artworkDiary.addPhoto(
      Uint8List.fromList([0xFF, 0xD8, 0xFF, 1, 2, 3]),
    );
    await source.artworkDiary.save(
      ArtworkEntry(
        id: 'd1',
        title: 'Forest page',
        date: DateTime(2026, 10, 30),
        onWhat: 'Forest colouring book',
        status: ArtworkStatus.inProgress,
        markerIds: const ['ohuhu_oahu:B08', 'copic:BV04'],
        paletteId: 'p1',
        notes: 'Blended with colourless',
        photos: [photo],
        createdAtEpochMs: 5,
      ),
    );
    final exported = source.backup().exportJson();
    final decoded = jsonDecode(exported) as Map<String, dynamic>;
    final diary = decoded['artworkDiary'] as List<dynamic>;
    expect(diary.single, {
      'id': 'd1',
      'title': 'Forest page',
      'date': '2026-10-30',
      'onWhat': 'Forest colouring book',
      'status': 'inProgress',
      'markers': ['ohuhu_oahu:B08', 'copic:BV04'],
      'paletteId': 'p1',
      'notes': 'Blended with colourless',
      // Only the file name: the bytes never reach the clipboard.
      'photos': [photo],
      'createdAtEpochMs': 5,
    });

    final target = await harness();
    await target.backup().importJson(exported);
    expect(target.artworkDiary.entries, source.artworkDiary.entries);
    expect(target.backup().exportJson(), exported);
    // The other phone has no such file: the entry is there, the photo is not.
    expect(await target.artworkDiary.photoBytes(photo), isNull);
    expect(target.artworkDiary.entries.single.title, 'Forest page');
  });

  test('restoring on the same phone keeps the photos of the entries', () async {
    final h = await harness();
    final String photo = await h.artworkDiary.addPhoto(
      Uint8List.fromList([0xFF, 0xD8, 0xFF, 9]),
    );
    await h.artworkDiary.save(
      ArtworkEntry(
        id: 'd1',
        title: 'Kept',
        date: DateTime(2026, 10, 30),
        photos: [photo],
        createdAtEpochMs: 1,
      ),
    );
    final exported = h.backup().exportJson();
    await h.backup().importJson(exported);
    expect(h.photos.names, {photo});

    // An entry that is not in the backup goes, with its photo.
    final String other = await h.artworkDiary.addPhoto(
      Uint8List.fromList([0xFF, 0xD8, 0xFF, 8]),
    );
    await h.artworkDiary.save(
      ArtworkEntry(
        id: 'd2',
        title: 'Only here',
        date: DateTime(2026, 10, 31),
        photos: [other],
        createdAtEpochMs: 2,
      ),
    );
    await h.backup().importJson(exported);
    expect(h.artworkDiary.entries.map((e) => e.id), ['d1']);
    expect(h.photos.names, {photo});
  });

  test(
    'a backup from before the diary imports and keeps your entries',
    () async {
      final h = await harness();
      await h.artworkDiary.save(
        ArtworkEntry(
          id: 'd1',
          title: 'Mine',
          date: DateTime(2026, 10, 30),
          createdAtEpochMs: 1,
        ),
      );
      await h.backup().importJson(kotlinSample);
      expect(h.artworkDiary.entries.single.title, 'Mine');
      // The rest of the old backup did import.
      expect(h.savedPalettes.palettesOf(MarkerBrand.ohuhuOahu), isNotEmpty);
    },
  );

  test(
    'an empty artworkDiary clears the entries, a bad one is refused',
    () async {
      final h = await harness();
      await h.artworkDiary.save(
        ArtworkEntry(
          id: 'd1',
          title: 'Mine',
          date: DateTime(2026, 10, 30),
          createdAtEpochMs: 1,
        ),
      );
      for (final source in [
        '{"version":1,"artworkDiary":{"id":"x"}}',
        '{"version":1,"artworkDiary":[5]}',
        '{"version":1,"artworkDiary":[{"id":"x"}]}',
      ]) {
        await expectLater(
          h.backup().importJson(source),
          throwsA(isA<BackupFormatException>()),
          reason: source,
        );
      }
      expect(h.artworkDiary.entries, hasLength(1));

      await h.backup().importJson('{"version":1,"artworkDiary":[]}');
      expect(h.artworkDiary.entries, isEmpty);
    },
  );

  test('a diary entry from the backup is cleaned like any other', () async {
    final h = await harness();
    await h.backup().importJson(
      '{"version":1,"artworkDiary":[{"id":"x","title":"T",'
      '"date":"2026-02-03","markers":["b08","copic:bv04",5],'
      '"photos":["a.jpg","b.jpg","c.jpg","d.jpg","e.jpg"],"status":"odd"}]}',
    );
    final entry = h.artworkDiary.entries.single;
    expect(entry.markerIds, ['ohuhu_oahu:B08', 'copic:BV04']);
    expect(entry.photos, ['a.jpg', 'b.jpg', 'c.jpg', 'd.jpg']);
    expect(entry.status, ArtworkStatus.finished);
    expect(entry.date, DateTime(2026, 2, 3));
  });

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

  test(
    'a saved blending chain goes in the backup and comes back in order',
    () async {
      final source = await harness();
      await source.savedPalettes.save(
        palette(
          id: 'c1',
          name: 'Sky blend',
          baseCode: 'B411',
          mode: PaletteMode.blendingChain,
          paletteSize: 4,
          colorCodes: const ['B010', 'B411', 'BV514', 'B115'],
        ),
      );
      final exported = source.backup().exportJson();
      final saved =
          (jsonDecode(exported) as Map<String, dynamic>)['savedPalettes']
              as Map<String, dynamic>;
      expect(
        ((saved['ohuhu_oahu'] as List).single as Map)['mode'],
        'BlendingChain',
      );

      final target = await harness();
      await target.backup().importJson(exported);
      final back = target.savedPalettes
          .palettesOf(MarkerBrand.ohuhuOahu)
          .single;
      expect(back.mode, PaletteMode.blendingChain);
      expect(back.colorCodes, ['B010', 'B411', 'BV514', 'B115']);
      expect(back.baseCode, 'B411');
    },
  );

  test('Copic backup preserves ownership, own colours, wishlist, dried markers and chains', () async {
    final source = await harness();
    await source.appSettings.setBrand(MarkerBrand.copic);
    await source.appSettings.setOwnedMarkerCodes({'copic:BV04', 'copic:B05'});
    await source.ownColors.set('copic:BV04', '123456');
    await source.wishlist.add('copic:R29');
    await source.dried.add('copic:B05');
    await source.savedPalettes.save(
      palette(
        id: 'copic-chain',
        brandId: 'copic',
        baseCode: 'BV04',
        mode: PaletteMode.blendingChain,
        colorCodes: const ['BV000', 'BV01', 'BV04', 'BV08'],
        paletteSize: 4,
      ),
    );
    final target = await harness();
    await target.backup().importJson(source.backup().exportJson());
    expect(target.appSettings.brand, MarkerBrand.copic);
    expect(target.appSettings.settings.extraMarkerIds, {
      'copic:BV04',
      'copic:B05',
    });
    expect(target.ownColors.colors, {'copic:BV04': '123456'});
    expect(target.wishlist.idsOf(MarkerBrand.copic), {'copic:R29'});
    expect(target.dried.idsOf(MarkerBrand.copic), {'copic:B05'});
    expect(target.wishlist.idsOf(MarkerBrand.decoTime), isEmpty);
    final chain = target.savedPalettes.palettesOf(MarkerBrand.copic).single;
    expect(chain.mode, PaletteMode.blendingChain);
    expect(chain.baseCode, 'BV04');
    expect(chain.colorCodes, ['BV000', 'BV01', 'BV04', 'BV08']);
  });

  test('own colours go in the backup and come back', () async {
    final source = await populated();
    final exported =
        jsonDecode(source.backup().exportJson()) as Map<String, dynamic>;
    expect(exported['ownColors'], {
      'decotime:02': '123456',
      'ohuhu_oahu:R1': 'aabbcc',
    });
    expect((exported['appSettings'] as Map)['useOwnColors'], isFalse);

    final target = await harness();
    await target.backup().importJson(jsonEncode(exported));
    expect(target.ownColors.colors, source.ownColors.colors);
    expect(target.appSettings.state.useOwnColors, isFalse);
  });

  test(
    'a backup from before own colours imports and keeps the ones you have',
    () async {
      final h = await harness();
      await h.ownColors.set('R1', 'aabbcc');
      await h.backup().importJson(kotlinSample);
      expect(h.ownColors.colors, {'ohuhu_oahu:R1': 'aabbcc'});
      expect(h.appSettings.state.useOwnColors, isTrue);
    },
  );

  test(
    'an empty ownColors section clears them, a bad one is refused',
    () async {
      final h = await harness();
      await h.ownColors.set('R1', 'aabbcc');
      await expectLater(
        h.backup().importJson('{"version":1,"ownColors":{"R1":5}}'),
        throwsA(isA<BackupFormatException>()),
      );
      await expectLater(
        h.backup().importJson('{"version":1,"ownColors":[]}'),
        throwsA(isA<BackupFormatException>()),
      );
      expect(h.ownColors.colors, isNotEmpty);

      await h.backup().importJson('{"version":1,"ownColors":{}}');
      expect(h.ownColors.colors, isEmpty);
    },
  );

  test('own colours with bad entries are cleaned on import', () async {
    final h = await harness();
    await h.backup().importJson(
      '{"version":1,"ownColors":{"R1":"#ABC","G1":"nope"}}',
    );
    expect(h.ownColors.colors, {'ohuhu_oahu:R1': 'aabbcc'});
  });

  test(
    'the wishlist and the dried markers go in the backup and come back',
    () async {
      final source = await populated();
      final exported =
          jsonDecode(source.backup().exportJson()) as Map<String, dynamic>;
      expect(exported['wishlist'], ['decotime:07', 'ohuhu_oahu:R5']);
      expect(exported['driedMarkers'], ['ohuhu_oahu:R1']);

      final target = await harness();
      await target.wishlist.add('G9');
      await target.backup().importJson(jsonEncode(exported));
      expect(target.wishlist.ids, source.wishlist.ids);
      expect(target.dried.ids, source.dried.ids);
    },
  );

  test(
    'a backup from before the wishlist imports and keeps the ones you have',
    () async {
      final h = await harness();
      await h.wishlist.add('R5');
      await h.dried.add('R1');
      await h.backup().importJson(kotlinSample);
      expect(h.wishlist.ids, {'ohuhu_oahu:R5'});
      expect(h.dried.ids, {'ohuhu_oahu:R1'});
    },
  );

  test('empty wishlist sections clear them, a bad one is refused', () async {
    final h = await harness();
    await h.wishlist.add('R5');
    await h.dried.add('R1');
    for (final source in [
      '{"version":1,"wishlist":{"R1":1}}',
      '{"version":1,"wishlist":[5]}',
      '{"version":1,"driedMarkers":"R1"}',
      '{"version":1,"driedMarkers":[null]}',
    ]) {
      await expectLater(
        h.backup().importJson(source),
        throwsA(isA<BackupFormatException>()),
        reason: source,
      );
    }
    expect(h.wishlist.ids, isNotEmpty);
    expect(h.dried.ids, isNotEmpty);

    await h.backup().importJson(
      '{"version":1,"wishlist":[],"driedMarkers":[]}',
    );
    expect(h.wishlist.ids, isEmpty);
    expect(h.dried.ids, isEmpty);
  });

  test('wishlist ids with bad entries are cleaned on import', () async {
    final h = await harness();
    await h.backup().importJson(
      '{"version":1,"wishlist":["r1","R1","decotime:03",":",""]}',
    );
    expect(h.wishlist.ids, {'decotime:03', 'ohuhu_oahu:R1'});
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
