import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/brand_equivalents.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/ui/pages/swatches/brand_equivalents_section.dart';

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
  await tester.ensureVisible(_key('swatch-brand-equivalents'));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(loadAppFonts);

  group('Swatches: In other brands', () {
    testWidgets('lists the closest markers of every other brand', (
      WidgetTester tester,
    ) async {
      await pumpSwatches(tester);
      await _openB08(tester);

      expect(find.text(l10n.swatchesOtherBrandsTitle), findsOneWidget);
      expect(find.text(l10n.swatchesOtherBrandsOnlyMine), findsOneWidget);
      // The brand of the marker itself is never offered.
      expect(_key('swatch-equivalents-ohuhu_oahu'), findsNothing);
      for (final MarkerBrand brand in <MarkerBrand>[
        MarkerBrand.decoTime,
        MarkerBrand.copic,
        MarkerBrand.finecolour,
      ]) {
        final Finder group = _key('swatch-equivalents-${brand.id}');
        expect(group, findsOneWidget, reason: brand.label);
        // Three markers each, with their distance.
        expect(_rows(group), findsNWidgets(3), reason: brand.label);
        expect(
          find.descendant(of: group, matching: find.textContaining('ΔE ')),
          findsNWidgets(3),
          reason: brand.label,
        );
      }
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

      // Only Copic is left, with the owned marker that has not run dry.
      expect(_key('swatch-equivalents-copic'), findsOneWidget);
      expect(_key('swatch-equivalents-decotime'), findsNothing);
      expect(_key('swatch-equivalents-finecolour'), findsNothing);
      expect(_key('swatch-equivalent-copic:B00'), findsOneWidget);
      expect(_key('swatch-equivalent-copic:B01'), findsNothing);

      // Off again: the whole catalogue competes.
      await tester.tap(_key('swatch-equivalents-only-mine'));
      await tester.pumpAndSettle();
      expect(_key('swatch-equivalents-decotime'), findsOneWidget);
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
      expect(find.text(l10n.swatchesAddToPalette), findsOneWidget);
      expect(_key('swatch-other-brand-note'), findsNothing);

      await tester.tap(_rows(_key('swatch-equivalents-copic')).first);
      await tester.pumpAndSettle();

      // Now the sheet describes a Copic marker: its brand is named, the
      // palette actions give way to a note, and it lists the other brands
      // (Ohuhu among them) from there.
      expect(find.text(l10n.settingsBrandTitle.toUpperCase()), findsOneWidget);
      expect(find.text(l10n.swatchesAddToPalette), findsNothing);
      expect(find.text(l10n.swatchesBlendingChain), findsNothing);
      expect(_key('swatch-other-brand-note'), findsOneWidget);
      await tester.ensureVisible(_key('swatch-brand-equivalents'));
      await tester.pumpAndSettle();
      expect(_key('swatch-equivalents-ohuhu_oahu'), findsOneWidget);
      expect(_key('swatch-equivalents-copic'), findsNothing);
      // Its own closest alternatives are Copic markers too.
      expect(find.text(l10n.swatchesClosestAlternatives), findsOneWidget);
    });

    testWidgets('going back to a marker of the active brand restores the '
        'palette actions', (WidgetTester tester) async {
      await pumpSwatches(tester);
      await _openB08(tester);
      await tester.tap(_rows(_key('swatch-equivalents-copic')).first);
      await tester.pumpAndSettle();
      await tester.ensureVisible(_key('swatch-equivalents-ohuhu_oahu'));
      await tester.pumpAndSettle();
      await tester.tap(_rows(_key('swatch-equivalents-ohuhu_oahu')).first);
      await tester.pumpAndSettle();

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
      expect(find.text('B01'), findsOneWidget);
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
