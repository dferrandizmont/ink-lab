import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/palette_generator.dart';
import 'package:ink_lab/core/scene_catalog.dart';

import '../support/l10n.dart';

/// The 27 scenes that were an enum before the catalogue: saved palettes and
/// AI requests store them by these ids.
const List<String> legacyIds = <String>[
  'ghostCharacter',
  'cuteCharacter',
  'fantasyCreature',
  'warmPortrait',
  'coolPortrait',
  'sunsetLandscape',
  'forestScene',
  'oceanScene',
  'autumnScene',
  'springGarden',
  'cozyInterior',
  'vintageRoom',
  'pastelDream',
  'neonNight',
  'moodyNight',
  'floralPattern',
  'geometricPattern',
  'plaidPattern',
  'polkaDotPattern',
  'candyStripes',
  'halloweenMood',
  'christmasMood',
  'springMood',
  'summerMood',
  'autumnMood',
  'winterMood',
  'winterSnow',
];

void main() {
  final String source = File(SceneCatalog.assetPath).readAsStringSync();
  final SceneCatalog catalog = SceneCatalog.parse(source);
  final Map<String, dynamic> raw = jsonDecode(source) as Map<String, dynamic>;

  List<MarkerColor> range(MarkerBrand brand) =>
      parseColors(File(brand.assetPath).readAsStringSync(), brand: brand);

  group('scenes.json', () {
    test('is declared as an asset', () {
      expect(
        File('pubspec.yaml').readAsStringSync(),
        contains('- ${SceneCatalog.assetPath}'),
      );
    });

    test('has unique ids and about sixty scenes', () {
      final List<String> ids = catalog.scenes.map((s) => s.id).toList();
      expect(ids.toSet().length, ids.length);
      expect(ids.length, inInclusiveRange(60, 75));
      expect(
        (raw['scenes'] as List<dynamic>).length,
        ids.length,
        reason: 'every JSON entry is parsed',
      );
    });

    test('keeps every id the old enum had', () {
      for (final String id in legacyIds) {
        expect(catalog.find(id), isNotNull, reason: id);
      }
    });

    test('rejects a duplicated id and an unknown category', () {
      final Map<String, dynamic> copy =
          jsonDecode(source) as Map<String, dynamic>;
      final List<dynamic> scenes = copy['scenes'] as List<dynamic>;
      expect(
        () => SceneCatalog.parse(
          jsonEncode(<String, dynamic>{
            ...copy,
            'scenes': <dynamic>[...scenes, scenes.first],
          }),
        ),
        throwsFormatException,
      );
      final Map<String, dynamic> moved = Map<String, dynamic>.of(
        scenes.first as Map<String, dynamic>,
      )..['category'] = 'nope';
      expect(
        () => SceneCatalog.parse(
          jsonEncode(<String, dynamic>{
            ...copy,
            'scenes': <dynamic>[moved],
          }),
        ),
        throwsFormatException,
      );
    });

    test('every scene has a name in both languages', () {
      for (final Scene s in catalog.scenes) {
        for (final String lang in <String>['en', 'es']) {
          final String? name = s.names[lang];
          expect(name, isNotNull, reason: '${s.id} $lang');
          expect(name, name!.trim(), reason: '${s.id} $lang');
          expect(name, isNotEmpty, reason: '${s.id} $lang');
          // Short enough to stay on one line in a field at 360 dp.
          expect(name.length, lessThanOrEqualTo(28), reason: '${s.id} $lang');
        }
      }
      final Set<String> english = catalog.scenes
          .map((s) => s.names['en']!)
          .toSet();
      expect(english.length, catalog.scenes.length, reason: 'unique names');
    });

    test('every category is known, used and named in both languages', () {
      final Set<String> used = catalog.scenes.map((s) => s.category).toSet();
      expect(used, catalog.categories.toSet());
      for (final String id in catalog.categories) {
        expect(catalog.inCategory(id), isNotEmpty, reason: id);
        expect(l10n.sceneCategoryLabel(id), isNot(id), reason: 'en $id');
        expect(l10nEs.sceneCategoryLabel(id), isNot(id), reason: 'es $id');
        expect(
          l10nEs.sceneCategoryLabel(id),
          isNot(l10n.sceneCategoryLabel(id)),
          reason: id,
        );
      }
    });

    test('recipes are well formed', () {
      for (final Scene s in catalog.scenes) {
        expect(s.seedHue, inInclusiveRange(0, 360), reason: s.id);
        expect(s.seedSaturation, inInclusiveRange(0, 1), reason: s.id);
        expect(s.seedValue, inInclusiveRange(0, 1), reason: s.id);
        // Five roles: a palette of the biggest size needs no filler.
        expect(s.targets.length, greaterThanOrEqualTo(5), reason: s.id);
        expect(
          s.targets.map((t) => t.role).toSet().length,
          s.targets.length,
          reason: '${s.id} repeats a role',
        );
        for (final ScenarioTarget t in s.targets) {
          expect(t.hueOffsets, isNotEmpty, reason: '${s.id} ${t.role}');
          expect(t.valueDelta.abs(), lessThanOrEqualTo(1));
          expect(t.saturationDelta.abs(), lessThanOrEqualTo(1));
        }
      }
    });

    test('old wire values and ids still resolve', () {
      for (final String id in legacyIds) {
        final Scene scene = Scene.byId(id);
        expect(scene.toJson(), '${id[0].toUpperCase()}${id.substring(1)}');
        expect(Scene.fromJson(scene.toJson()), scene);
        expect(Scene.fromJson(id), scene);
      }
      expect(Scene.fromJson('GhostCharacter').label, 'Ghost Character');
      expect(() => Scene.fromJson('NoSuchScene'), throwsFormatException);
      expect(() => Scene.fromJson(null), throwsFormatException);
    });

    test('loads through the marker repository and installs itself', () async {
      final MarkerRepository repo = MarkerRepository(
        loadAsset: (String path) => File(path).readAsStringSync(),
      );
      final SceneCatalog loaded = await repo.loadScenes();
      expect(loaded.scenes.length, catalog.scenes.length);
      expect(identical(SceneCatalog.current, loaded), isTrue);
      SceneCatalog.install(catalog);
    });
  });

  for (final MarkerBrand brand in <MarkerBrand>[
    MarkerBrand.ohuhuOahu,
    MarkerBrand.decoTime,
  ]) {
    group('every scene on the full ${brand.id} range', () {
      final List<MarkerColor> colors = range(brand);

      test('has a default base and fills every palette size', () {
        for (final Scene s in catalog.scenes) {
          final MarkerColor? base = findScenarioDefaultBase(colors, s);
          expect(base, isNotNull, reason: s.id);
          for (final int size in <int>[3, 4, 5]) {
            final List<PaletteSuggestion> palette = buildScenarioPalette(
              base!,
              colors,
              s,
              size: size,
            );
            expect(palette.length, size, reason: '${s.id} size $size');
            expect(
              palette.map((p) => p.color.newCode).toSet().length,
              size,
              reason: '${s.id} size $size repeats a marker',
            );
            expect(
              palette.any((p) => p.color.newCode == base.newCode),
              isFalse,
              reason: '${s.id} repeats the base',
            );
            expect(
              palette.any((p) => p.reason == 'Scenario support'),
              isFalse,
              reason: '${s.id} needed filler markers',
            );
          }
        }
      });

      test('previews four different markers, stable for the range', () {
        for (final Scene s in catalog.scenes) {
          final List<MarkerColor> preview = scenePreviewColors(s, colors);
          expect(preview.length, 4, reason: s.id);
          expect(preview.map((c) => c.newCode).toSet().length, 4, reason: s.id);
          expect(
            scenePreviewColors(s, colors).map((c) => c.newCode),
            preview.map((c) => c.newCode),
            reason: '${s.id} is stable',
          );
        }
      });
    });
  }

  test('scenes differ from each other on the Ohuhu range', () {
    final List<MarkerColor> colors = range(MarkerBrand.ohuhuOahu);
    final Map<String, String> byPalette = <String, String>{};
    for (final Scene s in catalog.scenes) {
      final String key = scenePreviewColors(
        s,
        colors,
      ).map((c) => c.newCode).join('|');
      expect(
        byPalette[key],
        isNull,
        reason: '${s.id} previews exactly like ${byPalette[key]}',
      );
      byPalette[key] = s.id;
    }
  });
}
