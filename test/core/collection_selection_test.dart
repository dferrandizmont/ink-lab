import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/models.dart';

import 'fixtures.dart';

void main() {
  final classic = color('R10', 'ff0000', sets: ['classic_160']);
  final classicFirst = color('R2', 'aa0000', sets: ['classic_160']);
  final otherPack = color('R1', '00ff00', sets: ['classic_40']);
  final addon = color('R3', 'ffaaaa', sets: ['skin_36']);
  final deco = color('R10', '0000ff', brandId: 'decotime', sets: []);
  final decoOther = color('R2', '0000aa', brandId: 'decotime', sets: []);
  final catalog = [classic, otherPack, deco, classicFirst, addon, decoOther];

  test(
    'empty Ohuhu active sets fall back to classic160 for both candidate lists',
    () {
      expect(
        swatchCandidateColors(colors: catalog, brand: MarkerBrand.ohuhuOahu),
        [classicFirst, classic],
      );
      expect(
        paletteCandidateColors(colors: catalog, brand: MarkerBrand.ohuhuOahu),
        [classicFirst, classic],
      );
      final settings = AppSettings(
        selectedCoreSetIds: {},
        selectedAddonSetIds: {'skin_36'},
      );
      expect(
        swatchCandidateColors(
          colors: catalog,
          brand: MarkerBrand.ohuhuOahu,
          activeSetIds: settings.effectiveSetIds(),
        ),
        [addon],
      );
    },
  );

  test('Ohuhu swatches ignore owned codes while palettes intersect them with packs', () {
    final settings = AppSettings(
      selectedCoreSetIds: {'classic_160'},
      ownedMarkerCodes: {' r10 ', 'ohuhu_oahu:R1', 'decotime:R2'},
    );
    expect(
      swatchCandidateColors(
        colors: catalog,
        brand: MarkerBrand.ohuhuOahu,
        activeSetIds: settings.effectiveSetIds(),
        ownedMarkerCodes: settings.ownedMarkerCodes,
      ),
      [classicFirst, classic],
    );
    expect(
      paletteCandidateColors(
        colors: catalog,
        brand: MarkerBrand.ohuhuOahu,
        activeSetIds: settings.effectiveSetIds(),
        ownedMarkerCodes: settings.ownedMarkerCodes,
      ),
      [classic],
    );
    expect(
      paletteCandidateColors(
        colors: catalog,
        brand: MarkerBrand.ohuhuOahu,
        ownedMarkerCodes: {'R1'},
      ),
      isEmpty,
    );
    expect(
      swatchCandidateColors(
        colors: catalog,
        brand: MarkerBrand.ohuhuOahu,
        activeSetIds: {'missing'},
      ),
      isEmpty,
    );
  });

  test(
    'DecoTime swatches and palettes require owned brand codes and ignore packs',
    () {
      for (final select in [swatchCandidateColors, paletteCandidateColors]) {
        expect(select(colors: catalog, brand: MarkerBrand.decoTime), isEmpty);
        expect(
          select(
            colors: catalog,
            brand: MarkerBrand.decoTime,
            activeSetIds: {'missing'},
            ownedMarkerCodes: {
              'decotime:r10',
              'ohuhu_oahu:R2',
              'R2',
              'decotime:missing',
            },
          ),
          [deco],
        );
        expect(
          select(
            colors: catalog,
            brand: MarkerBrand.decoTime,
            ownedMarkerCodes: {'R10', 'ohuhu_oahu:R2'},
          ),
          isEmpty,
        );
      }
    },
  );
}
