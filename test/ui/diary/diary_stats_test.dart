import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/pages/diary/artwork_entry_page.dart';
import 'package:ink_lab/ui/pages/diary/diary_stats_page.dart';
import 'package:ink_lab/ui/share/diary_entry_card_layout.dart';
import 'package:ink_lab/ui/share/share_sink.dart';
import 'package:ink_lab/ui/widgets/color_swatch_tile.dart';

import '../../support/fake_share_sink.dart';
import '../../support/l10n.dart';
import 'diary_test_support.dart';

const String _b08 = 'ohuhu_oahu:B08';
const String _r012 = 'ohuhu_oahu:R012';

Future<List<MarkerColor>> _owned(AppScope scope) async {
  final List<MarkerColor> catalog = await scope.markers.loadColors(
    MarkerBrand.ohuhuOahu,
  );
  return ownedColors(
    colors: catalog,
    brand: MarkerBrand.ohuhuOahu,
    ownedSetIds: scope.settings.settings.effectiveSetIds(),
    ownedMarkerCodes: scope.settings.settings.ownedMarkerCodes,
  );
}

/// Saves the entries and a palette the entries link to.
Future<void> Function(AppScope) _seed(List<ArtworkEntry> entries) =>
    (AppScope scope) async {
      await scope.savedPalettes.save(
        savedPalette(codes: const <String>['B08', 'R012']),
      );
      for (final ArtworkEntry e in entries) {
        await scope.artworkDiary.save(e);
      }
    };

final List<ArtworkEntry> _entries = <ArtworkEntry>[
  entry(
    id: 'a',
    title: 'Forest',
    date: DateTime(2026, 10, 30),
    markerIds: const <String>[_b08, _r012],
    paletteId: 'p1',
  ),
  entry(
    id: 'b',
    title: 'Sea',
    date: DateTime(2026, 10, 12),
    status: ArtworkStatus.inProgress,
    markerIds: const <String>[_b08],
    paletteId: 'p1',
  ),
  entry(id: 'c', title: 'Sketch', date: DateTime(2026, 9, 3)),
];

/// Lets the real asynchronous rendering finish (the image encoder runs off
/// the test's fake clock) until [done] holds, then settles the widgets.
Future<void> _until(WidgetTester tester, bool Function() done) async {
  await tester.runAsync(() async {
    for (int i = 0; i < 600 && !done(); i++) {
      await Future<void>.delayed(const Duration(milliseconds: 50));
      await tester.pump();
    }
    await Future<void>.delayed(const Duration(milliseconds: 100));
    await tester.pump();
  });
  await tester.pump();
  await tester.pumpAndSettle();
}

