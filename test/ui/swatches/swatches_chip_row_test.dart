import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/ui/icons/ink_icons.dart';
import 'package:ink_lab/ui/pages/swatches/swatches_page.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/widgets/ink_chip.dart';

import '../../support/l10n.dart';
import '../../support/truncation.dart';

// The row of filters of the Swatches page: the three chips that narrow the
// list and the pinned chip that opens the filters sheet.
//
// The three chips are whole on screen at any text size: the pinned chip
// shrinks to its icon when the row would overflow, and the row wraps when
// even that is not enough. No chip is ever cut by the edge of the screen or
// hidden behind the pinned one.

/// The screen of the Swatches page at [width] dp, [locale] and [scale].
Future<AppScope> pumpSwatchesRow(
  WidgetTester tester, {
  required Locale locale,
  required double width,
  required double scale,
}) async {
  tester.view.physicalSize = Size(width, 900);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  final AppScope scope = AppScope.inMemory(
    markers: MarkerRepository(
      loadAsset: (String path) => File(path).readAsStringSync(),
    ),
    child: const SwatchesPage(),
  );
  await tester.pumpWidget(
    MaterialApp(
      locale: locale,
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      theme: AppTheme.light(),
      builder: (BuildContext context, Widget? child) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: TextScaler.linear(scale)),
        child: child!,
      ),
      home: Scaffold(body: scope),
    ),
  );
  await tester.pumpAndSettle();
  return scope;
}

/// The rect of the chip with [label].
Rect chipRect(WidgetTester tester, String label) =>
    tester.getRect(find.widgetWithText(InkChip, label));

