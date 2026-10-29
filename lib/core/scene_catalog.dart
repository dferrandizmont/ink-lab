import 'dart:convert';

import 'model/scene.dart';

/// The bundled drawing scenes (`assets/data/scenes.json`): a list of
/// categories, the scenes that belong to each and the Spanish text of the
/// roles that the ARB phrases do not cover.
///
/// The catalogue is installed once at start-up ([install]); saved palettes
/// and AI requests resolve their scene through [Scene.fromJson], which reads
/// [current].
final class SceneCatalog {
  SceneCatalog._(this.categories, this.scenes, this._roleNames)
    : _byId = <String, Scene>{for (final Scene s in scenes) s.id: s};

  /// Asset path of the catalogue.
  static const String assetPath = 'assets/data/scenes.json';

  /// The category ids, in display order.
  final List<String> categories;

  /// Every scene, grouped by category in display order.
  final List<Scene> scenes;

  final Map<String, Scene> _byId;
  final Map<String, String> _roleNames;

  static SceneCatalog? _current;

  /// The installed catalogue; throws when none was installed.
  static SceneCatalog get current =>
      _current ??
      (throw StateError('The scene catalogue is not loaded: call install().'));

  /// Whether a catalogue was installed.
  static bool get isInstalled => _current != null;

  /// Makes [catalog] the one [Scene.fromJson] reads.
  static void install(SceneCatalog catalog) => _current = catalog;

  /// Parses the JSON text of the asset.
  ///
  /// Throws a [FormatException] when a scene is malformed or two scenes share
  /// an id.
  factory SceneCatalog.parse(String source) {
    final Object? decoded = jsonDecode(source);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('The scene catalogue is not an object.');
    }
    final List<String> categories = <String>[
      for (final Object? id in decoded['categories'] as List<dynamic>)
        id as String,
    ];
    final Map<String, String> roles = <String, String>{
      for (final MapEntry<String, dynamic> e
          in (decoded['roles'] as Map<String, dynamic>? ??
                  const <String, dynamic>{})
              .entries)
        e.key: e.value as String,
    };
    final List<Scene> scenes = <Scene>[];
    final Set<String> ids = <String>{};
    for (final Object? raw in decoded['scenes'] as List<dynamic>) {
      final Scene scene = _parseScene(raw as Map<String, dynamic>);
      if (!ids.add(scene.id)) {
        throw FormatException('Duplicate scene id: ${scene.id}');
      }
      if (!categories.contains(scene.category)) {
        throw FormatException(
          'Unknown category ${scene.category} in ${scene.id}',
        );
      }
      scenes.add(scene);
    }
    return SceneCatalog._(
      List<String>.unmodifiable(categories),
      List<Scene>.unmodifiable(scenes),
      Map<String, String>.unmodifiable(roles),
    );
  }

  static Scene _parseScene(Map<String, dynamic> json) {
    final Map<String, dynamic> name = json['name'] as Map<String, dynamic>;
    final Map<String, dynamic> seed = json['seed'] as Map<String, dynamic>;
    return Scene(
      id: json['id'] as String,
      category: json['category'] as String,
      names: Map<String, String>.unmodifiable(<String, String>{
        for (final MapEntry<String, dynamic> e in name.entries)
          e.key: e.value as String,
      }),
      seedHue: (seed['h'] as num).toDouble(),
      seedSaturation: (seed['s'] as num).toDouble(),
      seedValue: (seed['v'] as num).toDouble(),
      targets: List<ScenarioTarget>.unmodifiable(<ScenarioTarget>[
        for (final Object? t in json['targets'] as List<dynamic>)
          _parseTarget(t as Map<String, dynamic>),
      ]),
    );
  }

  static ScenarioTarget _parseTarget(Map<String, dynamic> json) =>
      ScenarioTarget(
        json['role'] as String,
        List<double>.unmodifiable(<double>[
          for (final Object? h in json['hues'] as List<dynamic>)
            (h as num).toDouble(),
        ]),
        valueDelta: (json['valueDelta'] as num).toDouble(),
        saturationDelta: (json['saturationDelta'] as num).toDouble(),
        preferNeutral: json['preferNeutral'] as bool? ?? false,
        minSaturation: (json['minSaturation'] as num?)?.toDouble(),
        maxSaturation: (json['maxSaturation'] as num?)?.toDouble(),
      );

  /// The scene with [id], or `null`.
  Scene? find(String id) => _byId[id];

  /// The scenes of [category], in display order.
  List<Scene> inCategory(String category) => <Scene>[
    for (final Scene s in scenes)
      if (s.category == category) s,
  ];

  /// The Spanish text of [role] when the catalogue has it.
  String? roleName(String role, String languageCode) =>
      languageCode == 'es' ? _roleNames[role] : null;

  /// Every role the catalogue translates (Spanish).
  Iterable<String> get translatedRoles => _roleNames.keys;
}