/// Opens the entry form header's "More actions" menu.
Future<void> _openMenu(WidgetTester tester) async {
  await tester.tap(find.byTooltip(l10n.commonMoreActions));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await loadAppFonts();
  });

  group('the diary summary card', () {
    testWidgets('is not there while the diary is empty', (
      WidgetTester tester,
    ) async {
      await pumpDiary(tester);
      expect(key('diary-stats-card'), findsNothing);
    });

    testWidgets('counts the entries and the markers used most', (
      WidgetTester tester,
    ) async {
      await pumpDiary(tester, setup: _seed(_entries));
      expect(key('diary-stats-card'), findsOneWidget);
      expect(
        find.text(
          '${l10n.diaryStatsArtworks(3)} · ${l10n.diaryStatsFinished(2)} · '
          '${l10n.diaryStatsInProgress(1)}',
        ),
        findsOneWidget,
      );
      // B08 is in two entries, R012 in one.
      expect(
        find.descendant(
          of: key('diary-stats-card'),
          matching: find.text('× 2'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: key('diary-stats-card'),
          matching: find.byType(SwatchBlock),
        ),
        findsNWidgets(2),
      );
      expect(find.text(l10n.diaryStatsOpen), findsOneWidget);
    });

    testWidgets('leaves out a count of zero', (WidgetTester tester) async {
      await pumpDiary(tester, setup: _seed(<ArtworkEntry>[entry(id: 'only')]));
      expect(
        find.text(
          '${l10n.diaryStatsArtworks(1)} · ${l10n.diaryStatsFinished(1)}',
        ),
        findsOneWidget,
      );
    });

    testWidgets('opens the diary numbers', (WidgetTester tester) async {
      await pumpDiary(tester, setup: _seed(_entries));
      await tester.tap(key('diary-stats-card'));
      await tester.pumpAndSettle();
      expect(find.byKey(DiaryStatsPage.pageKey), findsOneWidget);
      expect(find.text(l10n.diaryStatsTitle), findsOneWidget);
    });
  });

  group('the diary numbers', () {
    testWidgets('list the months, the markers and the palettes', (
      WidgetTester tester,
    ) async {
      await pumpDiaryPage(
        tester,
        const DiaryStatsPage(),
        setup: _seed(_entries),
      );
      expect(find.text(l10n.diaryStatsFinished(2)), findsOneWidget);
      expect(find.text(l10n.diaryStatsInProgress(1)), findsOneWidget);
      // Newest month first, two entries in October and one in September.
      expect(key('diary-stats-month-2026-10'), findsOneWidget);
      expect(key('diary-stats-month-2026-09'), findsOneWidget);
      expect(
        tester.getTopLeft(key('diary-stats-month-2026-10')).dy,
        lessThan(tester.getTopLeft(key('diary-stats-month-2026-09')).dy),
      );
      expect(
        find.descendant(
          of: key('diary-stats-month-2026-10'),
          matching: find.text('2'),
        ),
        findsOneWidget,
      );
      // The markers: B08 (2 entries) before R012 (1 entry).
      expect(key('diary-stats-marker-$_b08'), findsOneWidget);
      expect(
        tester.getTopLeft(key('diary-stats-marker-$_b08')).dy,
        lessThan(tester.getTopLeft(key('diary-stats-marker-$_r012')).dy),
      );
      expect(
        find.descendant(
          of: key('diary-stats-marker-$_b08'),
          matching: find.text(l10n.diaryStatsEntries(2)),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: key('diary-stats-marker-$_b08'),
          matching: find.text('B08'),
        ),
        findsOneWidget,
      );
      // The palette linked twice, once the folded block is opened.
      expect(key('diary-stats-palettes-toggle'), findsOneWidget);
      await tester.ensureVisible(key('diary-stats-palettes'));
      await tester.pumpAndSettle();
      expect(key('diary-stats-palettes-list'), findsNothing);
      await tester.tap(key('diary-stats-palettes-toggle'));
      await tester.pumpAndSettle();
      expect(key('diary-stats-palettes-list'), findsOneWidget);
      expect(key('diary-stats-palette-p1'), findsOneWidget);
      expect(
        find.descendant(
          of: key('diary-stats-palette-p1'),
          matching: find.text('Sunrise'),
        ),
        findsOneWidget,
      );
      expect(find.text(l10n.diaryStatsMonthsLatest(12)), findsNothing);
    });

    testWidgets('leaves the palettes folded until asked', (
      WidgetTester tester,
    ) async {
      await pumpDiaryPage(
        tester,
        const DiaryStatsPage(),
        setup: _seed(_entries),
      );
      await tester.ensureVisible(key('diary-stats-palettes'));
      await tester.pumpAndSettle();
      expect(key('diary-stats-palettes-toggle'), findsOneWidget);
      expect(key('diary-stats-palettes-list'), findsNothing);
      expect(key('diary-stats-palette-p1'), findsNothing);

      await tester.tap(key('diary-stats-palettes-toggle'));
      await tester.pumpAndSettle();
      expect(key('diary-stats-palettes-list'), findsOneWidget);
      expect(key('diary-stats-palette-p1'), findsOneWidget);
    });

    testWidgets('show only the latest twelve months', (
      WidgetTester tester,
    ) async {
      await pumpDiaryPage(
        tester,
        const DiaryStatsPage(),
        setup: _seed(<ArtworkEntry>[
          for (int m = 0; m < 14; m++)
            entry(id: 'm$m', date: DateTime(2025, 1 + m, 5)),
        ]),
      );
      expect(find.text(l10n.diaryStatsMonthsLatest(12)), findsOneWidget);
      expect(key('diary-stats-month-2026-02'), findsOneWidget);
      expect(key('diary-stats-month-2025-02'), findsNothing);
    });

    testWidgets('say so when no entry has markers or a palette', (
      WidgetTester tester,
    ) async {
      await pumpDiaryPage(
        tester,
        const DiaryStatsPage(),
        setup: _seed(<ArtworkEntry>[entry(id: 'plain')]),
      );
      expect(find.text(l10n.diaryStatsMarkersEmpty), findsOneWidget);
      expect(find.text(l10n.diaryStatsPalettesEmpty), findsOneWidget);
    });

    testWidgets('leave out a palette that was deleted', (
      WidgetTester tester,
    ) async {
      await pumpDiaryPage(
        tester,
        const DiaryStatsPage(),
        setup: (AppScope scope) => scope.artworkDiary.save(
          entry(id: 'gone', paletteId: 'deleted-long-ago'),
        ),
      );
      expect(find.text(l10n.diaryStatsPalettesEmpty), findsOneWidget);
    });

    testWidgets('an empty diary says it is empty', (WidgetTester tester) async {
      await pumpDiaryPage(tester, const DiaryStatsPage());
      expect(find.text(l10n.diaryEmptyMessage), findsOneWidget);
      expect(key('diary-stats-months'), findsNothing);
    });

    testWidgets('count the owned markers never used, list on request', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await pumpDiaryPage(
        tester,
        const DiaryStatsPage(),
        setup: _seed(_entries),
      );
      final List<MarkerColor> owned = await _owned(scope);
      expect(owned, isNotEmpty);
      final int used = owned
          .where((MarkerColor c) => c.colorId == _b08 || c.colorId == _r012)
          .length;
      final int unused = owned.length - used;
      expect(unused, greaterThan(0));
      await tester.ensureVisible(key('diary-stats-unused'));
      await tester.pumpAndSettle();
      expect(find.text(l10n.diaryStatsUnusedCount(unused)), findsOneWidget);
      expect(key('diary-stats-unused-list'), findsNothing);

      await tester.tap(key('diary-stats-unused-toggle'));
      await tester.pumpAndSettle();
      expect(key('diary-stats-unused-list'), findsOneWidget);
      expect(find.text(l10n.diaryStatsUnusedHide), findsOneWidget);
      expect(
        find.descendant(
          of: key('diary-stats-unused-list'),
          matching: find.byType(SwatchBlock),
        ),
        findsNWidgets(unused),
      );

      await tester.tap(key('diary-stats-unused-toggle'));
      await tester.pumpAndSettle();
      expect(key('diary-stats-unused-list'), findsNothing);
    });

    testWidgets('say so when every owned marker is in an entry', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await pumpDiaryPage(
        tester,
        const DiaryStatsPage(),
      );
      final List<MarkerColor> owned = await _owned(scope);
      await scope.artworkDiary.save(
        entry(
          id: 'all',
          markerIds: <String>[for (final MarkerColor c in owned) c.colorId],
        ),
      );
      await tester.pumpAndSettle();
      await tester.ensureVisible(key('diary-stats-unused'));
      await tester.pumpAndSettle();
      expect(find.text(l10n.diaryStatsUnusedNone), findsOneWidget);
      expect(key('diary-stats-unused-toggle'), findsNothing);
    });
  });

  group('sharing an entry as an image', () {
    testWidgets('does nothing until the entry has a title', (
      WidgetTester tester,
    ) async {
      final FakeShareSink sink = FakeShareSink();
      await pumpDiaryPage(tester, ArtworkEntryPage(shareSink: sink));
      await _openMenu(tester);
      await tester.tap(key('diary-share'));
      await tester.pumpAndSettle();
      expect(sink.shared, isEmpty, reason: 'no title, nothing to share');

      await tester.enterText(key('diary-title'), 'Forest page');
      await tester.pumpAndSettle();
      await _openMenu(tester);
      await tester.tap(key('diary-share'));
      await _until(tester, () => sink.shared.isNotEmpty);
      expect(sink.shared, hasLength(1));
    });

    testWidgets('renders the entry and opens the share sheet on tap only', (
      WidgetTester tester,
    ) async {
      final FakeShareSink sink = FakeShareSink();
      await pumpDiaryPage(
        tester,
        ArtworkEntryPage(entry: _entries.first, shareSink: sink),
        setup: _seed(_entries),
      );
      await tester.pump(const Duration(seconds: 1));
      expect(sink.shared, isEmpty, reason: 'nothing leaves without a tap');

      await _openMenu(tester);
      await tester.tap(key('diary-share'));
      await _until(tester, () => sink.shared.isNotEmpty);

      expect(sink.shared, hasLength(1));
      expect(sink.shared.single, hasLength(1));
      final ShareImage image = sink.shared.single.single;
      expect(image.name, 'ink-lab-diary.png');
      final ({int width, int height}) size = pngSize(image.bytes)!;
      expect(size.width, 1080);
      // Two markers and a palette of two colours, no photo, no "painted on".
      expect(
        size.height,
        DiaryEntryCardLayout(
          titleLines: 1,
          hasOnWhat: false,
          hasPhoto: false,
          markerCount: 2,
          hasMore: false,
          paletteColors: 2,
        ).height.round(),
      );
      expect(sink.subjects.single, 'Forest');
      expect(find.byType(SnackBar), findsNothing);
    });

    testWidgets('puts the first photo in the image', (
      WidgetTester tester,
    ) async {
      final ({
        StoredArtworkDiaryRepository diary,
        InMemoryArtworkPhotoStore photos,
      })
      stores = newDiary();
      final String photo = await stores.diary.addPhoto(tinyPng);

      Future<int> heightOf(ArtworkEntry e) async {
        final FakeShareSink sink = FakeShareSink();
        await pumpDiaryPage(
          tester,
          ArtworkEntryPage(
            key: ValueKey<String>(e.id),
            entry: e,
            shareSink: sink,
          ),
          diary: stores.diary,
        );
        await _openMenu(tester);
        await tester.tap(key('diary-share'));
        await _until(tester, () => sink.shared.isNotEmpty);
        return pngSize(sink.shared.single.single.bytes)!.height;
      }

      final int with_ = await heightOf(entry(id: 'w', photos: <String>[photo]));
      final int without = await heightOf(entry(id: 'n'));
      expect(
        with_ - without,
        (DiaryEntryCardLayout.photoHeight + DiaryEntryCardLayout.blockGap)
            .round(),
      );
    });

    testWidgets('says so when the image cannot be shared', (
      WidgetTester tester,
    ) async {
      final FakeShareSink sink = FakeShareSink(fail: true);
      await pumpDiaryPage(
        tester,
        ArtworkEntryPage(entry: entry(), shareSink: sink),
      );
      await _openMenu(tester);
      await tester.tap(key('diary-share'));
      await _until(tester, () => find.byType(SnackBar).evaluate().isNotEmpty);
      expect(key('diary-share-failed'), findsOneWidget);
      expect(find.text(l10n.shareFailed), findsOneWidget);
    });
  });
}
