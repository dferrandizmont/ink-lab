import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/ideas_engine.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/palette_advisor.dart';
import 'package:ink_lab/ui/pages/palette/palette_draft.dart';
import 'package:ink_lab/ui/pages/palette/palette_page.dart';
import 'package:ink_lab/ui/theme/app_typography.dart';
import 'package:ink_lab/ui/widgets/ink_segmented.dart';
import 'package:ink_lab/ui/widgets/palette_strip.dart';

import 'palette_test_support.dart';
import '../../support/l10n.dart';

void main() {
  testWidgets('renders the palette builder inside a scope', (
    WidgetTester tester,
  ) async {
    await pumpPalette(tester);

    expect(find.byKey(PalettePage.pageKey), findsOneWidget);
    expect(
      find.byKey(const ValueKey<String>('palette-base-input')),
      findsOneWidget,
    );
    expect(
      find.text(AppTypography.caps(l10n.paletteBaseMarkerTitle)),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey<String>('palette-generate')),
      findsOneWidget,
    );
    expect(find.text('Recommended'), findsWidgets);
    expect(find.text(l10n.paletteSavedEmpty), findsOneWidget);
  });

  testWidgets('generates a palette from a base code, new or old spelling', (
    WidgetTester tester,
  ) async {
    await pumpPalette(tester);

    await enterBaseCode(tester, 'B08');
    expect(find.textContaining('Combinations ('), findsOneWidget);
    expect(find.byType(PaletteStrip), findsWidgets);
    expect(find.textContaining('B08'), findsWidgets);

    // The legacy spelling of the same marker resolves to the same colour.
    await enterBaseCode(tester, 'B289');
    expect(find.textContaining('B08'), findsWidgets);
    expect(find.textContaining('Combinations ('), findsOneWidget);
  });

  testWidgets('reports an unknown code in brand-aware language', (
    WidgetTester tester,
  ) async {
    await pumpPalette(tester);

    await enterBaseCode(tester, 'ZZZZ');

    expect(find.textContaining('not an Ink Lab marker code'), findsOneWidget);
  });

  testWidgets('the palette size chip changes the result size', (
    WidgetTester tester,
  ) async {
    await pumpPalette(tester);
    await enterBaseCode(tester, 'B08');

    await tester.tap(
      find.descendant(
        of: find.byType(InkSegmented<int>),
        matching: find.text('3'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Combinations (3)'), findsOneWidget);
  });

  testWidgets('scenario mode picks a default base and generates', (
    WidgetTester tester,
  ) async {
    await pumpPalette(tester);

    // The harmony chips scroll horizontally: bring the last one into view.
    await tester.ensureVisible(
      find.byKey(const ValueKey<String>('palette-scenario-toggle')),
    );
    await tester.tap(
      find.byKey(const ValueKey<String>('palette-scenario-toggle')),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('as the default base'), findsOneWidget);
    expect(find.textContaining('Combinations ('), findsOneWidget);
  });

  testWidgets('a DecoTime marker outside the owned set is rejected', (
    WidgetTester tester,
  ) async {
    await pumpPalette(
      tester,
      brand: MarkerBrand.decoTime,
      // Ownership is brand-scoped for non-Ohuhu brands (`brandId:code`).
      ownedMarkerCodes: const <String>{
        'decotime:01',
        'decotime:02',
        'decotime:03',
      },
    );

    await enterBaseCode(tester, 'ZZZ');
    expect(
      find.textContaining('is not a DecoTime marker code'),
      findsOneWidget,
    );

    await enterBaseCode(tester, '05');
    expect(find.textContaining('is not in your collection'), findsOneWidget);

    await enterBaseCode(tester, '02');
    expect(find.textContaining('Combinations ('), findsOneWidget);
  });

  testWidgets('saves the result to the brand repository', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpPalette(tester);
    await enterBaseCode(tester, 'B08');

    await tester.tap(find.byKey(const ValueKey<String>('palette-save')));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey<String>('palette-name-field')),
      'Ocean plan',
    );
    await tester.tap(
      find.byKey(const ValueKey<String>('palette-save-confirm')),
    );
    await tester.pumpAndSettle();

    final List<SavedPalette> saved = scope.savedPalettes.palettesOf(
      MarkerBrand.ohuhuOahu,
    );
    expect(saved, hasLength(1));
    expect(saved.single.name, 'Ocean plan');
    expect(saved.single.baseCode, 'B08');
    expect(saved.single.colorCodes, isNotEmpty);
    expect(find.textContaining('saved'), findsWidgets);
  });

  testWidgets('loads a saved palette back into the builder', (
    WidgetTester tester,
  ) async {
    final SavedPalette stored = SavedPalette(
      id: 'p1',
      brandId: MarkerBrand.ohuhuOahu.id,
      name: 'Stored',
      baseCode: 'B08',
      baseName: 'Cotton Candy Blue',
      mode: PaletteMode.triad,
      paletteSize: 3,
      createdAtEpochMs: 1,
      colorCodes: const <String>['B08', '120', 'BV19'],
    );
    final AppScope scope = await pumpPalette(
      tester,
      setup: (AppScope scope) => scope.savedPalettes.save(stored),
    );
    expect(scope.savedPalettes.palettesOf(MarkerBrand.ohuhuOahu), hasLength(1));

    await tester.tap(find.byKey(const ValueKey<String>('palette-load-p1')));
    await tester.pumpAndSettle();

    final TextField field = tester.widget<TextField>(
      find.byKey(const ValueKey<String>('palette-base-input')),
    );
    expect(field.controller?.text, 'B08');
    expect(find.textContaining('Combinations ('), findsOneWidget);
    expect(find.text('120'), findsWidgets);
  });

  testWidgets('deletes a saved palette', (WidgetTester tester) async {
    final SavedPalette stored = SavedPalette(
      id: 'p2',
      brandId: MarkerBrand.ohuhuOahu.id,
      name: 'To remove',
      baseCode: 'B08',
      baseName: 'Cotton Candy Blue',
      mode: PaletteMode.recommended,
      paletteSize: 3,
      createdAtEpochMs: 1,
      colorCodes: const <String>['B08'],
    );
    final AppScope scope = await pumpPalette(
      tester,
      setup: (AppScope scope) => scope.savedPalettes.save(stored),
    );

    await tester.tap(find.byKey(const ValueKey<String>('palette-delete-p2')));
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(const ValueKey<String>('palette-delete-confirm')),
    );
    await tester.pumpAndSettle();

    expect(scope.savedPalettes.palettesOf(MarkerBrand.ohuhuOahu), isEmpty);
  });

  testWidgets('applies a palette handed over from Ideas', (
    WidgetTester tester,
  ) async {
    addTearDown(() => paletteDraft.value = null);
    paletteDraft.value = PaletteDraft(
      title: 'Two-marker challenge',
      suggestions: <PaletteSuggestion>[
        PaletteSuggestion(
          color: markerColor('AA1', '#ffcccc'),
          reason: IdeaRoles.reasonFor(IdeaRoles.light),
          role: IdeaRoles.light,
        ),
        PaletteSuggestion(
          color: markerColor('AA2', '#660000'),
          reason: IdeaRoles.reasonFor(IdeaRoles.shadow),
          role: IdeaRoles.shadow,
        ),
      ],
    );

    await pumpPalette(tester);
    await tester.pumpAndSettle();

    expect(paletteDraft.value, isNull);
    expect(find.text('AA1'), findsWidgets);
    expect(find.text('AA2'), findsWidgets);
    expect(
      find.text(l10n.paletteIdeaApplied('Two-marker challenge', 2)),
      findsOneWidget,
    );
    // The roles and reasons of the idea are kept, not "Applied from Ideas".
    expect(
      find.text(l10n.reasonLabel(IdeaRoles.reasonFor(IdeaRoles.light))),
      findsWidgets,
    );
    expect(
      find.textContaining(l10n.reasonLabel('Applied from Ideas')),
      findsNothing,
    );
  });

  testWidgets('locks a colour so a variation keeps it', (
    WidgetTester tester,
  ) async {
    await pumpPalette(tester);
    await enterBaseCode(tester, 'B08');

    // Lock the first suggestion.
    final Finder firstLock = find.byTooltip(l10n.paletteLockButton).first;
    await tester.tap(firstLock);
    await tester.pumpAndSettle();
    expect(find.byTooltip(l10n.paletteUnlockButton), findsOneWidget);

    // Apply a variation; the locked colour must survive.
    await tester.ensureVisible(find.text('Warmer'));
    await tester.tap(find.text('Warmer'));
    await tester.pumpAndSettle();
    expect(find.byTooltip(l10n.paletteUnlockButton), findsOneWidget);
    expect(find.textContaining('variation applied'), findsOneWidget);
  });

  testWidgets('the base marker can be picked from a searchable list', (
    WidgetTester tester,
  ) async {
    await pumpPalette(tester);

    await tester.tap(find.byKey(const ValueKey<String>('palette-pick-base')));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey<String>('palette-base-picker')),
      findsOneWidget,
    );

    await tester.enterText(
      find.byKey(const ValueKey<String>('palette-picker-search')),
      'B08',
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey<String>('palette-picker-B08')));
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey<String>('palette-base-picker')),
      findsNothing,
    );
    final TextField field = tester.widget(
      find.byKey(const ValueKey<String>('palette-base-input')),
    );
    expect(field.controller!.text, 'B08');
    expect(find.byType(PaletteStrip), findsWidgets);
  });

  testWidgets('"Add to palette" from Swatches can be undone', (
    WidgetTester tester,
  ) async {
    addTearDown(() => paletteBaseDraft.value = null);
    await pumpPalette(tester);
    await enterBaseCode(tester, 'B08');
    expect(find.byType(PaletteStrip), findsWidgets);

    final MarkerColor other = markerColor('R16', '#f2a6a0');
    paletteBaseDraft.value = other;
    await tester.pumpAndSettle();

    final TextField field = tester.widget(
      find.byKey(const ValueKey<String>('palette-base-input')),
    );
    expect(field.controller!.text, 'R16');
    expect(find.text(l10n.paletteBaseReplaced('R16')), findsOneWidget);

    await tester.tap(find.text(l10n.paletteUndoButton));
    await tester.pumpAndSettle();
    expect(field.controller!.text, 'B08');
  });

  testWidgets('"Add to palette" on an empty palette just sets the base', (
    WidgetTester tester,
  ) async {
    addTearDown(() => paletteBaseDraft.value = null);
    await pumpPalette(tester);

    paletteBaseDraft.value = markerColor('B08', '#9fd6ee');
    await tester.pumpAndSettle();

    expect(find.text(l10n.paletteBaseReplaced('B08')), findsNothing);
  });

  testWidgets('the empty state points to the Scenes chip, which is near', (
    WidgetTester tester,
  ) async {
    await pumpPalette(tester);

    expect(find.text(l10n.paletteEmptyHint), findsOneWidget);
    expect(l10n.paletteEmptyHint, contains(l10n.paletteScenarioToggle));
    final double recommended = tester
        .getRect(find.byKey(const ValueKey<String>('palette-mode-recommended')))
        .right;
    final double scenes = tester
        .getRect(find.byKey(const ValueKey<String>('palette-scenario-toggle')))
        .left;
    expect(scenes, greaterThan(recommended));
    expect(scenes - recommended, lessThan(24));
  });
}
