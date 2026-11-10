import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/ideas_engine.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/palette_advisor.dart';
import 'package:ink_lab/ui/pages/palette/palette_draft.dart';
import 'package:ink_lab/ui/pages/palette/palette_notes.dart';
import 'package:ink_lab/ui/pages/palette/palette_page.dart';
import 'package:ink_lab/ui/theme/app_typography.dart';
import 'package:ink_lab/ui/widgets/ink_button.dart';
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
    // The saved palettes moved to their own sheet: the page only offers the
    // header action, and the list is not painted on it.
    expect(
      find.byKey(const ValueKey<String>('palette-saved-palettes')),
      findsOneWidget,
    );
    expect(find.text(l10n.paletteSavedEmpty), findsNothing);
  });

  testWidgets('with a result, Save palette is the only primary button', (
    WidgetTester tester,
  ) async {
    await pumpPalette(tester);
    await enterBaseCode(tester, 'B08');

    final List<InkButton> primaries = tester
        .widgetList<InkButton>(find.byType(InkButton))
        .where((InkButton button) => button.variant == InkButtonVariant.primary)
        .toList();
    expect(primaries, hasLength(1));
    expect(primaries.single.key, const ValueKey<String>('palette-save'));
    expect(
      find.byKey(const ValueKey<String>('palette-regenerate')),
      findsOneWidget,
    );
    // Share, colour vision and clear wait in the result's "⋯".
    expect(find.byKey(const ValueKey<String>('palette-share')), findsNothing);
  });

  testWidgets('the actions keep their place with and without a result', (
    WidgetTester tester,
  ) async {
    await pumpPalette(tester);

    // Without a result: the row of secondaries and the empty slot of the
    // primary, which is already there.
    final Rect slotBefore = tester.getRect(
      find.byKey(const ValueKey<String>('palette-save-slot')),
    );
    final double generateHeight = tester
        .getRect(find.byKey(const ValueKey<String>('palette-generate')))
        .height;
    expect(find.byKey(const ValueKey<String>('palette-save')), findsNothing);

    await enterBaseCode(tester, 'B08');

    // With a result the slot is the same, so nothing below it moves.
    final Rect slotAfter = tester.getRect(
      find.byKey(const ValueKey<String>('palette-save-slot')),
    );
    expect(find.byKey(const ValueKey<String>('palette-save')), findsOneWidget);
    expect(
      slotAfter.height,
      moreOrLessEquals(slotBefore.height, epsilon: 0.01),
    );
    expect(slotAfter.width, moreOrLessEquals(slotBefore.width, epsilon: 0.01));
    // The primary takes the whole row.
    expect(
      tester.getRect(find.byKey(const ValueKey<String>('palette-save'))).width,
      moreOrLessEquals(slotAfter.width, epsilon: 0.01),
    );
    // The secondaries of the row are all the same size.
    expect(
      tester
          .getRect(find.byKey(const ValueKey<String>('palette-regenerate')))
          .height,
      moreOrLessEquals(generateHeight, epsilon: 0.01),
    );
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

    await choosePaletteType(tester, 'palette-scenario-toggle');

    expect(find.textContaining('as the default base'), findsOneWidget);
    expect(find.textContaining('Combinations ('), findsOneWidget);
  });

  for (final brand in [
    MarkerBrand.decoTime,
    MarkerBrand.copic,
    MarkerBrand.finecolour,
  ]) {
    testWidgets('${brand.label}: codes and ownership are validated', (
      WidgetTester tester,
    ) async {
      await pumpPalette(
        tester,
        brand: brand,
        // Ownership is brand-scoped for non-Ohuhu brands (`brandId:code`).
        ownedMarkerCodes: brand == MarkerBrand.finecolour
            ? {
                'finecolour:BV321',
                'finecolour:R140',
                'finecolour:B94',
                'finecolour:Y1',
                'finecolour:G45',
              }
            : brand == MarkerBrand.copic
            ? {'copic:BV04', 'copic:R29', 'copic:B05', 'copic:Y08', 'copic:G17'}
            : {'decotime:01', 'decotime:02', 'decotime:03'},
      );

      await enterBaseCode(tester, 'ZZZ');
      expect(
        find.textContaining('is not a ${brand.label} marker code'),
        findsOneWidget,
      );

      await enterBaseCode(
        tester,
        brand == MarkerBrand.finecolour
            ? 'E12'
            : brand == MarkerBrand.copic
            ? 'E00'
            : '05',
      );
      expect(find.textContaining('is not in your collection'), findsOneWidget);

      await enterBaseCode(
        tester,
        brand == MarkerBrand.finecolour
            ? 'BV321'
            : brand == MarkerBrand.copic
            ? 'BV04'
            : '02',
      );
      expect(find.textContaining('Combinations ('), findsOneWidget);
    });
  }

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

  testWidgets('a saved palette handed over from Settings loads in the page', (
    WidgetTester tester,
  ) async {
    final SavedPalette stored = SavedPalette(
      id: 'p7',
      brandId: MarkerBrand.ohuhuOahu.id,
      name: 'From settings',
      baseCode: 'B08',
      baseName: 'Cotton Candy Blue',
      mode: PaletteMode.triad,
      paletteSize: 3,
      createdAtEpochMs: 1,
      colorCodes: const <String>['B08', '120', 'BV19'],
    );
    await pumpPalette(tester);
    addTearDown(() => paletteSavedDraft.value = null);

    paletteSavedDraft.value = stored;
    await tester.pumpAndSettle();

    final TextField field = tester.widget<TextField>(
      find.byKey(const ValueKey<String>('palette-base-input')),
    );
    expect(field.controller?.text, 'B08');
    expect(find.textContaining('Combinations ('), findsOneWidget);
    // Consumed: it is not replayed.
    expect(paletteSavedDraft.value, isNull);
  });

  testWidgets('saving shows "saved" on the button and a snack bar, and a '
      'deleted palette can be saved again', (WidgetTester tester) async {
    final AppScope scope = await pumpPalette(tester);
    await enterBaseCode(tester, 'B08');
    expect(find.text(l10n.paletteSavedButton), findsNothing);

    await tester.tap(find.byKey(const ValueKey<String>('palette-save')));
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(const ValueKey<String>('palette-save-confirm')),
    );
    await tester.pumpAndSettle();

    // Where the finger is: the button, and a snack bar with the name.
    final Finder save = find.byKey(const ValueKey<String>('palette-save'));
    expect(
      find.descendant(of: save, matching: find.text(l10n.paletteSavedButton)),
      findsOneWidget,
    );
    expect(
      tester.widget<InkButton>(save).onPressed,
      isNull,
      reason: 'a saved palette is not saved twice',
    );
    expect(
      find.byKey(const ValueKey<String>('palette-saved-snack')),
      findsOneWidget,
    );
    // No banner at the top of the page.
    expect(find.byType(PaletteNoticeCard), findsNothing);

    // Deleting it makes the palette saveable again.
    final String id = scope.savedPalettes
        .palettesOf(MarkerBrand.ohuhuOahu)
        .single
        .id;
    await scope.savedPalettes.delete(MarkerBrand.ohuhuOahu, id);
    await tester.pumpAndSettle();
    expect(
      find.descendant(of: save, matching: find.text(l10n.paletteSaveButton)),
      findsOneWidget,
    );
    expect(tester.widget<InkButton>(save).onPressed, isNotNull);
  });

  testWidgets('a long marker name stays on one line', (
    WidgetTester tester,
  ) async {
    await pumpPalette(tester);
    tester.view.physicalSize = const Size(360, 3000);
    await tester.pumpAndSettle();
    final List<MarkerColor> catalog = await diskMarkerRepository().loadColors(
      MarkerBrand.ohuhuOahu,
    );
    final MarkerColor longest = catalog.reduce(
      (MarkerColor a, MarkerColor b) =>
          a.newName.length >= b.newName.length ? a : b,
    );
    await enterBaseCode(tester, longest.newCode);

    final Finder name = find.byKey(const ValueKey<String>('palette-base-name'));
    expect(name, findsOneWidget);
    expect(tester.widget<Text>(name).maxLines, 1);
    // One line, not two: the card does not grow with the name.
    expect(
      tester.getSize(name).height,
      lessThan(AppTypography.caption.fontSize! * 2),
    );
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

    await openSavedPalettesSheet(tester);
    await tester.tap(find.byKey(const ValueKey<String>('palette-load-p1')));
    await tester.pumpAndSettle();

    final TextField field = tester.widget<TextField>(
      find.byKey(const ValueKey<String>('palette-base-input')),
    );
    expect(field.controller?.text, 'B08');
    expect(find.textContaining('Combinations ('), findsOneWidget);
    expect(find.text('120'), findsWidgets);
  });

  testWidgets('a loaded palette shows each marker name, not the reason', (
    WidgetTester tester,
  ) async {
    final List<MarkerColor> catalog = await diskMarkerRepository().loadColors(
      MarkerBrand.ohuhuOahu,
    );
    final MarkerColor base = catalog.firstWhere((c) => c.newCode == 'B08');
    final List<MarkerColor> companions = catalog
        .where((MarkerColor c) => c.newCode != 'B08')
        .take(4)
        .toList();
    final SavedPalette stored = SavedPalette(
      id: 'p9',
      brandId: MarkerBrand.ohuhuOahu.id,
      name: 'Stored five',
      baseCode: base.newCode,
      baseName: base.newName,
      mode: PaletteMode.triad,
      paletteSize: 5,
      createdAtEpochMs: 1,
      colorCodes: <String>[
        base.newCode,
        for (final MarkerColor c in companions) c.newCode,
      ],
    );
    await pumpPalette(
      tester,
      setup: (AppScope scope) => scope.savedPalettes.save(stored),
    );

    await openSavedPalettesSheet(tester);
    await tester.tap(find.byKey(const ValueKey<String>('palette-load-p9')));
    await tester.pumpAndSettle();

    // The notice may say "loaded"; the rows must not repeat the reason.
    expect(find.text('Loaded palette'), findsNothing);
    for (final MarkerColor c in companions) {
      final Finder why = find.byKey(
        ValueKey<String>('palette-row-why-${c.newCode}'),
      );
      expect(why, findsOneWidget);
      expect(
        find.descendant(of: why, matching: find.text(c.newName)),
        findsOneWidget,
      );
    }
  });

  group('a saved palette row names its kind', () {
    SavedPalette saved(String id, {String? scene}) => SavedPalette(
      id: id,
      brandId: MarkerBrand.ohuhuOahu.id,
      name: 'Stored $id',
      baseCode: 'B08',
      baseName: 'Cotton Candy Blue',
      mode: PaletteMode.complementary,
      paletteSize: 5,
      createdAtEpochMs: 1,
      colorCodes: const <String>['B08', '120'],
      scenarioName: scene,
    );

    String subtitle(WidgetTester tester, String id) => tester
        .widget<Text>(
          find.descendant(
            of: find.byKey(ValueKey<String>('palette-saved-subtitle-$id')),
            matching: find.byType(Text),
          ),
        )
        .data!;

    testWidgets('a scene palette shows the scene, not the leftover mode', (
      WidgetTester tester,
    ) async {
      await pumpPalette(
        tester,
        setup: (AppScope scope) async {
          await scope.savedPalettes.save(
            saved('s1', scene: 'wildflowerMeadow'),
          );
          // An older save holds the wire value of the scene.
          await scope.savedPalettes.save(
            saved('s2', scene: 'WildflowerMeadow'),
          );
        },
      );
      await openSavedPalettesSheet(tester);
      expect(subtitle(tester, 's1'), 'Wildflower Meadow · 5 colours');
      expect(subtitle(tester, 's2'), 'Wildflower Meadow · 5 colours');
      expect(find.textContaining('Complementary ·'), findsNothing);
    });

    testWidgets(
      'an unknown scene reads as Scenes; a theory palette as its mode',
      (WidgetTester tester) async {
        await pumpPalette(
          tester,
          setup: (AppScope scope) async {
            await scope.savedPalettes.save(saved('s3', scene: 'goneScene'));
            await scope.savedPalettes.save(saved('s4'));
          },
        );
        await openSavedPalettesSheet(tester);
        expect(
          subtitle(tester, 's3'),
          '${l10n.paletteTypeScenesGroup} · 5 colours',
        );
        expect(subtitle(tester, 's4'), startsWith('Complementary'));
      },
    );
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

    await openSavedPalettesSheet(tester);
    await tapOverflowItem(tester, 'palette-saved-menu-p2', 'palette-delete-p2');
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

  testWidgets(
    'the empty state points to Scenes, a type right under the page title',
    (WidgetTester tester) async {
      await pumpPalette(tester);

      expect(find.text(l10n.paletteEmptyHint), findsOneWidget);
      expect(l10n.paletteEmptyHint, contains(l10n.paletteScenarioToggle));
      // The type field is the first control of the page.
      final Finder type = find.byKey(
        const ValueKey<String>('palette-type-field'),
      );
      final Finder base = find.byKey(
        const ValueKey<String>('palette-base-input'),
      );
      expect(type, findsOneWidget);
      expect(tester.getRect(type).bottom, lessThan(tester.getRect(base).top));
      expect(
        find.descendant(of: type, matching: find.text(l10n.modeRecommended)),
        findsOneWidget,
      );
    },
  );

  group('RoleLabel', () {
    Future<Text> pumpLabel(WidgetTester tester, double width) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: SizedBox(
              width: width,
              child: Align(
                alignment: Alignment.centerLeft,
                child: RoleLabel(
                  text: 'a very long role label that cannot fit',
                  style: AppTypography.capsStyle,
                ),
              ),
            ),
          ),
        ),
      );
      return tester.widget<Text>(find.byType(Text));
    }

    testWidgets('shrinks a little to stay on one line', (
      WidgetTester tester,
    ) async {
      final Text plain = await pumpLabel(tester, 1000);
      expect(plain.maxLines, 1);
      final double base = plain.style!.fontSize!;
      // Slightly too narrow: scaled down but not below the floor.
      final double full = tester.getSize(find.byType(Text)).width;
      final Text shrunk = await pumpLabel(tester, full * 0.9);
      expect(shrunk.maxLines, 1);
      expect(shrunk.style!.fontSize!, lessThan(base));
      expect(shrunk.style!.fontSize!, greaterThanOrEqualTo(base * 0.8));
    });

    testWidgets('wraps to two lines past the minimum scale', (
      WidgetTester tester,
    ) async {
      final Text plain = await pumpLabel(tester, 1000);
      final double base = plain.style!.fontSize!;
      final Text wrapped = await pumpLabel(tester, 80);
      expect(wrapped.maxLines, 2);
      expect(wrapped.overflow, TextOverflow.ellipsis);
      expect(wrapped.style!.fontSize!, closeTo(base * 0.8, 0.01));
    });
  });
}
