import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';

import 'fixtures.dart';

Map<String, dynamic> wire(Map<String, dynamic> value) =>
    jsonDecode(jsonEncode(value)) as Map<String, dynamic>;

void main() {
  for (final brand in MarkerBrand.values) {
    test(
      '${brand.label} real disk catalog parsing and full JSON round trip',
      () async {
        final raw = await File(brand.assetPath).readAsString();
        final parsed = parseColors(raw, brand: brand);
        expect(parsed.length, brand == MarkerBrand.ohuhuOahu ? 503 : 313);
        expect(parsed.every((c) => c.brandId == brand.id), isTrue);
        expect(parsed.map((c) => c.colorId).toSet().length, parsed.length);
        for (final c in parsed) {
          expect(MarkerColor.fromJson(wire(c.toJson())), c);
          expect(c.hex, matches(RegExp(r'^[0-9a-f]{6}$')));
        }
        expect(
          parsed.first.newCode,
          brand == MarkerBrand.ohuhuOahu ? '0' : '0.5',
        );
        expect(
          parsed.last.newCode,
          brand == MarkerBrand.ohuhuOahu ? 'YR513' : 'GG9',
        );
      },
    );
  }
  test(
    'DecoTime payload trims, normalizes, defaults and ignores unknown fields',
    () {
      final parsed = parseColors(
        '[{"code":" gg1 ","name":" ","hex":" #AbCDef ","extra":42},'
        '{"code":"02","name":" Name ","hex":"#"}]',
        brand: MarkerBrand.decoTime,
      );
      expect(parsed.first.newCode, 'GG1');
      expect(parsed.first.newName, 'GG1');
      expect(parsed.first.oldCode, 'GG1');
      expect(parsed.first.hex, 'abcdef');
      expect(parsed.first.sets, isEmpty);
      expect(parsed.last.newName, 'Name');
      expect(parsed.last.hex, 'cfcfcf');
      expect(parseColors('[]', brand: MarkerBrand.decoTime), isEmpty);
      expect(
        () => parseColors('invalid', brand: MarkerBrand.decoTime),
        throwsFormatException,
      );
      expect(
        () => parseColors('[{}]', brand: MarkerBrand.decoTime),
        throwsA(isA<TypeError>()),
      );
      final original = color('R1', 'aa1122');
      expect(
        parseColors(
          jsonEncode([original.copyWith(brandId: 'wrong').toJson()]),
          brand: MarkerBrand.ohuhuOahu,
        ).single.brandId,
        'ohuhu_oahu',
      );
    },
  );
  test('asset wrapper loads correct paths, shares concurrent calls, caches per brand', () async {
    final paths = <String>[];
    final repository = MarkerRepository(
      loadAsset: (path) async {
        paths.add(path);
        return File(path).readAsString();
      },
    );
    final result = await Future.wait([
      repository.loadColors(MarkerBrand.ohuhuOahu),
      repository.loadColors(MarkerBrand.ohuhuOahu),
      repository.loadColors(MarkerBrand.decoTime),
    ]);
    expect(paths, MarkerBrand.values.map((b) => b.assetPath));
    expect(identical(result[0], result[1]), isTrue);
    expect(await repository.loadColors(MarkerBrand.decoTime), result[2]);
    expect(paths.length, 2);
    expect(() => result[0].clear(), throwsUnsupportedError);
  });
  test('explicit parser brand chooses format even with misleading keys', () {
    final payload = jsonEncode([
      {...color('R1', 'ff0000').toJson(), 'code': ' dt1 ', 'name': 'Deco name'},
    ]);
    final ohuhu = parseColors(payload, brand: MarkerBrand.ohuhuOahu).single;
    final deco = parseColors(payload, brand: MarkerBrand.decoTime).single;
    expect(ohuhu.newCode, 'R1');
    expect(ohuhu.brandId, MarkerBrand.ohuhuOahu.id);
    expect(deco.newCode, 'DT1');
    expect(deco.newName, 'Deco name');
    expect(deco.brandId, MarkerBrand.decoTime.id);
  });
  test(
    'AppSettings effective packs match single, compare, addons and fallback',
    () {
      expect(AppSettings().effectiveSetIds(), {'classic_160'});
      expect(AppSettings(selectedCoreSetIds: {}).effectiveSetIds(), {
        'classic_160',
      });
      for (final mode in PackSelectionMode.values) {
        expect(PackSelectionMode.fromJson(mode.toJson()), mode);
        expect(
          AppSettings(
            packSelectionMode: mode,
            selectedCoreSetIds: {},
          ).effectiveSetIds(),
          {'classic_160'},
        );
        expect(
          AppSettings(
            packSelectionMode: mode,
            selectedCoreSetIds: {},
            selectedAddonSetIds: {'skin_36'},
          ).effectiveSetIds(),
          {'skin_36'},
        );
      }
      final cores = {'classic_80', 'classic_40'};
      final addons = {'skin_36', 'classic_80'};
      final owned = {'R1', 'decotime:01'};
      final single = AppSettings(
        selectedCoreSetIds: cores,
        selectedAddonSetIds: addons,
        ownedMarkerCodes: owned,
      );
      final compare = AppSettings(
        packSelectionMode: PackSelectionMode.compare,
        selectedCoreSetIds: cores,
        selectedAddonSetIds: addons,
      );
      cores.clear();
      addons.clear();
      owned.clear();
      expect(single.effectiveSetIds(), {'classic_80', 'skin_36'});
      expect(compare.effectiveSetIds(), {
        'classic_80',
        'classic_40',
        'skin_36',
      });
      expect(single.ownedMarkerCodes, {'R1', 'decotime:01'});
      expect(AppSettings().ownedMarkerCodes, isEmpty);
      expect(() => single.selectedCoreSetIds.clear(), throwsUnsupportedError);
      expect(() => single.selectedAddonSetIds.clear(), throwsUnsupportedError);
      expect(() => single.ownedMarkerCodes.clear(), throwsUnsupportedError);
    },
  );
  test(
    'ColorMatchPick preserves Kotlin JSON, numeric deltaE and brand default',
    () {
      const pick = ColorMatchPick(
        id: 'pick',
        brandId: 'decotime',
        sampledHex: 'aabbcc',
        matchedCode: '01',
        matchedName: 'Blue',
        matchedHex: 'aabbcd',
        deltaE: 1.25,
        createdAtEpochMs: 1793190000000,
      );
      expect(pick.toJson(), {
        'id': 'pick',
        'brandId': 'decotime',
        'sampledHex': 'aabbcc',
        'matchedCode': '01',
        'matchedName': 'Blue',
        'matchedHex': 'aabbcd',
        'deltaE': 1.25,
        'createdAtEpochMs': 1793190000000,
      });
      final decoded = ColorMatchPick.fromJson(wire(pick.toJson()));
      expect(decoded, pick);
      expect(decoded.hashCode, pick.hashCode);
      final legacy = pick.toJson()
        ..remove('brandId')
        ..['deltaE'] = 2;
      expect(ColorMatchPick.fromJson(legacy).brandId, 'ohuhu_oahu');
      expect(ColorMatchPick.fromJson(legacy).deltaE, 2.0);
      expect(
        () => ColorMatchPick.fromJson(pick.toJson()..['brandId'] = null),
        throwsA(isA<TypeError>()),
      );
      expect(
        () => ColorMatchPick.fromJson(pick.toJson()..remove('matchedCode')),
        throwsA(isA<TypeError>()),
      );
    },
  );
  test('failed asset reads can be retried', () async {
    var reads = 0;
    final repository = MarkerRepository(
      loadAsset: (_) {
        if (++reads == 1) throw const FormatException('bad read');
        return '[]';
      },
    );
    await expectLater(
      repository.loadColors(MarkerBrand.ohuhuOahu),
      throwsFormatException,
    );
    expect(await repository.loadColors(MarkerBrand.ohuhuOahu), isEmpty);
    expect(reads, 2);
  });
  test('model identity, display modes, defaults, defensive lists and enum wire spelling', () {
    final sets = ['classic_40'];
    final c = color(
      'r1',
      '123456',
      sets: sets,
    ).copyWith(oldCode: 'old', oldName: 'Legacy');
    sets.clear();
    expect(c.colorId, 'ohuhu_oahu:R1');
    expect(c.displayCode(NameDisplayMode.both), 'r1 / old');
    expect(c.displayName(NameDisplayMode.both), 'Name r1 / Legacy');
    expect(c.displayCode(NameDisplayMode.newOnly), 'r1');
    expect(c.displayName(NameDisplayMode.oldOnly), 'Legacy');
    expect(c.sets, ['classic_40']);
    expect(() => c.sets.add('x'), throwsUnsupportedError);
    expect(MarkerColor.fromJson(c.toJson()).hashCode, c.hashCode);
    expect(MarkerBrand.fromId(' decotime '), MarkerBrand.decoTime);
    expect(MarkerBrand.fromId(null), MarkerBrand.ohuhuOahu);
    expect(MarkerBrand.fromId('unknown'), MarkerBrand.ohuhuOahu);
    for (final mode in PaletteMode.values) {
      expect(PaletteMode.fromJson(mode.toJson()), mode);
    }
    for (final scenario in DrawingScenario.values) {
      expect(DrawingScenario.fromJson(scenario.toJson()), scenario);
    }
    for (final set in OahuSet.values) {
      expect(OahuSet.byId[set.id], set);
      expect(OahuSet.fromJson(set.toJson()), set);
    }
    for (final brand in MarkerBrand.values) {
      expect(MarkerBrand.fromJson(brand.toJson()), brand);
    }
    for (final scope in BrandScope.values) {
      expect(BrandScope.fromJson(scope.toJson()), scope);
    }
    for (final display in NameDisplayMode.values) {
      expect(NameDisplayMode.fromJson(display.toJson()), display);
    }
    expect(PaletteMode.splitComplementary.toJson(), 'SplitComplementary');
    expect(OahuSet.pastel48.isCore, isFalse);
    expect(OahuSet.classic40.isCore, isTrue);
    expect(() => PaletteMode.fromJson('bad'), throwsFormatException);
  });
  test('SavedPalette keeps Kotlin schema, optional defaults and large epoch timestamps', () {
    final saved = SavedPalette(
      id: 'id',
      name: 'name',
      baseCode: 'R1',
      baseName: 'red',
      mode: PaletteMode.triad,
      paletteSize: 3,
      createdAtEpochMs: 1793190000000,
      colorCodes: ['G1', 'B1'],
      scenarioName: 'ForestScene',
    );
    expect(SavedPalette.fromJson(wire(saved.toJson())), saved);
    final legacy = saved.toJson()
      ..remove('brandId')
      ..remove('isCustom')
      ..remove('scenarioName');
    final decoded = SavedPalette.fromJson(legacy);
    expect(decoded.brandId, 'ohuhu_oahu');
    expect(decoded.isCustom, isFalse);
    expect(decoded.scenarioName, isNull);
    expect(decoded.createdAtEpochMs, 1793190000000);
  });
  test('all AiPalette.kt data-only types round trip without provider code', () {
    final request = AiPaletteRequest(
      brandId: 'ohuhu_oahu',
      brandLabel: 'Ohuhu Oahu',
      baseColor: harmonyColors.first,
      candidates: harmonyColors,
      scenario: DrawingScenario.forestScene,
      mode: PaletteMode.recommended,
      paletteSize: 5,
      userGoal: 'forest',
    );
    expect(AiPaletteRequest.fromJson(wire(request.toJson())), request);
    final noBase = request.toJson()
      ..['baseColor'] = null
      ..['scenario'] = null;
    expect(AiPaletteRequest.fromJson(noBase).baseColor, isNull);
    final item = AiPaletteItem(code: 'R1', role: 'Base', reason: 'Warm');
    expect(AiPaletteItem.fromJson(wire(item.toJson())), item);
    final response = AiProviderPaletteResponse(
      items: [item],
      tips: ['Keep light'],
    );
    expect(
      AiProviderPaletteResponse.fromJson(wire(response.toJson())),
      response,
    );
    final envelope = AiPaletteJsonEnvelope(
      palette: [AiPaletteJsonItem(code: 'R1')],
    );
    expect(AiPaletteJsonEnvelope.fromJson(wire(envelope.toJson())), envelope);
    expect(AiPaletteJsonEnvelope.fromJson({}).palette, isEmpty);
    expect(AiPaletteJsonItem.fromJson({}).code, '');
    expect(AiPaletteJsonItem.fromJson({}).role, isNull);
    expect(
      () => AiPaletteJsonItem.fromJson({'code': null}),
      throwsA(isA<TypeError>()),
    );
    expect(
      () => AiPaletteJsonEnvelope.fromJson({'palette': null}),
      throwsA(isA<TypeError>()),
    );
    expect(
      () => MarkerColor.fromJson(
        harmonyColors.first.toJson()..['brandId'] = null,
      ),
      throwsA(isA<TypeError>()),
    );
  });
}
