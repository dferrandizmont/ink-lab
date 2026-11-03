import 'dart:convert';
import 'dart:io';
import 'dart:ui' show Locale;

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/ideas_engine.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/data/idea_widget_sync.dart';

import '../support/l10n.dart';

MarkerRepository _markers() =>
    MarkerRepository(loadAsset: (String path) => File(path).readAsStringSync());

/// A sync over in-memory stores that records what it writes.
({IdeaWidgetSync sync, List<String> writes, AppSettingsRepository settings})
_rig({
  AppLanguage language = AppLanguage.english,
  bool? enabled,
  IdeaWidgetWriter? writer,
  List<Locale> device = const <Locale>[Locale('en', 'US')],
}) {
  final InMemoryKeyValueStore store = InMemoryKeyValueStore();
  final StoredAppSettingsRepository settings = StoredAppSettingsRepository(
    store,
    initial: AppScope.previewSettings().copyWith(language: language),
  );
  final List<String> writes = <String>[];
  final MarkerRepository markers = _markers();
  final StoredOwnColorRepository ownColors = StoredOwnColorRepository(store);
  markers.ownColors = OwnColorOverlay(settings: settings, colors: ownColors);
  final IdeaWidgetSync sync = IdeaWidgetSync(
    settings: settings,
    markers: markers,
    ownColors: ownColors,
    dried: StoredDriedMarkerRepository(store),
    writer: writer ?? (String json) async => writes.add(json),
    enabled: enabled,
    deviceLocales: () => device,
    debounce: Duration.zero,
  );
  return (sync: sync, writes: writes, settings: settings);
}

Map<String, Object?> _decode(String json) =>
    jsonDecode(json) as Map<String, Object?>;

/// The Kotlin widget's way of choosing the day's idea (`IdeaWidgetProvider`):
/// the days since the epoch from a plain civil-date count, no time zones.
int _kotlinIndex(DateTime day, int count) {
  int daysFromCivil(int y, int m, int d) {
    final int yy = m <= 2 ? y - 1 : y;
    final int era = (yy >= 0 ? yy : yy - 399) ~/ 400;
    final int yoe = yy - era * 400;
    final int doy = (153 * (m > 2 ? m - 3 : m + 9) + 2) ~/ 5 + d - 1;
    final int doe = yoe * 365 + yoe ~/ 4 - yoe ~/ 100 + doy;
    return era * 146097 + doe - 719468;
  }

  final int days =
      daysFromCivil(day.year, day.month, day.day) - daysFromCivil(2024, 1, 1);
  return ((days % count) + count) % count;
}

