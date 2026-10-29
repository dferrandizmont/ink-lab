import 'dart:async';
import 'dart:convert';

import '../core/models.dart';
import 'data_exceptions.dart';
import 'key_value_store.dart';
import 'replay_stream.dart';

/// The most recent colour-match picks.
///
/// Newest first. A pick is de-duplicated by `(brandId, matchedCode,
/// sampledHex)` — re-running the same match moves it to the front instead of
/// adding a duplicate — and the list is capped at
/// [ColorMatchHistoryRepository.maxEntries].
abstract class ColorMatchHistoryRepository {
  static const int maxEntries = 50;

  List<ColorMatchPick> get entries;

  /// Emits the current list immediately, then every change.
  Stream<List<ColorMatchPick>> get changes;

  Future<void> load();

  /// Records a pick at the front, de-duplicated and capped.
  Future<void> record(ColorMatchPick pick);

  Future<void> remove(String id);
  Future<void> clear();

  /// Replaces the whole list, as a backup restore does.
  Future<void> restore(List<ColorMatchPick> picks);
}

/// [ColorMatchHistoryRepository] on top of a [KeyValueStore].
///
/// Stored under a single key, `color_match_history`, as the JSON array of
/// [ColorMatchPick] objects (the Kotlin field names). Entries are global and
/// carry their own `brandId`, so a decotime match and an Ohuhu match coexist.
final class StoredColorMatchHistoryRepository
    implements ColorMatchHistoryRepository {
  StoredColorMatchHistoryRepository(this._store);

  static const String key = 'color_match_history';

  final KeyValueStore _store;
  final StreamController<List<ColorMatchPick>> _controller =
      StreamController<List<ColorMatchPick>>.broadcast();

  List<ColorMatchPick> _entries = const [];

  @override
  List<ColorMatchPick> get entries => _entries;

  @override
  Stream<List<ColorMatchPick>> get changes =>
      replayStream<List<ColorMatchPick>>(() => _entries, _controller.stream);

  @override
  Future<void> load() async {
    _entries = _normalize(_decode(await _store.getString(key)));
  }

  @override
  Future<void> record(ColorMatchPick pick) => _persist([pick, ..._entries]);

  @override
  Future<void> remove(String id) {
    final next = _entries.where((pick) => pick.id != id).toList();
    if (next.length == _entries.length) return Future<void>.value();
    return _persist(next);
  }

  @override
  Future<void> clear() => _persist(const []);

  @override
  Future<void> restore(List<ColorMatchPick> picks) => _persist(picks);

  Future<void> _persist(List<ColorMatchPick> picks) async {
    _entries = _normalize(picks);
    await _store.setString(
      key,
      jsonEncode(_entries.map((pick) => pick.toJson()).toList()),
    );
    _controller.add(_entries);
  }

  List<ColorMatchPick> _normalize(List<ColorMatchPick> picks) {
    final seen = <String>{};
    final result = <ColorMatchPick>[];
    for (final pick in picks) {
      final signature =
          '${pick.brandId}|${pick.matchedCode}|${pick.sampledHex}';
      if (!seen.add(signature)) continue;
      result.add(pick);
      if (result.length == ColorMatchHistoryRepository.maxEntries) break;
    }
    return List.unmodifiable(result);
  }

  List<ColorMatchPick> _decode(String? raw) {
    if (raw == null || raw.trim().isEmpty) return const [];
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        throw const DataStoreException(
          'expected a JSON array of colour-match picks',
          key: key,
        );
      }
      return decoded
          .map(
            (item) =>
                ColorMatchPick.fromJson((item as Map).cast<String, dynamic>()),
          )
          .toList();
    } on DataStoreException {
      rethrow;
    } catch (error) {
      throw DataStoreException(
        'could not parse colour-match history: $error',
        key: key,
      );
    }
  }
}
