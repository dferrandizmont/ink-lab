import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';

import 'fixtures.dart';

void main() {
  test('stores a colour per marker and survives a reopen', () async {
    final h = await harness();
    await h.ownColors.set('R1', '#AABBCC');
    await h.ownColors.set('decotime:01', 'f0a');

    expect(h.ownColors.colors, {
      'decotime:01': 'ff00aa',
      'ohuhu_oahu:R1': 'aabbcc',
    });
    expect(h.ownColors.hexOf('r1'), 'aabbcc');
    expect(h.ownColors.hexOf('ohuhu_oahu:R1'), 'aabbcc');
    expect(h.ownColors.hexOf('G1'), isNull);

    final reopened = StoredOwnColorRepository(h.store);
    await reopened.load();
    expect(reopened.colors, h.ownColors.colors);
  });

  test('uses a single JSON object under one key', () async {
    final h = await harness();
    await h.ownColors.set('R1', 'aabbcc');
    final raw = await h.store.getString(StoredOwnColorRepository.key);
    expect(jsonDecode(raw!), {'ohuhu_oahu:R1': 'aabbcc'});
  });

  test('ignores a value that is not a colour or a marker id', () async {
    final h = await harness();
    await h.ownColors.set('R1', 'not a colour');
    await h.ownColors.set(':', 'aabbcc');
    await h.ownColors.set('', 'aabbcc');
    expect(h.ownColors.colors, isEmpty);
    expect(await h.store.containsKey(StoredOwnColorRepository.key), isFalse);
  });

  test('remove and clear go back to the catalogue and leave no key', () async {
    final h = await harness();
    await h.ownColors.set('R1', 'aabbcc');
    await h.ownColors.set('G1', '112233');
    await h.ownColors.remove('R1');
    expect(h.ownColors.colors.keys, ['ohuhu_oahu:G1']);
    await h.ownColors.remove('not-there');
    expect(h.ownColors.colors.keys, ['ohuhu_oahu:G1']);

    await h.ownColors.clear();
    expect(h.ownColors.colors, isEmpty);
    expect(await h.store.containsKey(StoredOwnColorRepository.key), isFalse);
  });

  test('counts the colours of a brand', () async {
    final h = await harness();
    await h.ownColors.set('R1', 'aabbcc');
    await h.ownColors.set('G1', '112233');
    await h.ownColors.set('decotime:01', '445566');
    expect(h.ownColors.countOf(MarkerBrand.ohuhuOahu), 2);
    expect(h.ownColors.countOf(MarkerBrand.decoTime), 1);
  });

  test('the revision goes up on every change', () async {
    final h = await harness();
    final start = h.ownColors.revision;
    await h.ownColors.set('R1', 'aabbcc');
    expect(h.ownColors.revision, start + 1);
    await h.ownColors.clear();
    expect(h.ownColors.revision, start + 2);
  });

  test('replays the current colours, then every change', () async {
    final h = await harness();
    await h.ownColors.set('R1', 'aabbcc');
    final seen = <Map<String, String>>[];
    final sub = h.ownColors.changes.listen(seen.add);
    await Future<void>.delayed(Duration.zero);
    await h.ownColors.set('G1', '112233');
    await Future<void>.delayed(Duration.zero);
    await sub.cancel();

    expect(seen.first, {'ohuhu_oahu:R1': 'aabbcc'});
    expect(seen.last.keys, ['ohuhu_oahu:G1', 'ohuhu_oahu:R1']);
    // A late listener starts from the current value too.
    expect(await h.ownColors.changes.first, seen.last);
  });

  test('restore replaces everything and cleans the input', () async {
    final h = await harness();
    await h.ownColors.set('R1', 'aabbcc');
    await h.ownColors.restore({'g1': '#123', 'bad': 'zz', 'B1': 'ABCDEF'});
    expect(h.ownColors.colors, {
      'ohuhu_oahu:B1': 'abcdef',
      'ohuhu_oahu:G1': '112233',
    });
  });

  test('a corrupt stored value is a typed error', () async {
    final store = InMemoryKeyValueStore({
      StoredOwnColorRepository.key: '[1, 2]',
    });
    await expectLater(
      StoredOwnColorRepository(store).load(),
      throwsA(isA<DataStoreException>()),
    );
    final garbage = InMemoryKeyValueStore({
      StoredOwnColorRepository.key: '{nope',
    });
    await expectLater(
      StoredOwnColorRepository(garbage).load(),
      throwsA(isA<DataStoreException>()),
    );
  });

  test('entries with odd types in the store are skipped', () async {
    final store = InMemoryKeyValueStore({
      StoredOwnColorRepository.key: '{"R1": "aabbcc", "G1": 5, "B1": "xyz"}',
    });
    final repo = StoredOwnColorRepository(store);
    await repo.load();
    expect(repo.colors, {'ohuhu_oahu:R1': 'aabbcc'});
  });

  group('Use my colours', () {
    test('is on by default and persists', () async {
      final h = await harness();
      expect(h.appSettings.state.useOwnColors, isTrue);
      await h.appSettings.setUseOwnColors(false);

      final reopened = StoredAppSettingsRepository(h.store);
      await reopened.load();
      expect(reopened.state.useOwnColors, isFalse);
    });

    test('is part of the settings wire shape and old files read as on', () {
      expect(
        AppSettingsState(useOwnColors: false).toJson()['useOwnColors'],
        isFalse,
      );
      expect(AppSettingsState.fromJson(const {}).useOwnColors, isTrue);
      expect(
        AppSettingsState.fromJson(const {'useOwnColors': false}).useOwnColors,
        isFalse,
      );
    });

    test(
      'the overlay serves the colours only while the switch is on',
      () async {
        final h = await harness();
        final overlay = OwnColorOverlay(
          settings: h.appSettings,
          colors: h.ownColors,
        );
        expect(overlay.activeOwnColors, isEmpty);

        await h.ownColors.set('R1', 'aabbcc');
        expect(overlay.activeOwnColors, {'ohuhu_oahu:R1': 'aabbcc'});
        final on = overlay.revision;

        await h.appSettings.setUseOwnColors(false);
        expect(overlay.activeOwnColors, isEmpty);
        expect(overlay.revision, isNot(on));

        await h.appSettings.setUseOwnColors(true);
        expect(overlay.revision, on);
        await h.ownColors.set('G1', '112233');
        expect(overlay.revision, isNot(on));
      },
    );
  });
}
