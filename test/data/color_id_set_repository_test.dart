import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';

/// The wishlist and the dried-out markers share one implementation: the same
/// behaviour is checked for both, then the keys that tell them apart.
void main() {
  final Map<String, StoredColorIdSetRepository Function(KeyValueStore)>
  factories = <String, StoredColorIdSetRepository Function(KeyValueStore)>{
    'wishlist': StoredWishlistRepository.new,
    'dried markers': StoredDriedMarkerRepository.new,
  };

  for (final MapEntry<
        String,
        StoredColorIdSetRepository Function(KeyValueStore)
      >
      entry
      in factories.entries) {
    group(entry.key, () {
      late InMemoryKeyValueStore store;
      late StoredColorIdSetRepository repo;

      setUp(() async {
        store = InMemoryKeyValueStore();
        repo = entry.value(store);
        await repo.load();
      });

      test('starts empty and leaves no key behind', () async {
        expect(repo.ids, isEmpty);
        expect(await store.containsKey(repo.key), isFalse);
      });

      test(
        'scopes ids to a brand, upper-cases codes and survives a reopen',
        () async {
          await repo.add('r1');
          await repo.add('decotime:02');
          await repo.add(' ohuhu_oahu:b08 ');
          expect(repo.ids.toList(), <String>[
            'decotime:02',
            'ohuhu_oahu:B08',
            'ohuhu_oahu:R1',
          ]);
          expect(repo.contains('R1'), isTrue);
          expect(repo.contains('ohuhu_oahu:r1'), isTrue);
          expect(repo.contains('decotime:R1'), isFalse);

          final StoredColorIdSetRepository reopened = entry.value(store);
          await reopened.load();
          expect(reopened.ids, repo.ids);
        },
      );

      test('is one sorted JSON array under one key', () async {
        await repo.add('R3');
        await repo.add('R1');
        final String? raw = await store.getString(repo.key);
        expect(jsonDecode(raw!), <String>['ohuhu_oahu:R1', 'ohuhu_oahu:R3']);
      });

      test('ignores a duplicate and ids that are not markers', () async {
        await repo.add('R1');
        final int revision = repo.revision;
        await repo.add('r1');
        await repo.add(':');
        await repo.add('');
        await repo.add('decotime:');
        expect(repo.ids, hasLength(1));
        expect(repo.revision, revision, reason: 'nothing changed');
      });

      test('remove, toggle and clear', () async {
        await repo.add('R1');
        await repo.add('R2');
        await repo.remove('R1');
        await repo.remove('not-there');
        expect(repo.ids.toList(), <String>['ohuhu_oahu:R2']);

        await repo.toggle('R2');
        expect(repo.ids, isEmpty);
        expect(await store.containsKey(repo.key), isFalse);
        await repo.toggle('R9');
        expect(repo.contains('R9'), isTrue);

        await repo.clear();
        expect(repo.ids, isEmpty);
        expect(await store.containsKey(repo.key), isFalse);
      });

      test('counts and lists the markers of one brand', () async {
        await repo.add('R1');
        await repo.add('R2');
        await repo.add('decotime:05');
        expect(repo.countOf(MarkerBrand.ohuhuOahu), 2);
        expect(repo.countOf(MarkerBrand.decoTime), 1);
        expect(repo.idsOf(MarkerBrand.decoTime), <String>{'decotime:05'});
      });

      test('the revision goes up on every change', () async {
        final int start = repo.revision;
        await repo.add('R1');
        expect(repo.revision, start + 1);
        await repo.remove('R1');
        expect(repo.revision, start + 2);
      });

      test('replays the current set, then every change', () async {
        await repo.add('R1');
        final List<Set<String>> seen = <Set<String>>[];
        final sub = repo.changes.listen(seen.add);
        await Future<void>.delayed(Duration.zero);
        await repo.add('R2');
        await Future<void>.delayed(Duration.zero);
        await sub.cancel();
        expect(seen, <Set<String>>[
          <String>{'ohuhu_oahu:R1'},
          <String>{'ohuhu_oahu:R1', 'ohuhu_oahu:R2'},
        ]);
        // A second subscription works too (a widget remounting).
        expect(await repo.changes.first, repo.ids);
      });

      test('restore replaces everything and normalises', () async {
        await repo.add('R1');
        await repo.restore(<String>['g1', 'G1', 'decotime:03', '', 'x:']);
        expect(repo.ids.toList(), <String>['decotime:03', 'ohuhu_oahu:G1']);
        await repo.restore(const <String>[]);
        expect(repo.ids, isEmpty);
        expect(await store.containsKey(repo.key), isFalse);
      });

      test('a stored value that is not an array is reported', () async {
        await store.setString(repo.key, '{"a":1}');
        await expectLater(
          entry.value(store).load(),
          throwsA(isA<DataStoreException>()),
        );
        await store.setString(repo.key, 'not json');
        await expectLater(
          entry.value(store).load(),
          throwsA(isA<DataStoreException>()),
        );
      });

      test('entries that are not strings are dropped on load', () async {
        await store.setString(repo.key, '["R1", 5, null, "decotime:02"]');
        final StoredColorIdSetRepository loaded = entry.value(store);
        await loaded.load();
        expect(loaded.ids.toList(), <String>['decotime:02', 'ohuhu_oahu:R1']);
      });
    });
  }

  test('the wishlist and the dried markers use different keys', () async {
    final InMemoryKeyValueStore store = InMemoryKeyValueStore();
    final StoredWishlistRepository wishlist = StoredWishlistRepository(store);
    final StoredDriedMarkerRepository dried = StoredDriedMarkerRepository(
      store,
    );
    await wishlist.load();
    await dried.load();
    await wishlist.add('R1');
    expect(dried.ids, isEmpty);
    expect(wishlist.key, 'wishlist_marker_ids');
    expect(dried.key, 'dried_marker_ids');
  });
}
