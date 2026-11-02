import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/palette_card_layout.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/pages/collection/collection_page.dart';
import 'package:ink_lab/ui/share/share_sink.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/widgets/ink_button.dart';

import '../../support/fake_share_sink.dart';
import '../../support/l10n.dart';
import '../palette/palette_test_support.dart';

Finder _key(String key) => find.byKey(ValueKey<String>(key));

/// Lets the real asynchronous rendering finish (the image encoder runs off
/// the test's fake clock), then settles the widgets.
Future<void> _untilShared(WidgetTester tester, FakeShareSink sink) async {
  await tester.runAsync(() async {
    for (int i = 0; i < 600 && sink.shared.isEmpty; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 50));
      // The page started the work on the test's fake clock: pumping lets its
      // continuations run.
      await tester.pump();
    }
    // The page then clears its busy state.
    await Future<void>.delayed(const Duration(milliseconds: 100));
    await tester.pump();
  });
  await tester.pump();
  await tester.pumpAndSettle();
}

/// Like [_untilShared], for a share that fails: waits for [finder].
Future<void> _untilFound(WidgetTester tester, Finder finder) async {
  await tester.runAsync(() async {
    for (int i = 0; i < 600; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 50));
      await tester.pump();
      if (finder.evaluate().isNotEmpty) break;
    }
  });
  await tester.pumpAndSettle();
}

MarkerRepository _markers() =>
    MarkerRepository(loadAsset: (String path) => File(path).readAsStringSync());

Future<AppScope> _pumpCollection(
  WidgetTester tester,
  FakeShareSink sink, {
  AppSettingsState? state,
}) async {
  tester.view.physicalSize = const Size(412, 900);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  final AppScope scope = AppScope.inMemory(
    markers: _markers(),
    settingsState: state,
    child: MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      theme: AppTheme.light(),
      home: CollectionPage(shareSink: sink),
    ),
  );
  await tester.pumpWidget(scope);
  await tester.pumpAndSettle();
  return scope;
}

