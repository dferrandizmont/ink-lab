import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/ideas_engine.dart';
import 'package:ink_lab/data/data.dart';

import 'fixtures.dart';

/// Two ids of the ideas catalogue, so the test does not depend on how many
/// ideas there are.
const String firstIdea = 'smooth_fill';
const String secondIdea = 'grayscale';

void main() {
  group('StoredIdeaFavoritesRepository', () {
    late InMemoryKeyValueStore store;
    late StoredIdeaFavoritesRepository repo;

    setUp(() async {
      store = InMemoryKeyValueStore();
      repo = StoredIdeaFavoritesRepository(store);
      await repo.load();
    });

    test('the ids of the catalogue are the ones it knows', () {
      expect(
        IdeasEngine.presets.map((IdeaPreset p) => p.id),
        contains(firstIdea),
      );
      expect(
        IdeasEngine.presets.map((IdeaPreset p) => p.id),
        contains(secondIdea),
      );
    });

    test('starts empty and leaves no key behind', () async {
      expect(repo.favorites, isEmpty);
      expect(repo.recent, isEmpty);
      expect(
        await store.containsKey(StoredIdeaFavoritesRepository.favoritesKey),
        isFalse,
      );
      expect(
        await store.containsKey(StoredIdeaFavoritesRepository.recentKey),
        isFalse,
      );
    });

    test('toggle adds the idea and takes it out again', () async {
      expect(await repo.toggle(firstIdea), isTrue);
      expect(repo.isFavorite(firstIdea), isTrue);
      expect(repo.favorites, <String>{firstIdea});
      expect(await repo.toggle(firstIdea), isFalse);
      expect(repo.favorites, isEmpty);
      // An empty list leaves no key behind.
      expect(
        await store.containsKey(StoredIdeaFavoritesRepository.favoritesKey),
        isFalse,
      );
    });

    test('an idea the catalogue does not know is dropped', () async {
      expect(await repo.toggle('not_an_idea'), isFalse);
      expect(repo.favorites, isEmpty);
      await repo.recordViewed('not_an_idea');
      expect(repo.recent, isEmpty);
    });

    test('the favourites are sorted and stored as one JSON array', () async {
      await repo.toggle(secondIdea);
      await repo.toggle(firstIdea);
      expect(repo.favorites.toList(), <String>[secondIdea, firstIdea]);
      final String? raw = await store.getString(
        StoredIdeaFavoritesRepository.favoritesKey,
      );
      expect(jsonDecode(raw!), <String>[secondIdea, firstIdea]);
    });

    test('the favourites survive a reopen', () async {
      await repo.toggle(firstIdea);
      final StoredIdeaFavoritesRepository reopened = StoredIdeaFavoritesRepository(
        store,
      );
      await reopened.load();
      expect(reopened.favorites, <String>{firstIdea});
    });

    test('the recent ideas come newest first, without duplicates', () async {
      await repo.recordViewed(firstIdea);
      await repo.recordViewed(secondIdea);
      await repo.recordViewed(firstIdea);
      expect(repo.recent, <String>[firstIdea, secondIdea]);
      final String? raw = await store.getString(
        StoredIdeaFavoritesRepository.recentKey,
      );
      expect(jsonDecode(raw!), <String>[firstIdea, secondIdea]);
    });

    test('only the last twenty ideas are kept', () async {
      final List<String> ids = IdeasEngine.presets
          .map((IdeaPreset p) => p.id)
          .take(25)
          .toList();
      for (final String id in ids) {
        await repo.recordViewed(id);
      }
      expect(repo.recent, hasLength(IdeaFavoritesRepository.maxRecent));
      // The newest one first, the oldest one gone.
      expect(repo.recent.first, ids.last);
      expect(repo.recent, isNot(contains(ids.first)));
    });

    test('the streams replay the current value, then every change', () async {
      await repo.toggle(firstIdea);
      await repo.recordViewed(secondIdea);
      final List<Set<String>> favorites = <Set<String>>[];
      final List<List<String>> recent = <List<String>>[];
      final sub = repo.favoriteChanges.listen(favorites.add);
      final recentSub = repo.recentChanges.listen(recent.add);
      await Future<void>.delayed(Duration.zero);
      await repo.toggle(secondIdea);
      await Future<void>.delayed(Duration.zero);
      await sub.cancel();
      await recentSub.cancel();
      expect(favorites, <Set<String>>[
        <String>{firstIdea},
        <String>{firstIdea, secondIdea},
      ]);
      expect(recent.first, <String>[secondIdea]);
      // A second subscription works too (a widget remounting).
      expect(await repo.favoriteChanges.first, repo.favorites);
      expect(await repo.recentChanges.first, repo.recent);
    });

    test('clear empties the favourites and the recent ideas', () async {
      await repo.toggle(firstIdea);
      await repo.recordViewed(secondIdea);
      await repo.clearFavorites();
      await repo.clearRecent();
      expect(repo.favorites, isEmpty);
      expect(repo.recent, isEmpty);
      expect(
        await store.containsKey(StoredIdeaFavoritesRepository.favoritesKey),
        isFalse,
      );
      expect(
        await store.containsKey(StoredIdeaFavoritesRepository.recentKey),
        isFalse,
      );
    });

    test('restore replaces everything and normalises', () async {
      await repo.toggle(firstIdea);
      await repo.restoreFavorites(<String>[secondIdea, 'not_an_idea']);
      expect(repo.favorites, <String>{secondIdea});
      await repo.restoreFavorites(const <String>[]);
      expect(repo.favorites, isEmpty);

      await repo.restoreRecent(<String>[firstIdea, firstIdea, 'not_an_idea']);
      expect(repo.recent, <String>[firstIdea]);
      await repo.restoreRecent(const <String>[]);
      expect(repo.recent, isEmpty);
    });

    test('a stored value that is not an array is reported', () async {
      // A clean store per case: with the broken favourites still in place the
      // load would fail there and never reach the recent list.
      final InMemoryKeyValueStore brokenFavorites = InMemoryKeyValueStore();
      await brokenFavorites.setString(
        StoredIdeaFavoritesRepository.favoritesKey,
        '{"a":1}',
      );
      await expectLater(
        StoredIdeaFavoritesRepository(brokenFavorites).load(),
        throwsA(
          isA<DataStoreException>().having(
            (DataStoreException error) => error.key,
            'key',
            StoredIdeaFavoritesRepository.favoritesKey,
          ),
        ),
      );

      final InMemoryKeyValueStore brokenRecent = InMemoryKeyValueStore();
      await brokenRecent.setString(
        StoredIdeaFavoritesRepository.recentKey,
        'not json',
      );
      await expectLater(
        StoredIdeaFavoritesRepository(brokenRecent).load(),
        throwsA(
          isA<DataStoreException>().having(
            (DataStoreException error) => error.key,
            'key',
            StoredIdeaFavoritesRepository.recentKey,
          ),
        ),
      );
    });

    test('entries that are not strings are dropped on load', () async {
      await store.setString(
        StoredIdeaFavoritesRepository.favoritesKey,
        '["$firstIdea", 5, null]',
      );
      final StoredIdeaFavoritesRepository loaded = StoredIdeaFavoritesRepository(
        store,
      );
      await loaded.load();
      expect(loaded.favorites, <String>{firstIdea});
    });
  });

  group('the queue of changes', () {
    late SlowKeyValueStore slow;
    late StoredIdeaFavoritesRepository repo;

    setUp(() async {
      slow = SlowKeyValueStore();
      repo = StoredIdeaFavoritesRepository(slow);
      await repo.load();
    });

    test('two overlapping toggles do not lose one of them', () async {
      final List<bool> results = await Future.wait(<Future<bool>>[
        repo.toggle(firstIdea),
        repo.toggle(secondIdea),
      ]);

      expect(results, <bool>[true, true]);
      expect(repo.favorites, <String>{firstIdea, secondIdea});
      final String? stored = await slow.getString(
        StoredIdeaFavoritesRepository.favoritesKey,
      );
      expect(jsonDecode(stored!), <String>[secondIdea, firstIdea]);
    });

    test('two overlapping views do not lose one of them', () async {
      await Future.wait(<Future<void>>[
        repo.recordViewed(firstIdea),
        repo.recordViewed(secondIdea),
      ]);

      // The newest one first: the second view came after the first.
      expect(repo.recent, <String>[secondIdea, firstIdea]);
    });

    test('a restore waits for the change that was queued before it', () async {
      await Future.wait(<Future<void>>[
        repo.toggle(firstIdea),
        repo.restoreFavorites(<String>[secondIdea]),
      ]);

      expect(repo.favorites, <String>{secondIdea});
    });

    test('a write that fails does not stop the next change', () async {
      slow.failNextWrite = StateError('the disk is full');
      await expectLater(repo.toggle(firstIdea), throwsA(isA<StateError>()));
      expect(repo.favorites, isEmpty);

      // The queue keeps going: the next change works.
      expect(await repo.toggle(firstIdea), isTrue);
      expect(repo.favorites, <String>{firstIdea});
    });
  });

  group('the backup', () {
    test('the favourite ideas and the recent ones go in it and come back', () async {
      final source = await harness();
      await source.ideaFavorites.toggle(firstIdea);
      await source.ideaFavorites.toggle(secondIdea);
      await source.ideaFavorites.recordViewed(secondIdea);
      await source.ideaFavorites.recordViewed(firstIdea);

      final exported =
          jsonDecode(source.backup().exportJson()) as Map<String, dynamic>;
      expect(exported['ideaFavorites'], <String>[secondIdea, firstIdea]);
      expect(exported['recentIdeas'], <String>[firstIdea, secondIdea]);

      final target = await harness();
      await target.backup().importJson(jsonEncode(exported));
      expect(target.ideaFavorites.favorites, <String>{firstIdea, secondIdea});
      expect(target.ideaFavorites.recent, <String>[firstIdea, secondIdea]);
      expect(target.backup().exportJson(), source.backup().exportJson());
    });

    test('a backup from before the idea favourites imports and keeps yours', () async {
      final h = await harness();
      await h.ideaFavorites.toggle(firstIdea);
      await h.backup().importJson('{"version":1}');
      expect(h.ideaFavorites.favorites, <String>{firstIdea});
    });

    test('an idea the catalogue does not know never comes back', () async {
      final h = await harness();
      await h.backup().importJson(
        '{"version":1,"ideaFavorites":["$firstIdea","not_an_idea"],'
        '"recentIdeas":["not_an_idea"]}',
      );
      expect(h.ideaFavorites.favorites, <String>{firstIdea});
      expect(h.ideaFavorites.recent, isEmpty);
    });

    test('a broken idea section is refused', () async {
      final h = await harness();
      for (final source in [
        '{"version":1,"ideaFavorites":{"a":1}}',
        '{"version":1,"ideaFavorites":[5]}',
        '{"version":1,"recentIdeas":"nope"}',
      ]) {
        await expectLater(
          h.backup().importJson(source),
          throwsA(isA<BackupFormatException>()),
          reason: source,
        );
      }
    });
  });
}

