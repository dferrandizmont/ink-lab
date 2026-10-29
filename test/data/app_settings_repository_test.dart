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
    expect(h.appSettings.settings.packSelectionMode, PackSelectionMode.single);
    expect(h.appSettings.settings.selectedCoreSetIds, {'classic_160'});
    expect(h.appSettings.settings.selectedAddonSetIds, isEmpty);
    expect(h.appSettings.settings.ownedMarkerCodes, isEmpty);
    expect(h.appSettings.favorites, isEmpty);
    expect(h.appSettings.nameDisplayMode, NameDisplayMode.both);
    expect(h.appSettings.onboardingCompleted, isFalse);
    expect(h.appSettings.themeMode, AppThemeMode.system);
  });

  test('every setter persists and survives a reopen', () async {
    final h = await harness();
    await h.appSettings.setBrand(MarkerBrand.decoTime);
    await h.appSettings.setScope(BrandScope.mixedBrands);
    await h.appSettings.setPackSelectionMode(PackSelectionMode.compare);
    await h.appSettings.setSelectedCoreSetIds({'classic_80', 'classic_40'});
    await h.appSettings.setSelectedAddonSetIds({'skin_36'});
    await h.appSettings.setOwnedMarkerCodes({'R1', 'decotime:02'});
    await h.appSettings.setNameDisplayMode(NameDisplayMode.newOnly);
    await h.appSettings.setOnboardingCompleted(true);
    await h.appSettings.setThemeMode(AppThemeMode.dark);

    final reopened = StoredAppSettingsRepository(h.store);
    await reopened.load();
    expect(reopened.brand, MarkerBrand.decoTime);
    expect(reopened.scope, BrandScope.mixedBrands);
    expect(reopened.settings.packSelectionMode, PackSelectionMode.compare);
    expect(reopened.settings.selectedCoreSetIds, {'classic_80', 'classic_40'});
    expect(reopened.settings.selectedAddonSetIds, {'skin_36'});
    expect(reopened.settings.ownedMarkerCodes, {'R1', 'decotime:02'});
    expect(reopened.nameDisplayMode, NameDisplayMode.newOnly);
    expect(reopened.themeMode, AppThemeMode.dark);
    expect(reopened.onboardingCompleted, isTrue);
    expect(reopened.state, h.appSettings.state);
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
    await h.appSettings.setPackSelectionMode(PackSelectionMode.compare);
    await pumpEventQueue();
    expect(settingsSeen, hasLength(2));
    expect(settingsSeen.last.packSelectionMode, PackSelectionMode.compare);

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
        packSelectionMode: PackSelectionMode.compare,
        selectedCoreSetIds: const {'classic_40'},
        ownedMarkerCodes: const {'decotime:01'},
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
}
