import 'dart:async';

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

  test('the navigation rail is folded until the user unfolds it', () async {
    final h = await harness();
    expect(h.appSettings.railExpanded, isFalse);
    expect(h.appSettings.state.railExpanded, isFalse);

    await h.appSettings.setRailExpanded(true);
    expect(h.appSettings.railExpanded, isTrue);
    final reopened = StoredAppSettingsRepository(h.store);
    await reopened.load();
    expect(reopened.railExpanded, isTrue);

    await reopened.setRailExpanded(false);
    final again = StoredAppSettingsRepository(h.store);
    await again.load();
    expect(again.railExpanded, isFalse);
  });

  test('restore brings the rail choice back', () async {
    final h = await harness();
    await h.appSettings.restore(AppSettingsState(railExpanded: true));
    final reopened = StoredAppSettingsRepository(h.store);
    await reopened.load();
    expect(reopened.railExpanded, isTrue);
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

  group('onboarding draft', () {
    final draft = OnboardingDraft(
      step: 'sets',
      brandId: 'ohuhu_oahu',
      seriesIds: const {'oahu', 'honolulu'},
      setIds: const {'classic_160', 'skin_36'},
      extraMarkerIds: const {'ohuhu_oahu:R1'},
    );

    test('is empty on a fresh install', () async {
      final h = await harness();
      expect(h.appSettings.onboardingDraft, isNull);
    });

    test('persists, survives a reopen and is removed with null', () async {
      final h = await harness();
      await h.appSettings.setOnboardingDraft(draft);
      expect(h.appSettings.onboardingDraft, draft);
      expect(
        await h.store.containsKey(
          StoredAppSettingsRepository.keyOnboardingDraft,
        ),
        isTrue,
      );

      final reopened = StoredAppSettingsRepository(h.store);
      await reopened.load();
      expect(reopened.onboardingDraft, draft);

      await reopened.setOnboardingDraft(null);
      expect(reopened.onboardingDraft, isNull);
      expect(
        await h.store.containsKey(
          StoredAppSettingsRepository.keyOnboardingDraft,
        ),
        isFalse,
      );
      final again = StoredAppSettingsRepository(h.store);
      await again.load();
      expect(again.onboardingDraft, isNull);
    });

    test('is not part of the snapshot, the stream or a backup', () async {
      final h = await harness();
      final before = h.appSettings.state;
      final seen = <AppSettingsState>[];
      final subscription = h.appSettings.changes.listen(seen.add);
      await pumpEventQueue();
      seen.clear();
      await h.appSettings.setOnboardingDraft(draft);
      await pumpEventQueue();
      await subscription.cancel();
      expect(seen, isEmpty);
      expect(h.appSettings.state, before);
      expect(
        h.appSettings.state.toJson().containsKey('onboardingDraft'),
        isFalse,
      );
    });

    test('a damaged value loads as no draft', () async {
      for (final raw in <String>[
        '',
        'not json',
        '[1, 2]',
        '{"brand": "ohuhu_oahu"}',
        '{"step": 3, "brand": "ohuhu_oahu"}',
      ]) {
        final h = await harness({
          StoredAppSettingsRepository.keyOnboardingDraft: raw,
        });
        expect(h.appSettings.onboardingDraft, isNull, reason: raw);
      }
    });

    test('unusable ids inside the lists are dropped', () async {
      final h = await harness({
        StoredAppSettingsRepository.keyOnboardingDraft:
            '{"step":"series","brand":"copic","series":["oahu",3,""," "],'
            '"sets":"nope"}',
      });
      final loaded = h.appSettings.onboardingDraft;
      expect(loaded, isNotNull);
      expect(loaded!.step, 'series');
      expect(loaded.brandId, 'copic');
      expect(loaded.seriesIds, {'oahu'});
      expect(loaded.setIds, isEmpty);
      expect(loaded.extraMarkerIds, isEmpty);
    });

    test('restoring a backup leaves the draft alone', () async {
      final h = await harness();
      await h.appSettings.setOnboardingDraft(draft);
      await h.appSettings.restore(AppSettingsState(onboardingCompleted: true));
      expect(h.appSettings.onboardingDraft, draft);
    });
  });

  group('the single markers of the collection', () {
    test('adding keeps the ones already there, persists and tells', () async {
      final h = await harness();
      await h.appSettings.setExtraMarkerIds(<String>{'decotime:01'});

      final List<AppSettingsState> seen = <AppSettingsState>[];
      final StreamSubscription<AppSettingsState> subscription = h
          .appSettings
          .changes
          .listen(seen.add);
      await pumpEventQueue();

      await h.appSettings.addExtraMarkerIds(<String>{'decotime:02'});
      await pumpEventQueue();

      expect(h.appSettings.settings.extraMarkerIds, <String>{
        'decotime:01',
        'decotime:02',
      });
      // It is on the disk, not only in the memory.
      expect(
        await h.store.getStringList(
          StoredAppSettingsRepository.keyExtraMarkerIds,
        ),
        <String>['decotime:01', 'decotime:02'],
      );
      // And the change was told.
      expect(seen, hasLength(2));
      expect(seen.last.settings.extraMarkerIds, contains('decotime:02'));
      await subscription.cancel();
    });

    test('removing takes the ids out, persists and tells', () async {
      final h = await harness();
      await h.appSettings.setExtraMarkerIds(<String>{
        'decotime:01',
        'decotime:02',
      });

      final List<AppSettingsState> seen = <AppSettingsState>[];
      final StreamSubscription<AppSettingsState> subscription = h
          .appSettings
          .changes
          .listen(seen.add);
      await pumpEventQueue();

      await h.appSettings.removeExtraMarkerIds(<String>{'decotime:01'});
      await pumpEventQueue();

      expect(h.appSettings.settings.extraMarkerIds, <String>{'decotime:02'});
      expect(
        await h.store.getStringList(
          StoredAppSettingsRepository.keyExtraMarkerIds,
        ),
        <String>['decotime:02'],
      );
      expect(seen, hasLength(2));
      expect(seen.last.settings.extraMarkerIds, isNot(contains('decotime:01')));
      await subscription.cancel();
    });

    test('two adds that overlap keep both markers', () async {
      final h = await harness();

      // Neither is awaited: the second one starts before the first landed.
      final Future<void> first = h.appSettings.addExtraMarkerIds(<String>{
        'decotime:01',
      });
      final Future<void> second = h.appSettings.addExtraMarkerIds(<String>{
        'decotime:02',
      });
      await Future.wait(<Future<void>>[first, second]);

      expect(h.appSettings.settings.extraMarkerIds, <String>{
        'decotime:01',
        'decotime:02',
      });
      expect(
        await h.store.getStringList(
          StoredAppSettingsRepository.keyExtraMarkerIds,
        ),
        <String>['decotime:01', 'decotime:02'],
      );
    });

    test('an add and a remove that overlap end with the last word', () async {
      final h = await harness();
      await h.appSettings.setExtraMarkerIds(<String>{'decotime:01'});

      final Future<void> add = h.appSettings.addExtraMarkerIds(<String>{
        'decotime:02',
      });
      final Future<void> remove = h.appSettings.removeExtraMarkerIds(<String>{
        'decotime:01',
      });
      await Future.wait(<Future<void>>[add, remove]);

      expect(h.appSettings.settings.extraMarkerIds, <String>{'decotime:02'});
    });

    test('addExtraMarkerIds + setOwnedSetIds without awaiting keeps both', () async {
      final h = await harness();
      await h.appSettings.setExtraMarkerIds(<String>{'decotime:01'});

      final Future<void> first = h.appSettings.addExtraMarkerIds(<String>{
        'decotime:02',
      });
      final Future<void> second = h.appSettings.setOwnedSetIds(<String>{
        'classic_80',
      });
      await Future.wait(<Future<void>>[first, second]);

      expect(h.appSettings.settings.extraMarkerIds, <String>{
        'decotime:01',
        'decotime:02',
      });
      expect(h.appSettings.settings.ownedSetIds, <String>{'classic_80'});
    });

    test(
      'addExtraMarkerIds + setCollection without awaiting: later call fields win, '
      'add is not lost unless setCollection replaces extraMarkerIds',
      () async {
        final h = await harness();
        await h.appSettings.setExtraMarkerIds(<String>{'decotime:01'});

        final Future<void> first = h.appSettings.addExtraMarkerIds(<String>{
          'decotime:02',
        });
        final Future<void> second = h.appSettings.setCollection(
          AppSettings(ownedSetIds: const <String>{'classic_80'}),
        );
        await Future.wait(<Future<void>>[first, second]);

        expect(h.appSettings.settings.ownedSetIds, <String>{'classic_80'});
        // setCollection replaces extraMarkerIds, so the add is lost.
        expect(h.appSettings.settings.extraMarkerIds, isEmpty);
      },
    );
  });

  test('restore queued after an add: restore result wins', () async {
    final h = await harness();
    await h.appSettings.setExtraMarkerIds(<String>{'decotime:01'});

    final Future<void> add = h.appSettings.addExtraMarkerIds(<String>{
      'decotime:02',
    });
    final Future<void> restore = h.appSettings.restore(
      AppSettingsState(
        settings: AppSettings(ownedSetIds: const <String>{'classic_80'}),
      ),
    );
    await Future.wait(<Future<void>>[add, restore]);

    expect(h.appSettings.settings.ownedSetIds, <String>{'classic_80'});
    expect(h.appSettings.settings.extraMarkerIds, isEmpty);
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
