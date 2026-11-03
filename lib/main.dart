import 'dart:async' show unawaited;
import 'dart:io' show Directory, Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

import 'ai/ai.dart';
import 'app.dart';
import 'app_scope.dart';
import 'core/marker_repository.dart';
import 'core/palette_generator.dart' show PaletteGenerator;
import 'data/data.dart';
import 'data/idea_widget_sync.dart';
import 'ui/pages/ideas/idea_deep_link.dart';

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
  final ideaFavorites = StoredIdeaFavoritesRepository(store);
  await Future.wait([
    settings.load(),
    savedPalettes.load(),
    matchHistory.load(),
    ownColors.load(),
    wishlist.load(),
    dried.load(),
    artworkDiary.load(),
    aiSettings.load(),
    ideaFavorites.load(),
  ]);
  final secrets = SecureSecretStore();
  // The iOS Keychain outlives the app: drop a key a deleted copy left.
  if (Platform.isIOS) {
    await clearSecretsLeftByEarlierInstall(store: store, secrets: secrets);
  }
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
  // The "Idea of the day" home-screen widget (Android): keep its data current
  // and open the idea it was tapped on. Both do nothing elsewhere.
  IdeaWidgetSync(
    settings: settings,
    markers: markers,
    ownColors: ownColors,
    dried: dried,
  ).start();
  unawaited(listenToIdeaWidgetLinks());
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
      ideaFavorites: ideaFavorites,
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