void main() {
  group('the widget JSON', () {
    test('lists every idea in the catalogue order, with the epoch', () async {
      final rig = _rig();
      await rig.sync.sync();
      final Map<String, Object?> json = _decode(rig.writes.single);

      expect(json['epoch'], '2024-01-01');
      final List<Object?> items = json['items']! as List<Object?>;
      expect(items.length, IdeasEngine.presets.length);
      expect(
        <Object?>[for (final Object? i in items) (i! as Map)['id']],
        <String>[for (final IdeaPreset p in IdeasEngine.presets) p.id],
      );
      final Map<Object?, Object?> first = items.first! as Map;
      expect(
        first.keys,
        containsAll(<String>[
          'id',
          'title',
          'summary',
          'category',
          'minutes',
          'colors',
        ]),
      );
      expect(first['minutes'], IdeasEngine.presets.first.minutes);
    });

    test('colours are #RRGGBB, at most five, from the user markers', () async {
      final rig = _rig();
      await rig.sync.sync();
      final List<Object?> items =
          _decode(rig.writes.single)['items']! as List<Object?>;
      final RegExp hex = RegExp(r'^#[0-9A-F]{6}$');
      var withColors = 0;
      for (final Object? item in items) {
        final List<Object?> colors = (item! as Map)['colors']! as List<Object?>;
        expect(colors.length, lessThanOrEqualTo(5));
        for (final Object? c in colors) {
          expect(c, matches(hex));
        }
        if (colors.isNotEmpty) withColors++;
      }
      expect(withColors, greaterThan(0));
    });

    test('texts follow the app language and the minutes pattern', () {
      final List<MarkerColor> none = <MarkerColor>[];
      for (final (AppLocalizations l, String label, String fmt)
          in <(AppLocalizations, String, String)>[
            (l10n, 'Idea of the day', '{n} min'),
            (l10nEs, 'Idea del día', '{n} min'),
            (l10nDe, 'Idee des Tages', '{n} Min.'),
          ]) {
        final Map<String, Object?> json = _decode(
          buildIdeaWidgetJson(l10n: l, candidates: none),
        );
        expect(json['label'], label);
        expect(json['minutesFmt'], fmt);
        final Map<Object?, Object?> first =
            (json['items']! as List<Object?>).first! as Map;
        expect(first['title'], l.ideaTitle(IdeasEngine.presets.first));
        expect(first['summary'], l.ideaSummary(IdeasEngine.presets.first));
      }
      expect(
        l10nEs.ideaTitle(IdeasEngine.presets.first),
        isNot(l10n.ideaTitle(IdeasEngine.presets.first)),
      );
    });

    test('a forced language wins; "system" follows the device', () async {
      final es = _rig(language: AppLanguage.spanish);
      await es.sync.sync();
      expect(_decode(es.writes.single)['label'], 'Idea del día');

      final system = _rig(
        language: AppLanguage.system,
        device: const <Locale>[Locale('ca'), Locale('de', 'AT')],
      );
      await system.sync.sync();
      expect(_decode(system.writes.single)['label'], 'Idee des Tages');

      expect(
        ideaWidgetLocale(AppLanguage.system, const <Locale>[Locale('ja')]),
        const Locale('en'),
      );
    });

    test('catalogue hex values are normalised or dropped', () {
      expect(ideaWidgetHex('ffcc00'), '#FFCC00');
      expect(ideaWidgetHex('#ffcc00'), '#FFCC00');
      expect(ideaWidgetHex('ffcc0'), isNull);
      expect(ideaWidgetHex('zzzzzz'), isNull);
    });
  });

  group("today's idea", () {
    test('the Kotlin day count picks the same idea as featuredFor', () {
      final int count = IdeasEngine.presets.length;
      for (
        DateTime d = DateTime(2024);
        d.isBefore(DateTime(2032));
        d = DateTime(d.year, d.month, d.day + 1)
      ) {
        expect(
          IdeasEngine.presets[_kotlinIndex(d, count)].id,
          IdeasEngine.featuredFor(d).id,
          reason: '$d',
        );
      }
    });
  });

  group('the sync', () {
    test('does nothing off Android unless a writer is injected', () async {
      var called = false;
      final InMemoryKeyValueStore store = InMemoryKeyValueStore();
      final StoredAppSettingsRepository settings = StoredAppSettingsRepository(
        store,
        initial: AppScope.previewSettings(),
      );
      // No writer: the host running the tests is not Android, so the real
      // (plugin) writer is never reached.
      final IdeaWidgetSync sync = IdeaWidgetSync(
        settings: settings,
        markers: _markers(),
        ownColors: StoredOwnColorRepository(store),
        dried: StoredDriedMarkerRepository(store),
      );
      expect(sync.enabled, isFalse);
      await sync.sync();
      sync.start(observeLifecycle: false);
      await sync.dispose();

      final rig = _rig(
        enabled: false,
        writer: (String json) async => called = true,
      );
      await rig.sync.sync();
      rig.sync.start(observeLifecycle: false);
      expect(called, isFalse);
    });

    test('swallows a failing writer', () async {
      final rig = _rig(
        writer: (String json) async => throw StateError('no widget'),
      );
      await rig.sync.sync();
    });

    test('swallows a catalogue that cannot load', () async {
      final InMemoryKeyValueStore store = InMemoryKeyValueStore();
      final StoredAppSettingsRepository settings = StoredAppSettingsRepository(
        store,
        initial: AppScope.previewSettings(),
      );
      final List<String> writes = <String>[];
      final IdeaWidgetSync sync = IdeaWidgetSync(
        settings: settings,
        markers: MarkerRepository(
          loadAsset: (String path) => throw const FileSystemException('x'),
        ),
        ownColors: StoredOwnColorRepository(store),
        dried: StoredDriedMarkerRepository(store),
        writer: (String json) async => writes.add(json),
      );
      await sync.sync();
      // The ideas are still written, only without colours.
      final List<Object?> items =
          _decode(writes.single)['items']! as List<Object?>;
      expect(items, isNotEmpty);
    });

    test('writes at start and again when the language changes', () async {
      final rig = _rig();
      rig.sync.start(observeLifecycle: false);
      await Future<void>.delayed(const Duration(milliseconds: 200));
      expect(rig.writes, isNotEmpty);
      expect(_decode(rig.writes.last)['label'], 'Idea of the day');

      await rig.settings.setLanguage(AppLanguage.spanish);
      await Future<void>.delayed(const Duration(milliseconds: 200));
      expect(_decode(rig.writes.last)['label'], 'Idea del día');
      await rig.sync.dispose();
    });
  });
}
