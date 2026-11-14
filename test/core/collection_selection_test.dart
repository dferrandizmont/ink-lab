import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/palette_advisor.dart';

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

  test('candidate selection is memoized and unmodifiable', () {
    final first = mixedCandidateColors(
      colors: catalog,
      brand: MarkerBrand.ohuhuOahu,
      scope: BrandScope.singleBrand,
      activeSetIds: {'classic_160'},
      ownedMarkerCodes: {'decotime:R10'},
    );
    final second = mixedCandidateColors(
      colors: catalog,
      brand: MarkerBrand.ohuhuOahu,
      scope: BrandScope.singleBrand,
      activeSetIds: {'classic_160'},
      ownedMarkerCodes: {'decotime:R10'},
    );
    expect(identical(first, second), isTrue);
    expect(() => first.add(classic), throwsUnsupportedError);
    final changedSets = mixedCandidateColors(
      colors: catalog,
      brand: MarkerBrand.ohuhuOahu,
      scope: BrandScope.singleBrand,
      activeSetIds: {'classic_40'},
      ownedMarkerCodes: {'decotime:R10'},
    );
    expect(identical(changedSets, first), isFalse);
    final changedColors = mixedCandidateColors(
      colors: [...catalog],
      brand: MarkerBrand.ohuhuOahu,
      scope: BrandScope.singleBrand,
      activeSetIds: {'classic_160'},
      ownedMarkerCodes: {'decotime:R10'},
    );
    expect(identical(changedColors, first), isTrue);
    final pal = paletteCandidateColors(
      colors: catalog,
      brand: MarkerBrand.ohuhuOahu,
      activeSetIds: {'classic_160'},
      ownedMarkerCodes: {'decotime:R10'},
    );
    expect(identical(pal, first), isTrue);
  });

  test('ownedCandidateColors is memoized and unmodifiable', () {
    final first = ownedCandidateColors(
      colors: catalog,
      brand: MarkerBrand.ohuhuOahu,
      scope: BrandScope.mixedBrands,
      activeSetIds: {'classic_160'},
      ownedMarkerCodes: {'decotime:R10', 'decotime:R2'},
    );
    final second = ownedCandidateColors(
      colors: catalog,
      brand: MarkerBrand.ohuhuOahu,
      scope: BrandScope.mixedBrands,
      activeSetIds: {'classic_160'},
      ownedMarkerCodes: {'decotime:R10', 'decotime:R2'},
    );
    expect(identical(first, second), isTrue);
    expect(() => first.clear(), throwsUnsupportedError);
  });

  group('candidate cache key', () {
    List<MarkerColor> mixed({
      List<MarkerColor>? colors,
      MarkerBrand brand = MarkerBrand.ohuhuOahu,
      BrandScope scope = BrandScope.singleBrand,
      Set<String> sets = const {},
      Set<String> codes = const {},
      Set<String> dried = const {},
    }) => mixedCandidateColors(
      colors: colors ?? catalog,
      brand: brand,
      scope: scope,
      activeSetIds: sets,
      ownedMarkerCodes: codes,
      driedColorIds: dried,
    );

    List<MarkerColor> owned({
      List<MarkerColor>? colors,
      MarkerBrand brand = MarkerBrand.ohuhuOahu,
      BrandScope scope = BrandScope.mixedBrands,
      Set<String> sets = const {},
      Set<String> codes = const {},
      Set<String> dried = const {},
    }) => ownedCandidateColors(
      colors: colors ?? catalog,
      brand: brand,
      scope: scope,
      activeSetIds: sets,
      ownedMarkerCodes: codes,
      driedColorIds: dried,
    );

    // Each case changes ONE input of a baseline and must miss with the right
    // content; the baseline itself must still give its own content after.
    final cases =
        <
          ({
            String name,
            List<MarkerColor> Function() base,
            List<MarkerColor> Function() changed,
            List<MarkerColor> baseExpected,
            List<MarkerColor> changedExpected,
          })
        >[
          (
            name: 'brand',
            base: () => mixed(sets: {'classic_160'}, codes: {'decotime:R10'}),
            changed: () => mixed(
              brand: MarkerBrand.decoTime,
              sets: {'classic_160'},
              codes: {'decotime:R10'},
            ),
            baseExpected: [classicFirst, classic],
            changedExpected: [deco],
          ),
          (
            name: 'scope',
            base: () => mixed(
              sets: {'classic_160'},
              codes: {'decotime:R10', 'decotime:R2'},
            ),
            changed: () => mixed(
              scope: BrandScope.mixedBrands,
              sets: {'classic_160'},
              codes: {'decotime:R10', 'decotime:R2'},
            ),
            baseExpected: [classicFirst, classic],
            changedExpected: [classicFirst, classic, decoOther, deco],
          ),
          (
            name: 'activeSetIds',
            base: () => mixed(sets: {'classic_160'}),
            changed: () => mixed(sets: {'classic_40'}),
            baseExpected: [classicFirst, classic],
            changedExpected: [otherPack],
          ),
          (
            name: 'ownedMarkerCodes',
            base: () => mixed(sets: {'classic_160'}, codes: {'R1'}),
            changed: () => mixed(sets: {'classic_160'}, codes: {'R3'}),
            baseExpected: [otherPack, classicFirst, classic],
            changedExpected: [classicFirst, addon, classic],
          ),
          (
            name: 'driedColorIds',
            base: () => mixed(sets: {'classic_160'}),
            changed: () =>
                mixed(sets: {'classic_160'}, dried: {classic.colorId}),
            baseExpected: [classicFirst, classic],
            changedExpected: [classicFirst],
          ),
        ];

    for (final c in cases) {
      test('a change of only ${c.name} misses and is right', () {
        final base = c.base();
        expect(base, c.baseExpected);
        final changed = c.changed();
        expect(identical(changed, base), isFalse);
        expect(changed, c.changedExpected);
        // The baseline is still answered with its own content, and now hits.
        final again = c.base();
        expect(again, c.baseExpected);
        expect(identical(again, base), isTrue);
        expect(identical(c.changed(), changed), isTrue);
      });
    }

    test('hits return the same instance with the same content', () {
      final a = mixed(sets: {'classic_40'});
      final b = mixed(colors: [...catalog], sets: {'classic_40'});
      expect(a, [otherPack]);
      expect(identical(a, b), isTrue);
      final o1 = owned(sets: {'classic_40'}, codes: {'decotime:R2'});
      final o2 = owned(sets: {'classic_40'}, codes: {'decotime:R2'});
      expect(o1, [otherPack, decoOther]);
      expect(identical(o1, o2), isTrue);
    });

    test('mutating the caller sets afterwards does not corrupt the key', () {
      final sets = <String>{'classic_160'};
      final codes = <String>{'decotime:R10'};
      final dried = <String>{};
      List<MarkerColor> call() => mixed(
        scope: BrandScope.mixedBrands,
        sets: sets,
        codes: codes,
        dried: dried,
      );
      List<MarkerColor> oldCopy() => mixed(
        scope: BrandScope.mixedBrands,
        sets: {'classic_160'},
        codes: {'decotime:R10'},
      );
      final first = call();
      expect(first, [classicFirst, classic, deco]);

      sets
        ..clear()
        ..add('classic_40');
      final changedSets = call();
      expect(changedSets, [otherPack, deco]);
      expect(identical(changedSets, first), isFalse);
      // An equal copy of the old set still gives the old content (a hit).
      expect(oldCopy(), same(first));

      sets
        ..clear()
        ..add('classic_160');
      codes.add('decotime:R2');
      expect(call(), [classicFirst, classic, decoOther, deco]);
      expect(oldCopy(), same(first));

      codes.remove('decotime:R2');
      dried.add(classic.colorId);
      expect(call(), [classicFirst, deco]);
      expect(oldCopy(), same(first));
      expect(first, [classicFirst, classic, deco]);
    });

    test('mutating the caller sets does not corrupt the owned cache', () {
      final sets = <String>{'classic_160'};
      List<MarkerColor> call() =>
          owned(sets: sets, codes: const {'decotime:R10'});
      final first = call();
      expect(first, [classicFirst, classic, deco]);
      sets
        ..clear()
        ..add('classic_40');
      expect(call(), [otherPack, deco]);
      expect(
        owned(sets: {'classic_160'}, codes: {'decotime:R10'}),
        same(first),
      );
    });

    test('the input list mutated in place gives the new right result', () {
      final list = <MarkerColor>[...catalog];
      List<MarkerColor> call() => mixed(colors: list, sets: {'classic_160'});
      final before = call();
      expect(before, [classicFirst, classic]);
      expect(identical(call(), before), isTrue);

      list.removeWhere((c) => identical(c, classic));
      final removed = call();
      expect(removed, [classicFirst]);
      expect(identical(removed, before), isFalse);
      expect(before, [classicFirst, classic]);

      // Same length, one element swapped in place.
      final i = list.indexOf(classicFirst);
      list[i] = classic;
      expect(call(), [classic]);

      list.add(classicFirst);
      expect(call(), [classicFirst, classic]);
    });

    test('the owned cache sees an in-place mutation too', () {
      final list = <MarkerColor>[...catalog];
      List<MarkerColor> call() => owned(colors: list, sets: {'classic_160'});
      expect(call(), [classicFirst, classic]);
      list.removeWhere((c) => identical(c, classicFirst));
      expect(call(), [classic]);
    });

    test('distinct objects whose sort keys tie keep their list order', () {
      final tieA = color('R5', '111111', sets: ['classic_160']);
      final tieB = color('R5', '222222', sets: ['classic_160']);
      final tieC = color('r5', '333333', sets: ['classic_160']);
      List<MarkerColor> call(List<MarkerColor> list) =>
          mixed(colors: list, sets: {'classic_160'});
      void expectOrder(List<MarkerColor> got, List<MarkerColor> want) {
        expect(got, hasLength(want.length));
        for (var i = 0; i < want.length; i++) {
          expect(identical(got[i], want[i]), isTrue, reason: 'position $i');
        }
      }

      final abc = call([tieB, tieA, tieC]);
      expectOrder(abc, [tieB, tieA, tieC]);
      // The same objects in another order are another key and keep THEIR
      // order, not the cached one.
      final cab = call([tieC, tieA, tieB]);
      expect(identical(cab, abc), isFalse);
      expectOrder(cab, [tieC, tieA, tieB]);
      // An equal-looking but distinct object is not the same key either.
      final twin = color('R5', '111111', sets: ['classic_160']);
      final withTwin = call([tieB, twin, tieC]);
      expect(identical(withTwin, abc), isFalse);
      expectOrder(withTwin, [tieB, twin, tieC]);
      expectOrder(owned(colors: [tieB, tieA, tieC], sets: {'classic_160'}), [
        tieB,
        tieA,
        tieC,
      ]);
    });

    test('two equal requests built apart share one cached result', () {
      PaletteAdvisorRequest build() => PaletteAdvisorRequest(
        availableColors: [...catalog],
        brand: MarkerBrand.ohuhuOahu,
        scope: BrandScope.mixedBrands,
        activeSetIds: {'classic_160'},
        ownedMarkerCodes: {'decotime:R10'},
        driedColorIds: {classic.colorId},
      );
      List<MarkerColor> candidates(PaletteAdvisorRequest r) =>
          paletteCandidateColors(
            colors: r.availableColors,
            brand: r.brand,
            scope: r.scope,
            driedColorIds: r.driedColorIds,
            activeSetIds: r.activeSetIds,
            ownedMarkerCodes: r.ownedMarkerCodes,
          );
      final a = build();
      final b = build();
      expect(identical(a.availableColors, b.availableColors), isFalse);
      final ra = candidates(a);
      expect(ra, [classicFirst, deco]);
      expect(identical(candidates(b), ra), isTrue);
    });
  });
}
