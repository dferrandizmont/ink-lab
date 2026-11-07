import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/brand_equivalents.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/ui/pages/swatches/brand_equivalents_section.dart';
import 'package:ink_lab/ui/widgets/ink_sheet.dart';

import '../../support/l10n.dart';
import 'swatches_page_test.dart' show pumpSwatches;

Finder _key(String key) => find.byKey(ValueKey<String>(key));

/// The result rows inside [group].
Finder _rows(Finder group) => find.descendant(
  of: group,
  matching: find.byWidgetPredicate(
    (Widget w) =>
        w.key is ValueKey<String> &&
        (w.key! as ValueKey<String>).value.startsWith('swatch-equivalent-'),
  ),
);

MarkerColor _marker(String brandId, String code, String hex) => MarkerColor(
  brandId: brandId,
  newCode: code,
  newName: 'Name $code',
  oldCode: code,
  oldName: 'Name $code',
  hex: hex,
  sets: const <String>[],
);

/// Opens B08 (Ohuhu) and scrolls to the "In other brands" section.
Future<void> _openB08(WidgetTester tester) async {
  await tester.tap(find.text('B08'));
  await tester.pumpAndSettle();
  await _expandSheet(tester);
  await _scrollTo(tester, _key('swatch-brand-equivalents'));
}

/// The scrollable of the detail sheet.
Finder _sheetScroll(WidgetTester tester) => find
    .descendant(of: find.byType(InkSheet), matching: find.byType(Scrollable))
    .first;

/// Brings the sheet to the full height: its content scrolls only there.
Future<void> _expandSheet(WidgetTester tester) async {
  await tester.drag(_sheetScroll(tester), const Offset(0, -600));
  await tester.pumpAndSettle();
}

/// Scrolls the sheet until [finder] is on screen.
Future<void> _scrollTo(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(
    finder,
    200,
    scrollable: _sheetScroll(tester),
  );
  await tester.pumpAndSettle();
}

/// Scrolls the sheet until [finder] is on screen by moving its position, with
/// no drag. With fifteen brands the groups of a sheet that has just changed
/// marker are far below its top, and a drag there can resize the sheet away.
Future<void> _jumpTo(WidgetTester tester, Finder finder) async {
  final ScrollPosition position = tester
      .state<ScrollableState>(_sheetScroll(tester))
      .position;
  for (
    int step = 0;
    step < 80 && finder.hitTestable().evaluate().isEmpty;
    step++
  ) {
    position.jumpTo(
      (position.pixels + 100).clamp(0, position.maxScrollExtent).toDouble(),
    );
    await tester.pump();
  }
  await tester.pumpAndSettle();
}

/// Scrolls the sheet back to its top.
Future<void> _scrollToTop(WidgetTester tester) async {
  tester.state<ScrollableState>(_sheetScroll(tester)).position.jumpTo(0);
  await tester.pumpAndSettle();
}

/// The compact rows of the list of all brands.
Finder _brandRows() => find.byWidgetPredicate(
  (Widget w) =>
      w.key is ValueKey<String> &&
      (w.key! as ValueKey<String>).value.startsWith('swatch-equivalents-row-'),
);

/// Opens the list of all brands of the "In other brands" section.
Future<void> _openAll(WidgetTester tester) async {
  final Finder all = _key('swatch-equivalents-all');
  await _scrollTo(tester, all);
  await tester.tap(all);
  await tester.pumpAndSettle();
}

