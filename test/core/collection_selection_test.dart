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

  test('swatches "All" is the whole range of the brand, owned or not', () {
    expect(
      swatchCandidateColors(colors: catalog, brand: MarkerBrand.ohuhuOahu),
      [otherPack, classicFirst, addon, classic],
    );
    expect(
      swatchCandidateColors(colors: catalog, brand: MarkerBrand.decoTime),
      [decoOther, deco],
    );
  });

  test('owned = markers of the owned sets + extra markers (union)', () {
    final settings = AppSettings(
      ownedSetIds: {'skin_36'},
      extraMarkerIds: {' r10 ', 'ohuhu_oahu:R1', 'decotime:R2'},
    );
    final List<MarkerColor> owned = ownedColors(
      colors: catalog,
      brand: MarkerBrand.ohuhuOahu,
      ownedSetIds: settings.ownedSetIds,
      ownedMarkerCodes: settings.extraMarkerIds,
    );
    expect(owned, [otherPack, addon, classic]);
    // The palette engines read the same collection.
    expect(
      paletteCandidateColors(
        colors: catalog,
        brand: MarkerBrand.ohuhuOahu,
        activeSetIds: settings.effectiveSetIds(),
        ownedMarkerCodes: settings.ownedMarkerCodes,
      ),
      owned,
    );
    expect(
      ownedColors(
        colors: catalog,
        brand: MarkerBrand.decoTime,
        ownedSetIds: settings.ownedSetIds,
        ownedMarkerCodes: settings.extraMarkerIds,
      ),
      [decoOther],
    );
  });

  test(
    'an Ohuhu collection that is not set up yet palettes from the range',
    () {
      expect(
        paletteCandidateColors(colors: catalog, brand: MarkerBrand.ohuhuOahu),
        [otherPack, classicFirst, addon, classic],
      );
      expect(
        ownedColors(colors: catalog, brand: MarkerBrand.ohuhuOahu),
        isEmpty,
      );
      expect(
        paletteCandidateColors(
          colors: catalog,
          brand: MarkerBrand.ohuhuOahu,
          activeSetIds: {'missing'},
        ),
        isEmpty,
      );
    },
  );

  test('DecoTime owns extra markers only: sets never apply', () {
    // A DecoTime collection that is not set up yet palettes from the range,
    // like Ohuhu.
    expect(
      paletteCandidateColors(colors: catalog, brand: MarkerBrand.decoTime),
      [decoOther, deco],
    );
    expect(
      paletteCandidateColors(
        colors: catalog,
        brand: MarkerBrand.decoTime,
        activeSetIds: {'classic_160'},
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
      paletteCandidateColors(
        colors: catalog,
        brand: MarkerBrand.decoTime,
        activeSetIds: {'classic_160'},
        ownedMarkerCodes: {'R10', 'ohuhu_oahu:R2'},
      ),
      // Only Ohuhu codes and sets: DecoTime is still not set up.
      [decoOther, deco],
    );
  });

  group('migration of the old pack selection', () {
    test('single pack mode keeps only the first core pack, plus add-ons', () {
      final s = AppSettings.fromLegacy(
        selectedCoreSetIds: {'classic_80', 'classic_40'},
        selectedAddonSetIds: {'skin_36'},
        ownedMarkerCodes: {' R1 ', 'decotime:01', ''},
      );
      expect(s.ownedSetIds, {'classic_40', 'skin_36'});
      expect(s.extraMarkerIds, {'R1', 'decotime:01'});
    });

    test('compare mode meant "I own several packs": all of them', () {
      final s = AppSettings.fromLegacy(
        singlePackMode: false,
        selectedCoreSetIds: {'classic_80', 'classic_40'},
        selectedAddonSetIds: {'skin_36'},
      );
      expect(s.ownedSetIds, {'classic_80', 'classic_40', 'skin_36'});
    });

    test('an empty stored selection keeps what the user saw: Oahu 160', () {
      expect(AppSettings.fromLegacy(selectedCoreSetIds: {}).ownedSetIds, {
        'classic_160',
      });
    });

    test('nothing stored means nothing owned', () {
      expect(AppSettings.fromLegacy().ownedSetIds, isEmpty);
      expect(AppSettings().ownedSetIds, isEmpty);
      expect(AppSettings().extraMarkerIds, isEmpty);
    });

    test('collections are unmodifiable', () {
      final sets = {'classic_40'};
      final s = AppSettings(ownedSetIds: sets, extraMarkerIds: {'R1'});
      sets.clear();
      expect(s.ownedSetIds, {'classic_40'});
      expect(() => s.ownedSetIds.clear(), throwsUnsupportedError);
      expect(() => s.extraMarkerIds.clear(), throwsUnsupportedError);
    });
  });
}