/// Opens the folded "Printable swatch chart" card of My collection (spec §2.6):
/// the switch and the share button live inside.
Future<void> _openChart(WidgetTester tester) async {
  await tester.ensureVisible(_key('collection-chart'));
  await tester.pumpAndSettle();
  await tester.tap(_key('collection-chart'));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(loadAppFonts);

  group('Palette: Share', () {
    testWidgets('is offered only once there is a palette', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester, shareSink: FakeShareSink());
      expect(_key('palette-overflow'), findsNothing);
      await enterBaseCode(tester, 'B08');
      // Share lives in the result's "⋯" now, which appears with a result.
      expect(_key('palette-overflow'), findsOneWidget);
      await tester.tap(_key('palette-overflow'));
      await tester.pumpAndSettle();
      expect(_key('palette-share'), findsOneWidget);
      await closeSheet(tester);
    });

    testWidgets('renders the palette on screen and opens the share sheet', (
      WidgetTester tester,
    ) async {
      final FakeShareSink sink = FakeShareSink();
      await pumpPalette(tester, shareSink: sink);
      await enterBaseCode(tester, 'B08');

      await tapResultItem(tester, 'palette-share', settle: false);
      await _untilShared(tester, sink);

      expect(sink.shared, hasLength(1));
      final ShareImage image = sink.shared.single.single;
      expect(image.name, 'ink-lab-palette.png');
      final ({int width, int height})? size = pngSize(image.bytes);
      expect(size?.width, 1080);
      // The base and four companions (the default size of five).
      expect(size?.height, PaletteCardLayout(5).height.round());
      expect(sink.subjects.single, l10n.modeLabel(PaletteMode.recommended));
    });

    testWidgets('a scene palette is titled with the scene', (
      WidgetTester tester,
    ) async {
      final FakeShareSink sink = FakeShareSink();
      await pumpPalette(tester, shareSink: sink);
      await choosePaletteType(tester, 'palette-scenario-toggle');
      await tapResultItem(tester, 'palette-share', settle: false);
      await _untilShared(tester, sink);

      expect(sink.shared, hasLength(1));
      expect(
        sink.subjects.single,
        isNot(l10n.modeLabel(PaletteMode.recommended)),
      );
      expect(sink.subjects.single, isNotEmpty);
    });

    testWidgets('a saved palette is shared with its own name', (
      WidgetTester tester,
    ) async {
      final FakeShareSink sink = FakeShareSink();
      await pumpPalette(
        tester,
        shareSink: sink,
        setup: (AppScope scope) => scope.savedPalettes.save(
          SavedPalette(
            id: 'p1',
            name: 'Stored sky',
            baseCode: 'B08',
            baseName: 'Cotton Candy Blue',
            mode: PaletteMode.triad,
            paletteSize: 3,
            createdAtEpochMs: 1,
            colorCodes: const <String>['B08', '120', 'BV19'],
          ),
        ),
      );
      await openSavedPalettesSheet(tester);
      await tapOverflowItem(
        tester,
        'palette-saved-menu-p1',
        'palette-share-p1',
        settle: false,
      );
      await _untilShared(tester, sink);

      expect(sink.subjects.single, 'Stored sky');
      expect(
        pngSize(sink.shared.single.single.bytes)?.height,
        PaletteCardLayout(3).height.round(),
      );
    });

    testWidgets('a failure shows a notice instead of crashing', (
      WidgetTester tester,
    ) async {
      final FakeShareSink sink = FakeShareSink(fail: true);
      await pumpPalette(tester, shareSink: sink);
      await enterBaseCode(tester, 'B08');
      await tapResultItem(tester, 'palette-share', settle: false);
      await _untilFound(tester, _key('palette-share-failed'));

      expect(_key('palette-share-failed'), findsOneWidget);
      expect(find.text(l10n.shareFailed), findsOneWidget);
    });
  });

  group('My collection: printable swatch chart', () {
    testWidgets('shares every page at once, in A4', (
      WidgetTester tester,
    ) async {
      final FakeShareSink sink = FakeShareSink();
      await _pumpCollection(tester, sink);

      await tester.ensureVisible(_key('collection-chart'));
      await tester.pumpAndSettle();
      // Oahu 160 plus one extra marker, 36 per page.
      expect(
        find.text(
          '${l10n.collectionMarkers(161)} · ${l10n.collectionChartPages(5)}',
        ),
        findsOneWidget,
      );
      await _openChart(tester);
      await tester.ensureVisible(_key('collection-chart-share'));
      await tester.pumpAndSettle();
      await tester.tap(_key('collection-chart-share'));
      await tester.pump();
      await _untilShared(tester, sink);

      expect(sink.shared, hasLength(1));
      final List<ShareImage> pages = sink.shared.single;
      expect(pages, hasLength(5));
      for (final ShareImage page in pages) {
        expect(pngSize(page.bytes)?.width, 2480);
        expect(pngSize(page.bytes)?.height, 3508);
      }
      expect(pages.first.name, 'ink-lab-ohuhu-chart-1-of-5.png');
      expect(find.text(l10n.collectionChartCreate), findsOneWidget);
    });

    testWidgets('the catalogue colour switch is off by default', (
      WidgetTester tester,
    ) async {
      await _pumpCollection(tester, FakeShareSink());
      await _openChart(tester);
      expect(find.text(l10n.collectionChartShowColour), findsOneWidget);
      final Finder toggled = find.descendant(
        of: _key('collection-chart-colour'),
        matching: find.byWidgetPredicate(
          (Widget w) => w is Semantics && w.properties.toggled == true,
        ),
      );
      expect(toggled, findsNothing);
      await tester.tap(_key('collection-chart-colour'));
      await tester.pumpAndSettle();
      expect(toggled, findsWidgets);
    });

    testWidgets('with no markers the button is off and says why', (
      WidgetTester tester,
    ) async {
      final FakeShareSink sink = FakeShareSink();
      final AppScope scope = await _pumpCollection(tester, sink);
      await scope.settings.setBrand(MarkerBrand.decoTime);
      await tester.pumpAndSettle();
      await _openChart(tester);

      expect(find.text(l10n.collectionChartEmpty), findsOneWidget);
      expect(
        tester.widget<InkButton>(_key('collection-chart-share')).onPressed,
        isNull,
      );
    });

    testWidgets('a failure shows a notice', (WidgetTester tester) async {
      await _pumpCollection(tester, FakeShareSink(fail: true));
      await _openChart(tester);
      await tester.ensureVisible(_key('collection-chart-share'));
      await tester.pumpAndSettle();
      await tester.tap(_key('collection-chart-share'));
      await tester.pump();
      await _untilFound(tester, _key('collection-chart-failed'));
      expect(_key('collection-chart-failed'), findsOneWidget);
    });
  });
}
