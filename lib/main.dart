import 'dart:io' show Directory;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

import 'ai/ai.dart';
import 'app.dart';
import 'app_scope.dart';
import 'core/marker_repository.dart';
import 'core/palette_generator.dart' show PaletteGenerator;
import 'data/data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final store = SharedPreferencesAsyncStore();
  final settings = StoredAppSettingsRepository(store);
  final savedPalettes = StoredSavedPaletteRepository(store);
  final matchHistory = StoredColorMatchHistoryRepository(store);
  final ownColors = StoredOwnColorRepository(store);
  final wishlist = StoredWishlistRepository(store);
  final dried = StoredDriedMarkerRepository(store);
  // The diary's photos live in the app's private documents folder.
  final artworkDiary = StoredArtworkDiaryRepository(
    store,
    photos: DirectoryArtworkPhotoStore(() async {
      final documents = await getApplicationDocumentsDirectory();
      return Directory('${documents.path}/artworks');
    }),
  );
  final aiSettings = StoredAiSettingsRepository(store);
  await Future.wait([
    settings.load(),
    savedPalettes.load(),
    matchHistory.load(),
    ownColors.load(),
    wishlist.load(),
    dried.load(),
    artworkDiary.load(),
    aiSettings.load(),
  ]);
  final secrets = SecureSecretStore();
  final markers = MarkerRepository(loadAsset: rootBundle.loadString)
    ..ownColors = OwnColorOverlay(settings: settings, colors: ownColors);
  // Saved palettes and AI requests name their scene: have the catalogue ready.
  await markers.loadScenes();
  // A marker leaves the wishlist when it joins the collection.
  WishlistOwnershipSync(
    settings: settings,
    wishlist: wishlist,
    markers: markers,
  ).start();
  runApp(
    AppScope(
      settings: settings,
      savedPalettes: savedPalettes,
      matchHistory: matchHistory,
      ownColors: ownColors,
      wishlist: wishlist,
      dried: dried,
      artworkDiary: artworkDiary,
      aiSettings: aiSettings,
      secrets: secrets,
      markers: markers,
      aiService: AiService(
        aiSettings: aiSettings,
        secrets: secrets,
        localAdvisor: const PaletteGenerator(),
      ),
      child: const InkLabApp(),
    ),
  );
}
