import 'dart:async';
import 'dart:convert';

import '../core/ideas_engine.dart';
import 'data_exceptions.dart';
import 'key_value_store.dart';
import 'replay_stream.dart';

/// The ideas the user marked as favourites, and the ones they opened last.
///
/// The ids are the stable ids of the ideas catalogue (`IdeasEngine.presets`),
/// so a favourite survives a change of title or of order. An id that is not
/// in the catalogue is dropped: it belongs to an idea this build does not
/// know, and the screen could not show it anyway.
abstract class IdeaFavoritesRepository {
  /// How many recently viewed ideas are kept.
  static const int maxRecent = 20;

  /// How many favourite ideas are kept at most.
  ///
  /// The favourites are the ids of the ideas catalogue, so this is a safety
  /// net for a store that holds more than the app could ever write.
  static const int maxFavorites = 500;

  /// The favourite idea ids, sorted.
  Set<String> get favorites;

  /// Emits the current favourites immediately, then every change.
  Stream<Set<String>> get favoriteChanges;

  /// The ids of the ideas opened last, newest first, at most
  /// [maxRecent] of them.
  List<String> get recent;

  /// Emits the current recent list immediately, then every change.
  Stream<List<String>> get recentChanges;

  /// Whether [ideaId] is a favourite.
  bool isFavorite(String ideaId);

  Future<void> load();

  /// Adds [ideaId] to the favourites, or takes it out when it is already
  /// there. Returns whether it is a favourite now.
  Future<bool> toggle(String ideaId);

  /// Empties the favourites.
  Future<void> clearFavorites();

  /// Puts [ideaId] at the front of the recent ideas, moving it there when it
  /// was already there.
  Future<void> recordViewed(String ideaId);

  /// Empties the recent ideas.
  Future<void> clearRecent();

  /// Replaces the favourites, as a backup restore does.
  Future<void> restoreFavorites(Iterable<String> ids);

  /// Replaces the recent ideas, as a backup restore does.
  Future<void> restoreRecent(Iterable<String> ids);
}

/// [IdeaFavoritesRepository] on top of a [KeyValueStore].
///
/// Two keys: `idea_favorites`, a JSON array of idea ids, and
/// `idea_recent`, a JSON array of the ids of the ideas opened last, newest
/// first. The key of a list is removed while it is empty.
///
/// Every change goes through a queue: the next state is worked out and
/// written after the previous change is done, so two overlapping calls (a
/// double tap on the heart of two ideas, a screen that records a view while
/// the favourites are being restored) cannot overwrite each other.
final class StoredIdeaFavoritesRepository implements IdeaFavoritesRepository {
  StoredIdeaFavoritesRepository(this._store);

  /// The key of the favourites.
  static const String favoritesKey = 'idea_favorites';

  /// The key of the recently viewed ideas.
  static const String recentKey = 'idea_recent';

  final KeyValueStore _store;
  final StreamController<Set<String>> _favoritesController =
      StreamController<Set<String>>.broadcast();
  final StreamController<List<String>> _recentController =
      StreamController<List<String>>.broadcast();

  Set<String> _favorites = const <String>{};
  List<String> _recent = const <String>[];

  /// The tail of the queue of changes: every change waits for the one before
  /// it.
  Future<void> _pending = Future<void>.value();

  @override
  Set<String> get favorites => _favorites;

  @override
  Stream<Set<String>> get favoriteChanges =>
      replayStream<Set<String>>(() => _favorites, _favoritesController.stream);

  @override
  List<String> get recent => _recent;

  @override
  Stream<List<String>> get recentChanges =>
      replayStream<List<String>>(() => _recent, _recentController.stream);

  @override
  bool isFavorite(String ideaId) => _favorites.contains(ideaId);

  @override
  Future<void> load() => _enqueue(() async {
    _favorites = _normalizeFavorites(
      _decode(await _store.getString(favoritesKey), favoritesKey),
    );
    _recent = _normalizeRecent(
      _decode(await _store.getString(recentKey), recentKey),
    );
    _favoritesController.add(_favorites);
    _recentController.add(_recent);
  });

  @override
  Future<bool> toggle(String ideaId) {
    bool favorite = false;
    return _enqueue(() async {
      final String? id = _knownIdeaId(ideaId);
      if (id == null) return;
      final bool isFavorite = _favorites.contains(id);
      final Set<String> next = isFavorite
          ? (<String>{..._favorites}..remove(id))
          : <String>{..._favorites, id};
      await _persistFavorites(next);
      favorite = !isFavorite;
    }).then((_) => favorite);
  }

