import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/ui/pages/swatches/swatch_detail_sheet.dart';
import 'package:ink_lab/ui/pages/swatches/swatches_page.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/theme/app_typography.dart';
import 'package:ink_lab/ui/widgets/color_swatch_tile.dart';
import 'package:ink_lab/ui/widgets/ink_chip.dart';
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
    // The brand is Ohuhu (Oahu is a series), then the collection summary.
    expect(find.text('Ohuhu · Oahu · 1 set · 161 markers'), findsOneWidget);
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

    await tester.tap(find.text('B08'));
    await tester.pumpAndSettle();

    expect(find.text(l10n.swatchesCopyHex), findsOneWidget);
    expect(find.text(l10n.swatchesAddToPalette), findsOneWidget);
    expect(find.text(l10n.commonOldCode('B289')), findsOneWidget);
    // 82dcfa is the hex of B08.
    expect(find.text('#82DCFA'), findsWidgets);
    expect(find.text(l10n.commonRgb(130, 220, 250)), findsOneWidget);
    expect(find.text(l10n.swatchesClosestAlternatives), findsOneWidget);
    expect(find.textContaining('ΔE '), findsWidgets);
  });

  testWidgets('the detail sheet offers a blending chain when the shell can '
      'open one', (WidgetTester tester) async {
    // Standalone, without the shell, there is nowhere to send it.
    await pumpSwatches(tester);
    await tester.tap(find.text('B08'));
    await tester.pumpAndSettle();
    expect(find.text(l10n.swatchesBlendingChain), findsNothing);
  });

  testWidgets('the blending chain action closes the sheet and hands the '
      'marker over', (WidgetTester tester) async {
    final List<MarkerColor> asked = <MarkerColor>[];
    await pumpSwatches(tester, onBlendingChain: asked.add);

    await tester.tap(find.text('B08'));
    await tester.pumpAndSettle();
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

    await tester.tap(find.text('B08'));
    await tester.pumpAndSettle();
    final Finder alternative = find.bySemanticsLabel(
      RegExp(r', delta E \d+\.\d$'),
    );
    expect(alternative, findsNWidgets(3));
    await tester.tap(alternative.first);
    await tester.pumpAndSettle();

    expect(find.text(l10n.swatchesCopyHex), findsOneWidget);
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

    await tester.tap(find.text('B08'));
    await tester.pumpAndSettle();

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
    await tester.tap(find.text('B08'));
    await tester.pumpAndSettle();
    expect(find.text(l10n.swatchesCopyHex), findsOneWidget);
  });

  testWidgets('the detail sheet shows the swatch card of the active pack', (
    WidgetTester tester,
  ) async {
    await pumpSwatches(tester);

    await tester.tap(find.text('B08'));
    await tester.pumpAndSettle();

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

  group('my colour', () {
    Finder tileWithOwnColor() => find.byWidgetPredicate(
      (Widget w) => w is ColorSwatchTile && w.ownColor,
    );

    Future<void> openDetail(WidgetTester tester) async {
      await tester.tap(find.text('B08'));
      await tester.pumpAndSettle();
    }

    Future<void> saveOwnColor(WidgetTester tester, String hex) async {
      await tester.tap(find.byKey(const ValueKey<String>('swatch-own-set')));
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
      expect(find.text(l10n.swatchesMyColourHelp), findsOneWidget);
      expect(find.text(l10n.swatchesMyColourSet), findsOneWidget);
      expect(
        find.byKey(const ValueKey<String>('swatch-own-compare')),
        findsNothing,
      );
      expect(
        find.byKey(const ValueKey<String>('swatch-own-reset')),
        findsNothing,
      );

      await saveOwnColor(tester, '0a0b0c');

      expect(scope.ownColors.colors, <String, String>{
        'ohuhu_oahu:B08': '0a0b0c',
      });
      expect(find.byType(SwatchDetailSheet), findsOneWidget);
      expect(find.text(l10n.swatchesMyColourSaved), findsOneWidget);
      // Both colours, side by side; the sheet now shows the own one.
      expect(
        find.byKey(const ValueKey<String>('swatch-own-compare')),
        findsOneWidget,
      );
      expect(
        find.text(l10n.swatchesCatalogueLabel.toUpperCase()),
        findsOneWidget,
      );
      expect(find.text(l10n.swatchesMineLabel.toUpperCase()), findsOneWidget);
      expect(find.text('#0A0B0C'), findsWidgets);
      expect(find.text(l10n.swatchesMyColourChange), findsOneWidget);
      expect(sheetOf(tester).color.hex, '0a0b0c');
      expect(sheetOf(tester).color.hasOwnColor, isTrue);

      await tester.tap(find.byKey(const ValueKey<String>('swatch-own-reset')));
      await tester.pumpAndSettle();
      expect(scope.ownColors.colors, isEmpty);
      expect(find.text(l10n.swatchesMyColourWasReset), findsOneWidget);
      expect(
        find.byKey(const ValueKey<String>('swatch-own-compare')),
        findsNothing,
      );
      expect(sheetOf(tester).color.hasOwnColor, isFalse);
    });

    testWidgets('leaving the editor without saving changes nothing', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await pumpSwatches(tester);
      await openDetail(tester);
      await tester.tap(find.byKey(const ValueKey<String>('swatch-own-set')));
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
      expect(
        find.byKey(const ValueKey<String>('swatch-own-compare')),
        findsNothing,
      );
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
