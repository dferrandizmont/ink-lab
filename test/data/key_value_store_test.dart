import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Proves the default backend really is `shared_preferences`: the repositories
/// run over the platform mock prepared with
/// `SharedPreferences.setMockInitialValues`, exactly as the brief requires.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({
      StoredAppSettingsRepository.keyBrand: 'decotime',
      StoredAppSettingsRepository.keyFavorites: <String>['R1'],
      StoredSavedPaletteRepository.keyFor(MarkerBrand.ohuhuOahu):
          '['
          '{"id":"sp","brandId":"ohuhu_oahu","name":"N","baseCode":"R1",'
          '"baseName":"Red","mode":"Triad","paletteSize":2,'
          '"createdAtEpochMs":5,"colorCodes":["R1","G1"]}]',
      StoredAiSettingsRepository.key:
          '{"enabled":true,"provider":"openRouter"}',
    });
  });

  test(
    'repositories load from and write to the SharedPreferences mock',
    () async {
      final store = await SharedPreferencesStore.open();
      final appSettings = StoredAppSettingsRepository(store);
      final palettes = StoredSavedPaletteRepository(store);
      final ai = StoredAiSettingsRepository(store);
      await appSettings.load();
      await palettes.load();
      await ai.load();

      expect(appSettings.brand, MarkerBrand.decoTime);
      expect(appSettings.favorites, {'ohuhu_oahu:R1'});
      expect(palettes.palettesOf(MarkerBrand.ohuhuOahu).single.name, 'N');
      expect(ai.value.enabled, isTrue);
      expect(ai.value.provider, AiProvider.openRouter);

      await appSettings.setBrand(MarkerBrand.ohuhuOahu);
      await appSettings.toggleFavorite('decotime:09');
      await palettes.save(paletteLike());

      final raw = await SharedPreferences.getInstance();
      expect(raw.getString(StoredAppSettingsRepository.keyBrand), 'ohuhu_oahu');
      expect(
        raw.getStringList(StoredAppSettingsRepository.keyFavorites),
        containsAll(<String>['ohuhu_oahu:R1', 'decotime:09']),
      );
      expect(
        raw.getString(
          StoredSavedPaletteRepository.keyFor(MarkerBrand.ohuhuOahu),
        ),
        contains('"id":"new"'),
      );
    },
  );

  test('a second open sees the same values', () async {
    final first = StoredAppSettingsRepository(
      await SharedPreferencesStore.open(),
    );
    await first.load();
    await first.setPackSelectionMode(PackSelectionMode.compare);

    final second = StoredAppSettingsRepository(
      await SharedPreferencesStore.open(),
    );
    await second.load();
    expect(second.settings.packSelectionMode, PackSelectionMode.compare);
  });
}

SavedPalette paletteLike() => SavedPalette(
  id: 'new',
  name: 'New',
  baseCode: 'R2',
  baseName: 'Red',
  mode: PaletteMode.complementary,
  paletteSize: 2,
  createdAtEpochMs: 10,
  colorCodes: const ['R2', 'G2'],
);
