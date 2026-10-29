import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

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
  final aiSettings = StoredAiSettingsRepository(store);
  await Future.wait([
    settings.load(),
    savedPalettes.load(),
    matchHistory.load(),
    aiSettings.load(),
  ]);
  final secrets = SecureSecretStore();
  runApp(
    AppScope(
      settings: settings,
      savedPalettes: savedPalettes,
      matchHistory: matchHistory,
      aiSettings: aiSettings,
      secrets: secrets,
      markers: MarkerRepository(loadAsset: rootBundle.loadString),
      aiService: AiService(
        aiSettings: aiSettings,
        secrets: secrets,
        localAdvisor: const PaletteGenerator(),
      ),
      child: const InkLabApp(),
    ),
  );
}
