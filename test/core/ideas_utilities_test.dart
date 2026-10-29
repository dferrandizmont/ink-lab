import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/ideas_engine.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/natural_sort.dart';
import 'package:ink_lab/core/swatch_card_location.dart';

import 'fixtures.dart';

void main() {
  final deco = parseColors(
    File(MarkerBrand.decoTime.assetPath).readAsStringSync(),
    brand: MarkerBrand.decoTime,
  );
  final owned = paletteCandidateColors(
    colors: deco,
    brand: MarkerBrand.decoTime,
    ownedMarkerCodes: deco.take(8).map((c) => c.colorId).toSet(),
  );
  for (final preset in IdeasEngine.presets) {
    test('${preset.id}: original guide text and owned collection palette', () {
      for (final size in [1, 3, 4, 5, 10]) {
        final plan = IdeasEngine.generatePlan(preset, owned, size);
        expect(plan.preset, same(preset));
        expect(plan.overview, isNotEmpty);
        expect(plan.steps.length, 4);
        expect(plan.embellishments, isNotEmpty);
        expect(
          plan.palette.length,
          preset.outputMode == IdeaOutputMode.guideOnly ? 0 : size.clamp(3, 5),
        );
        expect(plan.palette.every((s) => owned.contains(s.color)), isTrue);
        expect(
          plan.palette.map((s) => s.color.colorId).toSet().length,
          plan.palette.length,
        );
        expect(
          plan.palette,
          IdeasEngine.generatePlan(preset, owned, size).palette,
        );
      }
      expect(IdeasEngine.generatePlan(preset, [], 5).palette, isEmpty);
    });
  }
  test('catalog has every Kotlin preset and signature guides keep their instructions', () {
    expect(IdeasEngine.presets.length, 30);
    expect(IdeasEngine.presets.map((p) => p.id).toSet().length, 30);
    final sticker = IdeasEngine.generatePlan(
      IdeasEngine.presets.first,
      harmonyColors,
      5,
    );
    expect(
      sticker.steps[1],
      'Add a clean white halo around the full silhouette.',
    );
    expect(sticker.palette, isEmpty);
    final unknown = IdeasEngine.generatePlan(
      const IdeaPreset(
        id: 'unknown',
        title: 'Unknown',
        category: IdeaCategory.challenge,
        outputMode: IdeaOutputMode.guideAndPalette,
        summary: '',
      ),
      harmonyColors,
      3,
    );
    expect(unknown.overview, 'Creative challenge');
    expect(unknown.palette.map((s) => s.color), harmonyColors.take(3));
  });
  test(
    'random preset reproduces JVM hash ordering independent of Dart hashCode',
    () {
      final preset = IdeasEngine.presets.firstWhere(
        (p) => p.id == 'random_colors',
      );
      final candidates = [
        'A',
        'B',
        'C',
        'D',
        'E',
        'F',
      ].map((code) => color(code, 'ff0000')).toList();
      // JVM Int-overflow hash of random_colors|ohuhu_oahu:<code>.
      final result = IdeasEngine.generatePlan(preset, candidates, 5);
      expect(result.palette.map((s) => s.color.newCode), [
        'D',
        'E',
        'F',
        'A',
        'B',
      ]);
    },
  );
  test('rainbow targets choose red, green and blue in role order', () {
    final preset = IdeasEngine.presets.firstWhere((p) => p.id == 'rainbow');
    final plan = IdeasEngine.generatePlan(preset, [
      color('blue', '0000ff'),
      color('green', '00ff00'),
      color('red', 'ff0000'),
    ], 3);
    expect(plan.palette.map((s) => s.color.newCode), ['red', 'green', 'blue']);
    expect(plan.palette.map((s) => s.reason), ['Hue 1', 'Hue 2', 'Hue 3']);
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
