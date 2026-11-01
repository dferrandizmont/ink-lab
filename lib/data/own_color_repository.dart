import 'dart:async';
import 'dart:convert';

import '../core/models.dart';
import '../core/own_colors.dart';
import 'app_settings_repository.dart';
import 'brand_scoping.dart';
import 'data_exceptions.dart';
import 'key_value_store.dart';
import 'replay_stream.dart';

/// The colours the user sees for their own markers, by marker.
///
/// A catalogue hex is only an estimate of the ink on paper, so the user can
/// store the colour they actually get. Entries are keyed by the brand-scoped
/// id (`brandId:CODE`) and hold six lower-case hex digits. Only the derived
/// hex is kept: the photo a colour was read from is never saved.
abstract class OwnColorRepository {
  /// Every own colour, `brandId:CODE` to `rrggbb`.
  Map<String, String> get colors;

  /// Goes up on every change, so results can be cached per revision.
  int get revision;

  /// Emits the current map immediately, then every change.
  Stream<Map<String, String>> get changes;

  /// The own colour of [colorId], or `null`.
  String? hexOf(String colorId);

  /// How many own colours [brand] has.
  int countOf(MarkerBrand brand);

  Future<void> load();

  /// Stores [hex] as the own colour of [colorId]. A value that is not a colour
  /// is ignored.
  Future<void> set(String colorId, String hex);

  /// Goes back to the catalogue colour of [colorId].
  Future<void> remove(String colorId);

  /// Forgets every own colour.
  Future<void> clear();

  /// Replaces the whole map, as a backup restore does.
  Future<void> restore(Map<String, String> colors);
}

/// [OwnColorRepository] on top of a [KeyValueStore].
///
/// Stored under a single key, `own_marker_colors`, as a JSON object of
/// `brandId:CODE` to `rrggbb`.
final class StoredOwnColorRepository implements OwnColorRepository {
  StoredOwnColorRepository(this._store);

  static const String key = 'own_marker_colors';

  final KeyValueStore _store;
  final StreamController<Map<String, String>> _controller =
      StreamController<Map<String, String>>.broadcast();

  Map<String, String> _colors = const {};
  int _revision = 0;

  @override
  Map<String, String> get colors => _colors;

  @override
  int get revision => _revision;

  @override
  Stream<Map<String, String>> get changes =>
      replayStream<Map<String, String>>(() => _colors, _controller.stream);

  @override
  String? hexOf(String colorId) {
    final String? scoped = scopedColorId(colorId);
    return scoped == null ? null : _colors[scoped];
  }

  @override
  int countOf(MarkerBrand brand) => _colors.keys
      .where((String id) => colorIdBelongsToBrand(id, brand))
      .length;

  @override
  Future<void> load() async {
    _colors = normalizeOwnColors(_decode(await _store.getString(key)));
    _revision++;
    _controller.add(_colors);
  }

  @override
  Future<void> set(String colorId, String hex) {
    final String? scoped = scopedColorId(colorId);
    final String? normalized = normalizeOwnHex(hex);
    if (scoped == null || normalized == null) return Future<void>.value();
    return _persist(<String, String>{..._colors, scoped: normalized});
  }

  @override
  Future<void> remove(String colorId) {
    final String? scoped = scopedColorId(colorId);
    if (scoped == null || !_colors.containsKey(scoped)) {
      return Future<void>.value();
    }
    return _persist(<String, String>{..._colors}..remove(scoped));
  }

  @override
  Future<void> clear() =>
      _colors.isEmpty ? Future<void>.value() : _persist(const {});

  @override
  Future<void> restore(Map<String, String> colors) =>
      _persist(normalizeOwnColors(colors));

  Future<void> _persist(Map<String, String> next) async {
    final Map<String, String> sorted = normalizeOwnColors(next);
    if (sorted.isEmpty) {
      await _store.remove(key);
    } else {
      await _store.setString(key, jsonEncode(sorted));
    }
    _colors = sorted;
    _revision++;
    _controller.add(_colors);
  }

  Map<String, String> _decode(String? raw) {
    if (raw == null || raw.trim().isEmpty) return const {};
    try {
      final Object? decoded = jsonDecode(raw);
      if (decoded is! Map) {
        throw const DataStoreException(
          'expected a JSON object of own marker colours',
          key: key,
        );
      }
      return <String, String>{
        for (final MapEntry<dynamic, dynamic> entry in decoded.entries)
          if (entry.key is String && entry.value is String)
            entry.key as String: entry.value as String,
      };
    } on DataStoreException {
      rethrow;
    } catch (error) {
      throw DataStoreException(
        'could not parse own marker colours: $error',
        key: key,
      );
    }
  }
}

/// [colors] with scoped ids and normalised hex values, sorted by id; entries
/// that are not a marker id or not a colour are dropped.
Map<String, String> normalizeOwnColors(Map<String, String> colors) {
  final Map<String, String> result = <String, String>{};
  for (final MapEntry<String, String> entry in colors.entries) {
    final String? id = scopedColorId(entry.key);
    final String? hex = normalizeOwnHex(entry.value);
    if (id != null && hex != null) result[id] = hex;
  }
  final List<String> ids = result.keys.toList()..sort();
  return Map<String, String>.unmodifiable(<String, String>{
    for (final String id in ids) id: result[id]!,
  });
}

/// The own colours the catalogue should use: the stored ones while "Use my
/// colours" is on, none while it is off.
///
/// This is what the marker repository reads, so Match, Palette and Ideas see
/// the effective colour of every marker.
final class OwnColorOverlay implements OwnColorSource {
  OwnColorOverlay({required this.settings, required this.colors});

  final AppSettingsRepository settings;
  final OwnColorRepository colors;

  bool get enabled => settings.state.useOwnColors;

  @override
  Map<String, String> get activeOwnColors =>
      enabled ? colors.colors : const <String, String>{};

  /// Unique for every combination of stored colours and switch position.
  @override
  int get revision => colors.revision * 2 + (enabled ? 1 : 0);
}
