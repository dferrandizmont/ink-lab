import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';

import 'fixtures.dart';

/// Regression: "Bad state: Stream has already been listened to." The
/// repository streams were `async*` getters, so a widget that kept the stream
/// and subscribed again after being unmounted (tab switch, lazy list) crashed.
void main() {
  test('app settings changes can be listened to again and again', () async {
    final h = await harness();
    final Stream<AppSettingsState> stream = h.appSettings.changes;

    for (var i = 0; i < 3; i++) {
      final AppSettingsState first = await stream.first;
      expect(first.brand, h.appSettings.brand);
    }
    // Two live listeners at the same time, both see the next change.
    final List<AppSettingsState> a = <AppSettingsState>[];
    final List<AppSettingsState> b = <AppSettingsState>[];
    final subA = stream.listen(a.add);
    final subB = stream.listen(b.add);
    await Future<void>.delayed(Duration.zero);
    await h.appSettings.setBrand(MarkerBrand.decoTime);
    await Future<void>.delayed(Duration.zero);
    expect(a.last.brand, MarkerBrand.decoTime);
    expect(b.last.brand, MarkerBrand.decoTime);
    await subA.cancel();
    await subB.cancel();
  });

  test('settingsChanges can be listened to again and again', () async {
    final h = await harness();
    final Stream<AppSettings> stream = h.appSettings.settingsChanges;
    for (var i = 0; i < 3; i++) {
      await stream.first;
    }
  });

  test('ai settings changes replay the current value every time', () async {
    final h = await harness();
    await h.aiSettings.setTextModel('m-1');
    final stream = h.aiSettings.changes;
    for (var i = 0; i < 3; i++) {
      expect((await stream.first).textModel, 'm-1');
    }
  });

  test('match history changes can be listened to again and again', () async {
    final h = await harness();
    await h.history.record(pick());
    final stream = h.history.changes;
    for (var i = 0; i < 3; i++) {
      expect(await stream.first, hasLength(1));
    }
  });

  test('saved palette watch can be listened to again and again', () async {
    final h = await harness();
    await h.savedPalettes.save(palette());
    final stream = h.savedPalettes.watch(MarkerBrand.ohuhuOahu);
    for (var i = 0; i < 3; i++) {
      expect(await stream.first, hasLength(1));
    }
    final List<List<SavedPalette>> seen = <List<SavedPalette>>[];
    final sub = stream.listen(seen.add);
    await Future<void>.delayed(Duration.zero);
    await h.savedPalettes.save(palette(id: 'p2', name: 'Other'));
    await Future<void>.delayed(Duration.zero);
    expect(seen.last, hasLength(2));
    await sub.cancel();
  });
}