void main() {
  setUpAll(loadAppFonts);

  for (final Locale locale in testSupportedLocales) {
    for (final double width in [360.0, 412.0]) {
      testWidgets(
        'empty favourites action wraps without clipping (${locale.languageCode}, $width dp, x2)',
        (tester) async {
          final t = lookupAppLocalizations(locale);
          await pumpSwatchesRow(tester, locale: locale, width: width, scale: 2);
          await tester.tap(
            find.widgetWithText(InkChip, t.swatchesFavoritesOnly),
          );
          await tester.pumpAndSettle();
          final Finder action = find.text(t.swatchesEmptyNoFavoritesAction);
          expect(action, findsOneWidget);
          await tester.ensureVisible(action);
          await tester.pumpAndSettle();
          expect(
            truncatedTexts(tester),
            isNot(contains(t.swatchesEmptyNoFavoritesAction)),
          );
          expect(tester.takeException(), isNull);
          await tester.tap(action);
          await tester.pumpAndSettle();
          expect(
            find.byKey(const ValueKey<String>('swatches-empty-no-favorites')),
            findsNothing,
          );
        },
      );
    }
  }

  for (final Locale locale in const <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('de'),
    Locale('fr'),
    Locale('it'),
    Locale('pt'),
  ]) {
    for (final double width in <double>[360, 412]) {
      for (final double scale in <double>[1.0, 1.3, 1.5, 2.0]) {
        final String tag = '${locale.languageCode} ${width.toInt()} dp x$scale';
        testWidgets(
          'the three chips are whole and clear of the pinned one ($tag)',
          (WidgetTester tester) async {
            final AppLocalizations t = lookupAppLocalizations(locale);
            await pumpSwatchesRow(
              tester,
              locale: locale,
              width: width,
              scale: scale,
            );

            // The row of the three chips and the pinned one.
            final Rect row = tester.getRect(find.byType(InkChipRow));
            final Rect pinned = tester.getRect(
              find.byKey(const ValueKey<String>('swatches-filters')),
            );
            expect(pinned.right, lessThanOrEqualTo(width));
            expect(pinned.left, greaterThanOrEqualTo(0));

            for (final String label in <String>[
              t.swatchesAllFilter,
              t.swatchesOwnedOnly,
              t.swatchesFavoritesOnly,
            ]) {
              final Rect chip = chipRect(tester, label);
              expect(
                chip.left,
                greaterThanOrEqualTo(row.left - 0.5),
                reason: '$tag: "$label" starts outside the row',
              );
              expect(
                chip.right,
                lessThanOrEqualTo(row.right + 0.5),
                reason: '$tag: "$label" is cut by the edge of the row',
              );
              expect(
                chip.overlaps(pinned),
                isFalse,
                reason: '$tag: "$label" is under the pinned chip',
              );
            }
          },
        );
      }
    }
  }

  testWidgets('the pinned chip keeps its word when the row fits', (
    WidgetTester tester,
  ) async {
    final AppLocalizations t = lookupAppLocalizations(const Locale('en'));
    await pumpSwatchesRow(
      tester,
      locale: const Locale('en'),
      width: 412,
      scale: 1.0,
    );

    expect(find.text(t.swatchesFilters), findsOneWidget);
    final InkChip chip = tester.widget<InkChip>(
      find.byKey(const ValueKey<String>('swatches-filters')),
    );
    expect(chip.label, t.swatchesFilters);
  });

  testWidgets('the pinned chip shrinks to its icon when the row overflows', (
    WidgetTester tester,
  ) async {
    final AppLocalizations t = lookupAppLocalizations(const Locale('de'));
    await pumpSwatchesRow(
      tester,
      locale: const Locale('de'),
      width: 360,
      scale: 2.0,
    );

    // The word is gone: the icon and the count of the filters are left.
    expect(find.text(t.swatchesFilters), findsNothing);
    final InkChip chip = tester.widget<InkChip>(
      find.byKey(const ValueKey<String>('swatches-filters')),
    );
    expect(chip.icon, InkIcons.filterLines);
    expect(chip.semanticLabel, t.swatchesFilters);
    // The chip still says what it is, for a long press.
    expect(find.byTooltip(t.swatchesFilters), findsOneWidget);
  });

  testWidgets('the count of the filters stays on the pinned chip', (
    WidgetTester tester,
  ) async {
    final AppLocalizations t = lookupAppLocalizations(const Locale('de'));
    final AppScope scope = await pumpSwatchesRow(
      tester,
      locale: const Locale('de'),
      width: 360,
      scale: 2.0,
    );

    // The Honolulu series filters the list: the chip says so.
    await tester.tap(find.byKey(const ValueKey<String>('swatches-filters')));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(InkChip, 'Honolulu').first);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip(t.commonClose));
    await tester.pumpAndSettle();

    final InkChip chip = tester.widget<InkChip>(
      find.byKey(const ValueKey<String>('swatches-filters')),
    );
    expect(chip.semanticLabel, t.swatchesFiltersCount(1));
    expect(scope.settings.settings.ownedSeries, isNotEmpty);
  });

  testWidgets('the measured width of a chip is the width it takes', (
    WidgetTester tester,
  ) async {
    for (final double scale in <double>[1.0, 1.5, 2.0]) {
      final AppLocalizations t = lookupAppLocalizations(const Locale('de'));
      await pumpSwatchesRow(
        tester,
        locale: const Locale('de'),
        width: 412,
        scale: scale,
      );
      final BuildContext context = tester.element(
        find.byKey(const ValueKey<String>('swatches-mine')),
      );
      final double measured = InkChip.naturalWidth(
        context,
        t.swatchesOwnedOnly,
      );
      final double real = chipRect(tester, t.swatchesOwnedOnly).width;
      expect(measured, moreOrLessEquals(real, epsilon: 0.5), reason: 'x$scale');
    }
  });

  testWidgets('activating a filter does not move the other chips', (
    WidgetTester tester,
  ) async {
    final AppLocalizations t = lookupAppLocalizations(const Locale('en'));
    for (final ({double width, double scale}) scenario
        in <({double width, double scale})>[
          (width: 360, scale: 1.5),
          (width: 412, scale: 1.0),
          (width: 360, scale: 2.0),
        ]) {
      await pumpSwatchesRow(
        tester,
        locale: const Locale('en'),
        width: scenario.width,
        scale: scenario.scale,
      );

      Rect rectOf(String label) =>
          tester.getRect(find.widgetWithText(InkChip, label));
      final Map<String, Rect> before = <String, Rect>{
        for (final String label in <String>[
          t.swatchesAllFilter,
          t.swatchesOwnedOnly,
          t.swatchesFavoritesOnly,
        ])
          label: rectOf(label),
      };

      await tester.tap(find.byKey(const ValueKey<String>('swatches-filters')));
      await tester.pumpAndSettle();
      final Finder pack = find.widgetWithText(InkChip, 'Honolulu');
      if (pack.evaluate().isNotEmpty) {
        await tester.tap(pack.first);
        await tester.pumpAndSettle();
      }
      await tester.tap(find.byTooltip(t.commonClose));
      await tester.pumpAndSettle();

      for (final String label in before.keys) {
        final Rect after = rectOf(label);
        expect(
          after.left,
          moreOrLessEquals(before[label]!.left, epsilon: 1.0),
          reason:
              '${scenario.width}x${scenario.scale}: $label moved horizontally',
        );
        expect(
          after.right,
          moreOrLessEquals(before[label]!.right, epsilon: 1.0),
          reason:
              '${scenario.width}x${scenario.scale}: $label moved horizontally',
        );
        expect(
          after.top,
          moreOrLessEquals(before[label]!.top, epsilon: 1.0),
          reason:
              '${scenario.width}x${scenario.scale}: $label moved vertically',
        );
      }
    }
  });
}
