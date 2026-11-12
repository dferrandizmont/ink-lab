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

  test('the brands that can be mixed are the ones with a usable marker', () {
    List<MarkerBrand> brands({Set<String> dried = const {}}) =>
        usableOwnedBrands(
          colors: catalog,
          activeSetIds: {'classic_160'},
          ownedMarkerCodes: {'decotime:R10'},
          driedColorIds: dried,
        );
    expect(brands(), [MarkerBrand.ohuhuOahu, MarkerBrand.decoTime]);
    // Its only marker ran dry: nothing of that brand is left to mix.
    expect(brands(dried: {deco.colorId}), [MarkerBrand.ohuhuOahu]);
    expect(usableOwnedBrands(colors: catalog), isEmpty);
  });

  test('mixed candidates keep identical codes in distinct brands and omit dried markers', () {
    final selected = mixedCandidateColors(
      colors: catalog,
      brand: MarkerBrand.ohuhuOahu,
      activeSetIds: {'classic_160'},
      ownedMarkerCodes: {'decotime:R10', 'decotime:R2'},
      driedColorIds: {decoOther.colorId},
    );
    expect(selected.map((c) => c.colorId), [
      classicFirst.colorId,
      classic.colorId,
      deco.colorId,
    ]);
    expect(selected.where((c) => c.newCode == 'R10'), hasLength(2));
    expect(
      mixedCandidateColors(
        colors: catalog,
        brand: MarkerBrand.ohuhuOahu,
        scope: BrandScope.singleBrand,
        activeSetIds: {'classic_160'},
        ownedMarkerCodes: {'decotime:R10'},
      ),
      [classicFirst, classic],
    );
    expect(
      mixedCandidateColors(
        colors: catalog,
        brand: MarkerBrand.ohuhuOahu,
        ownedMarkerCodes: {'decotime:R10'},
      ),
      isEmpty,
    );
  });

  test('the owned markers follow the scope, dried ones included', () {
    List<String> owned({
      BrandScope scope = BrandScope.mixedBrands,
      Set<String> codes = const {'decotime:R10', 'decotime:R2'},
      Set<String> sets = const {'classic_160'},
      Set<String> dried = const {},
    }) => ownedCandidateColors(
      colors: catalog,
      brand: MarkerBrand.ohuhuOahu,
      scope: scope,
      activeSetIds: sets,
      ownedMarkerCodes: codes,
      driedColorIds: dried,
    ).map((c) => c.colorId).toList();
    final ohuhu = [classicFirst.colorId, classic.colorId];
    final decoTime = [decoOther.colorId, deco.colorId];
    // One brand: its markers, whatever else the user owns.
    expect(owned(scope: BrandScope.singleBrand), ohuhu);
    // Two usable brands are mixed: the markers of both, a dried one too.
    expect(owned(), [...ohuhu, ...decoTime]);
    expect(owned(dried: {decoOther.colorId}), [...ohuhu, ...decoTime]);
    // Only one brand is usable, so the scope works as the active brand.
    expect(owned(dried: {deco.colorId, decoOther.colorId}), ohuhu);
    // The active brand is empty and the other brand ran dry: no brand is
    // usable, and the collection is still not empty (it is all dried out).
    expect(
      owned(sets: const {}, dried: {deco.colorId, decoOther.colorId}),
      decoTime,
    );
    // The other brand is usable and the active one is empty: the scope
    // works as the active brand, which owns nothing.
    expect(owned(sets: const {}), isEmpty);
  });

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

  test('an Ohuhu collection that is not set up yet offers nothing', () {
    expect(
      paletteCandidateColors(colors: catalog, brand: MarkerBrand.ohuhuOahu),
      isEmpty,
    );
    expect(ownedColors(colors: catalog, brand: MarkerBrand.ohuhuOahu), isEmpty);
    expect(
      paletteCandidateColors(
        colors: catalog,
        brand: MarkerBrand.ohuhuOahu,
        activeSetIds: {'missing'},
      ),
      isEmpty,
    );
  });

  test('DecoTime owns extra markers only: sets never apply', () {
    // A DecoTime collection that is not set up yet offers nothing, like
    // Ohuhu: the range is never offered in its place.
    expect(
      paletteCandidateColors(colors: catalog, brand: MarkerBrand.decoTime),
      isEmpty,
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
      isEmpty,
    );
  });

  group('the palette candidates', () {
    test('nothing owned: nothing to build a palette with', () {
      expect(
        paletteCandidateColors(colors: catalog, brand: MarkerBrand.ohuhuOahu),
        isEmpty,
      );
      expect(
        paletteCandidateColors(colors: catalog, brand: MarkerBrand.decoTime),
        isEmpty,
      );
      // The whole range is still one call away, for the screens that ask
      // for it explicitly.
      expect(brandRangeColors(colors: catalog, brand: MarkerBrand.decoTime), [
        decoOther,
        deco,
      ]);
    });

    test('only the owned markers, and never the dried-out ones', () {
      expect(
        paletteCandidateColors(
          colors: catalog,
          brand: MarkerBrand.ohuhuOahu,
          activeSetIds: {'classic_160'},
        ),
        [classicFirst, classic],
      );
      expect(
        paletteCandidateColors(
          colors: catalog,
          brand: MarkerBrand.ohuhuOahu,
          activeSetIds: {'classic_160'},
          driedColorIds: {classicFirst.colorId},
        ),
        [classic],
      );
      // The markers added by hand are owned too.
      expect(
        paletteCandidateColors(
          colors: catalog,
          brand: MarkerBrand.ohuhuOahu,
          ownedMarkerCodes: {'ohuhu_oahu:R1'},
        ),
        [otherPack],
      );
    });
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
