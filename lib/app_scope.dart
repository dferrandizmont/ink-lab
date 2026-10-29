import 'package:flutter/widgets.dart';

import 'ai/ai.dart' as ai;
import 'core/marker_repository.dart';
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
  final AiSettingsRepository aiSettings;
  final SecretStore secrets;
  final MarkerRepository markers;
  final ai.AiService aiService;

  /// Builds a scope over in-memory stores (tests and previews).
  ///
  /// [aiSettings], [secrets] and [aiService] can be overridden so a test can
  /// seed a stored key or inject a fake HTTP transport.
  static AppScope inMemory({
    required MarkerRepository markers,
    required Widget child,
    Key? key,
    AiSettingsRepository? aiSettings,
    SecretStore? secrets,
    ai.AiService? aiService,
    core.PaletteAdvisor localAdvisor = const PaletteGenerator(),
  }) {
    final store = InMemoryKeyValueStore();
    final resolvedAiSettings = aiSettings ?? StoredAiSettingsRepository(store);
    final resolvedSecrets = secrets ?? InMemorySecretStore();
    return AppScope(
      key: key,
      settings: StoredAppSettingsRepository(store),
      savedPalettes: StoredSavedPaletteRepository(store),
      matchHistory: StoredColorMatchHistoryRepository(store),
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

  static AppScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'No AppScope above this context');
    return scope!;
  }

  @override
  bool updateShouldNotify(AppScope oldWidget) => false;
}
