import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';

import 'fixtures.dart';

void main() {
  test('saves newest first and survives a reopen', () async {
    final h = await harness();
    await h.savedPalettes.save(palette(id: 'a', name: 'A'));
    await h.savedPalettes.save(palette(id: 'b', name: 'B'));
    expect(h.savedPalettes.palettesOf(MarkerBrand.ohuhuOahu).map((p) => p.id), [
      'b',
      'a',
    ]);

    final reopened = StoredSavedPaletteRepository(h.store);
    await reopened.load();
    expect(reopened.palettesOf(MarkerBrand.ohuhuOahu).map((p) => p.id), [
      'b',
      'a',
    ]);
  });

  test('de-duplicates by id and by content signature', () async {
    final h = await harness();
    await h.savedPalettes.save(palette(id: 'a', name: 'Same'));
    await h.savedPalettes.save(palette(id: 'a', name: 'Same')); // same id
    expect(h.savedPalettes.palettesOf(MarkerBrand.ohuhuOahu), hasLength(1));

    // Different id, identical content: still one entry.
    await h.savedPalettes.save(palette(id: 'b', name: 'Same'));
    expect(h.savedPalettes.palettesOf(MarkerBrand.ohuhuOahu), hasLength(1));
    expect(h.savedPalettes.palettesOf(MarkerBrand.ohuhuOahu).single.id, 'b');

    // Same id but changed content replaces in place.
    await h.savedPalettes.save(palette(id: 'b', name: 'Renamed'));
    final palettes = h.savedPalettes.palettesOf(MarkerBrand.ohuhuOahu);
    expect(palettes, hasLength(1));
    expect(palettes.single.name, 'Renamed');
  });

  test('caps the list per brand, dropping the oldest', () async {
    final h = await harness();
    for (var i = 0; i < SavedPaletteRepository.maxPerBrand + 5; i++) {
      await h.savedPalettes.save(palette(id: 'p$i', name: 'P$i'));
    }
    final palettes = h.savedPalettes.palettesOf(MarkerBrand.ohuhuOahu);
    expect(palettes, hasLength(SavedPaletteRepository.maxPerBrand));
    expect(palettes.first.id, 'p${SavedPaletteRepository.maxPerBrand + 4}');
    expect(palettes.last.id, 'p5');
  });

  test('scopes palettes per brand and keeps them independent', () async {
    final h = await harness();
    await h.savedPalettes.save(palette(id: 'o', brandId: 'ohuhu_oahu'));
    await h.savedPalettes.save(
      palette(id: 'd', brandId: 'decotime', name: 'Deco'),
    );
    expect(h.savedPalettes.palettesOf(MarkerBrand.ohuhuOahu).single.id, 'o');
    expect(h.savedPalettes.palettesOf(MarkerBrand.decoTime).single.id, 'd');
    expect(h.savedPalettes.exportByBrand().keys, ['ohuhu_oahu', 'decotime']);

    await h.savedPalettes.delete(MarkerBrand.ohuhuOahu, 'o');
    expect(h.savedPalettes.palettesOf(MarkerBrand.ohuhuOahu), isEmpty);
    expect(h.savedPalettes.palettesOf(MarkerBrand.decoTime), hasLength(1));

    await h.savedPalettes.clearBrand(MarkerBrand.decoTime);
    expect(h.savedPalettes.palettesOf(MarkerBrand.decoTime), isEmpty);
  });

  test('watch emits the current list and then changes', () async {
    final h = await harness();
    await h.savedPalettes.save(palette(id: 'a'));
    final seen = <List<SavedPalette>>[];
    final subscription = h.savedPalettes
        .watch(MarkerBrand.ohuhuOahu)
        .listen(seen.add);
    await pumpEventQueue();
    expect(seen.single.map((p) => p.id), ['a']);

    await h.savedPalettes.save(palette(id: 'b', name: 'B'));
    await pumpEventQueue();
    expect(seen, hasLength(2));
    expect(seen.last.map((p) => p.id), ['b', 'a']);

    // A change to another brand is not emitted on this brand's stream.
    await h.savedPalettes.save(palette(id: 'd', brandId: 'decotime'));
    await pumpEventQueue();
    expect(seen, hasLength(2));
    await subscription.cancel();
  });

  test(
    'restore replaces every brand, including clearing absent ones',
    () async {
      final h = await harness();
      await h.savedPalettes.save(palette(id: 'old', brandId: 'decotime'));
      await h.savedPalettes.restore({
        'ohuhu_oahu': [palette(id: 'new')],
      });
      expect(
        h.savedPalettes.palettesOf(MarkerBrand.ohuhuOahu).single.id,
        'new',
      );
      expect(h.savedPalettes.palettesOf(MarkerBrand.decoTime), isEmpty);
    },
  );

  test('corrupt stored data raises a typed error', () async {
    final store = InMemoryKeyValueStore({
      StoredSavedPaletteRepository.keyFor(MarkerBrand.ohuhuOahu): 'not json',
    });
    final repository = StoredSavedPaletteRepository(store);
    await expectLater(repository.load(), throwsA(isA<DataStoreException>()));
  });
}
