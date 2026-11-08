import 'dart:io';
import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/color_utils.dart';
import 'package:ink_lab/core/ideas_engine.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/natural_sort.dart';
import 'package:ink_lab/core/palette_advisor.dart';
import 'package:ink_lab/core/swatch_card_location.dart';

import 'fixtures.dart';

/// The ladder roles, from the lightest to the darkest.
const List<String> _ladder = <String>[
  IdeaRoles.light,
  IdeaRoles.lightMid,
  IdeaRoles.base,
  IdeaRoles.shadow,
  IdeaRoles.deepShadow,
];

/// The 23 technique ideas added from docs/ideas/new-ideas-proposal.md.
const List<String> _newTechniqueIds = <String>[
  'feathered_edge',
  'tip_to_tip',
  'blender_pattern',
  'one_marker_layers',
  'stipple_peel',
  'clear_glass',
  'polished_metal',
  'cast_shadow',
  'soft_clouds',
  'still_water',
  'twisted_ribbon',
  'no_line_leaf',
  'short_fur',
  'wood_grain',
  'brick_wall',
  'folded_cloth',
  'water_drops',
  'strawberry_seeds',
  'palette_mixing',
  'long_hair',
  'overlap_glazes',
  'faded_background',
  'hatch_shading',
];

/// The season of every idea that belongs to one; the rest have none.
const Map<String, IdeaSeason> _seasons = <String, IdeaSeason>{
  'spring': IdeaSeason.spring,
  'autumn': IdeaSeason.autumn,
  'halloween': IdeaSeason.autumn,
  'winter': IdeaSeason.winter,
  'christmas': IdeaSeason.winter,
  'tulip_field': IdeaSeason.spring,
  'summer_beach': IdeaSeason.summer,
  'watermelon_slice': IdeaSeason.summer,
  'forest_mushrooms': IdeaSeason.autumn,
  'harvest_basket': IdeaSeason.autumn,
  'hot_chocolate': IdeaSeason.winter,
  'lunar_new_year': IdeaSeason.winter,
  'diwali_lamps': IdeaSeason.autumn,
  'hanukkah_candles': IdeaSeason.winter,
  'painted_eggs': IdeaSeason.spring,
  'dia_de_muertos': IdeaSeason.autumn,
  'valentine_card': IdeaSeason.winter,
  'carnival_mask': IdeaSeason.winter,
  'midsummer_crown': IdeaSeason.summer,
  'holi_colours': IdeaSeason.spring,
  'summer_ice_cream': IdeaSeason.summer,
  'new_year_fireworks': IdeaSeason.winter,
};

/// The 17 colour challenges added from docs/ideas/new-ideas-proposal.md.
///
/// `colour_wheel` is the one without a palette: it works with the whole
/// collection, like `swatch_chart`.
const List<String> _newColourChallengeIds = <String>[
  'colour_grey_black',
  'analogous_trio',
  'triad',
  'split_complement',
  'two_gray_temperatures',
  'gray_plus_accent',
  'earth_tones',
  'jewel_tones',
  'low_key',
  'complement_gradient',
  'warm_light_cool_shadow',
  'vivid_and_muted',
  'one_marker_blender',
  'colour_wheel',
  'deep_skin',
  'black_object',
  'white_object',
];

/// The 14 moods added from docs/ideas/new-ideas-proposal.md.
///
/// All of them come with a palette: they pick their markers from the
/// collection like every other idea with a fixed set of roles.
const List<String> _newMoodIds = <String>[
  'cozy_lamp',
  'foggy_morning',
  'rainy_window',
  'eerie_forest',
  'golden_hour',
  'stormy_sea',
  'candle_flame',
  'desert_noon',
  'bokeh_lights',
  'retro_poster',
  'fresh_citrus',
  'tropical_noon',
  'greenhouse_light',
  'dusty_attic',
];

/// The 18 seasons and holidays added from docs/ideas/new-ideas-proposal.md.
const List<String> _newSeasonIds = <String>[
  'tulip_field',
  'summer_beach',
  'watermelon_slice',
  'forest_mushrooms',
  'harvest_basket',
  'hot_chocolate',
  'lunar_new_year',
  'diwali_lamps',
  'hanukkah_candles',
  'painted_eggs',
  'dia_de_muertos',
  'valentine_card',
  'carnival_mask',
  'midsummer_crown',
  'eid_night',
  'holi_colours',
  'summer_ice_cream',
  'new_year_fireworks',
];

