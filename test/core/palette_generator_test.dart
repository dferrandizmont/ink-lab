import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/palette_advisor.dart';
import 'package:ink_lab/core/palette_generator.dart';

import 'fixtures.dart';

void main() {
  final ohuhu = parseColors(
    File(MarkerBrand.ohuhuOahu.assetPath).readAsStringSync(),
    brand: MarkerBrand.ohuhuOahu,
  );
  final deco = parseColors(
    File(MarkerBrand.decoTime.assetPath).readAsStringSync(),
    brand: MarkerBrand.decoTime,
  );
  final collection = paletteCandidateColors(
    colors: ohuhu,
    brand: MarkerBrand.ohuhuOahu,
    activeSetIds: {'classic_40'},
  );
  final base = collection.firstWhere((c) => c.newCode != '0');
  for (final mode in PaletteMode.values) {
    for (final size in [1, 3, 4, 5, 10]) {
      test(
        '${mode.name} size $size uses only active collection codes, excludes base',
        () {
          final result = buildPalette(base, collection, mode, size: size);
          expect(
            result.length,
            mode == PaletteMode.customPalette ? 0 : size.clamp(3, 5),
          );
          expect(
            result.map((s) => s.color.colorId).toSet().length,
            result.length,
          );
          expect(
            result.every(
              (s) => collection.contains(s.color) && s.color != base,
            ),
            isTrue,
          );
          expect(result.every((s) => s.reason.isNotEmpty), isTrue);
          expect(result, buildPalette(base, collection, mode, size: size));
        },
      );
    }
  }
  final expectedFirst = {
    PaletteMode.complementary: 'opposite',
    PaletteMode.analogous: 'nearA',
    PaletteMode.splitComplementary: 'splitA',
    PaletteMode.triad: 'triadA',
    PaletteMode.square: 'squareA',
    PaletteMode.rectangle: 'rectangleA',
    PaletteMode.monochrome: 'mono',
    PaletteMode.shadow: 'shadow',
  };
  for (final entry in expectedFirst.entries) {
    test(
      '${entry.key.name} prioritizes the expected source-formula target',
      () {
        expect(
          buildPalette(
            harmonyColors.first,
            harmonyColors,
            entry.key,
          ).first.color.newCode,
          entry.value,
        );
      },
    );
  }
  test('recommended preserves role priority, fallback and duplicate-role overwrite', () {
    final base = color('B', 'ff8080');
    final shadow = color('S', '803f3f');
    final highlight = color('H', 'ffcccc');
    final result = buildPalette(base, [
      base,
      shadow,
      highlight,
    ], PaletteMode.recommended);
    expect(result.map((s) => s.color.newCode).toSet(), {'S', 'H'});
    expect(result.first.reason, 'Controlled contrast');
    expect(result.last.reason, 'Neutral balance');
    expect(
      result,
      buildPalette(base, [base, shadow, highlight], PaletteMode.recommended),
    );
  });
  test('stable ties retain input order and tiny candidate pools do not invent colors', () {
    final same = [
      color('first', '00ffff'),
      color('second', '00ffff'),
      color('third', '00ffff'),
    ];
    expect(
      buildPalette(
        harmonyColors.first,
        same,
        PaletteMode.complementary,
      ).map((s) => s.color.newCode),
      ['first', 'second', 'third'],
    );
    expect(buildPalette(base, [base], PaletteMode.shadow), isEmpty);
    expect(findScenarioDefaultBase([], DrawingScenario.forestScene), isNull);
    expect(
      buildScenarioPalette(base, [], DrawingScenario.forestScene),
      isEmpty,
    );
  });
  test('collection validation preserves MainActivity natural order and equal-code stability', () {
    final first = color('R02', 'ff0000');
    final second = color('r2', '00ff00');
    final sorted = paletteCandidateColors(
      colors: [color('R10', 'ffffff'), first, second, color('R1', '000000')],
      brand: MarkerBrand.ohuhuOahu,
      activeSetIds: {'classic_40'},
    );
    expect(sorted.map((c) => c.newCode), ['R1', 'R02', 'r2', 'R10']);
    expect(sorted[1], same(first));
    expect(sorted[2], same(second));
  });
  for (final scenario in DrawingScenario.values) {
    test(
      '${scenario.name} default seed and scenario palette stay inside collection',
      () {
        final seed = findScenarioDefaultBase(collection, scenario)!;
        expect(collection, contains(seed));
        for (final token in [0, 7, -7]) {
          final result = buildScenarioPalette(
            seed,
            collection,
            scenario,
            size: 5,
            variationToken: token,
          );
          expect(result.length, 5);
          expect(
            result.every(
              (s) => collection.contains(s.color) && s.color != seed,
            ),
            isTrue,
          );
          expect(result.map((s) => s.color.colorId).toSet().length, 5);
          expect(
            result,
            buildScenarioPalette(
              seed,
              collection,
              scenario,
              variationToken: token,
            ),
          );
        }
      },
    );
  }
  test(
    'Ghost scenario seed, role labels and token rotations follow Kotlin',
    () {
      final seed = color('seed', 'b8cce0'); // H=210, S~.18, V~.88.
      expect(
        findScenarioDefaultBase([
          harmonyColors.first,
          seed,
        ], DrawingScenario.ghostCharacter),
        seed,
      );
      final result = buildScenarioPalette(seed, [
        seed,
        ...harmonyColors,
      ], DrawingScenario.ghostCharacter);
      expect(result.map((s) => s.reason), [
        'Soft shadow',
        'Deep shadow',
        'Highlight',
        'Accent',
        'Background',
      ]);
      expect(
        buildScenarioPalette(
          seed,
          [seed, ...harmonyColors],
          DrawingScenario.ghostCharacter,
          variationToken: 1,
        ),
        isNot(result),
      );
    },
  );
  for (final variation in QuickPaletteVariation.values) {
    test(
      '${variation.name} retains locks, strips repeated prefixes, excludes base',
      () {
        final current = [
          PaletteSuggestion(color: harmonyColors[1], reason: 'Accent'),
          PaletteSuggestion(
            color: harmonyColors[2],
            reason: 'Soft: Vibrant: Warm: Original',
          ),
          PaletteSuggestion(color: harmonyColors[3], reason: ''),
        ];
        final result = remixPaletteWithVariation(
          current,
          harmonyColors,
          {current.first.color.newCode},
          harmonyColors.first.newCode,
          variation,
          size: 3,
        );
        expect(result.length, 3);
        expect(result.first.color, current.first.color);
        expect(result.first.reason, 'Locked');
        expect(result[1].reason, '${variation.reasonPrefix}: Original');
        expect(result[2].reason, '${variation.reasonPrefix}: AI suggestion');
        expect(
          result.every(
            (s) =>
                harmonyColors.contains(s.color) &&
                s.color != harmonyColors.first,
          ),
          isTrue,
        );
        expect(result.map((s) => s.color.colorId).toSet().length, 3);
        expect(
          remixPaletteWithVariation(current, [], {}, null, variation, size: 3),
          current,
        );
      },
    );
  }
  test('brand scopes and source owned-marker rules never leak matching codes between brands', () {
    expect(
      scopedCodesForBrand({
        ' r1 ',
        'decotime:01',
        'ohuhu_oahu:r2',
        '',
        'unknown:r3',
      }, 'ohuhu_oahu'),
      {'R1', 'R2', 'R3'},
    );
    expect(
      scopedCodesForBrand({'01', 'decotime: 01 ', 'ohuhu_oahu:02'}, 'decotime'),
      {'01'},
    );
    expect(
      paletteCandidateColors(
        colors: [...ohuhu, ...deco],
        brand: MarkerBrand.decoTime,
      ),
      isEmpty,
    );
    final owned = paletteCandidateColors(
      colors: [...ohuhu, ...deco],
      brand: MarkerBrand.decoTime,
      ownedMarkerCodes: {'decotime:01', 'decotime:02', 'ohuhu_oahu:03'},
      activeSetIds: {'classic_40'},
    );
    expect(owned.map((c) => c.newCode), ['01', '02']);
    expect(owned.every((c) => c.brandId == 'decotime'), isTrue);
    final selectedOhuhu = paletteCandidateColors(
      colors: ohuhu,
      brand: MarkerBrand.ohuhuOahu,
      ownedMarkerCodes: {base.colorId},
      activeSetIds: {'classic_40'},
    );
    expect(selectedOhuhu, [base]);
  });
  for (final mode in PaletteMode.values) {
    test(
      'DecoTime ${mode.name} advisor enforces owned markers on full mixed catalog',
      () {
        final owned = deco.take(7).map((c) => c.colorId).toSet();
        final PaletteAdvisor advisor = const PaletteGenerator();
        final result = advisor.advise(
          PaletteAdvisorRequest(
            brand: MarkerBrand.decoTime,
            baseColor: deco[1],
            availableColors: [...ohuhu, ...deco],
            ownedMarkerCodes: owned,
            mode: mode,
          ),
        );
        expect(result, isA<PaletteAdviceSuccess>());
        final suggestions = (result as PaletteAdviceSuccess).suggestions;
        expect(suggestions.length, mode == PaletteMode.customPalette ? 0 : 5);
        expect(
          suggestions.every(
            (s) => owned.contains(s.color.colorId) && s.color != deco[1],
          ),
          isTrue,
        );
      },
    );
  }
  test(
    'advisor reports typed failures and can choose a scenario base locally',
    () {
      const advisor = PaletteGenerator();
      PaletteFailureReason failure(PaletteAdvisorRequest request) =>
          (advisor.advise(request) as PaletteAdviceFailure).reason;
      expect(
        failure(PaletteAdvisorRequest(availableColors: [])),
        PaletteFailureReason.noAvailableColors,
      );
      expect(
        failure(PaletteAdvisorRequest(availableColors: ohuhu)),
        PaletteFailureReason.missingBaseColor,
      );
      expect(
        failure(
          PaletteAdvisorRequest(availableColors: ohuhu, baseColor: deco[1]),
        ),
        PaletteFailureReason.invalidBaseColor,
      );
      expect(
        failure(
          PaletteAdvisorRequest(
            availableColors: deco,
            brand: MarkerBrand.decoTime,
            baseColor: deco[1],
          ),
        ),
        PaletteFailureReason.noAvailableColors,
      );
      expect(
        failure(
          PaletteAdvisorRequest(availableColors: [base], baseColor: base),
        ),
        PaletteFailureReason.noSuggestions,
      );
      final success = advisor.advise(
        PaletteAdvisorRequest(
          availableColors: ohuhu,
          activeSetIds: {'classic_40'},
          scenario: DrawingScenario.forestScene,
        ),
      );
      expect(success, isA<PaletteAdviceSuccess>());
      expect(
        (success as PaletteAdviceSuccess).suggestions.every(
          (s) => collection.contains(s.color),
        ),
        isTrue,
      );
    },
  );
  test('base input resolves current and legacy codes case-insensitively', () {
    final first = color('R1', 'ff0000').copyWith(oldCode: 'OLD7');
    final later = color('OLD7', '00ff00');
    expect(resolveBaseColor(' r1 ', [first, later]), same(first));
    expect(resolveBaseColor(' oLd7 ', [first, later]), same(first));
    expect(resolveBaseColor('missing', [first, later]), isNull);
    expect(resolveBaseColor('', [first, later]), isNull);
    expect(resolveBaseColor('R1', []), isNull);
  });
  test('palette builders accept supplied candidates from other brands', () {
    final seed = color('base', 'ff0000');
    final foreign = color('companion', '00ffff', brandId: 'decotime');
    final duplicateCode = foreign.copyWith(newCode: seed.newCode);
    final candidates = [seed, duplicateCode, foreign];
    expect(
      buildPalette(seed, candidates, PaletteMode.triad).single.color,
      same(foreign),
    );
    expect(
      buildScenarioPalette(
        seed,
        candidates,
        DrawingScenario.forestScene,
      ).single.color,
      same(foreign),
    );
  });
  test('scenario minimum saturation adds Kotlin penalty only below bound', () {
    const unbounded = ScenarioTarget(
      'test',
      [0],
      valueDelta: 0,
      saturationDelta: 0,
    );
    const bounded = ScenarioTarget(
      'test',
      [0],
      valueDelta: 0,
      saturationDelta: 0,
      minSaturation: 0.4,
    );
    const bothBounds = ScenarioTarget(
      'test',
      [0],
      valueDelta: 0,
      saturationDelta: 0,
      minSaturation: 0.4,
      maxSaturation: 0.6,
    );
    final base = [30.0, 0.5, 0.7];
    for (final saturation in [0.0, 0.2, 0.4, 0.8]) {
      final candidate = [30.0, saturation, 0.7];
      final score = scoreScenarioTarget(base, candidate, unbounded);
      final minPenalty = saturation < 0.4 ? (0.4 - saturation) * 0.5 : 0;
      final maxPenalty = saturation > 0.6 ? (saturation - 0.6) * 0.5 : 0;
      expect(
        scoreScenarioTarget(base, candidate, bounded),
        closeTo(score + minPenalty, 1e-12),
      );
      expect(
        scoreScenarioTarget(base, candidate, bothBounds),
        closeTo(score + minPenalty + maxPenalty, 1e-12),
      );
    }
  });
}
