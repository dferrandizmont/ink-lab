import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';

/// A palette with sensible defaults, overridable per test.
SavedPalette palette({
  String id = 'p1',
  String brandId = 'ohuhu_oahu',
  String name = 'Sunrise',
  String baseCode = 'R1',
  String baseName = 'Red',
  PaletteMode mode = PaletteMode.triad,
  int paletteSize = 3,
  int createdAtEpochMs = 1000,
  List<String> colorCodes = const ['R1', 'G1', 'B1'],
  bool isCustom = false,
  String? scenarioName,
}) => SavedPalette(
  id: id,
  brandId: brandId,
  name: name,
  baseCode: baseCode,
  baseName: baseName,
  mode: mode,
  paletteSize: paletteSize,
  createdAtEpochMs: createdAtEpochMs,
  colorCodes: colorCodes,
  isCustom: isCustom,
  scenarioName: scenarioName,
);

/// A colour-match pick with sensible defaults, overridable per test.
ColorMatchPick pick({
  String id = 'c1',
  String brandId = 'ohuhu_oahu',
  String sampledHex = 'aabbcc',
  String matchedCode = 'R1',
  String matchedName = 'Red',
  String matchedHex = 'aabbcd',
  double deltaE = 1.25,
  int createdAtEpochMs = 1000,
}) => ColorMatchPick(
  id: id,
  brandId: brandId,
  sampledHex: sampledHex,
  matchedCode: matchedCode,
  matchedName: matchedName,
  matchedHex: matchedHex,
  deltaE: deltaE,
  createdAtEpochMs: createdAtEpochMs,
);

/// The repositories plus the shared store, all loaded, over an
/// [InMemoryKeyValueStore].
final class Harness {
  Harness({
    required this.store,
    required this.appSettings,
    required this.savedPalettes,
    required this.history,
    required this.aiSettings,
    required this.ownColors,
    required this.wishlist,
    required this.dried,
    required this.artworkDiary,
    required this.photos,
  });

  final KeyValueStore store;
  final StoredAppSettingsRepository appSettings;
  final StoredSavedPaletteRepository savedPalettes;
  final StoredColorMatchHistoryRepository history;
  final StoredAiSettingsRepository aiSettings;
  final StoredOwnColorRepository ownColors;
  final StoredWishlistRepository wishlist;
  final StoredDriedMarkerRepository dried;
  final StoredArtworkDiaryRepository artworkDiary;

  /// The photo files behind [artworkDiary].
  final InMemoryArtworkPhotoStore photos;

  BackupService backup() => BackupService(
    appSettings: appSettings,
    savedPalettes: savedPalettes,
    history: history,
    aiSettings: aiSettings,
    ownColors: ownColors,
    wishlist: wishlist,
    dried: dried,
    artworkDiary: artworkDiary,
  );
}

Future<Harness> harness([Map<String, Object>? initial]) async {
  final store = InMemoryKeyValueStore(initial);
  final appSettings = StoredAppSettingsRepository(store);
  final savedPalettes = StoredSavedPaletteRepository(store);
  final history = StoredColorMatchHistoryRepository(store);
  final aiSettings = StoredAiSettingsRepository(store);
  final ownColors = StoredOwnColorRepository(store);
  final wishlist = StoredWishlistRepository(store);
  final dried = StoredDriedMarkerRepository(store);
  final photos = InMemoryArtworkPhotoStore();
  final artworkDiary = StoredArtworkDiaryRepository(store, photos: photos);
  await appSettings.load();
  await savedPalettes.load();
  await history.load();
  await aiSettings.load();
  await ownColors.load();
  await wishlist.load();
  await dried.load();
  await artworkDiary.load();
  return Harness(
    store: store,
    appSettings: appSettings,
    savedPalettes: savedPalettes,
    history: history,
    aiSettings: aiSettings,
    ownColors: ownColors,
    wishlist: wishlist,
    dried: dried,
    artworkDiary: artworkDiary,
    photos: photos,
  );
}
