import 'dart:async' show unawaited;
import 'dart:io' show Directory, Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart'
    show getApplicationSupportDirectory;

import 'ai/ai.dart';
import 'app.dart';
import 'app_licenses.dart';
import 'app_scope.dart';
import 'core/app_version.dart' as app_version;
import 'core/error_log.dart';
import 'core/marker_repository.dart';
import 'core/palette_generator.dart' show PaletteGenerator;
import 'core/platform_info.dart';
import 'data/data.dart';
import 'data/idea_widget_sync.dart';
import 'ui/pages/ideas/idea_deep_link.dart';

void main() {
  // The log of unhandled errors lives in the app support folder. Nothing here
  // waits for the disk: the folder is resolved when the first error is
  // written, and no handler can throw.
  final errorLog = ErrorLog(
    storage: FileErrorLogStorage(() async {
      final support = await getApplicationSupportDirectory();
      return Directory('${support.path}/error_log');
    }),
    appVersion: app_version.appVersion,
    platform: PlatformInfo.summary,
  );
  // One zone for the binding and the app, so the errors nobody caught land in
  // the log (and are still printed in debug).
  runGuardedByErrorLog(errorLog, () => _start(errorLog));
}

Future<void> _start(ErrorLog errorLog) async {
  WidgetsFlutterBinding.ensureInitialized();
  installErrorHandlers(errorLog);
  unawaited(errorLog.refresh());
  registerBundledLicences();
  final store = SharedPreferencesAsyncStore();
  final settings = StoredAppSettingsRepository(store);
  final savedPalettes = StoredSavedPaletteRepository(store);
  final matchHistory = StoredColorMatchHistoryRepository(store);
  final ownColors = StoredOwnColorRepository(store);
  final wishlist = StoredWishlistRepository(store);
  final dried = StoredDriedMarkerRepository(store);
  // The diary's photos live in the app's private documents folder.
  final photoStore = DirectoryArtworkPhotoStore(() async {
    final documents = await artworkDocumentsDirectory();
    return Directory('${documents.path}/artworks');
  });
  final artworkDiary = StoredArtworkDiaryRepository(store, photos: photoStore);
  // The photos of the real paper swatches share the diary's private folder.
  final markerExtras = StoredMarkerExtrasRepository(
    store,
    dried: dried,
    photos: photoStore,
  );
  // The blending recipes: their own JSON file next to the diary's, and their
  // photos in the same private folder.
  final blendRecipes = StoredBlendRecipeRepository(
    storage: FileArtworkDiaryStorage(
      name: StoredBlendRecipeRepository.fileName,
    ),
    photos: artworkDiary.photoStore,
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
    markerExtras.load(),
    artworkDiary.load(),
    blendRecipes.load(),
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
      markerExtras: markerExtras,
      artworkDiary: artworkDiary,
      blendRecipes: blendRecipes,
      aiSettings: aiSettings,
      ideaFavorites: ideaFavorites,
      secrets: secrets,
      markers: markers,
      errorLog: errorLog,
      reviewPrompt: ReviewPrompt(
        settings: settings,
        appVersion: app_version.appVersion,
        hasOwnData: () =>
            savedPalettes.exportByBrand().values.any(
              (list) => list.isNotEmpty,
            ) ||
            artworkDiary.entries.isNotEmpty,
      ),
      aiService: AiService(
        aiSettings: aiSettings,
        secrets: secrets,
        localAdvisor: const PaletteGenerator(),
      ),
      child: const InkLabApp(),
    ),
  );
}