/// Lightness of the markers of [plan] that play ladder roles, in role order.
List<double> _ladderLightness(IdeaPlan plan) {
  final List<PaletteSuggestion> ladder =
      plan.palette.where((s) => _ladder.contains(s.role)).toList()
        ..sort((a, b) => _ladder.indexOf(a.role!) - _ladder.indexOf(b.role!));
  return <double>[for (final s in ladder) ideaLightness(s.color.hex)];
}

/// The temperature of a gray marker, the way the engine reads it: warm, cool
/// or neutral.
String _grayTemperature(String hex) {
  final LabColor lab = hexToLab(hex);
  final double chroma = math.sqrt(lab.a * lab.a + lab.b * lab.b);
  if (chroma < 2) return 'neutral';
  double hue = math.atan2(lab.b, lab.a) * 180 / math.pi;
  if (hue < 0) hue += 360;
  if (hue >= 20 && hue <= 130) return 'warm';
  if (hue >= 170 && hue <= 300) return 'cool';
  return 'neutral';
}

IdeaPreset _preset(String id) => IdeasEngine.byId(id)!;

void main() {
  final ohuhu = paletteCandidateColors(
    colors: parseColors(
      File(MarkerBrand.ohuhuOahu.assetPath).readAsStringSync(),
      brand: MarkerBrand.ohuhuOahu,
    ),
    brand: MarkerBrand.ohuhuOahu,
    activeSetIds: <String>{'classic_160'},
  );
  // The whole range of a brand: every marker it sells, owned or not.
  final fullOhuhu = paletteCandidateColors(
    colors: parseColors(
      File(MarkerBrand.ohuhuOahu.assetPath).readAsStringSync(),
      brand: MarkerBrand.ohuhuOahu,
    ),
    brand: MarkerBrand.ohuhuOahu,
  );
  final fullCopic = paletteCandidateColors(
    colors: parseColors(
      File(MarkerBrand.copic.assetPath).readAsStringSync(),
      brand: MarkerBrand.copic,
    ),
    brand: MarkerBrand.copic,
  );
  final deco = parseColors(
    File(MarkerBrand.decoTime.assetPath).readAsStringSync(),
    brand: MarkerBrand.decoTime,
  );
  final smallDeco = paletteCandidateColors(
    colors: deco,
    brand: MarkerBrand.decoTime,
    ownedMarkerCodes: deco.take(8).map((c) => c.colorId).toSet(),
  );

  group('catalog', () {
    test(
      'has 45-110 presets with unique ids and steps bound to real roles',
      () {
        expect(IdeasEngine.presets.length, inInclusiveRange(45, 110));
        expect(
          IdeasEngine.presets.map((p) => p.id).toSet().length,
          IdeasEngine.presets.length,
        );
        for (final IdeaPreset preset in IdeasEngine.presets) {
          expect(
            preset.stepRoles.length,
            inInclusiveRange(4, 6),
            reason: preset.id,
          );
          expect(preset.minutes, greaterThan(0));
          expect(preset.materials, isNotEmpty, reason: preset.id);
          for (final String? role in preset.stepRoles) {
            if (role != null) expect(IdeaRoles.all, contains(role));
          }
        }
        for (final IdeaCategory category in IdeaCategory.values) {
          expect(
            IdeasEngine.presets.where((p) => p.category == category),
            isNotEmpty,
            reason: category.name,
          );
        }
      },
    );

    test('the idea of the day changes every day and stays all day', () {
      final IdeaPreset morning = IdeasEngine.featuredFor(
        DateTime(2026, 10, 29, 8),
      );
      expect(IdeasEngine.featuredFor(DateTime(2026, 10, 29, 23)), morning);
      expect(
        IdeasEngine.featuredFor(DateTime(2026, 10, 30, 8)),
        isNot(morning),
      );
    });

    test('the 23 new technique ideas are in the catalog with five steps', () {
      expect(_newTechniqueIds.length, 23);
      for (final String id in _newTechniqueIds) {
        final IdeaPreset preset = _preset(id);
        expect(preset.category, IdeaCategory.technique, reason: id);
        expect(preset.stepRoles.length, 5, reason: id);
        expect(preset.materials, isNotEmpty, reason: id);
        expect(preset.minutes, inInclusiveRange(10, 45), reason: id);
      }
    });

    test('only the seasonal ideas carry a season', () {
      for (final IdeaPreset preset in IdeasEngine.presets) {
        expect(preset.season, _seasons[preset.id], reason: preset.id);
      }
    });
  });

  group('the new colour challenges', () {
    test('the 17 colour challenges are in the catalog', () {
      expect(_newColourChallengeIds.length, 17);
      for (final String id in _newColourChallengeIds) {
        final IdeaPreset preset = _preset(id);
        expect(preset.category, IdeaCategory.colorChallenge, reason: id);
        expect(preset.stepRoles.length, inInclusiveRange(4, 6), reason: id);
        expect(preset.materials, isNotEmpty, reason: id);
        expect(preset.minutes, inInclusiveRange(10, 45), reason: id);
        expect(preset.season, isNull, reason: id);
      }
    });

    test('every one with a palette gets a full plan from a whole range', () {
      for (final String id in _newColourChallengeIds) {
        final IdeaPreset preset = _preset(id);
        for (final (String name, List<MarkerColor> collection)
            in <(String, List<MarkerColor>)>[
              ('Ohuhu', fullOhuhu),
              ('Copic', fullCopic),
            ]) {
          final IdeaPlan plan = IdeasEngine.generatePlan(preset, collection);
          if (!preset.hasPalette) {
            expect(plan.palette, isEmpty, reason: '$id with the whole $name');
            expect(plan.wanted, 0, reason: '$id with the whole $name');
            continue;
          }
          expect(plan.missing, 0, reason: '$id with the whole $name');
          expect(
            plan.palette.map((s) => s.color.colorId).toSet().length,
            plan.palette.length,
            reason: '$id with the whole $name',
          );
          // Every step that names a role finds the marker that plays it.
          for (final String? role in preset.stepRoles) {
            if (role == null) continue;
            expect(
              plan.markerFor(role),
              isNotNull,
              reason: '$id has no marker for $role in the whole $name',
            );
          }
        }
      }
    });

    test('the colour wheel is the one without a palette', () {
      expect(_preset('colour_wheel').hasPalette, isFalse);
      for (final String id in _newColourChallengeIds) {
        if (id == 'colour_wheel') continue;
        expect(_preset(id).hasPalette, isTrue, reason: id);
      }
    });
  });

  group('the new moods', () {
    test('the 14 moods are in the catalog', () {
      expect(_newMoodIds.length, 14);
      for (final String id in _newMoodIds) {
        final IdeaPreset preset = _preset(id);
        expect(preset.category, IdeaCategory.mood, reason: id);
        expect(preset.stepRoles.length, inInclusiveRange(4, 6), reason: id);
        expect(preset.materials, isNotEmpty, reason: id);
        expect(preset.minutes, inInclusiveRange(10, 45), reason: id);
        expect(preset.season, isNull, reason: id);
      }
    });

    test('every one with a palette gets a full plan from a whole range', () {
      for (final String id in _newMoodIds) {
        final IdeaPreset preset = _preset(id);
        for (final (String name, List<MarkerColor> collection)
            in <(String, List<MarkerColor>)>[
              ('Ohuhu', fullOhuhu),
              ('Copic', fullCopic),
            ]) {
          final IdeaPlan plan = IdeasEngine.generatePlan(preset, collection);
          if (!preset.hasPalette) {
            expect(plan.palette, isEmpty, reason: '$id with the whole $name');
            expect(plan.wanted, 0, reason: '$id with the whole $name');
            continue;
          }
          expect(plan.missing, 0, reason: '$id with the whole $name');
          expect(
            plan.palette.map((s) => s.color.colorId).toSet().length,
            plan.palette.length,
            reason: '$id with the whole $name',
          );
          // Every step that names a role finds the marker that plays it.
          for (final String? role in preset.stepRoles) {
            if (role == null) continue;
            expect(
              plan.markerFor(role),
              isNotNull,
              reason: '$id has no marker for $role in the whole $name',
            );
          }
        }
      }
    });

    test('every mood has a palette of its own', () {
      for (final String id in _newMoodIds) {
        expect(_preset(id).hasPalette, isTrue, reason: id);
      }
    });
  });

  group('the new seasons and holidays', () {
    test('the 18 season ideas are in the catalog', () {
      expect(_newSeasonIds.length, 18);
      for (final String id in _newSeasonIds) {
        final IdeaPreset preset = _preset(id);
        expect(preset.category, IdeaCategory.season, reason: id);
        expect(preset.stepRoles.length, inInclusiveRange(4, 6), reason: id);
        expect(preset.materials, isNotEmpty, reason: id);
        expect(preset.minutes, inInclusiveRange(10, 45), reason: id);
      }
    });

    test('every one with a palette gets a full plan from a whole range', () {
      for (final String id in _newSeasonIds) {
        final IdeaPreset preset = _preset(id);
        for (final (String name, List<MarkerColor> collection)
            in <(String, List<MarkerColor>)>[
              ('Ohuhu', fullOhuhu),
              ('Copic', fullCopic),
            ]) {
          final IdeaPlan plan = IdeasEngine.generatePlan(preset, collection);
          if (!preset.hasPalette) {
            expect(plan.palette, isEmpty, reason: '$id with the whole $name');
            expect(plan.wanted, 0, reason: '$id with the whole $name');
            continue;
          }
          expect(plan.missing, 0, reason: '$id with the whole $name');
          expect(
            plan.palette.map((s) => s.color.colorId).toSet().length,
            plan.palette.length,
            reason: '$id with the whole $name',
          );
          // Every step that names a role finds the marker that plays it.
          for (final String? role in preset.stepRoles) {
            if (role == null) continue;
            expect(
              plan.markerFor(role),
              isNotNull,
              reason: '$id has no marker for $role in the whole $name',
            );
          }
        }
      }
    });

    test('only eid_night has no season, every idea has a palette', () {
      for (final String id in _newSeasonIds) {
        expect(_preset(id).hasPalette, isTrue, reason: id);
      }
    });
  });

  group('palettes from the collection', () {
    for (final IdeaPreset preset in IdeasEngine.presets) {
      test('${preset.id}: owned, distinct, roled and reproducible', () {
        for (final List<MarkerColor> collection in <List<MarkerColor>>[
          ohuhu,
          smallDeco,
        ]) {
          final IdeaPlan plan = IdeasEngine.generatePlan(preset, collection);
          expect(plan.preset, same(preset));
          if (!preset.hasPalette) {
            expect(plan.palette, isEmpty);
            continue;
          }
          expect(plan.palette.length + plan.missing, plan.wanted);
          expect(
            plan.palette.every((s) => collection.contains(s.color)),
            isTrue,
          );
          expect(
            plan.palette.map((s) => s.color.colorId).toSet().length,
            plan.palette.length,
          );
          for (final PaletteSuggestion s in plan.palette) {
            expect(IdeaRoles.all, contains(s.role), reason: preset.id);
            expect(s.reason, IdeaRoles.reasonFor(s.role!));
            expect(s.color.newName.toLowerCase(), isNot(contains('blender')));
          }
          // Light → dark ladders are really ordered by lightness.
          final List<double> ls = _ladderLightness(plan);
          for (var i = 1; i < ls.length; i++) {
            expect(ls[i], lessThan(ls[i - 1]), reason: '${preset.id} $ls');
          }
          expect(
            IdeasEngine.generatePlan(preset, collection).palette,
            plan.palette,
          );
        }
        expect(IdeasEngine.generatePlan(preset, const []).palette, isEmpty);
      });
    }

    test('a full collection fills every palette', () {
      for (final IdeaPreset preset in IdeasEngine.presets) {
        final IdeaPlan plan = IdeasEngine.generatePlan(preset, ohuhu);
        expect(plan.missing, 0, reason: preset.id);
      }
    });

    for (final (String name, List<MarkerColor> collection)
        in <(String, List<MarkerColor>)>[
          ('Ohuhu', fullOhuhu),
          ('Copic', fullCopic),
        ]) {
      test('the whole $name range fills every palette', () {
        expect(collection, isNotEmpty);
        for (final IdeaPreset preset in IdeasEngine.presets) {
          final IdeaPlan plan = IdeasEngine.generatePlan(preset, collection);
          expect(plan.missing, 0, reason: preset.id);
          expect(
            plan.palette.map((s) => s.color.colorId).toSet().length,
            plan.palette.length,
            reason: preset.id,
          );
        }
      });

      test('every named step role of $name has a marker', () {
        for (final IdeaPreset preset in IdeasEngine.presets) {
          if (!preset.hasPalette) continue;
          final IdeaPlan plan = IdeasEngine.generatePlan(preset, collection);
          for (final String? role in preset.stepRoles) {
            if (role == null) continue;
            expect(
              plan.markerFor(role),
              isNotNull,
              reason: '${preset.id} has no marker for $role',
            );
          }
        }
      });
    }

    test('a tinted gray ladder keeps one temperature', () {
      for (final (String id, String temperature) in <(String, String)>[
        ('clear_glass', 'cool'),
        ('polished_metal', 'neutral'),
      ]) {
        for (final List<MarkerColor> collection in <List<MarkerColor>>[
          fullOhuhu,
          fullCopic,
        ]) {
          final IdeaPlan plan = IdeasEngine.generatePlan(
            _preset(id),
            collection,
          );
          final List<PaletteSuggestion> grays = plan.palette
              .where(
                (s) =>
                    IdeaRoles.ladderOrder.contains(s.role) ||
                    s.role == IdeaRoles.shadowGray,
              )
              .toList();
          expect(grays, isNotEmpty, reason: id);
          for (final PaletteSuggestion s in grays) {
            expect(
              _grayTemperature(s.color.hex),
              temperature,
              reason: '$id ${s.color.newCode}',
            );
          }
        }
      }
    });

    test('shades of gray is a ladder of grays from light to dark', () {
      final IdeaPlan plan = IdeasEngine.generatePlan(
        _preset('grayscale'),
        ohuhu,
      );
      expect(plan.palette.map((s) => s.role), _ladder);
      final List<double> ls = <double>[
        for (final s in plan.palette) ideaLightness(s.color.hex),
      ];
      // A real ladder, not five mid grays.
      expect(ls.first - ls.last, greaterThan(40));
      for (var i = 1; i < ls.length; i++) {
        expect(ls[i], lessThan(ls[i - 1]));
      }
    });

    test('one color family keeps one hue and spreads from light to dark', () {
      final IdeaPlan plan = IdeasEngine.generatePlan(
        _preset('one_color'),
        ohuhu,
      );
      expect(plan.palette.map((s) => s.role), <String>[
        IdeaRoles.light,
        IdeaRoles.base,
        IdeaRoles.shadow,
        IdeaRoles.deepShadow,
      ]);
      final List<double> ls = _ladderLightness(plan);
      expect(ls.first - ls.last, greaterThan(25));
    });

    test('ladders are ordered by lightness whatever the input order', () {
      final List<MarkerColor> reds = <MarkerColor>[
        color('R4', '5a0a0a'),
        color('R1', 'f9c9c9'),
        color('R3', 'b01818'),
        color('R2', 'e86b6b'),
      ];
      for (final List<MarkerColor> input in <List<MarkerColor>>[
        reds,
        reds.reversed.toList(),
      ]) {
        final IdeaPlan plan = IdeasEngine.generatePlan(
          _preset('one_color'),
          input,
        );
        expect(plan.palette.map((s) => s.color.newCode), <String>[
          'R1',
          'R2',
          'R3',
          'R4',
        ]);
        expect(plan.palette.map((s) => s.role), <String>[
          IdeaRoles.light,
          IdeaRoles.base,
          IdeaRoles.shadow,
          IdeaRoles.deepShadow,
        ]);
      }
    });
  });

  group('seeds', () {
    test(
      'random markers change with the seed and repeat with the same one',
      () {
        final IdeaPreset random = _preset('random_colors');
        final Set<String> draws = <String>{
          for (var seed = 1; seed <= 6; seed++)
            IdeasEngine.generatePlan(
              random,
              ohuhu,
              seed: seed,
            ).palette.map((s) => s.color.colorId).join(','),
        };
        expect(draws.length, greaterThan(4));
        expect(
          IdeasEngine.generatePlan(random, ohuhu, seed: 7).palette,
          IdeasEngine.generatePlan(random, ohuhu, seed: 7).palette,
        );
        // Still sorted and labelled from light to dark.
        final IdeaPlan plan = IdeasEngine.generatePlan(random, ohuhu, seed: 3);
        expect(plan.palette.map((s) => s.role), _ladder);
        final List<double> ls = _ladderLightness(plan);
        for (var i = 1; i < ls.length; i++) {
          expect(ls[i], lessThanOrEqualTo(ls[i - 1]));
        }
      },
    );

    test('"Other markers" picks other markers for most ideas', () {
      var changed = 0;
      final List<IdeaPreset> withPalette = IdeasEngine.presets
          .where((p) => p.hasPalette)
          .toList();
      for (final IdeaPreset preset in withPalette) {
        final String first = IdeasEngine.generatePlan(
          preset,
          ohuhu,
        ).palette.map((s) => s.color.colorId).join(',');
        final bool differs = <int>[1, 2, 3].any(
          (seed) =>
              IdeasEngine.generatePlan(
                preset,
                ohuhu,
                seed: seed,
              ).palette.map((s) => s.color.colorId).join(',') !=
              first,
        );
        if (differs) changed++;
      }
      expect(changed, greaterThanOrEqualTo(withPalette.length - 2));
    });
  });

  group('roles', () {
    test('every role has a reason and the ladders name real roles', () {
      for (final String role in IdeaRoles.all) {
        expect(IdeaRoles.reasonFor(role), isNot(role));
      }
      for (var n = 1; n <= 5; n++) {
        expect(IdeaRoles.ladder(n).length, n);
      }
    });

    test('a step with a role finds the marker that plays it', () {
      final IdeaPlan plan = IdeasEngine.generatePlan(
        _preset('three_marker_blend'),
        ohuhu,
      );
      expect(plan.markerFor(IdeaRoles.light), plan.palette.first);
      expect(plan.markerFor(IdeaRoles.shadow), plan.palette.last);
      expect(plan.markerFor(null), isNull);
      expect(plan.markerFor(IdeaRoles.blush), isNull);
    });
  });

  test('natural sort handles case, leading zeros, numeric runs, prefixes and decimals', () {
    final codes = ['R10', 'r2', 'R1', 'R1A', 'R1A10', 'R1A2', 'R'];
    codes.sort(naturalCodeComparator);
    expect(codes, ['R', 'R1', 'R1A', 'R1A2', 'R1A10', 'r2', 'R10']);
    expect(naturalCodeComparator('r02', 'R2'), 0);
    expect(naturalCodeComparator('', 'R'), lessThan(0));
    expect(naturalCodeComparator('0.5', '01'), lessThan(0));
    expect(
      naturalCodeComparator('R99999999999999999999', 'R10'),
      greaterThan(0),
    );
  });
  test(
    'swatch catalog normalizes keys, accepts unknown fields and fails closed',
    () {
      final catalog = decodeSwatchCardLocationCatalog(
        '{"version":1,"extra":true,"profiles":['
        '{"setId":"classic_40","codeToCard":{" r1 ":1,"R2":0,"R3":-1," ":4,"missing":2}}]}',
      );
      expect(catalog['classic_40'], {'R1': 1, 'R2': 0, 'R3': -1, 'MISSING': 2});
      final colors = [
        color('r1', 'ff0000'),
        color('R2', '00ff00'),
        color('R3', '0000ff'),
        color('missing', 'ffffff', sets: ['classic_60']),
      ];
      expect(buildSwatchCardLocationLabels(colors, {'classic_40'}, catalog), {
        'R1': 'Card 1',
      });
      expect(buildSwatchCardLocationLabels(colors, {}, catalog), isEmpty);
      expect(
        buildSwatchCardLocationLabels(colors, {
          'classic_40',
          'classic_60',
        }, catalog),
        isEmpty,
      );
      expect(
        buildSwatchCardLocationLabels(colors, {'classic_60'}, catalog),
        isEmpty,
      );
      for (final raw in [
        'broken',
        '{}',
        '[]',
        '{"version":1,"profiles":[{}]}',
        '{"version":1,"profiles":[{"setId":"s","codeToCard":{"A":"1"}}]}',
      ]) {
        expect(decodeSwatchCardLocationCatalog(raw), isEmpty);
      }
    },
  );
}
