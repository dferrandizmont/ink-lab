import 'dart:async';
import 'dart:io';

import 'package:ink_lab/core/scene_catalog.dart';

/// The drawing scenes are a bundled asset that the app installs at start-up;
/// every test file starts with the same catalogue read from disk, so saved
/// palettes and AI requests can name their scene.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  SceneCatalog.install(
    SceneCatalog.parse(File(SceneCatalog.assetPath).readAsStringSync()),
  );
  await testMain();
}
