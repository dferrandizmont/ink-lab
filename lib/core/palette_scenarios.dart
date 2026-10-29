part of 'palette_generator.dart';

/// The colour roles of [scene], in the order they are picked.
List<ScenarioTarget> _scenarioTargets(Scene scene) => scene.targets;

(double, double, double) _scenarioSeed(Scene scene) =>
    (scene.seedHue, scene.seedSaturation, scene.seedValue);

/// A four-colour preview of [scene]: its default base followed by the first
/// three roles, picked from [range].
///
/// Pass the whole range of a brand (not only the markers the user owns) so the
/// preview is the same for everyone and does not change with the collection.
List<MarkerColor> scenePreviewColors(Scene scene, List<MarkerColor> range) {
  final MarkerColor? base = findScenarioDefaultBase(range, scene);
  if (base == null) return const <MarkerColor>[];
  final List<PaletteSuggestion> picks = buildScenarioPalette(
    base,
    range,
    scene,
    size: 3,
  );
  return <MarkerColor>[base, for (final PaletteSuggestion p in picks) p.color];
}