/// Opens the "Details" block of the sheet.
Future<void> _openDetails(WidgetTester tester) async {
  final Finder details = _key('swatch-details');
  await _scrollTo(tester, details);
  await tester.tap(details);
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(loadAppFonts);

  group('Swatches: In other brands', () {
    testWidgets('one list holds the closest marker of every other brand, '
        'closest first', (WidgetTester tester) async {
      await pumpSwatches(tester);
      await _openB08(tester);

      expect(find.text(l10n.swatchesOtherBrandsTitle), findsOneWidget);
      expect(find.text(l10n.swatchesOtherBrandsOnlyMine), findsOneWidget);
      final int others = MarkerBrand.values.length - 1;
      // One disclosure, closed, that counts the brands.
      final Finder all = _key('swatch-equivalents-all');
      expect(all, findsOneWidget);
      expect(find.text(l10n.swatchesAllBrands(others)), findsOneWidget);
      expect(_brandRows(), findsNothing);
      // The user owns no marker of another brand: no group of their own.
      expect(find.text(l10n.swatchesOtherBrandsYours.toUpperCase()), findsNothing);

      await _scrollTo(tester, all);
      await tester.tap(all);
      await tester.pumpAndSettle();
      // One row per brand, never the brand of the marker itself.
      expect(_brandRows(), findsNWidgets(others));
      expect(_key('swatch-equivalents-row-ohuhu_oahu'), findsNothing);
      for (final MarkerBrand brand in MarkerBrand.values) {
        if (brand == MarkerBrand.ohuhuOahu) continue;
        final Finder row = _key('swatch-equivalents-row-${brand.id}');
        expect(row, findsOneWidget, reason: brand.label);
        expect(
          find.descendant(of: row, matching: find.text(brand.label)),
          findsOneWidget,
          reason: brand.label,
        );
        expect(
          find.descendant(of: row, matching: find.textContaining('ΔE ')),
          findsOneWidget,
          reason: brand.label,
        );
      }
      // Closest first.
      final List<double> distances = <double>[
        for (final Element row in _brandRows().evaluate())
          double.parse(
            RegExp(r'ΔE ([0-9.]+)')
                .firstMatch(
                  find
                      .descendant(
                        of: find.byElementPredicate((Element e) => e == row),
                        matching: find.textContaining('ΔE '),
                      )
                      .evaluate()
                      .map((Element e) => (e.widget as Text).data!)
                      .first,
                )!
                .group(1)!,
          ),
      ];
      expect(distances, hasLength(others));
      for (int i = 1; i < distances.length; i++) {
        expect(distances[i], greaterThanOrEqualTo(distances[i - 1]));
      }
    });

    testWidgets('the brands the user owns come first, as groups of their '
        'closest markers', (WidgetTester tester) async {
      final AppScope scope = await pumpSwatches(tester);
      await scope.settings.setOwnedMarkerCodes(<String>{
        'copic:B00',
        'copic:B01',
      });
      await tester.pumpAndSettle();
      await _openB08(tester);

      final Finder group = _key('swatch-equivalents-copic');
      expect(group, findsOneWidget);
      expect(
        find.text(l10n.swatchesOtherBrandsYours.toUpperCase()),
        findsOneWidget,
      );
      // Other brands the user does not own are not groups.
      expect(_key('swatch-equivalents-decotime'), findsNothing);
      // The group is above the list of all brands.
      expect(
        tester.getTopLeft(group).dy,
        lessThan(tester.getTopLeft(_key('swatch-equivalents-all')).dy),
      );
      // Closed, it shows its best match; opened, the closest three.
      expect(_rows(group), findsNothing);
      await tester.tap(group);
      await tester.pumpAndSettle();
      expect(_rows(group), findsNWidgets(3));
    });

    testWidgets('"Only mine" keeps the owned markers and drops the dried '
        'ones', (WidgetTester tester) async {
      final AppScope scope = await pumpSwatches(tester);
      await scope.settings.setOwnedMarkerCodes(<String>{
        'copic:B00',
        'copic:B01',
      });
      await scope.dried.add('copic:B01');
      await tester.pumpAndSettle();
      await _openB08(tester);

      await tester.tap(_key('swatch-equivalents-only-mine'));
      await tester.pumpAndSettle();

      // Only Copic is left, with the owned marker that has not run dry; the
      // list of all brands would repeat it, so it is not there.
      expect(_key('swatch-equivalents-copic'), findsOneWidget);
      expect(_key('swatch-equivalents-all'), findsNothing);
      expect(_key('swatch-equivalents-decotime'), findsNothing);
      await tester.tap(_key('swatch-equivalents-copic'));
      await tester.pumpAndSettle();
      expect(_key('swatch-equivalent-copic:B00'), findsOneWidget);
      expect(_key('swatch-equivalent-copic:B01'), findsNothing);

      // Off again: every brand competes, in the list of all brands.
      await tester.tap(_key('swatch-equivalents-only-mine'));
      await tester.pumpAndSettle();
      expect(_key('swatch-equivalents-all'), findsOneWidget);
    });

    testWidgets('"Only mine" says so when none of the other brands is '
        'owned', (WidgetTester tester) async {
      await pumpSwatches(tester);
      await _openB08(tester);

      await tester.tap(_key('swatch-equivalents-only-mine'));
      await tester.pumpAndSettle();

      expect(_key('swatch-equivalents-empty'), findsOneWidget);
      expect(find.text(l10n.swatchesOtherBrandsNoneMine), findsOneWidget);
    });

    testWidgets('a result opens that marker, without palette actions', (
      WidgetTester tester,
    ) async {
      await pumpSwatches(tester, onBlendingChain: (_) {});
      await _openB08(tester);
      // The sheet of an Ohuhu marker offers the palette actions.
      await _scrollToTop(tester);
      expect(find.text(l10n.swatchesAddToPalette), findsOneWidget);
      expect(_key('swatch-other-brand-note'), findsNothing);

      await _openAll(tester);
      final Finder row = _key('swatch-equivalents-row-copic');
      await _scrollTo(tester, row);
      await tester.tap(row);
      await tester.pumpAndSettle();

      // Now the sheet describes a Copic marker: the palette actions give
      // way to a note, and it lists the other brands from there. The user
      // owns Ohuhu, so Ohuhu comes first, as a group.
      await _scrollToTop(tester);
      expect(find.text(l10n.swatchesAddToPalette), findsNothing);
      expect(find.text(l10n.swatchesBlendingChain), findsNothing);
      expect(_key('swatch-other-brand-note'), findsOneWidget);
      // Its brand is in the details, which start closed.
      await _openDetails(tester);
      expect(find.text(l10n.settingsBrandTitle.toUpperCase()), findsOneWidget);
      await _jumpTo(tester, _key('swatch-equivalents-ohuhu_oahu'));
      expect(_key('swatch-equivalents-ohuhu_oahu'), findsOneWidget);
      expect(_key('swatch-equivalents-copic'), findsNothing);
      // Its own closest alternatives are Copic markers too.
      await _scrollToTop(tester);
      expect(find.text(l10n.swatchesClosestAlternatives), findsOneWidget);
    });

    testWidgets('going back to a marker of the active brand restores the '
        'palette actions', (WidgetTester tester) async {
      await pumpSwatches(tester);
      await _openB08(tester);
      await _openAll(tester);
      final Finder row = _key('swatch-equivalents-row-copic');
      await _scrollTo(tester, row);
      await tester.tap(row);
      await tester.pumpAndSettle();
      // The sheet now describes the Copic marker; the user's own brand is
      // a group of its own.
      await _scrollToTop(tester);
      await _jumpTo(tester, _key('swatch-equivalents-ohuhu_oahu'));
      await tester.tap(_key('swatch-equivalents-ohuhu_oahu'));
      await tester.pumpAndSettle();
      await _jumpTo(tester, _rows(_key('swatch-equivalents-ohuhu_oahu')).first);
      await tester.tap(_rows(_key('swatch-equivalents-ohuhu_oahu')).first);
      await tester.pumpAndSettle();

      await _scrollToTop(tester);
      expect(find.text(l10n.swatchesAddToPalette), findsOneWidget);
      expect(_key('swatch-other-brand-note'), findsNothing);
    });
  });

  group('BrandEquivalentsSection', () {
    Widget host(BrandEquivalentsLoader loader, MarkerColor marker) =>
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: testLocalizationsDelegates,
          supportedLocales: testSupportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: BrandEquivalentsSection(
                marker: marker,
                loader: loader,
                onSelect: (_) {},
              ),
            ),
          ),
        );

    testWidgets('measures once, not on every rebuild', (
      WidgetTester tester,
    ) async {
      int calls = 0;
      final MarkerColor marker = _marker('ohuhu_oahu', 'B08', '82dcfa');
      Future<List<BrandEquivalentGroup>> loader(
        MarkerColor m, {
        required bool onlyMine,
      }) async {
        calls++;
        return <BrandEquivalentGroup>[
          BrandEquivalentGroup(
            brandId: 'copic',
            matches: <BrandEquivalent>[
              BrandEquivalent(
                color: _marker('copic', 'B01', '80d0f0'),
                deltaE: 3,
              ),
            ],
          ),
        ];
      }

      await tester.pumpWidget(host(loader, marker));
      await tester.pumpAndSettle();
      expect(calls, 1);
      // A rebuild of the same marker does not ask again.
      await tester.pumpWidget(host(loader, marker));
      await tester.pumpAndSettle();
      expect(calls, 1);
      // Another colour for the marker does.
      await tester.pumpWidget(
        host(loader, _marker('ohuhu_oahu', 'B08', '000000')),
      );
      await tester.pumpAndSettle();
      expect(calls, 2);
      // The brand is in the list of all brands, which starts closed.
      expect(find.text(l10n.swatchesAllBrands(1)), findsOneWidget);
      await tester.tap(_key('swatch-equivalents-all'));
      await tester.pumpAndSettle();
      expect(find.text('B01'), findsOneWidget);
    });

    testWidgets('puts the brands the user owns first, closest first', (
      WidgetTester tester,
    ) async {
      BrandEquivalentGroup group(String brand, String code, double d) =>
          BrandEquivalentGroup(
            brandId: brand,
            matches: <BrandEquivalent>[
              BrandEquivalent(color: _marker(brand, code, '80d0f0'), deltaE: d),
            ],
          );
      Future<List<BrandEquivalentGroup>> loader(
        MarkerColor m, {
        required bool onlyMine,
      }) async => <BrandEquivalentGroup>[
        group('decotime', 'D1', 9),
        group('copic', 'C1', 4),
        group('finecolour', 'F1', 2),
        group('promarker', 'P1', 1),
      ];
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: testLocalizationsDelegates,
          supportedLocales: testSupportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: BrandEquivalentsSection(
                marker: _marker('ohuhu_oahu', 'B08', '82dcfa'),
                loader: loader,
                ownedBrands: () async => <String>{'finecolour', 'decotime'},
                onSelect: (_) {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      // Finecolour (closer) before DecoTime; Copic is not the user's.
      expect(
        tester.getTopLeft(_key('swatch-equivalents-finecolour')).dy,
        lessThan(tester.getTopLeft(_key('swatch-equivalents-decotime')).dy),
      );
      expect(_key('swatch-equivalents-copic'), findsNothing);
      expect(_key('swatch-equivalents-promarker'), findsNothing);
      // The list of all brands counts the four and is sorted by distance.
      expect(find.text(l10n.swatchesAllBrands(4)), findsOneWidget);
      await tester.tap(_key('swatch-equivalents-all'));
      await tester.pumpAndSettle();
      final List<double> tops = <double>[
        for (final String id in <String>[
          'promarker',
          'finecolour',
          'copic',
          'decotime',
        ])
          tester.getTopLeft(_key('swatch-equivalents-row-$id')).dy,
      ];
      expect(tops, orderedEquals(<double>[...tops]..sort()));
    });

    testWidgets('a failed lookup says so instead of crashing', (
      WidgetTester tester,
    ) async {
      Future<List<BrandEquivalentGroup>> loader(
        MarkerColor m, {
        required bool onlyMine,
      }) => Future<List<BrandEquivalentGroup>>.error(StateError('no data'));
      await tester.pumpWidget(
        host(loader, _marker('ohuhu_oahu', 'B08', '82dcfa')),
      );
      await tester.pumpAndSettle();
      expect(find.text(l10n.swatchesOtherBrandsFailed), findsOneWidget);
    });
  });
}
