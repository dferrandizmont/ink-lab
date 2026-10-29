import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';

import 'fixtures.dart';

void main() {
  test('defaults match the Kotlin store', () async {
    final h = await harness();
    expect(h.appSettings.brand, MarkerBrand.ohuhuOahu);
    expect(h.appSettings.scope, BrandScope.singleBrand);
    // A fresh install owns nothing until the first-run setup.
    expect(h.appSettings.settings.ownedSetIds, isEmpty);
    expect(h.appSettings.settings.extraMarkerIds, isEmpty);
    expect(h.appSettings.state.matchSuggestUnowned, isTrue);
    expect(h.appSettings.favorites, isEmpty);
    expect(h.appSettings.nameDisplayMode, NameDisplayMode.newOnly);
    expect(h.appSettings.onboardingCompleted, isFalse);
    expect(h.appSettings.themeMode, AppThemeMode.system);
  });

  test('every setter persists and survives a reopen', () async {
    final h = await harness();
    await h.appSettings.setBrand(MarkerBrand.decoTime);
    await h.appSettings.setScope(BrandScope.mixedBrands);
    await h.appSettings.setOwnedSetIds({'classic_80', 'skin_36'});
    await h.appSettings.setExtraMarkerIds({'R1', 'decotime:02'});
    await h.appSettings.setMatchSuggestUnowned(false);
    await h.appSettings.setNameDisplayMode(NameDisplayMode.newOnly);
    await h.appSettings.setOnboardingCompleted(true);
    await h.appSettings.setThemeMode(AppThemeMode.dark);

    final reopened = StoredAppSettingsRepository(h.store);
    await reopened.load();
    expect(reopened.brand, MarkerBrand.decoTime);
    expect(reopened.scope, BrandScope.mixedBrands);
    expect(reopened.settings.ownedSetIds, {'classic_80', 'skin_36'});
    // Extra markers are stored brand-scoped.
    expect(reopened.settings.extraMarkerIds, {'ohuhu_oahu:R1', 'decotime:02'});
    expect(reopened.state.matchSuggestUnowned, isFalse);
    expect(reopened.nameDisplayMode, NameDisplayMode.newOnly);
    expect(reopened.themeMode, AppThemeMode.dark);
    expect(reopened.onboardingCompleted, isTrue);
    expect(reopened.state, h.appSettings.state);
  });

  test('the chosen series persist without any set, and in a backup', () async {
    final h = await harness();
    await h.appSettings.setCollection(
      AppSettings(chosenSeriesIds: const {'honolulu', 'oahu', 'bogus'}),
    );

    final reopened = StoredAppSettingsRepository(h.store);
    await reopened.load();
    expect(reopened.settings.ownedSetIds, isEmpty);
    // Unknown series ids are dropped.
    expect(reopened.settings.chosenSeriesIds, {'honolulu', 'oahu'});
    expect(reopened.settings.ownedSeries, {
      MarkerLine.oahu,
      MarkerLine.honolulu,
    });

    // A series that holds an owned set counts even if it was never stored.
    final legacy = AppSettings(ownedSetIds: const {'kaala_basic_24'});
    expect(legacy.ownedSeries, {MarkerLine.kaala});

    final json = reopened.state.toJson();
    expect(AppSettingsState.fromJson(json), reopened.state);
    expect(AppSettingsState.fromJson(json).settings.chosenSeriesIds, {
      'honolulu',
      'oahu',
    });
  });

  test('changes replays the current snapshot then emits updates', () async {
    final h = await harness();
    final seen = <AppSettingsState>[];
    final subscription = h.appSettings.changes.listen(seen.add);
    await pumpEventQueue();
    expect(seen, hasLength(1));

    await h.appSettings.setBrand(MarkerBrand.decoTime);
    await pumpEventQueue();
    expect(seen, hasLength(2));
    expect(seen.last.brand, MarkerBrand.decoTime);

    final settingsSeen = <AppSettings>[];
    final settingsSub = h.appSettings.settingsChanges.listen(settingsSeen.add);
    await pumpEventQueue();
    await h.appSettings.setOwnedSetIds({'classic_40'});
    await pumpEventQueue();
    expect(settingsSeen, hasLength(2));
    expect(settingsSeen.last.ownedSetIds, {'classic_40'});

    await subscription.cancel();
    await settingsSub.cancel();
  });

  test(
    'legacy unscoped favourites belong to Ohuhu and junk is dropped',
    () async {
      final h = await harness({
        StoredAppSettingsRepository.keyFavorites: <String>[
          'R1',
          'decotime:01',
          'ohuhu_oahu:R2',
          ':bad',
          'decotime:',
          '',
        ],
      });
      expect(h.appSettings.favorites, {
        'ohuhu_oahu:R1',
        'decotime:01',
        'ohuhu_oahu:R2',
      });
    },
  );

  test('legacy favourite key is read when the current key is absent', () async {
    final h = await harness({
      StoredAppSettingsRepository.keyLegacyFavorites: <String>['R1'],
    });
    expect(h.appSettings.favorites, {'ohuhu_oahu:R1'});
  });

  test('favourites are brand-scoped and toggled case-insensitively', () async {
    final h = await harness();
    expect(h.appSettings.isFavorite('R1'), isFalse);
    await h.appSettings.toggleFavorite('R1');
    expect(h.appSettings.favorites, {'ohuhu_oahu:R1'});
    expect(h.appSettings.isFavorite('r1'), isTrue);
    expect(h.appSettings.isFavorite('ohuhu_oahu:r1'), isTrue);

    await h.appSettings.toggleFavorite('decotime:02');
    expect(h.appSettings.favorites, {'ohuhu_oahu:R1', 'decotime:02'});
    expect(h.appSettings.isFavorite('decotime:02'), isTrue);
    expect(h.appSettings.isFavorite('ohuhu_oahu:02'), isFalse);

    await h.appSettings.toggleFavorite('ohuhu_oahu:R1');
    expect(h.appSettings.favorites, {'decotime:02'});
    await h.appSettings.toggleFavorite(''); // ignored, no crash
    expect(h.appSettings.favorites, {'decotime:02'});
  });

  test('scoping agrees with the core rule for well-formed values', () async {
    for (final raw in [
      'R1',
      'r1',
      'decotime:01',
      'ohuhu_oahu:r2',
      'unknown:05',
      ' r3 ',
    ]) {
      final expected = <String>{};
      for (final brand in MarkerBrand.values) {
        for (final code in scopedCodesForBrand({raw}, brand.id)) {
          expected.add('${brand.id}:$code');
        }
      }
      expect(scopedColorId(raw), expected.single);
    }
    expect(scopedColorId(':bad'), isNull);
    expect(scopedColorId('decotime:'), isNull);
    expect(scopedColorId('   '), isNull);
  });

  test('restore replaces the whole snapshot and persists it', () async {
    final h = await harness();
    final restored = AppSettingsState(
      brand: MarkerBrand.decoTime,
      scope: BrandScope.mixedBrands,
      settings: AppSettings(
        ownedSetIds: const {'classic_40'},
        extraMarkerIds: const {'decotime:01'},
      ),
      favorites: const {'decotime:01'},
      nameDisplayMode: NameDisplayMode.oldOnly,
      onboardingCompleted: true,
      themeMode: AppThemeMode.light,
    );
    await h.appSettings.restore(restored);
    final reopened = StoredAppSettingsRepository(h.store);
    await reopened.load();
    expect(reopened.state, restored);
  });

  group('migration from the pack selection of older versions', () {
    test(
      'single pack + add-ons + owned codes become sets and extras',
      () async {
        final h = await harness({
          StoredAppSettingsRepository.keyPackSelectionMode: 'Single',
          StoredAppSettingsRepository.keySelectedCoreSetIds: <String>[
            'classic_80',
          ],
          StoredAppSettingsRepository.keySelectedAddonSetIds: <String>[
            'skin_36',
          ],
          StoredAppSettingsRepository.keyOwnedMarkerCodes: <String>[
            'R1',
            'decotime:02',
          ],
        });
        expect(h.appSettings.settings.ownedSetIds, {'classic_80', 'skin_36'});
        expect(h.appSettings.settings.extraMarkerIds, {
          'ohuhu_oahu:R1',
          'decotime:02',
        });
        // A user who had set up a collection does not see the setup again.
        expect(h.appSettings.onboardingCompleted, isTrue);
        // The new keys are written once, so the migration does not run again.
        expect(
          await h.store.getStringList(
            StoredAppSettingsRepository.keyOwnedSetIds,
          ),
          <String>['classic_80', 'skin_36'],
        );
        expect(
          await h.store.getBool(
            StoredAppSettingsRepository.keyOnboardingCompleted,
          ),
          isTrue,
        );
      },
    );

    test('compare mode keeps every selected pack', () async {
      final h = await harness({
        StoredAppSettingsRepository.keyPackSelectionMode: 'Compare',
        StoredAppSettingsRepository.keySelectedCoreSetIds: <String>[
          'classic_80',
          'honolulu_120',
        ],
      });
      expect(h.appSettings.settings.ownedSetIds, {
        'classic_80',
        'honolulu_120',
      });
    });

    test('a fresh install migrates to an empty collection', () async {
      final h = await harness();
      expect(h.appSettings.settings.ownedSetIds, isEmpty);
      expect(h.appSettings.onboardingCompleted, isFalse);
    });

    test('new keys win over legacy keys', () async {
      final h = await harness({
        StoredAppSettingsRepository.keySelectedCoreSetIds: <String>[
          'classic_80',
        ],
        StoredAppSettingsRepository.keyOwnedSetIds: <String>['kaala_basic_24'],
        StoredAppSettingsRepository.keyExtraMarkerIds: <String>[],
      });
      expect(h.appSettings.settings.ownedSetIds, {'kaala_basic_24'});
    });
  });
}
