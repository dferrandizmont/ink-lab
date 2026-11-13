import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/ui/pages/palette/palette_draft.dart';
import 'package:ink_lab/ui/pages/palette/palette_notes.dart';
import 'package:ink_lab/ui/widgets/palette_strip.dart';

import '../../support/l10n.dart';
import 'palette_test_support.dart';

Finder _key(String value) => find.byKey(ValueKey<String>(value));

/// The markers on screen, in order, with their brand when the row shows it.
List<String> _rows(WidgetTester tester) => rowCodes(tester);

/// Regenerate and the quick variations on a palette whose base is of a brand
/// that is not in use, and what a variation tells the user.
void main() {
  group('a palette of a brand that is not in use', () {
    Future<void> pumpKept(WidgetTester tester) async {
      final scope = await pumpPalette(
        tester,
        ownedMarkerCodes: <String>{'decotime:91', 'decotime:92'},
      );
      await enterBaseCode(tester, 'B08');
      expect(find.byType(PaletteStrip), findsOneWidget);
      // The brand changes under the palette: it stays, as Ohuhu's.
      await scope.settings.setBrand(MarkerBrand.decoTime);
      await tester.pumpAndSettle();
      expect(find.byType(PaletteStrip), findsOneWidget);
    }

    testWidgets('Regenerate leaves it as it is and says why', (tester) async {
      await pumpKept(tester);
      final List<String> before = _rows(tester);
      final List<String?>? strip = tester
          .widget<PaletteStrip>(find.byType(PaletteStrip))
          .labels;
      expect(before, isNotEmpty);

      await tester.ensureVisible(_key('palette-regenerate'));
      await tester.tap(_key('palette-regenerate'));
      await tester.pumpAndSettle();

      expect(_rows(tester), before);
      expect(
        tester.widget<PaletteStrip>(find.byType(PaletteStrip)).labels,
        strip,
      );
      // No error under the base field, no "Palette changed · Undo": nothing
      // changed. The reason is a snack bar, so nothing on the page moves.
      expect(find.byType(PaletteErrorNote), findsNothing);
      expect(_key('palette-changed'), findsNothing);
      expect(find.text(l10n.paletteUndoButton), findsNothing);
      expect(_key('palette-other-brand-snack'), findsOneWidget);
      expect(find.textContaining('is from Ohuhu'), findsOneWidget);
      expect(find.textContaining('is not in use right now'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('a quick variation leaves it as it is and says why', (
      tester,
    ) async {
      await pumpKept(tester);
      final List<String> before = _rows(tester);

      await tester.ensureVisible(find.text('Warmer'));
      await tester.tap(find.text('Warmer'));
      await tester.pumpAndSettle();

      // Not remixed with DecoTime markers: no mix of brands appears.
      expect(_rows(tester), before);
      expect(find.byType(PaletteErrorNote), findsNothing);
      expect(_key('palette-changed'), findsNothing);
      expect(_key('palette-other-brand-snack'), findsOneWidget);
      expect(find.textContaining('variation applied'), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('an edited loaded palette is not asked to be replaced', (
      tester,
    ) async {
      await pumpPalette(
        tester,
        brand: MarkerBrand.decoTime,
        ownedMarkerCodes: <String>{'decotime:91', 'decotime:92'},
      );
      // A palette saved with Ohuhu, loaded while DecoTime is in use.
      paletteSavedDraft.value = SavedPalette(
        id: 'stored',
        name: 'Stored',
        baseCode: 'B08',
        baseName: 'Blue',
        mode: PaletteMode.triad,
        paletteSize: 3,
        createdAtEpochMs: 0,
        colorCodes: <String>['B08', '120', 'BV19'],
      );
      await tester.pumpAndSettle();
      // Locking a colour is an edit of a loaded palette: a Regenerate that
      // replaced it would ask first (see palette_mixed_undo_test.dart).
      await tester.tap(find.byTooltip(l10n.paletteLockButton).first);
      await tester.pumpAndSettle();
      final List<String> before = _rows(tester);

      await tester.ensureVisible(_key('palette-regenerate'));
      await tester.tap(_key('palette-regenerate'));
      await tester.pumpAndSettle();

      // Nothing is replaced, so nothing asks.
      expect(find.text(l10n.paletteReplaceTitle), findsNothing);
      expect(_rows(tester), before);
      expect(find.byTooltip(l10n.paletteUnlockButton), findsOneWidget);
      expect(_key('palette-other-brand-snack'), findsOneWidget);
      expect(_key('palette-changed'), findsNothing);
    });

    testWidgets(
      'with the mix on, a saved palette of a third brand is kept too',
      (tester) async {
        await pumpPalette(
          tester,
          setup: (scope) async {
            await scope.settings.setOwnedMarkerCodes(<String>{
              'decotime:91',
              'decotime:92',
            });
            await scope.settings.setScope(BrandScope.mixedBrands);
          },
        );
        // Copic is not among the brands in the mix.
        paletteSavedDraft.value = SavedPalette(
          id: 'copic',
          brandId: 'copic',
          name: 'Copic',
          baseCode: 'E08',
          baseName: 'Base',
          mode: PaletteMode.triad,
          paletteSize: 3,
          createdAtEpochMs: 0,
          colorCodes: <String>['E08', 'E09', 'E11'],
        );
        await tester.pumpAndSettle();
        final List<String> before = _rows(tester);
        expect(before, isNotEmpty);

        await tester.ensureVisible(_key('palette-regenerate'));
        await tester.tap(_key('palette-regenerate'));
        await tester.pumpAndSettle();

        expect(_rows(tester), before);
        expect(find.byType(PaletteStrip), findsOneWidget);
        expect(find.byType(PaletteErrorNote), findsNothing);
        expect(_key('palette-changed'), findsNothing);
        expect(_key('palette-other-brand-snack'), findsOneWidget);
        expect(find.textContaining('is from Copic'), findsOneWidget);
        expect(find.textContaining('Copic is not in use'), findsOneWidget);

        // A quick variation is told the same way and changes nothing.
        await tester.ensureVisible(find.text('Warmer'));
        await tester.tap(find.text('Warmer'));
        await tester.pumpAndSettle();
        expect(_rows(tester), before);
        expect(_key('palette-changed'), findsNothing);
        expect(_key('palette-other-brand-snack'), findsOneWidget);
      },
    );

    testWidgets('a base of the brand in use regenerates as before', (
      tester,
    ) async {
      await pumpPalette(tester);
      await enterBaseCode(tester, 'B08');
      await tester.ensureVisible(_key('palette-regenerate'));
      await tester.tap(_key('palette-regenerate'));
      await tester.pumpAndSettle();
      expect(_key('palette-other-brand-snack'), findsNothing);
      expect(_key('palette-changed'), findsOneWidget);
    });
  });

  group('a quick variation', () {
    testWidgets('is told once, by the Undo snack bar, and Undo restores', (
      tester,
    ) async {
      await pumpPalette(tester);
      await enterBaseCode(tester, 'B08');

      await tester.ensureVisible(find.text('Warmer'));
      await tester.tap(find.text('Warmer'));
      await tester.pumpAndSettle();
      final List<String> warmer = _rows(tester);

      await tester.ensureVisible(find.text('Cooler'));
      await tester.tap(find.text('Cooler'));
      await tester.pumpAndSettle();

      // One message, which names the variation and offers Undo.
      expect(find.byType(PaletteNoticeCard), findsNothing);
      expect(find.text(l10n.paletteVariationApplied('Cooler')), findsOneWidget);
      expect(find.textContaining('variation applied'), findsOneWidget);
      expect(find.text(l10n.paletteChanged), findsNothing);
      expect(find.text(l10n.paletteUndoButton), findsOneWidget);

      await tester.tap(find.text(l10n.paletteUndoButton));
      await tester.pumpAndSettle();
      expect(_rows(tester), warmer);
      // Nothing about the undone variation is left on the page.
      expect(find.byType(PaletteNoticeCard), findsNothing);
      expect(find.textContaining('variation applied'), findsNothing);
    });

    testWidgets('Undo brings back the note of the palette it replaced', (
      tester,
    ) async {
      await pumpPalette(tester);
      paletteSavedDraft.value = SavedPalette(
        id: 'stored',
        name: 'Stored',
        baseCode: 'B08',
        baseName: 'Blue',
        mode: PaletteMode.triad,
        paletteSize: 3,
        createdAtEpochMs: 0,
        colorCodes: <String>['B08', '120', 'BV19'],
      );
      await tester.pumpAndSettle();
      expect(find.text(l10n.paletteLoadedNotice('Stored')), findsOneWidget);

      await tester.ensureVisible(find.text('Cooler'));
      await tester.tap(find.text('Cooler'));
      await tester.pumpAndSettle();
      // The variation is the one message; the "loaded" note went with the
      // palette it described.
      expect(find.byType(PaletteNoticeCard), findsNothing);
      expect(find.textContaining('variation applied'), findsOneWidget);

      await tester.tap(find.text(l10n.paletteUndoButton));
      await tester.pumpAndSettle();
      expect(find.text(l10n.paletteLoadedNotice('Stored')), findsOneWidget);
      expect(find.textContaining('variation applied'), findsNothing);
    });
  });
}
