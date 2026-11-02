import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/ui/icons/ink_icons.dart';
import 'package:ink_lab/ui/pages/swatches/swatch_detail_sheet.dart';
import 'package:ink_lab/ui/pages/swatches/swatches_page.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/theme/app_typography.dart';
import 'package:ink_lab/ui/widgets/color_swatch_tile.dart';
import 'package:ink_lab/ui/widgets/ink_button.dart';
import 'package:ink_lab/ui/widgets/ink_chip.dart';
import 'package:ink_lab/ui/widgets/ink_overflow_menu.dart';
import 'package:ink_lab/ui/widgets/ink_sheet.dart';
import 'package:ink_lab/ui/widgets/swatch_list_tile.dart';

import '../../support/l10n.dart';

/// A marker repository that reads the real datasets from disk.
///
/// The read is synchronous on purpose: a widget test runs in a fake-async
/// zone where real file I/O never completes.
MarkerRepository diskMarkers() =>
    MarkerRepository(loadAsset: (String path) => File(path).readAsStringSync());

/// Pumps the swatch page over an in-memory scope and returns the scope, so
/// the test can drive the repositories directly.
Future<AppScope> pumpSwatches(
  WidgetTester tester, {
  ThemeData? theme,
  Size size = const Size(390, 844),
  Locale locale = const Locale('en'),
  bool showAll = true,
  ValueChanged<MarkerColor>? onBlendingChain,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  final AppScope scope = AppScope.inMemory(
    markers: diskMarkers(),
    child: SwatchesPage(onBlendingChain: onBlendingChain),
  );
  await tester.pumpWidget(
    MaterialApp(
      locale: locale,
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      theme: theme ?? AppTheme.light(),
      // The shell hosts the page inside its own Scaffold.
      home: Scaffold(body: scope),
    ),
  );
  await tester.pumpAndSettle();
  // The preview collection opens the page on "Mine"; most tests browse the
  // whole range.
  if (showAll) {
    await tester.tap(
      find.text(lookupAppLocalizations(locale).swatchesAllFilter),
    );
    await tester.pumpAndSettle();
  }
  return scope;
}

/// Opens the filters sheet (the chip reads `Filters` or `Filters · n`).
Future<void> openFilters(WidgetTester tester) async {
  final Finder chip = find.textContaining(l10n.swatchesFilters);
  await tester.ensureVisible(chip);
  await tester.pumpAndSettle();
  await tester.tap(chip);
  await tester.pumpAndSettle();
}

/// Opens the collapsible pack section of the filters sheet.
Future<void> openPackSection(WidgetTester tester, AppLocalizations t) async {
  // Closed, the header shows the current choice ("All packs").
  final Finder header = find.text(t.swatchesAllPacks);
  expect(header, findsOneWidget, reason: 'the pack list starts closed');
  await tester.ensureVisible(header);
  await tester.pumpAndSettle();
  await tester.tap(header);
  await tester.pumpAndSettle();
}

/// Opens the detail sheet of a swatch.
Future<void> openDetail(WidgetTester tester, [String code = 'B08']) async {
  await tester.tap(find.text(code));
  await tester.pumpAndSettle();
}

/// The scrollable of the detail sheet.
Finder sheetScroll(WidgetTester tester) => find
    .descendant(of: find.byType(InkSheet), matching: find.byType(Scrollable))
    .first;

/// Something inside the detail sheet (the page behind it may show it too).
Finder inSheet(Finder finder) =>
    find.descendant(of: find.byType(InkSheet), matching: finder);

/// Scrolls the sheet back to its top.
Future<void> scrollSheetToTop(WidgetTester tester) async {
  tester.state<ScrollableState>(sheetScroll(tester)).position.jumpTo(0);
  await tester.pumpAndSettle();
}

/// Scrolls the sheet until [finder] is on screen.
Future<void> scrollSheetTo(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(finder, 200, scrollable: sheetScroll(tester));
  await tester.pumpAndSettle();
}

/// Opens one of the disclosures of the sheet, by its key.
Future<void> openSheetDisclosure(WidgetTester tester, String key) async {
  final Finder header = find.byKey(ValueKey<String>(key));
  await scrollSheetTo(tester, header);
  await tester.tap(header);
  await tester.pumpAndSettle();
}

/// Opens the "⋯" menu of the sheet.
Future<void> openSheetMenu(WidgetTester tester) async {
  await tester.tap(find.byTooltip(l10n.commonMoreActions));
  await tester.pumpAndSettle();
}

/// Brings the sheet to the full height, its content at the top.
Future<void> expandSheet(WidgetTester tester) async {
  if (tester.getTopLeft(find.byType(InkSheet)).dy <= 2) return;
  await tester.drag(sheetScroll(tester), const Offset(0, -600));
  await tester.pumpAndSettle();
}

/// The result rows of a group of the "In other brands" section.
Finder brandRows(Finder group) => find.descendant(
  of: group,
  matching: find.byWidgetPredicate(
    (Widget w) =>
        w.key is ValueKey<String> &&
        (w.key! as ValueKey<String>).value.startsWith('swatch-equivalent-'),
  ),
);

/// The owned checks of the grid cells.
Finder _ownedChecks() => find.byWidgetPredicate(
  (Widget w) => w is InkIcon && w.icon == InkIcons.check,
);

/// Opens the detail sheet of [marker] on its own, in the real frame of the
/// sheet (the "⋯" menu and the ✕), at [size] and with the text at [scale].
///
/// The marker is not read from the catalogue, so the test can use a long
/// German name.
Future<void> openDetailSheetFor(
  WidgetTester tester,
  MarkerColor marker, {
  Size size = const Size(360, 740),
  double scale = 1.3,
  Locale locale = const Locale('de'),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(
      locale: locale,
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      theme: AppTheme.light(),
      builder: (BuildContext context, Widget? child) => MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(textScaler: TextScaler.linear(scale)),
        child: child!,
      ),
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) => TextButton(
            onPressed: () => showInkDraggableSheet<void>(
              context: context,
              actions: <Widget>[
                InkOverflowMenu(
                  key: const ValueKey<String>('swatch-overflow'),
                  items: <InkMenuItem>[
                    InkMenuItem(label: l10nDe.swatchesCopyHex, onSelected: () {}),
                  ],
                ),
              ],
              builder: (BuildContext context, ScrollController scroll) =>
                  SwatchDetailSheet(
                    color: marker,
                    favorite: false,
                    onToggleFavorite: () {},
                    onCopyHex: () {},
                    scrollController: scroll,
                  ),
            ),
            child: const Text('open'),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(loadAppFonts);

  testWidgets('the page shows the collection of the active brand', (
    WidgetTester tester,
  ) async {
    await pumpSwatches(tester);

    expect(find.byKey(SwatchesPage.pageKey), findsOneWidget);
    expect(find.text(l10n.swatchesTitle), findsOneWidget);
    // B08 belongs to the classic 160 pack, the default selection.
    expect(find.text('B08'), findsOneWidget);
    expect(find.byType(ColorSwatchTile), findsWidgets);
    // The brand is Ohuhu (Oahu is a series). The subtitle says no number:
    // the count of the range is on the title line.
    expect(find.text('Ohuhu · Oahu'), findsOneWidget);
    expect(find.textContaining('markers'), findsNothing);
  });

  testWidgets('the grid leaves the hex out and the list keeps it', (
    WidgetTester tester,
  ) async {
    await pumpSwatches(tester);

    // B08 is #82DCFA: the grid shows the code and the name, not the hex.
    expect(find.text('#82DCFA'), findsNothing);

    await openFilters(tester);
    await tester.tap(find.text(l10n.swatchesLayoutList));
    await tester.pumpAndSettle();

    // The list row keeps the hex.
    expect(find.text('#82DCFA'), findsOneWidget);
  });

  testWidgets('the owned check of the grid only shows with "All"', (
    WidgetTester tester,
  ) async {
    await pumpSwatches(tester);

    // The whole range: the owned markers carry the check.
    expect(_ownedChecks(), findsWidgets);

    await tester.tap(find.byKey(const ValueKey<String>('swatches-mine')));
    await tester.pumpAndSettle();
    // Every cell would carry it, so it says nothing: it is gone.
    expect(_ownedChecks(), findsNothing);

    await tester.tap(find.text(l10n.swatchesAllFilter));
    await tester.pumpAndSettle();
    expect(_ownedChecks(), findsWidgets);
  });

  testWidgets('the search filters the collection by code', (
    WidgetTester tester,
  ) async {
    await pumpSwatches(tester);

    await tester.enterText(find.byType(TextField), 'B08');
    await tester.pumpAndSettle();

    expect(
      find.descendant(
        of: find.byType(ColorSwatchTile),
        matching: find.text('B08'),
      ),
      findsOneWidget,
    );
    expect(find.byType(ColorSwatchTile), findsOneWidget);
  });

  testWidgets('the search filters the collection by name', (
    WidgetTester tester,
  ) async {
    await pumpSwatches(tester);

    await tester.enterText(find.byType(TextField), 'cotton');
    await tester.pumpAndSettle();

    expect(find.text('B08'), findsOneWidget);
    expect(find.text('B010'), findsNothing);
  });

  testWidgets('the search also finds a colour by its old code', (
    WidgetTester tester,
  ) async {
    await pumpSwatches(tester);

    await tester.enterText(find.byType(TextField), 'B289');
    await tester.pumpAndSettle();

    expect(find.text('B08'), findsOneWidget);
    expect(find.byType(ColorSwatchTile), findsOneWidget);
  });

  testWidgets('the search also matches the hex value', (
    WidgetTester tester,
  ) async {
    await pumpSwatches(tester);

    await tester.enterText(find.byType(TextField), '#82dcfa');
    await tester.pumpAndSettle();

    expect(find.text('B08'), findsOneWidget);
    expect(find.byType(ColorSwatchTile), findsOneWidget);
  });

  testWidgets('a search without results shows the empty state', (
    WidgetTester tester,
  ) async {
    await pumpSwatches(tester);

    await tester.enterText(find.byType(TextField), 'zzzz');
    await tester.pumpAndSettle();

    expect(find.text(l10n.swatchesEmptySearchTitle), findsOneWidget);
  });

  testWidgets('clear filters in the empty state restores the grid', (
    WidgetTester tester,
  ) async {
    await pumpSwatches(tester);

    await tester.enterText(find.byType(TextField), 'zzzz');
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.swatchesClearFilters));
    await tester.pumpAndSettle();

    expect(find.text(l10n.swatchesEmptySearchTitle), findsNothing);
    expect(find.byType(ColorSwatchTile), findsWidgets);
  });

  testWidgets('the filters sheet holds view filters only', (
    WidgetTester tester,
  ) async {
    await pumpSwatches(tester);

    await openFilters(tester);
    // Name display lives in Settings only.
    expect(find.text(l10n.swatchesOldLabels), findsNothing);
    expect(find.text(l10n.swatchesLayoutList), findsOneWidget);
  });

  testWidgets('a swatch opens a detail sheet with its values', (
    WidgetTester tester,
  ) async {
    await pumpSwatches(tester);

    await openDetail(tester);

    expect(find.text(l10n.swatchesAddToPalette), findsOneWidget);
    expect(find.text(l10n.commonOldCode('B289')), findsOneWidget);
    // 82dcfa is the hex of B08.
    expect(inSheet(find.text('#82DCFA')), findsOneWidget);
    expect(find.text(l10n.swatchesClosestAlternatives), findsOneWidget);
    expect(find.textContaining('ΔE '), findsWidgets);
    // The RGB line is gone: the hex says it all.
    expect(find.text(l10n.commonRgb(130, 220, 250)), findsNothing);
  });

  testWidgets('the detail sheet offers a blending chain when the shell can '
      'open one', (WidgetTester tester) async {
    // Standalone, without the shell, there is nowhere to send it.
    await pumpSwatches(tester);
    await openDetail(tester);
    await openSheetMenu(tester);
    expect(find.text(l10n.swatchesBlendingChain), findsNothing);
  });

  testWidgets('the blending chain action closes the sheet and hands the '
      'marker over', (WidgetTester tester) async {
    final List<MarkerColor> asked = <MarkerColor>[];
    await pumpSwatches(tester, onBlendingChain: asked.add);

    await openDetail(tester);
    await openSheetMenu(tester);
    expect(find.text(l10n.swatchesBlendingChain), findsOneWidget);
    await tester.tap(
      find.byKey(const ValueKey<String>('swatch-blending-chain')),
    );
    await tester.pumpAndSettle();

    expect(asked.map((MarkerColor c) => c.newCode), <String>['B08']);
    expect(find.text(l10n.swatchesCopyHex), findsNothing);
  });

  testWidgets('a closest alternative opens its own detail', (
    WidgetTester tester,
  ) async {
    await pumpSwatches(tester);

    await openDetail(tester);
    // The alternatives are closed: only the best one is on screen.
    expect(find.bySemanticsLabel(RegExp(r', delta E \d+\.\d$')), findsNothing);
    await openSheetDisclosure(tester, 'swatch-alternatives');
    final Finder alternative = find.bySemanticsLabel(
      RegExp(r', delta E \d+\.\d$'),
    );
    expect(alternative, findsNWidgets(3));
    await tester.tap(alternative.first);
    await tester.pumpAndSettle();

    expect(find.text(l10n.swatchesAddToPalette), findsOneWidget);
    expect(find.text(l10n.commonOldCode('B289')), findsNothing);
  });

  testWidgets('the favorite button stores the swatch as a favorite', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpSwatches(tester);

    await tester.tap(find.text('B08'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip(l10n.swatchesAddFavorite));
    await tester.pumpAndSettle();

    expect(scope.settings.favorites, contains('ohuhu_oahu:B08'));
    expect(scope.settings.isFavorite('ohuhu_oahu:B08'), isTrue);
  });

  testWidgets('the favorites filter only shows the favorite swatches', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpSwatches(tester);
    await scope.settings.setFavorites(<String>{'ohuhu_oahu:B08'});
    await tester.pumpAndSettle();

    await tester.tap(find.text(l10n.swatchesFavoritesOnly));
    await tester.pumpAndSettle();

    expect(find.text('B08'), findsOneWidget);
    expect(find.text('B010'), findsNothing);
  });

  testWidgets('"Mine" shows the owned sets plus the extra markers', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpSwatches(tester);
    await scope.settings.setCollection(
      AppSettings(extraMarkerIds: <String>{'B08'}),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text(l10n.swatchesOwnedOnly));
    await tester.pumpAndSettle();
    expect(find.byType(ColorSwatchTile), findsOneWidget);
    expect(find.text('B08'), findsOneWidget);
    expect(find.text('1 of 503'), findsOneWidget);

    await tester.tap(find.text(l10n.swatchesAllFilter));
    await tester.pumpAndSettle();
    expect(find.byType(ColorSwatchTile), findsWidgets);
    expect(find.text('B010'), findsOneWidget);
  });

  testWidgets('a pack chip in the filters sheet narrows the collection', (
    WidgetTester tester,
  ) async {
    await pumpSwatches(tester);

    expect(find.text('B08'), findsOneWidget);

    await openFilters(tester);
    // The packs of every line live in a collapsed section.
    expect(find.text('120 New'), findsNothing);
    await openPackSection(tester, l10n);
    await tester.ensureVisible(find.text('120 New'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('120 New'));
    await tester.pumpAndSettle();
    expect(find.text('Filters · 1'), findsOneWidget);

    // B03 only belongs to the new 120 pack, B08 only to the classic packs.
    expect(find.text('B03'), findsOneWidget);
    expect(find.text('B08'), findsNothing);
  });

  testWidgets('the line filter narrows the swatches to one product line', (
    WidgetTester tester,
  ) async {
    await pumpSwatches(tester);
    // B010 is in the classic 160 pack and sold in Oahu and Kaala only.
    expect(find.text('B010'), findsOneWidget);
    expect(find.text('B08'), findsOneWidget);

    await openFilters(tester);
    await tester.tap(find.widgetWithText(InkChip, 'Honolulu'));
    await tester.pumpAndSettle();
    expect(find.text('Filters · 1'), findsOneWidget);
    expect(find.text('B08'), findsOneWidget);
    expect(find.text('B010'), findsNothing);

    // Lines are a multi-select: adding Kaala brings B010 back.
    await tester.tap(find.widgetWithText(InkChip, 'Kaala'));
    await tester.pumpAndSettle();
    expect(find.text('B010'), findsOneWidget);

    await tester.tap(find.text(l10n.swatchesAllLines));
    await tester.pumpAndSettle();
    expect(find.text('Filters · 1'), findsNothing);
  });

  testWidgets('the line filter limits the packs offered in its section', (
    WidgetTester tester,
  ) async {
    await pumpSwatches(tester);

    await openFilters(tester);
    await tester.tap(find.widgetWithText(InkChip, 'Kaala'));
    await tester.pumpAndSettle();
    await openPackSection(tester, l10n);

    // Under its line caption a pack needs no line prefix.
    expect(find.text('60 Illustration'), findsOneWidget);
    expect(find.text(AppTypography.caps('Honolulu')), findsNothing);
    expect(find.text('Classic 160'), findsNothing);
  });

  testWidgets('the legacy packs sit under their own caption', (
    WidgetTester tester,
  ) async {
    await pumpSwatches(tester);

    await openFilters(tester);
    await openPackSection(tester, l10n);

    expect(find.text(l10n.swatchesLegacyPacks), findsWidgets);
    await tester.ensureVisible(find.text('White Case 24 (V1)'));
    expect(find.text('White Case 24 (V1)'), findsOneWidget);
  });

  for (final Locale locale in const <Locale>[Locale('en'), Locale('es')]) {
    testWidgets('the filters sheet fits 360 dp (${locale.languageCode})', (
      WidgetTester tester,
    ) async {
      final AppLocalizations t = lookupAppLocalizations(locale);
      await pumpSwatches(tester, size: const Size(360, 740), locale: locale);

      final Finder chip = find.textContaining(t.swatchesFilters);
      await tester.tap(chip);
      await tester.pumpAndSettle();
      expect(find.text(t.swatchesAllLines), findsOneWidget);
      expect(find.widgetWithText(InkChip, 'Honolulu'), findsOneWidget);

      await openPackSection(tester, t);
      // Every chip stays inside the 360 dp sheet.
      for (final Element chipElement in find.byType(InkChip).evaluate()) {
        final RenderBox box = chipElement.renderObject! as RenderBox;
        final Rect rect = box.localToGlobal(Offset.zero) & box.size;
        expect(rect.left, greaterThanOrEqualTo(0));
        expect(rect.right, lessThanOrEqualTo(360));
      }
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('the detail sheet lists the lines of the colour', (
    WidgetTester tester,
  ) async {
    await pumpSwatches(tester);

    await openDetail(tester);
    await openSheetDisclosure(tester, 'swatch-details');

    expect(find.text(AppTypography.caps(l10n.swatchesLines)), findsOneWidget);
    expect(find.text('Oahu, Honolulu, Kaala'), findsOneWidget);
    // A colour in two dozen packs names a few and counts the rest.
    expect(find.textContaining('more'), findsOneWidget);
  });

  for (final brand in [
    MarkerBrand.decoTime,
    MarkerBrand.copic,
    MarkerBrand.finecolour,
  ]) {
    testWidgets(
      '${brand.label} without owned markers: All browses, Mine explains',
      (WidgetTester tester) async {
        final AppScope scope = await pumpSwatches(tester);

        await scope.settings.setBrand(brand);
        await tester.pumpAndSettle();
        // The whole range is browsable before owning anything.
        expect(find.byType(ColorSwatchTile), findsWidgets);

        await tester.tap(find.byKey(const ValueKey<String>('swatches-mine')));
        await tester.pumpAndSettle();
        expect(find.text(l10n.swatchesEmptyNoOwnedTitle), findsOneWidget);
        expect(find.text(l10n.swatchesEmptyNoOwnedBody), findsOneWidget);
        expect(find.byType(ColorSwatchTile), findsNothing);
      },
    );

    testWidgets('the owned ${brand.label} markers show up as swatches', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await pumpSwatches(tester);

      await scope.settings.setBrand(brand);
      await scope.settings.setOwnedMarkerCodes(<String>{
        brand == MarkerBrand.finecolour
            ? 'finecolour:BV321'
            : brand == MarkerBrand.copic
            ? 'copic:BV04'
            : 'decotime:GG9',
      });
      await tester.pumpAndSettle();

      // A brand with owned markers opens on "Mine".
      expect(
        find.text(
          brand == MarkerBrand.finecolour
              ? 'BV321'
              : brand == MarkerBrand.copic
              ? 'BV04'
              : 'GG9',
        ),
        findsOneWidget,
      );
      expect(find.byType(ColorSwatchTile), findsOneWidget);
    });
  }

  testWidgets('the list layout shows one row per color', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpSwatches(tester);
    await scope.settings.setNameDisplayMode(NameDisplayMode.both);
    await tester.pumpAndSettle();

    await openFilters(tester);
    await tester.tap(find.text(l10n.swatchesLayoutList));
    await tester.pumpAndSettle();

    expect(find.byType(ColorSwatchTile), findsNothing);
    expect(find.byType(SwatchListTile), findsWidgets);
    expect(find.text('B08 / B289'), findsOneWidget);
  });

  testWidgets('the grid shows only the current name, never "new / old"', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpSwatches(tester);
    await scope.settings.setNameDisplayMode(NameDisplayMode.both);
    await tester.pumpAndSettle();

    expect(find.byType(ColorSwatchTile), findsWidgets);
    expect(find.textContaining(' / '), findsNothing);
  });

  testWidgets('with no collection a slim notice offers to set it up', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpSwatches(tester);
    final Finder notice = find.text(l10n.swatchesWholeRangeNotice('DecoTime'));
    expect(notice, findsNothing);

    await scope.settings.setBrand(MarkerBrand.decoTime);
    await tester.pumpAndSettle();
    expect(notice, findsOneWidget);
    expect(find.text(l10n.swatchesWholeRangeAction), findsOneWidget);

    await scope.settings.setOwnedMarkerCodes(<String>{'decotime:GG9'});
    await tester.pumpAndSettle();
    expect(notice, findsNothing);
  });

  testWidgets('the page and its sheet render in the dark theme', (
    WidgetTester tester,
  ) async {
    await pumpSwatches(tester, theme: AppTheme.dark());

    expect(find.byKey(SwatchesPage.pageKey), findsOneWidget);
    expect(find.byType(ColorSwatchTile), findsWidgets);
    await openDetail(tester);
    expect(find.text(l10n.swatchesAddToPalette), findsOneWidget);
    expect(find.byType(QualityBadge), findsNothing);
  });

  testWidgets('the detail sheet shows the swatch card of the active pack', (
    WidgetTester tester,
  ) async {
    await pumpSwatches(tester);

    await openDetail(tester);
    await openSheetDisclosure(tester, 'swatch-details');

    expect(find.text(l10n.swatchesLocation.toUpperCase()), findsOneWidget);
    expect(find.textContaining('Swatch card '), findsOneWidget);
  });

  testWidgets('the card locations are declared as an asset', (
    WidgetTester tester,
  ) async {
    final String pubspec = File('pubspec.yaml').readAsStringSync();
    expect(pubspec, contains('assets/data/oahu_card_locations.json'));
    final Map<String, Map<String, int>> catalog = await diskMarkers()
        .loadCardLocations();
    expect(catalog['classic_160'], isNotEmpty);
  });

  group('the detail sheet', () {
    testWidgets('opens at half the height and can be dragged to the full '
        'screen', (WidgetTester tester) async {
      await pumpSwatches(tester);

      await openDetail(tester);

      // Half of the 844 dp of the test phone.
      expect(
        tester.getTopLeft(find.byType(InkSheet)).dy,
        moreOrLessEquals(422, epsilon: 2),
      );

      await expandSheet(tester);
      expect(
        tester.getTopLeft(find.byType(InkSheet)).dy,
        moreOrLessEquals(0, epsilon: 2),
      );
    });

    testWidgets('the favourite sits on the line of the name', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await pumpSwatches(tester);

      await openDetail(tester);

      final Rect name = tester.getRect(inSheet(find.text('Cotton Candy Blue')));
      final Rect star = tester.getRect(
        find.byTooltip(l10n.swatchesAddFavorite),
      );
      expect((star.center.dy - name.center.dy).abs(), lessThanOrEqualTo(8));

      await tester.tap(find.byTooltip(l10n.swatchesAddFavorite));
      await tester.pumpAndSettle();
      expect(scope.settings.isFavorite('ohuhu_oahu:B08'), isTrue);
      expect(find.byTooltip(l10n.swatchesRemoveFavorite), findsOneWidget);
    });

    testWidgets('the star never sits under the "⋯" or the ✕ of the frame', (
      WidgetTester tester,
    ) async {
      // The worst case: the smallest phone, big text and a long name.
      await openDetailSheetFor(
        tester,
        MarkerColor(
          newCode: 'B08',
          newName: 'Kobaltblau Metallic Nachfuellfarbe',
          oldCode: 'B08',
          oldName: 'Kobaltblau Metallic Nachfuellfarbe',
          hex: '#EE315E',
          sets: const <String>[],
        ),
      );

      final Rect star = tester.getRect(
        find.byTooltip(l10nDe.swatchesAddFavorite),
      );
      final Rect overflow = tester.getRect(
        find.byKey(const ValueKey<String>('swatch-overflow')),
      );
      final Rect close = tester.getRect(find.byTooltip(l10nDe.commonClose));

      expect(
        star.overlaps(overflow),
        isFalse,
        reason: 'the star is under the "⋯" of the frame',
      );
      expect(
        star.overlaps(close),
        isFalse,
        reason: 'the star is under the ✕ of the frame',
      );
    });

    testWidgets('the "⋯" menu holds the actions of this marker', (
      WidgetTester tester,
    ) async {
      await pumpSwatches(tester, onBlendingChain: (_) {});
      await openDetail(tester);
      await openSheetMenu(tester);

      // The active brand: copy the hex, the blending chain, the wishlist and
      // the dried-out mark (the marker is in the default collection).
      expect(find.text(l10n.swatchesCopyHex), findsOneWidget);
      expect(find.text(l10n.swatchesBlendingChain), findsOneWidget);
      expect(find.text(l10n.wishlistAdd), findsOneWidget);
      expect(find.text(l10n.driedMark), findsOneWidget);
      // It has no colour of its own.
      expect(find.text(l10n.swatchesMyColourReset), findsNothing);
    });

    testWidgets('an owned marker offers the dried-out mark', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await pumpSwatches(tester);
      await scope.settings.setOwnedMarkerCodes(<String>{'ohuhu_oahu:B08'});
      await tester.pumpAndSettle();

      await openDetail(tester);
      // The status line says it.
      expect(find.text(l10n.commonOwned), findsOneWidget);

      await openSheetMenu(tester);
      expect(find.text(l10n.driedMark), findsOneWidget);
    });

    testWidgets('a marker of another brand offers the wishlist, not the '
        'palette', (WidgetTester tester) async {
      await pumpSwatches(tester);
      await openDetail(tester);
      await expandSheet(tester);
      // The group of another brand, and its best match.
      final Finder group = find.byKey(
        const ValueKey<String>('swatch-equivalents-copic'),
      );
      await scrollSheetTo(tester, group);
      await tester.tap(group);
      await tester.pumpAndSettle();
      await tester.tap(brandRows(group).first);
      await tester.pumpAndSettle();

      // The palette is for the active brand only: the wishlist takes over.
      expect(find.text(l10n.swatchesAddToPalette), findsNothing);
      expect(find.text(l10n.wishlistAdd), findsOneWidget);
      expect(
        find.byKey(const ValueKey<String>('swatch-other-brand-note')),
        findsOneWidget,
      );

      // The wishlist is the primary action, so it is not in the menu.
      await openSheetMenu(tester);
      expect(
        find.byKey(const ValueKey<String>('swatch-menu-wishlist')),
        findsNothing,
      );
      expect(find.text(l10n.swatchesCopyHex), findsOneWidget);
      // The marker of the other brand is not owned: no dried-out mark.
      expect(find.text(l10n.driedMark), findsNothing);
    });

    testWidgets('tapping the hex copies it', (WidgetTester tester) async {
      // The clipboard is a platform channel: without a mock the copy never
      // finishes inside the test.
      String? copied;
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (MethodCall call) async {
          if (call.method == 'Clipboard.setData') {
            copied =
                (call.arguments as Map<Object?, Object?>)['text'] as String;
          }
          return null;
        },
      );
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          null,
        ),
      );

      await pumpSwatches(tester);

      await openDetail(tester);
      await tester.tap(inSheet(find.text('#82DCFA')));
      await tester.pumpAndSettle();

      expect(copied, '#82DCFA');
      expect(find.text(l10n.swatchesHexCopied), findsOneWidget);
    });

    testWidgets('the sheet has one primary action and no quality badge', (
      WidgetTester tester,
    ) async {
      await pumpSwatches(tester);

      await openDetail(tester);

      expect(find.byType(InkButton), findsOneWidget);
      expect(
        find.byKey(const ValueKey<String>('swatch-primary')),
        findsOneWidget,
      );
      expect(find.byType(QualityBadge), findsNothing);
    });

    testWidgets('the groups of the other brands start closed', (
      WidgetTester tester,
    ) async {
      await pumpSwatches(tester);
      await openDetail(tester);
      await expandSheet(tester);

      final Finder group = find.byKey(
        const ValueKey<String>('swatch-equivalents-copic'),
      );
      await scrollSheetTo(tester, group);
      // The best match of the brand is on screen...
      expect(group, findsOneWidget);
      // ...but its three results are not.
      expect(brandRows(group), findsNothing);

      await tester.tap(group);
      await tester.pumpAndSettle();
      expect(brandRows(group), findsNWidgets(3));
    });

    testWidgets('choosing an alternative takes the sheet back to the top', (
      WidgetTester tester,
    ) async {
      await pumpSwatches(tester);
      await openDetail(tester);
      await openSheetDisclosure(tester, 'swatch-alternatives');

      final ScrollableState state = tester.state(sheetScroll(tester));
      state.position.jumpTo(80);
      await tester.pumpAndSettle();
      expect(state.position.pixels, greaterThan(0));

      final Finder alternative = find.bySemanticsLabel(
        RegExp(r', delta E \d+\.\d$'),
      );
      await tester.tap(alternative.first);
      await tester.pumpAndSettle();

      expect(state.position.pixels, 0);
    });
  });

  group('my colour', () {
    Finder tileWithOwnColor() => find.byWidgetPredicate(
      (Widget w) => w is ColorSwatchTile && w.ownColor,
    );

    Future<void> openDetail(WidgetTester tester) async {
      await tester.tap(find.text('B08'));
      await tester.pumpAndSettle();
    }

    Future<void> saveOwnColor(WidgetTester tester, String hex) async {
      await tester.tap(
        find.byKey(const ValueKey<String>('swatch-my-colour-row')),
      );
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey<String>('own-color-hex')),
        hex,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey<String>('own-color-save')));
      await tester.pumpAndSettle();
    }

    SwatchDetailSheet sheetOf(WidgetTester tester) =>
        tester.widget<SwatchDetailSheet>(find.byType(SwatchDetailSheet));

    testWidgets('the detail sets, shows both colours and resets', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await pumpSwatches(tester);
      await openDetail(tester);

      expect(find.text(l10n.swatchesMyColourTitle), findsOneWidget);
      // The row says the marker still has the colour of the catalogue.
      expect(find.text(l10n.swatchesMyColourSame), findsOneWidget);
      // The help of the editor lives in the editor now.
      expect(find.text(l10n.swatchesMyColourHelp), findsNothing);

      await saveOwnColor(tester, '0a0b0c');

      expect(scope.ownColors.colors, <String, String>{
        'ohuhu_oahu:B08': '0a0b0c',
      });
      expect(find.byType(SwatchDetailSheet), findsOneWidget);
      expect(find.text(l10n.swatchesMyColourSaved), findsOneWidget);
      // The row shows the colour the user stored.
      expect(find.text(l10n.swatchesMyColourValue('#0A0B0C')), findsOneWidget);
      expect(find.text('#0A0B0C'), findsWidgets);
      expect(sheetOf(tester).color.hex, '0a0b0c');
      expect(sheetOf(tester).color.hasOwnColor, isTrue);

      // The way back to the catalogue colour is in the menu now.
      await openSheetMenu(tester);
      await tester.tap(find.byKey(const ValueKey<String>('swatch-own-reset')));
      await tester.pumpAndSettle();
      expect(scope.ownColors.colors, isEmpty);
      expect(find.text(l10n.swatchesMyColourWasReset), findsOneWidget);
      expect(find.text(l10n.swatchesMyColourSame), findsOneWidget);
      expect(sheetOf(tester).color.hasOwnColor, isFalse);
    });

    testWidgets('leaving the editor without saving changes nothing', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await pumpSwatches(tester);
      await openDetail(tester);
      await tester.tap(
        find.byKey(const ValueKey<String>('swatch-my-colour-row')),
      );
      await tester.pumpAndSettle();
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(scope.ownColors.colors, isEmpty);
      expect(find.byType(SwatchDetailSheet), findsOneWidget);
    });

    testWidgets('the grid and the list mark the user own colours', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await pumpSwatches(tester);
      expect(tileWithOwnColor(), findsNothing);

      await scope.ownColors.set('B08', '0a0b0c');
      await tester.pumpAndSettle();
      expect(tileWithOwnColor(), findsOneWidget);
      expect(tester.widget<ColorSwatchTile>(tileWithOwnColor()).hex, '0a0b0c');
      expect(find.byType(OwnColorMark), findsOneWidget);

      // Switched off, the catalogue colour is shown and nothing is marked.
      await scope.settings.setUseOwnColors(false);
      await tester.pumpAndSettle();
      expect(tileWithOwnColor(), findsNothing);
      expect(find.byType(OwnColorMark), findsNothing);
      await scope.settings.setUseOwnColors(true);
      await tester.pumpAndSettle();

      // The list marks it too.
      await openFilters(tester);
      await tester.tap(find.text(l10n.swatchesLayoutList));
      await tester.pumpAndSettle();
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();
      expect(
        find.byWidgetPredicate((Widget w) => w is SwatchListTile && w.ownColor),
        findsOneWidget,
      );
    });

    testWidgets('saving the catalogue colour goes back to the catalogue', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await pumpSwatches(tester);
      final String catalogue = scope.markers
          .peekColors(MarkerBrand.ohuhuOahu)!
          .firstWhere((MarkerColor c) => c.newCode == 'B08')
          .hex;
      await scope.ownColors.set('B08', '0a0b0c');
      await tester.pumpAndSettle();
      await openDetail(tester);

      await saveOwnColor(tester, catalogue.toUpperCase());

      expect(scope.ownColors.colors, isEmpty);
      expect(find.text(l10n.swatchesMyColourSame), findsOneWidget);
    });

    testWidgets('saving one switches "Use my colours" on', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await pumpSwatches(tester);
      await scope.settings.setUseOwnColors(false);
      await tester.pumpAndSettle();
      await openDetail(tester);

      await saveOwnColor(tester, '0a0b0c');

      expect(scope.settings.state.useOwnColors, isTrue);
      expect(sheetOf(tester).color.hex, '0a0b0c');
    });

    testWidgets('the alternatives are measured with the own colours', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await pumpSwatches(tester);
      await openDetail(tester);
      final MarkerColor first = sheetOf(tester).alternatives.first.color;
      expect(first.hasOwnColor, isFalse);
      // The sheet may reach the top of the screen: close it, do not tap outside.
      Navigator.of(tester.element(find.byType(SwatchDetailSheet))).pop();
      await tester.pumpAndSettle();

      // The user's colour for that neighbour is far from B08: it drops out.
      await scope.ownColors.set(first.newCode, '001122');
      await tester.pumpAndSettle();
      await openDetail(tester);
      expect(
        sheetOf(tester).alternatives
            .map((SwatchAlternative a) => a.color.newCode),
        isNot(contains(first.newCode)),
      );
    });
  });

  for (final Locale locale in const <Locale>[Locale('en'), Locale('es')]) {
    testWidgets('the header total counts the brand range, not every '
        'dataset (${locale.languageCode})', (WidgetTester tester) async {
      final AppLocalizations t = lookupAppLocalizations(locale);
      final MarkerRepository repo = diskMarkers();
      final List<MarkerColor> all = (await tester.runAsync(
        () => repo.loadColors(MarkerBrand.ohuhuOahu),
      ))!;
      final int range = swatchCandidateColors(
        colors: all,
        brand: MarkerBrand.ohuhuOahu,
      ).length;

      final AppScope scope = await pumpSwatches(tester, locale: locale);

      // "All" is the whole Ohuhu range.
      expect(find.text(t.swatchesCountOf(range, range)), findsOneWidget);

      // The search narrows the visible count; the total stays put.
      await tester.enterText(find.byType(TextField), 'B08');
      await tester.pumpAndSettle();
      expect(find.text(t.swatchesCountOf(1, range)), findsOneWidget);

      // DecoTime: the whole DecoTime range, even with a single owned marker.
      await tester.enterText(find.byType(TextField), '');
      await scope.settings.setBrand(MarkerBrand.decoTime);
      await scope.settings.setOwnedMarkerCodes(<String>{'decotime:GG9'});
      await tester.pumpAndSettle();
      await tester.tap(find.text(t.swatchesAllFilter));
      await tester.pumpAndSettle();
      final List<MarkerColor> deco = (await tester.runAsync(
        () => repo.loadColors(MarkerBrand.decoTime),
      ))!;
      final int decoTotal = deco
          .where((MarkerColor c) => c.brandId == MarkerBrand.decoTime.id)
          .length;
      expect(
        find.text(t.swatchesCountOf(decoTotal, decoTotal)),
        findsOneWidget,
      );
      await tester.tap(find.byKey(const ValueKey<String>('swatches-mine')));
      await tester.pumpAndSettle();
      expect(find.text(t.swatchesCountOf(1, decoTotal)), findsOneWidget);
    });
  }
}
