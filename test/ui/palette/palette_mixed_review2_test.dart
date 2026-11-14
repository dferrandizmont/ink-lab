import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/ui/pages/palette/palette_notes.dart';
import 'package:ink_lab/ui/widgets/palette_strip.dart';

import '../../support/l10n.dart';
import 'palette_mixed_undo_test.dart'
    show baseField, key, savePaletteAs, snapshot, strip;
import 'palette_test_support.dart';

// Second review of "Mix my brands": what a palette kept across a change of
// brand or of the mix still says about itself.

/// Scenes, with the scene the page starts on: its palette is built on the
/// scene's default base, and the base field stays empty.
Future<void> chooseScenes(WidgetTester tester) async {
  await choosePaletteType(tester, 'palette-scenario-toggle');
  expect(baseField(tester).baseInput, isEmpty);
  expect(find.byType(PaletteStrip), findsWidgets);
}

void main() {
  group('a scene palette built on the default base', () {
    testWidgets('keeps that base when the brand changes, and saves it', (
      tester,
    ) async {
      final scope = await pumpPalette(
        tester,
        ownedMarkerCodes: {'decotime:91', 'decotime:92'},
      );
      await chooseScenes(tester);
      final before = snapshot(tester);
      final List<String> codes = strip(tester).labels!;
      final String base = codes.first;
      // The base is the first band: one more than the rows.
      expect(codes, hasLength(rowCodes(tester).length + 1));
      expect(strip(tester).brandLabels, isNull);

      // DecoTime has its own default base for the scene: the palette on
      // screen must not take it.
      await scope.settings.setBrand(MarkerBrand.decoTime);
      await tester.pumpAndSettle();
      expect(snapshot(tester)['rows'], before['rows']);
      expect(snapshot(tester)['strip'], before['strip']);
      expect(strip(tester).brandLabels, everyElement('Ohuhu'));
      // The base it was built on is now written down.
      expect(baseField(tester).baseInput, 'Ohuhu $base');
      expect(baseField(tester).resolvedBase!.colorId, 'ohuhu_oahu:$base');
      expect(find.byType(PaletteErrorNote), findsNothing);
      expect(key('palette-changed'), findsNothing);

      // What is saved is the palette on screen: that base, those companions.
      final SavedPalette saved = await savePaletteAs(tester, scope, 'Scene');
      expect(saved.baseColorId, 'ohuhu_oahu:$base');
      expect(saved.colorIds, <String>[
        for (final String code in codes) 'ohuhu_oahu:$code',
      ]);

      // Back to its brand: the same palette, the base in its own spelling.
      await scope.settings.setBrand(MarkerBrand.ohuhuOahu);
      await tester.pumpAndSettle();
      expect(snapshot(tester)['rows'], before['rows']);
      expect(snapshot(tester)['strip'], before['strip']);
      expect(strip(tester).brandLabels, isNull);
      expect(baseField(tester).baseInput, base);
    });

    testWidgets('keeps its base band under a brand the user owns nothing of', (
      tester,
    ) async {
      final scope = await pumpPalette(tester);
      await chooseScenes(tester);
      final before = snapshot(tester);
      final String base = strip(tester).labels!.first;

      // No Copic marker: there is no default base to find any more.
      await scope.settings.setBrand(MarkerBrand.copic);
      await tester.pumpAndSettle();
      expect(snapshot(tester)['rows'], before['rows']);
      expect(snapshot(tester)['strip'], before['strip']);
      expect(strip(tester).labels!.first, base);
      expect(strip(tester).brandLabels, everyElement('Ohuhu'));
      expect(baseField(tester).resolvedBase!.colorId, 'ohuhu_oahu:$base');

      // It can still be saved, base included.
      final SavedPalette saved = await savePaletteAs(tester, scope, 'Kept');
      expect(saved.baseColorId, 'ohuhu_oahu:$base');
    });

    testWidgets('keeps the same base marker when the mix is turned on', (
      tester,
    ) async {
      final scope = await pumpPalette(
        tester,
        ownedMarkerCodes: {'decotime:91', 'decotime:92'},
      );
      await chooseScenes(tester);
      final before = snapshot(tester);
      final String base = strip(tester).labels!.first;

      await scope.settings.setScope(BrandScope.mixedBrands);
      await tester.pumpAndSettle();
      expect(snapshot(tester)['rows'], before['rows']);
      expect(snapshot(tester)['strip'], before['strip']);
      // Every code has its brand now, and the base is the marker it was.
      expect(strip(tester).brandLabels, everyElement('Ohuhu'));
      // The field is empty while the scene still picks that base by itself,
      // and names it as soon as it would pick another.
      expect(baseField(tester).baseInput, anyOf(isEmpty, 'Ohuhu $base'));
      final SavedPalette saved = await savePaletteAs(tester, scope, 'Mix');
      expect(saved.baseColorId, 'ohuhu_oahu:$base');
    });

    testWidgets('is built again, as always, when one of its markers dries', (
      tester,
    ) async {
      final scope = await pumpPalette(tester);
      await chooseScenes(tester);
      final String gone = rowCodes(tester).first;
      await scope.dried.add('ohuhu_oahu:$gone');
      await tester.pumpAndSettle();
      expect(rowCodes(tester), isNot(contains(gone)));
      // Nothing was written in the field: it is still the scene's default.
      expect(baseField(tester).baseInput, isEmpty);
    });
  });

  group('the whole-range note of a kept blending chain', () {
    testWidgets('still names every brand after the mix is turned off', (
      tester,
    ) async {
      // Three markers in all: too few for a chain, so the range is offered.
      final scope = await pumpPalette(
        tester,
        setup: (scope) async {
          await scope.settings.setCollection(
            AppSettings(
              extraMarkerIds: const {'B08', 'decotime:91', 'decotime:92'},
            ),
          );
          await scope.settings.setScope(BrandScope.mixedBrands);
        },
      );
      await choosePaletteType(tester, 'palette-mode-blendingChain');
      await chooseBase(tester, '91', brand: MarkerBrand.decoTime);
      await tester.ensureVisible(key('palette-chain-whole-range'));
      await tester.tap(key('palette-chain-whole-range'));
      await tester.pumpAndSettle();
      expect(find.text(l10n.paletteChainWholeRangeNoteMixed), findsOneWidget);
      final before = snapshot(tester);

      // The chain stays: it was searched in the range of both brands, and
      // the note must go on saying so (not "the whole range of Ohuhu").
      await scope.settings.setScope(BrandScope.singleBrand);
      await tester.pumpAndSettle();
      expect(snapshot(tester)['strip'], before['strip']);
      expect(find.text(l10n.paletteChainWholeRangeNoteMixed), findsOneWidget);
      expect(find.text(l10n.paletteChainWholeRangeNote('Ohuhu')), findsNothing);
      expect(
        find.text(l10n.paletteChainWholeRangeNote('DecoTime')),
        findsNothing,
      );
    });

    testWidgets('names the brand of its range, not the brand changed to', (
      tester,
    ) async {
      final scope = await pumpPalette(
        tester,
        setup: (scope) => scope.settings.setCollection(
          AppSettings(extraMarkerIds: const {'B08', 'decotime:91'}),
        ),
      );
      await choosePaletteType(tester, 'palette-mode-blendingChain');
      await chooseBase(tester, 'B08');
      await tester.ensureVisible(key('palette-chain-whole-range'));
      await tester.tap(key('palette-chain-whole-range'));
      await tester.pumpAndSettle();
      expect(
        find.text(l10n.paletteChainWholeRangeNote('Ohuhu')),
        findsOneWidget,
      );
      final before = snapshot(tester);
      expect(before['strip'], isNotEmpty);

      await scope.settings.setBrand(MarkerBrand.decoTime);
      await tester.pumpAndSettle();
      expect(snapshot(tester)['strip'], before['strip']);
      expect(
        find.text(l10n.paletteChainWholeRangeNote('Ohuhu')),
        findsOneWidget,
      );
      expect(
        find.text(l10n.paletteChainWholeRangeNote('DecoTime')),
        findsNothing,
      );

      // A new search is one in the range in use now, and says so.
      await chooseBase(tester, '91');
      expect(
        find.text(l10n.paletteChainWholeRangeNote('DecoTime')),
        findsOneWidget,
      );
      expect(find.text(l10n.paletteChainWholeRangeNote('Ohuhu')), findsNothing);
    });
  });
}
