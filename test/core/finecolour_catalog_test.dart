import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/ideas_engine.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/own_colors.dart';
import 'package:ink_lab/core/palette_generator.dart';
import 'package:ink_lab/data/brand_scoping.dart';

import '../support/l10n.dart';

void main() {
  final repo = MarkerRepository(
    loadAsset: (path) => File(path).readAsStringSync(),
  );

  test(
    'Finecolour loads 480 unique named colours with valid hex and blender',
    () async {
      final colors = await repo.loadColors(MarkerBrand.finecolour);
      expect(colors, hasLength(480));
      expect(colors.map((c) => c.colorId).toSet(), hasLength(480));
      for (final color in colors) {
        expect(color.brandId, 'finecolour');
        expect(color.newName.trim(), isNotEmpty);
        expect(color.hex, matches(RegExp(r'^[0-9a-f]{6}$')));
        expect(color.sets, isEmpty);
        expect(color.lines, contains('EF102'));
        expect(
          color.lines.every({'EF100', 'EF101', 'EF102', 'EF103'}.contains),
          isTrue,
        );
        expect(MarkerColor.fromJson(color.toJson()), color);
      }
      expect(
        colors.singleWhere((c) => c.newCode == '0').newName,
        'Colorless Blender',
      );
      // These are sampled chart colours, retained exactly from the source.
      expect(colors.singleWhere((c) => c.newCode == 'Y1').hex, 'f9f2cb');
    },
  );

  test('Finecolour has no retail set memberships', () async {
    final colors = await repo.loadColors(MarkerBrand.finecolour);
    expect(colors, isNotEmpty);
    expect(colors.where((c) => c.sets.isNotEmpty), isEmpty);
  });

  test(
    'English and Spanish onboarding counts match the Finecolour catalogue',
    () async {
      final colors = await repo.loadColors(MarkerBrand.finecolour);
      for (final messages in [l10n, l10nEs]) {
        final numbers = RegExp(r'\d+')
            .allMatches(messages.onboardingFinecolourLine);
        expect(numbers, hasLength(1));
        expect(int.parse(numbers.single.group(0)!), colors.length);
      }
    },
  );

  test(
    'Finecolour dried markers are excluded without falling back to the range',
    () async {
      final colors = await repo.loadColors(MarkerBrand.finecolour);
      final chosen = colors.firstWhere((c) => c.newCode == 'BV321');
      expect(
        ownedColors(
          colors: colors,
          brand: MarkerBrand.finecolour,
          ownedSetIds: {'classic_160'},
          ownedMarkerCodes: {chosen.colorId},
          driedColorIds: {chosen.colorId},
        ),
        isEmpty,
      );
      expect(
        paletteCandidateColors(
          colors: colors,
          brand: MarkerBrand.finecolour,
          activeSetIds: {'classic_160'},
          ownedMarkerCodes: {chosen.colorId},
          driedColorIds: {chosen.colorId},
        ),
        isEmpty,
      );
      // Nothing owned at all: no fallback to the range.
      expect(
        paletteCandidateColors(
          colors: colors,
          brand: MarkerBrand.finecolour,
          activeSetIds: {'classic_160'},
          driedColorIds: {chosen.colorId},
          ownedMarkerCodes: const {},
        ),
        isEmpty,
      );
      // The whole range is still there for the screens that ask for it.
      expect(
        swatchCandidateColors(colors: colors, brand: MarkerBrand.finecolour),
        hasLength(colors.length),
      );
    },
  );

  test('stored brand ids and enum JSON stay stable', () {
    expect(MarkerBrand.ohuhuOahu.id, 'ohuhu_oahu');
    expect(MarkerBrand.copic.id, 'copic');
    expect(MarkerBrand.copic.toJson(), 'Copic');
    expect(MarkerBrand.decoTime.id, 'decotime');
    expect(MarkerBrand.finecolour.id, 'finecolour');
    for (final brand in MarkerBrand.values) {
      expect(MarkerBrand.fromId(brand.id), brand);
      expect(MarkerBrand.fromJson(brand.toJson()), brand);
    }
    expect(MarkerBrand.finecolour.toJson(), 'Finecolour');
    expect(MarkerBrand.finecolour.hasRetailSets, isFalse);
    expect(MarkerBrand.decoTime.hasRetailSets, isFalse);
    expect(MarkerBrand.ohuhuOahu.hasRetailSets, isTrue);
    expect(scopedColorId(' finecolour:bv321 '), 'finecolour:BV321');
  });

  test('ownership ignores foreign codes and retail sets, palettes and ideas use it', () async {
    final colors = await repo.loadColors(MarkerBrand.finecolour);
    const ids = {
      'finecolour:BV321',
      'finecolour:R140',
      'finecolour:B94',
      'finecolour:Y1',
      'finecolour:G45',
      'decotime:01',
      'ohuhu_oahu:BV321',
    };
    final mine = ownedColors(
      colors: colors,
      brand: MarkerBrand.finecolour,
      ownedSetIds: {'classic_160'},
      ownedMarkerCodes: ids,
    );
    expect(mine, hasLength(5));
    expect(mine.every((c) => ids.contains(c.colorId)), isTrue);
    expect(
      paletteCandidateColors(
        colors: colors,
        brand: MarkerBrand.finecolour,
        activeSetIds: {'classic_160'},
        ownedMarkerCodes: ids,
      ),
      mine,
    );
    // Nothing owned: no fallback to the range.
    expect(
      paletteCandidateColors(
        colors: colors,
        brand: MarkerBrand.finecolour,
        activeSetIds: {'classic_160'},
      ),
      isEmpty,
    );
    expect(
      swatchCandidateColors(colors: colors, brand: MarkerBrand.finecolour),
      hasLength(480),
    );
    final palette = buildPalette(mine.first, mine, PaletteMode.recommended);
    expect(palette, isNotEmpty);
    expect(palette.every((p) => mine.contains(p.color)), isTrue);
    for (final preset in IdeasEngine.presets) {
      final plan = IdeasEngine.generatePlan(preset, mine);
      expect(plan.palette.every((p) => mine.contains(p.color)), isTrue);
    }
    final customized = applyOwnColors(colors, {
      'finecolour:BV321': '123456',
      'ohuhu_oahu:R140': '654321',
    });
    expect(customized.singleWhere((c) => c.newCode == 'BV321').hex, '123456');
    expect(
      customized.singleWhere((c) => c.newCode == 'BV321').catalogHex,
      colors.singleWhere((c) => c.newCode == 'BV321').hex,
    );
    expect(
      customized.singleWhere((c) => c.newCode == 'R140').hasOwnColor,
      isFalse,
    );
  });
}