  @override
  Future<void> clearFavorites() => _enqueue(() async {
    if (_favorites.isEmpty) return;
    await _persistFavorites(const <String>{});
  });

  @override
  Future<void> recordViewed(String ideaId) => _enqueue(() async {
    final String? id = _knownIdeaId(ideaId);
    if (id == null) return;
    final List<String> next = <String>[
      id,
      for (final String other in _recent)
        if (other != id) other,
    ].take(IdeaFavoritesRepository.maxRecent).toList();
    await _persistRecent(next);
  });

  @override
  Future<void> clearRecent() => _enqueue(() async {
    if (_recent.isEmpty) return;
    await _persistRecent(const <String>[]);
  });

  @override
  Future<void> restoreFavorites(Iterable<String> ids) =>
      _enqueue(() => _persistFavorites(_normalizeFavorites(ids)));

  @override
  Future<void> restoreRecent(Iterable<String> ids) =>
      _enqueue(() => _persistRecent(_normalizeRecent(ids)));

  /// Runs [action] once every change queued before it is done.
  ///
  /// The queue keeps going when [action] fails: the error goes to the caller
  /// and the next change is worked out from the state that is stored.
  Future<void> _enqueue(Future<void> Function() action) {
    final Completer<void> completer = Completer<void>();
    _pending = _pending.then((_) async {
      try {
        await action();
        completer.complete();
      } catch (error, stackTrace) {
        completer.completeError(error, stackTrace);
      }
    });
    return completer.future;
  }

  Future<void> _persistFavorites(Set<String> favorites) async {
    final Set<String> sorted = Set<String>.unmodifiable(
      favorites.toList()..sort(),
    );
    if (sorted.isEmpty) {
      await _store.remove(favoritesKey);
    } else {
      await _store.setString(
        favoritesKey,
        jsonEncode(sorted.toList()),
      );
    }
    _favorites = sorted;
    _favoritesController.add(_favorites);
  }

  Future<void> _persistRecent(List<String> recent) async {
    final List<String> normalized = _normalizeRecent(recent);
    if (normalized.isEmpty) {
      await _store.remove(recentKey);
    } else {
      await _store.setString(recentKey, jsonEncode(normalized));
    }
    _recent = normalized;
    _recentController.add(_recent);
  }

  /// The ids of the catalogue, so a stale id is never stored.
  static final Set<String> _knownIds = <String>{
    for (final IdeaPreset preset in IdeasEngine.presets) preset.id,
  };

  /// The id of [ideaId] when the catalogue knows it, else `null`.
  static String? _knownIdeaId(String ideaId) {
    final String id = ideaId.trim();
    return _knownIds.contains(id) ? id : null;
  }

  /// The known ids, de-duplicated and sorted.
  ///
  /// The duplicates go before the sort: a list with the same id a thousand
  /// times is one id, and it must not be walked and sorted a thousand times.
  static Set<String> _normalizeFavorites(Iterable<String> ids) {
    final Set<String> known = <String>{};
    for (final String id in ids) {
      final String? knownId = _knownIdeaId(id);
      if (knownId != null) known.add(knownId);
    }
    final List<String> sorted = known.toList()
      ..sort();
    return Set<String>.unmodifiable(
      sorted.take(IdeaFavoritesRepository.maxFavorites),
    );
  }

  /// The known ids, newest first, de-duplicated and capped.
  static List<String> _normalizeRecent(Iterable<String> ids) {
    final Set<String> seen = <String>{};
    final List<String> result = <String>[];
    for (final String raw in ids) {
      final String? id = _knownIdeaId(raw);
      if (id == null || !seen.add(id)) continue;
      result.add(id);
      if (result.length == IdeaFavoritesRepository.maxRecent) break;
    }
    return List<String>.unmodifiable(result);
  }

  List<String> _decode(String? raw, String key) {
    if (raw == null || raw.trim().isEmpty) return const <String>[];
    try {
      final Object? decoded = jsonDecode(raw);
      if (decoded is! List) {
        throw DataStoreException(
          'expected a JSON array of idea ids',
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
      throw DataStoreException('could not parse idea ids: $error', key: key);
    }
  }
}
