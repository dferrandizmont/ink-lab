import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';

import 'fixtures.dart';

void main() {
  test(
    'legacy palette JSON loads unchanged and mixed IDs survive storage',
    () async {
      final legacy = palette(id: 'old', name: 'Old');
      final old = SavedPalette.fromJson(legacy.toJson()..remove('brandId'));
      expect(old.brandId, 'ohuhu_oahu');
      expect(old.colorCodes, legacy.colorCodes);
      expect(old.colorIds, [
        for (final c in legacy.colorCodes) 'ohuhu_oahu:$c',
      ]);
      final mixed = SavedPalette.fromJson({
        ...legacy.toJson(),
        'id': 'mixed',
        'baseCode': 'ohuhu_oahu:91',
        'colorCodes': ['ohuhu_oahu:91', 'decotime:91'],
      });
      final h = await harness();
      await h.savedPalettes.save(mixed);
      final reopened = StoredSavedPaletteRepository(h.store);
      await reopened.load();
      final saved = reopened.palettesOf(MarkerBrand.ohuhuOahu).single;
      expect(saved.colorIds, ['ohuhu_oahu:91', 'decotime:91']);
      expect(saved.brandOf('decotime:91'), MarkerBrand.decoTime);
      expect(saved.bareCode('decotime:91'), '91');
      expect(saved.showsBrandsUnder(saved.brandId), isTrue);
      expect(saved.mixed, isTrue);
    },
  );
  test(
    'a palette that mixes brands is listed under each of them, once',
    () async {
      final h = await harness();
      SavedPalette mixed(String id, int at, {String brandId = 'ohuhu_oahu'}) =>
          SavedPalette.fromJson({
            ...palette(id: id, name: id, brandId: brandId).toJson(),
            'baseCode': 'ohuhu_oahu:91',
            'colorCodes': ['ohuhu_oahu:91', 'decotime:91'],
            'createdAtEpochMs': at,
          });
      SavedPalette plain(String id, int at, {String brandId = 'ohuhu_oahu'}) =>
          SavedPalette.fromJson({
            ...palette(id: id, name: id, brandId: brandId).toJson(),
            'createdAtEpochMs': at,
          });
      await h.savedPalettes.save(plain('ohuhu', 1));
      await h.savedPalettes.save(plain('deco', 2, brandId: 'decotime'));
      await h.savedPalettes.save(mixed('mix', 3));
      List<String> listed(MarkerBrand brand) =>
          h.savedPalettes.listedFor(brand).map((p) => p.id).toList();

      // Stored once, under the brand in use when it was saved...
      expect(
        h.savedPalettes.palettesOf(MarkerBrand.decoTime).map((p) => p.id),
        ['deco'],
      );
      // ...and listed under both, newest first, with each brand's own.
      expect(listed(MarkerBrand.ohuhuOahu), ['mix', 'ohuhu']);
      expect(listed(MarkerBrand.decoTime), ['mix', 'deco']);
      expect(listed(MarkerBrand.copic), isEmpty);
      expect(h.savedPalettes.all.map((p) => p.id).toSet(), {
        'ohuhu',
        'deco',
        'mix',
      });
      final shown = h.savedPalettes.listedFor(MarkerBrand.decoTime).first;
      expect(shown.showsBrandsUnder('decotime'), isTrue);
      expect(shown.brandOf('decotime:91'), MarkerBrand.decoTime);
      expect(shown.bareCode('decotime:91'), '91');
      // A palette of one brand never shows up under another.
      expect(
        h.savedPalettes
            .listedFor(MarkerBrand.ohuhuOahu)
            .last
            .showsBrandsUnder('ohuhu_oahu'),
        isFalse,
      );

      // The list of a brand follows a save under another brand.
      final seen = <List<String>>[];
      final subscription = h.savedPalettes
          .watchListed(MarkerBrand.decoTime)
          .listen((list) => seen.add([for (final p in list) p.id]));
      var changes = 0;
      final all = h.savedPalettes.changes.listen((_) => changes++);
      await pumpEventQueue();
      expect(seen.single, ['mix', 'deco']);
      await h.savedPalettes.save(mixed('mix2', 4));
      await pumpEventQueue();
      expect(seen.last, ['mix2', 'mix', 'deco']);
      expect(changes, 1);
      // It is deleted under the brand it is stored with, and leaves both lists.
      await h.savedPalettes.delete(MarkerBrand.ohuhuOahu, 'mix');
      await pumpEventQueue();
      expect(seen.last, ['mix2', 'deco']);
      expect(listed(MarkerBrand.ohuhuOahu), ['mix2', 'ohuhu']);
      await subscription.cancel();
      await all.cancel();
    },
  );

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
