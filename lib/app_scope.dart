import 'package:flutter/widgets.dart';

import 'ai/ai.dart' as ai;
import 'core/marker_repository.dart';
import 'core/models.dart' show AppSettings;
import 'core/palette_advisor.dart' as core;
import 'core/palette_generator.dart' show PaletteGenerator;
import 'data/data.dart';

/// Composition root: the app-wide services, reachable from any page with
/// `AppScope.of(context)`. Pages stay parameterless; tests build their own scope
/// with in-memory stores.
class AppScope extends InheritedWidget {
  const AppScope({
    required this.settings,
    required this.savedPalettes,
    required this.matchHistory,
    required this.ownColors,
    required this.wishlist,
    required this.dried,
    required this.artworkDiary,
    required this.aiSettings,
    required this.secrets,
    required this.markers,
    required this.aiService,
    required super.child,
    super.key,
  });

  final AppSettingsRepository settings;
  final SavedPaletteRepository savedPalettes;
  final ColorMatchHistoryRepository matchHistory;

  /// The colours the user stored for their own markers.
  final OwnColorRepository ownColors;

  /// The markers the user wants to buy.
  final WishlistRepository wishlist;

  /// The owned markers that ran dry: Match, Palette and Ideas skip them.
  final DriedMarkerRepository dried;

  /// The artwork diary: entries in the key-value store, photos in a private
  /// folder on the device.
  final ArtworkDiaryRepository artworkDiary;
  final AiSettingsRepository aiSettings;
  final SecretStore secrets;
  final MarkerRepository markers;
  final ai.AiService aiService;

  /// Builds a scope over in-memory stores (tests and previews).
  ///
  /// [aiSettings], [secrets], [aiService] and [settingsState] can be
  /// overridden so a test can seed a stored key, inject a fake HTTP transport
  /// or start from a fresh install; [artworkDiary] lets a test watch the
  /// photo files.
  static AppScope inMemory({
    required MarkerRepository markers,
    required Widget child,
    Key? key,
    AiSettingsRepository? aiSettings,
    SecretStore? secrets,
    ai.AiService? aiService,
    core.PaletteAdvisor localAdvisor = const PaletteGenerator(),
    AppSettingsState? settingsState,
    ArtworkDiaryRepository? artworkDiary,
  }) {
    final store = InMemoryKeyValueStore();
    final resolvedAiSettings = aiSettings ?? StoredAiSettingsRepository(store);
    final resolvedSecrets = secrets ?? InMemorySecretStore();
    final settings = StoredAppSettingsRepository(
      store,
      initial: settingsState ?? previewSettings(),
    );
    final ownColors = StoredOwnColorRepository(store);
    final wishlist = StoredWishlistRepository(store);
    markers.ownColors = OwnColorOverlay(settings: settings, colors: ownColors);
    WishlistOwnershipSync(
      settings: settings,
      wishlist: wishlist,
      markers: markers,
    ).start();
    return AppScope(
      key: key,
      settings: settings,
      savedPalettes: StoredSavedPaletteRepository(store),
      matchHistory: StoredColorMatchHistoryRepository(store),
      ownColors: ownColors,
      wishlist: wishlist,
      dried: StoredDriedMarkerRepository(store),
      artworkDiary:
          artworkDiary ??
          StoredArtworkDiaryRepository(
            store,
            photos: InMemoryArtworkPhotoStore(),
          ),
      aiSettings: resolvedAiSettings,
      secrets: resolvedSecrets,
      markers: markers,
      aiService:
          aiService ??
          ai.AiService(
            aiSettings: resolvedAiSettings,
            secrets: resolvedSecrets,
            localAdvisor: localAdvisor,
          ),
      child: child,
    );
  }

  /// The settings an in-memory scope starts with: the first-run setup is done
  /// and the collection is Oahu 160, so previews and tests show a populated
  /// app. Pass `settingsState` to start elsewhere (e.g. a fresh install).
  static AppSettingsState previewSettings() => AppSettingsState(
    onboardingCompleted: true,
    settings: AppSettings(ownedSetIds: const {'classic_160'}),
  );

  /// The same services around [child]: for a route pushed from a page whose
  /// scope sits below the navigator (tests, previews).
  AppScope wrap(Widget child) => AppScope(
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
    aiService: aiService,
    child: child,
  );

  /// Pushes [page] on the navigator of [context], keeping the scope of
  /// [context] above it.
  static Future<void> push(BuildContext context, Widget page) {
    final AppScope? scope = context.getInheritedWidgetOfExactType<AppScope>();
    return Navigator.of(context).push<void>(
      PageRouteBuilder<void>(
        pageBuilder: (BuildContext context, _, _) =>
            scope == null ? page : scope.wrap(page),
        transitionsBuilder: (_, Animation<double> a, _, Widget child) =>
            FadeTransition(opacity: a, child: child),
      ),
    );
  }

  static AppScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'No AppScope above this context');
    return scope!;
  }

  @override
  bool updateShouldNotify(AppScope oldWidget) => false;
}