/// A store whose writes wait, so two changes can overlap.
///
/// The wait is what makes the race real: without it the writes would end in
/// the order they started, and the second one would read the state the first
/// one had already written.
final class SlowKeyValueStore implements KeyValueStore {
  SlowKeyValueStore([KeyValueStore? inner])
    : _inner = inner ?? InMemoryKeyValueStore();

  final KeyValueStore _inner;

  /// How long every write waits.
  Duration delay = const Duration(milliseconds: 20);

  /// When it is set, the next write throws it.
  Object? failNextWrite;

  @override
  Future<void> setString(String key, String value) async {
    await Future<void>.delayed(delay);
    _failIfAsked();
    await _inner.setString(key, value);
  }

  @override
  Future<void> remove(String key) async {
    await Future<void>.delayed(delay);
    _failIfAsked();
    await _inner.remove(key);
  }

  void _failIfAsked() {
    final Object? failure = failNextWrite;
    if (failure == null) return;
    failNextWrite = null;
    throw failure;
  }

  @override
  Future<String?> getString(String key) => _inner.getString(key);

  @override
  Future<bool?> getBool(String key) => _inner.getBool(key);

  @override
  Future<void> setBool(String key, bool value) => _inner.setBool(key, value);

  @override
  Future<int?> getInt(String key) => _inner.getInt(key);

  @override
  Future<void> setInt(String key, int value) => _inner.setInt(key, value);

  @override
  Future<double?> getDouble(String key) => _inner.getDouble(key);

  @override
  Future<void> setDouble(String key, double value) =>
      _inner.setDouble(key, value);

  @override
  Future<List<String>?> getStringList(String key) => _inner.getStringList(key);

  @override
  Future<void> setStringList(String key, List<String> value) =>
      _inner.setStringList(key, value);

  @override
  Future<bool> containsKey(String key) => _inner.containsKey(key);

  @override
  Future<Set<String>> keys() => _inner.keys();
}
