import '../scene_catalog.dart';

/// A scenario role's HSV target and optional saturation bounds.
final class ScenarioTarget {
  const ScenarioTarget(
    this.role,
    this.hueOffsets, {
    required this.valueDelta,
    required this.saturationDelta,
    this.preferNeutral = false,
    this.minSaturation,
    this.maxSaturation,
  });
  final String role;
  final List<double> hueOffsets;
  final double valueDelta, saturationDelta;
  // All source scenario targets use these fixed default weights.
  final double weightHue = 0.58, weightValue = 0.27, weightSaturation = 0.15;
  final bool preferNeutral;
  final double? minSaturation, maxSaturation;
}

/// A drawing scene: a recipe of colour roles around a base marker, loaded
/// from `assets/data/scenes.json` (see [SceneCatalog]).
///
/// The [id] is the camelCase name the first 27 scenes had as an enum, so the
/// wire format of saved palettes and AI requests (`GhostCharacter`) still
/// resolves ([fromJson]).
final class Scene {
  const Scene({
    required this.id,
    required this.category,
    required this.names,
    required this.seedHue,
    required this.seedSaturation,
    required this.seedValue,
    required this.targets,
  });

  /// Stable id, for example `forestScene`.
  final String id;

  /// Id of the [SceneCatalog.categories] entry the scene belongs to.
  final String category;

  /// Display names by language code; always has `en` and `es`.
  final Map<String, String> names;

  /// The (hue, saturation, value) the default base marker is chosen near.
  final double seedHue, seedSaturation, seedValue;

  /// The colour roles, in the order they are picked.
  final List<ScenarioTarget> targets;

  /// The English name: what AI prompts and logs use.
  String get label => names['en']!;

  /// The name in [languageCode], English when there is no translation.
  String nameFor(String languageCode) => names[languageCode] ?? label;

  /// The wire spelling kept from the enum days (`ForestScene`).
  String toJson() => '${id[0].toUpperCase()}${id.substring(1)}';

  /// Resolves a wire value (`ForestScene`) or an id (`forestScene`) against
  /// the installed [SceneCatalog].
  static Scene fromJson(Object? json) {
    if (json is String && json.isNotEmpty) {
      final Scene? scene = SceneCatalog.current.find(
        '${json[0].toLowerCase()}${json.substring(1)}',
      );
      if (scene != null) return scene;
    }
    throw FormatException('Unknown enum value: $json');
  }

  /// The scene with [id]; throws when it does not exist.
  static Scene byId(String id) {
    final Scene? scene = SceneCatalog.current.find(id);
    if (scene == null) throw ArgumentError.value(id, 'id', 'Unknown scene');
    return scene;
  }

  @override
  bool operator ==(Object other) => other is Scene && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Scene($id)';
}
