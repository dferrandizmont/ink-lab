import 'dart:async';
import 'dart:convert';

import '../core/models.dart';
import 'brand_scoping.dart';
import 'data_exceptions.dart';
import 'key_value_store.dart';
import 'replay_stream.dart';

/// A set of markers, by brand-scoped id (`brandId:CODE`): the shape of the
/// wishlist and of the dried-out markers.
abstract class ColorIdSetRepository {
  /// Every marker in the set, sorted by id.
  Set<String> get ids;

  /// Goes up on every change, so results can be cached per revision.
  int get revision;

  /// Emits the current set immediately, then every change.
  Stream<Set<String>> get changes;

  /// Whether [colorId] is in the set (the id is scoped first).
  bool contains(String colorId);

  /// The ids of [brand] only.
  Set<String> idsOf(MarkerBrand brand);

  /// How many markers [brand] has in the set.
  int countOf(MarkerBrand brand);

  Future<void> load();

  /// Adds [colorId]. An id that is not a marker id is ignored.
  Future<void> add(String colorId);

  /// Takes [colorId] out; nothing happens when it is not there.
  Future<void> remove(String colorId);

  /// Adds [colorId], or takes it out when it is already there.
  Future<void> toggle(String colorId);

  /// Empties the set.
  Future<void> clear();

  /// Replaces the whole set, as a backup restore does.
  Future<void> restore(Iterable<String> ids);
}

/// The markers the user wants to buy.
abstract class WishlistRepository implements ColorIdSetRepository {}

/// The owned markers that ran dry. They stay in the collection, but Match,
/// Palette and Ideas do not suggest them.
abstract class DriedMarkerRepository implements ColorIdSetRepository {}

/// [ColorIdSetRepository] on top of a [KeyValueStore].
///
/// Stored under a single key as a sorted JSON array of scoped ids; the key is
/// removed while the set is empty.
class StoredColorIdSetRepository implements ColorIdSetRepository {
  StoredColorIdSetRepository(this._store, this.key);

  /// The storage key.
  final String key;

  final KeyValueStore _store;
  final StreamController<Set<String>> _controller =
      StreamController<Set<String>>.broadcast();

  Set<String> _ids = const {};
  int _revision = 0;

  @override
  Set<String> get ids => _ids;

  @override
  int get revision => _revision;

  @override
  Stream<Set<String>> get changes =>
      replayStream<Set<String>>(() => _ids, _controller.stream);

  @override
  bool contains(String colorId) {
    final String? scoped = scopedColorId(colorId);
    return scoped != null && _ids.contains(scoped);
  }

  @override
  Set<String> idsOf(MarkerBrand brand) => <String>{
    for (final String id in _ids)
      if (colorIdBelongsToBrand(id, brand)) id,
  };

  @override
  int countOf(MarkerBrand brand) => idsOf(brand).length;

  @override
  Future<void> load() async {
    _ids = _normalize(_decode(await _store.getString(key)));
    _revision++;
    _controller.add(_ids);
  }

  @override
  Future<void> add(String colorId) {
    final String? scoped = scopedColorId(colorId);
    if (scoped == null || _ids.contains(scoped)) return Future<void>.value();
    return _persist(<String>{..._ids, scoped});
  }

  @override
  Future<void> remove(String colorId) {
    final String? scoped = scopedColorId(colorId);
    if (scoped == null || !_ids.contains(scoped)) return Future<void>.value();
    return _persist(<String>{..._ids}..remove(scoped));
  }

  @override
  Future<void> toggle(String colorId) =>
      contains(colorId) ? remove(colorId) : add(colorId);

  @override
  Future<void> clear() =>
      _ids.isEmpty ? Future<void>.value() : _persist(const {});

  @override
  Future<void> restore(Iterable<String> ids) => _persist(ids);

  Future<void> _persist(Iterable<String> next) async {
    final Set<String> sorted = _normalize(next);
    if (sorted.isEmpty) {
      await _store.remove(key);
    } else {
      await _store.setString(key, jsonEncode(sorted.toList()));
    }
    _ids = sorted;
    _revision++;
    _controller.add(_ids);
  }

  /// Scoped, de-duplicated and sorted; entries that are not marker ids drop.
  static Set<String> _normalize(Iterable<String> raw) {
    final List<String> sorted = scopedColorIds(raw).toList()..sort();
    return Set<String>.unmodifiable(sorted);
  }

  Iterable<String> _decode(String? raw) {
    if (raw == null || raw.trim().isEmpty) return const <String>[];
    try {
      final Object? decoded = jsonDecode(raw);
      if (decoded is! List) {
        throw DataStoreException(
          'expected a JSON array of marker ids',
          key: key,
        );
      }
      return <String>[
        for (final Object? item in decoded)
          if (item is String) item,
      ];
    } on DataStoreException {
      rethrow;
    } catch (error) {
      throw DataStoreException('could not parse marker ids: $error', key: key);
    }
  }
}

/// [WishlistRepository] stored under `wishlist_marker_ids`.
final class StoredWishlistRepository extends StoredColorIdSetRepository
    implements WishlistRepository {
  StoredWishlistRepository(KeyValueStore store) : super(store, storageKey);

  static const String storageKey = 'wishlist_marker_ids';
}

/// [DriedMarkerRepository] stored under `dried_marker_ids`.
final class StoredDriedMarkerRepository extends StoredColorIdSetRepository
    implements DriedMarkerRepository {
  StoredDriedMarkerRepository(KeyValueStore store) : super(store, storageKey);

  static const String storageKey = 'dried_marker_ids';
}
