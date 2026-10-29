import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';

import 'fixtures.dart';

void main() {
  test('records newest first and survives a reopen', () async {
    final h = await harness();
    await h.history.record(pick(id: 'a'));
    await h.history.record(pick(id: 'b', matchedCode: 'G1'));
    expect(h.history.entries.map((p) => p.id), ['b', 'a']);

    final reopened = StoredColorMatchHistoryRepository(h.store);
    await reopened.load();
    expect(reopened.entries.map((p) => p.id), ['b', 'a']);
  });

  test('de-duplicates identical matches, moving them to the front', () async {
    final h = await harness();
    await h.history.record(pick(id: 'a', matchedCode: 'R1'));
    await h.history.record(pick(id: 'b', matchedCode: 'G1'));
    // Same brand, code and sampled hex: replaces, does not duplicate.
    await h.history.record(pick(id: 'c', matchedCode: 'R1'));
    expect(h.history.entries.map((p) => p.id), ['c', 'b']);

    // Same code, different sampled hex: a distinct match.
    await h.history.record(
      pick(id: 'd', matchedCode: 'R1', sampledHex: '112233'),
    );
    expect(h.history.entries.map((p) => p.id), ['d', 'c', 'b']);
  });

  test('caps the history', () async {
    final h = await harness();
    for (var i = 0; i < ColorMatchHistoryRepository.maxEntries + 5; i++) {
      await h.history.record(pick(id: 'c$i', matchedCode: 'C$i'));
    }
    expect(
      h.history.entries,
      hasLength(ColorMatchHistoryRepository.maxEntries),
    );
    expect(
      h.history.entries.first.id,
      'c${ColorMatchHistoryRepository.maxEntries + 4}',
    );
  });

  test('changes replays the current list and emits updates', () async {
    final h = await harness();
    final seen = <List<ColorMatchPick>>[];
    final subscription = h.history.changes.listen(seen.add);
    await pumpEventQueue();
    expect(seen.single, isEmpty);
    await h.history.record(pick(id: 'a'));
    await pumpEventQueue();
    expect(seen.last.map((p) => p.id), ['a']);
    await subscription.cancel();
  });

  test('remove, clear and restore', () async {
    final h = await harness();
    await h.history.record(pick(id: 'a'));
    await h.history.record(pick(id: 'b', matchedCode: 'G1'));
    await h.history.remove('a');
    expect(h.history.entries.map((p) => p.id), ['b']);
    await h.history.remove('missing'); // no-op
    expect(h.history.entries.map((p) => p.id), ['b']);

    await h.history.restore([pick(id: 'x'), pick(id: 'y', matchedCode: 'G1')]);
    expect(h.history.entries.map((p) => p.id), ['x', 'y']);

    await h.history.clear();
    expect(h.history.entries, isEmpty);
  });

  test('corrupt stored data raises a typed error', () async {
    final store = InMemoryKeyValueStore({
      StoredColorMatchHistoryRepository.key: '{"not":"a list"}',
    });
    final repository = StoredColorMatchHistoryRepository(store);
    await expectLater(repository.load(), throwsA(isA<DataStoreException>()));
  });
}
