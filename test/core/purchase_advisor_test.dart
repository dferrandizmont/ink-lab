import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/color_utils.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/purchase_advisor.dart';
import 'package:ink_lab/core/scene_catalog.dart';
import 'package:ink_lab/core/shopping_list.dart';

import 'fixtures.dart';

/// A scene with one role per entry of [hues]: full value and saturation, so
/// the role asks for the pure hue.
Scene _scene(String id, List<List<double>> hues) => Scene(
  id: id,
  category: 'nature',
  names: <String, String>{'en': 'Scene $id', 'es': 'Escena $id'},
  seedHue: 0,
  seedSaturation: 1,
  seedValue: 1,
  targets: <ScenarioTarget>[
    for (int i = 0; i < hues.length; i++)
      ScenarioTarget('Role $i', hues[i], valueDelta: 0, saturationDelta: 0),
  ],
);

String _hex(double hue, [double s = 1, double v = 1]) =>
    rgbToHex(hsvToRgb(hue, s, v));

void main() {
  group('sceneRoleTargets', () {
    test('turns the seed by the hue offset and moves value and saturation', () {
      final Scene scene = Scene(
        id: 's',
        category: 'nature',
        names: const <String, String>{'en': 'S', 'es': 'S'},
        seedHue: 100,
        seedSaturation: 0.5,
        seedValue: 0.8,
        targets: const <ScenarioTarget>[
          ScenarioTarget(
            'Shadow',
            <double>[20],
            valueDelta: -0.3,
            saturationDelta: 0.2,
          ),
        ],
      );
      final RoleTarget role = sceneRoleTargets(scene).single;
      expect(role.role, 'Shadow');
      expect(role.colors, hasLength(1));
      final LabColor expected = rgbToLab(hsvToRgb(120, 0.7, 0.5));
      expect(role.colors.single.l, closeTo(expected.l, 1e-9));
      expect(role.colors.single.a, closeTo(expected.a, 1e-9));
      expect(role.colors.single.b, closeTo(expected.b, 1e-9));
    });

    test('a role that allows two hues has two colours', () {
      final RoleTarget role = sceneRoleTargets(
        _scene('a', <List<double>>[
          <double>[145, 215],
        ]),
      ).single;
      expect(role.colors, hasLength(2));
    });

    test('hue wraps around and the saturation limits are kept', () {
      final Scene scene = Scene(
        id: 's',
        category: 'nature',
        names: const <String, String>{'en': 'S', 'es': 'S'},
        seedHue: 350,
        seedSaturation: 0.9,
        seedValue: 0.9,
        targets: const <ScenarioTarget>[
          ScenarioTarget(
            'Pale',
            <double>[20],
            valueDelta: 0,
            saturationDelta: 0,
            preferNeutral: true,
          ),
          ScenarioTarget(
            'Muted',
            <double>[0],
            valueDelta: 0,
            saturationDelta: 0,
            maxSaturation: 0.4,
          ),
          ScenarioTarget(
            'Vivid',
            <double>[0],
            valueDelta: 0,
            saturationDelta: -0.8,
            minSaturation: 0.5,
          ),
        ],
      );
      final List<RoleTarget> roles = sceneRoleTargets(scene);
      LabColor lab(double h, double s, double v) => rgbToLab(hsvToRgb(h, s, v));
      expect(roles[0].colors.single.a, closeTo(lab(10, 0.3, 0.9).a, 1e-9));
      expect(roles[1].colors.single.b, closeTo(lab(350, 0.4, 0.9).b, 1e-9));
      expect(roles[2].colors.single.l, closeTo(lab(350, 0.5, 0.9).l, 1e-9));
    });
  });

  group('suggestPurchases', () {
    // Two scenes: A wants red and green, B wants blue.
    final Scene sceneA = _scene('a', <List<double>>[
      <double>[0],
      <double>[120],
    ]);
    final Scene sceneB = _scene('b', <List<double>>[
      <double>[240],
    ]);
    final MarkerColor owned = color('O1', _hex(0));
    final MarkerColor nearGreen = color('G1', _hex(120));
    final MarkerColor nearBlue = color('B1', _hex(240));
    final MarkerColor twin = color('T1', _hex(2));

    test('ranks by the number of scenes a marker would improve', () {
      // Owned: red only. Green helps scene A, blue helps scene B; a red
      // twin of what is owned helps nothing.
      final List<PurchaseSuggestion> result = suggestPurchases(
        range: <MarkerColor>[owned, nearGreen, nearBlue, twin],
        owned: <MarkerColor>[owned],
        scenes: <Scene>[sceneA, sceneB],
      );
      expect(result.last.color.newCode, 'T1');
      expect(result.last.improvedScenes, 0);
      expect(
        result.take(2).map((PurchaseSuggestion s) => s.color.newCode).toSet(),
        <String>{'G1', 'B1'},
      );
      final PurchaseSuggestion green = result.firstWhere(
        (PurchaseSuggestion s) => s.color.newCode == 'G1',
      );
      expect(green.improvedScenes, 1);
      expect(green.topScenes.single, sceneA);
      expect(green.totalGain, greaterThan(50));
    });

    test('a marker that helps two scenes beats one that helps one', () {
      // A cyan-ish middle colour that is closer to both the green role and
      // the blue role than red is, versus a pure blue that only serves B.
      final Scene wantsBlue = _scene('wb', <List<double>>[
        <double>[240],
      ]);
      final Scene wantsBlue2 = _scene('wb2', <List<double>>[
        <double>[235],
      ]);
      final Scene wantsGreen = _scene('wg', <List<double>>[
        <double>[120],
      ]);
      final MarkerColor blue = color('BLUE', _hex(240));
      final MarkerColor green = color('GREEN', _hex(120));
      final List<PurchaseSuggestion> result = suggestPurchases(
        range: <MarkerColor>[owned, blue, green],
        owned: <MarkerColor>[owned],
        scenes: <Scene>[wantsBlue, wantsBlue2, wantsGreen],
      );
      expect(result.first.color.newCode, 'BLUE');
      expect(result.first.improvedScenes, 2);
      expect(result.last.color.newCode, 'GREEN');
      expect(result.last.improvedScenes, 1);
    });

    test('owned markers are never suggested and dried ones can come back', () {
      final MarkerColor dried = color('D1', _hex(240));
      final List<PurchaseSuggestion> withDried = suggestPurchases(
        // The caller leaves a dried marker out of [owned].
        range: <MarkerColor>[owned, dried],
        owned: <MarkerColor>[owned],
        scenes: <Scene>[sceneB],
      );
      expect(withDried.single.color.newCode, 'D1');
      final List<PurchaseSuggestion> without = suggestPurchases(
        range: <MarkerColor>[owned, dried],
        owned: <MarkerColor>[owned, dried],
        scenes: <Scene>[sceneB],
      );
      expect(without, isEmpty);
    });

    test('a scene that is already well covered does not count', () {
      final MarkerColor blue = color('BLUE', _hex(240));
      final MarkerColor almostBlue = color('NEAR', _hex(241));
      final List<PurchaseSuggestion> result = suggestPurchases(
        range: <MarkerColor>[blue, almostBlue],
        owned: <MarkerColor>[blue],
        scenes: <Scene>[sceneB],
      );
      expect(result.single.improvedScenes, 0);
      expect(result.single.topScenes, isEmpty);
    });

    test('ties go to the marker that fills the biggest hole', () {
      // No scene can tell them apart (no scenes at all): the one farthest
      // from everything owned comes first.
      final MarkerColor close = color('CLOSE', _hex(5));
      final MarkerColor far = color('FAR', _hex(180));
      final List<PurchaseSuggestion> result = suggestPurchases(
        range: <MarkerColor>[owned, close, far],
        owned: <MarkerColor>[owned],
        scenes: const <Scene>[],
      );
      expect(result.map((PurchaseSuggestion s) => s.color.newCode), <String>[
        'FAR',
        'CLOSE',
      ]);
      expect(result.first.gap, greaterThan(result.last.gap));
      expect(result.first.improvedScenes, 0);
    });

    test('identical colours: natural code order decides which stays', () {
      final MarkerColor a = color('A2', _hex(180));
      final MarkerColor b = color('A10', _hex(180));
      final List<PurchaseSuggestion> result = suggestPurchases(
        range: <MarkerColor>[owned, b, a],
        owned: <MarkerColor>[owned],
        scenes: const <Scene>[],
      );
      expect(result.single.color.newCode, 'A2');
    });

    test('near-identical colours are not suggested twice', () {
      final MarkerColor blue = color('BLUE', _hex(240));
      final MarkerColor twinBlue = color('BLUE2', _hex(240.5));
      final MarkerColor green = color('GREEN', _hex(120));
      final List<PurchaseSuggestion> result = suggestPurchases(
        range: <MarkerColor>[owned, twinBlue, blue, green],
        owned: <MarkerColor>[owned],
        scenes: <Scene>[sceneA, sceneB],
      );
      expect(
        result.map((PurchaseSuggestion s) => s.color.newCode).toSet(),
        <String>{'BLUE', 'GREEN'},
      );
      // The better ranked one stays; with equal numbers the code decides.
      expect(
        result.any((PurchaseSuggestion s) => s.color.newCode == 'BLUE'),
        isTrue,
      );
    });

    test('limit, empty candidates and malformed hexes', () {
      final List<MarkerColor> range = <MarkerColor>[
        owned,
        for (int i = 0; i < 20; i++) color('X$i', _hex(i * 18.0)),
        color('BAD', 'not-a-colour'),
      ];
      final List<PurchaseSuggestion> top = suggestPurchases(
        range: range,
        owned: <MarkerColor>[owned],
        scenes: <Scene>[sceneA, sceneB],
        limit: 5,
      );
      expect(top, hasLength(5));
      expect(
        top.map((PurchaseSuggestion s) => s.color.newCode),
        isNot(contains('BAD')),
      );
      expect(
        suggestPurchases(
          range: <MarkerColor>[owned],
          owned: <MarkerColor>[owned],
          scenes: <Scene>[sceneA],
        ),
        isEmpty,
      );
      expect(
        suggestPurchases(
          range: range,
          owned: <MarkerColor>[owned],
          scenes: <Scene>[sceneA],
          limit: 0,
        ),
        isEmpty,
      );
    });

    test('without any owned marker every scene gains', () {
      final List<PurchaseSuggestion> result = suggestPurchases(
        range: <MarkerColor>[nearGreen, nearBlue],
        owned: const <MarkerColor>[],
        scenes: <Scene>[sceneA, sceneB],
      );
      expect(result, hasLength(2));
      for (final PurchaseSuggestion s in result) {
        expect(s.improvedScenes, 1);
        expect(s.gap, PurchaseAdvisor.noMarkerDistance);
      }
    });
  });

  group('with the real catalogues', () {
    final SceneCatalog scenes = SceneCatalog.parse(
      File(SceneCatalog.assetPath).readAsStringSync(),
    );
    List<MarkerColor> range(MarkerBrand brand) =>
        parseColors(File(brand.assetPath).readAsStringSync(), brand: brand);

    test('Oahu 160 owned: ten loose markers, best first', () {
      final List<MarkerColor> all = range(MarkerBrand.ohuhuOahu);
      final List<MarkerColor> owned = ownedColors(
        colors: all,
        brand: MarkerBrand.ohuhuOahu,
        ownedSetIds: const <String>{'classic_160'},
      );
      final List<PurchaseSuggestion> result = suggestPurchases(
        range: all,
        owned: owned,
        scenes: scenes.scenes,
      );
      expect(result, hasLength(10));
      final Set<String> ownedIds = <String>{
        for (final MarkerColor c in owned) c.colorId,
      };
      for (final PurchaseSuggestion s in result) {
        expect(ownedIds, isNot(contains(s.color.colorId)));
        expect(s.color.brandId, MarkerBrand.ohuhuOahu.id);
      }
      for (int i = 1; i < result.length; i++) {
        expect(
          result[i - 1].improvedScenes,
          greaterThanOrEqualTo(result[i].improvedScenes),
        );
      }
      expect(result.first.improvedScenes, greaterThan(0));
      expect(result.first.topScenes, isNotEmpty);
      // Printed for the record: an example of real output.
      // ignore: avoid_print
      print(
        result
            .map(
              (PurchaseSuggestion s) =>
                  '${s.color.newCode} ${s.color.newName} '
                  'scenes=${s.improvedScenes} gain=${s.totalGain.toStringAsFixed(0)} '
                  'gap=${s.gap.toStringAsFixed(1)} '
                  '[${s.topScenes.map((Scene sc) => sc.label).join(', ')}]',
            )
            .join('\n'),
      );
    });

    for (final brand in MarkerBrand.values.where(
      (brand) => !brand.hasRetailSets,
    )) {
      test('${brand.label} with a few markers owned also gets a ranking', () {
        final List<MarkerColor> all = range(brand);
        final List<MarkerColor> owned = all.take(12).toList();
        final List<PurchaseSuggestion> result = suggestPurchases(
          range: all,
          owned: owned,
          scenes: scenes.scenes,
        );
        expect(result, hasLength(10));
        expect(result.first.improvedScenes, greaterThan(0));
      });
    }

    test('500 markers against every scene is fast', () {
      final List<MarkerColor> base = range(MarkerBrand.ohuhuOahu);
      final List<MarkerColor> big = <MarkerColor>[
        for (int i = 0; i < 500; i++)
          base[i % base.length].copyWith(
            newCode: 'Z$i',
            hex: _hex((i * 37) % 360, 0.2 + (i % 7) / 9, 0.3 + (i % 11) / 16),
          ),
      ];
      final Stopwatch watch = Stopwatch()..start();
      final List<PurchaseSuggestion> result = suggestPurchases(
        range: big,
        owned: big.take(250).toList(),
        scenes: scenes.scenes,
      );
      watch.stop();
      expect(result, hasLength(10));
      // ignore: avoid_print
      print(
        '500 markers x ${scenes.scenes.length} scenes: '
        '${watch.elapsedMilliseconds} ms',
      );
      // The budget is ~50 ms on a phone; the test host in debug mode is slower
      // than a release build, so this only guards against a blow-up.
      expect(watch.elapsedMilliseconds, lessThan(1000));
    });
  });

  group('shoppingListText', () {
    test('one line per marker: brand, code and name, in order', () {
      final MarkerColor b10 = color('B10', 'ff0000');
      final MarkerColor b2 = color('B2', '00ff00');
      final MarkerColor deco = color('07', '0000ff', brandId: 'decotime');
      final MarkerColor copic = color('B05', '0088ff', brandId: 'copic');
      final MarkerColor finecolour = color(
        'BV321',
        '9876aa',
        brandId: 'finecolour',
      );
      expect(
        shoppingListText(<MarkerColor>[deco, copic, finecolour, b10, b2]),
        'Ohuhu - B2 - Name B2\n'
        'Ohuhu - B10 - Name B10\n'
        'DecoTime - 07 - Name 07\n'
        'Copic - B05 - Name B05\n'
        'Finecolour - BV321 - Name BV321',
      );
      expect(shoppingListText(const <MarkerColor>[]), '');
    });

    test('follows the name display mode', () {
      final MarkerColor c = MarkerColor(
        newCode: 'YR57',
        newName: 'Peach',
        oldCode: 'YR296',
        oldName: 'Old peach',
        hex: 'ffaa88',
        sets: const <String>[],
      );
      expect(
        shoppingListText(<MarkerColor>[c]),
        'Ohuhu - YR57 / YR296 - Peach / Old peach',
      );
      expect(
        shoppingListText(<MarkerColor>[c], mode: NameDisplayMode.newOnly),
        'Ohuhu - YR57 - Peach',
      );
      expect(
        shoppingListText(<MarkerColor>[c], mode: NameDisplayMode.oldOnly),
        'Ohuhu - YR296 - Old peach',
      );
    });
  });

  group('dried-out markers in the collection rules', () {
    final MarkerColor r1 = color('R1', 'ff0000', sets: <String>['classic_160']);
    final MarkerColor r2 = color('R2', 'ee0000', sets: <String>['classic_160']);
    final MarkerColor g1 = color('G1', '00ff00', sets: <String>['classic_40']);
    final List<MarkerColor> catalog = <MarkerColor>[r1, r2, g1];

    test('ownedColors leaves them out when asked', () {
      expect(
        ownedColors(
          colors: catalog,
          brand: MarkerBrand.ohuhuOahu,
          ownedSetIds: const <String>{'classic_160'},
          driedColorIds: <String>{r1.colorId},
        ),
        <MarkerColor>[r2],
      );
      expect(
        ownedColors(
          colors: catalog,
          brand: MarkerBrand.ohuhuOahu,
          ownedSetIds: const <String>{'classic_160'},
        ),
        <MarkerColor>[r1, r2],
      );
    });

    test('paletteCandidateColors never offers them, even in whole range', () {
      expect(
        paletteCandidateColors(
          colors: catalog,
          brand: MarkerBrand.ohuhuOahu,
          activeSetIds: const <String>{'classic_160'},
          driedColorIds: <String>{r1.colorId},
        ),
        <MarkerColor>[r2],
      );
      // Every owned marker dried: still a configured collection, so empty
      // rather than the whole range.
      expect(
        paletteCandidateColors(
          colors: catalog,
          brand: MarkerBrand.ohuhuOahu,
          activeSetIds: const <String>{'classic_160'},
          driedColorIds: <String>{r1.colorId, r2.colorId},
        ),
        isEmpty,
      );
      // Nothing configured: the whole range minus the dried ones.
      expect(
        paletteCandidateColors(
          colors: catalog,
          brand: MarkerBrand.ohuhuOahu,
          driedColorIds: <String>{g1.colorId},
        ),
        <MarkerColor>[r1, r2],
      );
    });
  });
}
