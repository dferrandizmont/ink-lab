import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/palette_advisor.dart';
import 'package:ink_lab/ui/pages/palette/palette_base_field.dart';
import 'package:ink_lab/ui/pages/palette/palette_base_picker_sheet.dart';
import 'package:ink_lab/ui/pages/palette/palette_draft.dart';
import 'package:ink_lab/ui/pages/palette/palette_notes.dart';
import 'package:ink_lab/ui/pages/palette/palette_suggestion_row.dart';
import 'package:ink_lab/ui/pages/palette/palette_type_fields.dart';
import 'package:ink_lab/ui/theme/app_typography.dart';
import 'package:ink_lab/ui/widgets/branded_code.dart';
import 'package:ink_lab/ui/widgets/ink_button.dart';
import 'package:ink_lab/ui/widgets/palette_strip.dart';

import '../../support/l10n.dart';
import 'palette_test_support.dart';

Finder key(String value) => find.byKey(ValueKey<String>(value));
Map<String, Object?> snapshot(WidgetTester tester) {
  final field = tester.widget<PaletteBaseAndSize>(
    find.byType(PaletteBaseAndSize),
  );
  final type = tester.widget<PaletteTypeFields>(find.byType(PaletteTypeFields));
  return {
    'base': field.baseController.text,
    'size': field.paletteSize,
    'mode': type.mode,
    'scenes': type.useScenario,
    'scene': type.scenario.id,
    'photo': type.photoScene,
    'photoPicks': type.photoPicks,
    'rows': [
      for (final r in tester.widgetList<PaletteSuggestionRow>(
        find.byType(PaletteSuggestionRow),
      ))
        {'suggestion': r.suggestion.toJson(), 'locked': r.locked},
    ],
    'strip': [
      for (final s in tester.widgetList<PaletteStrip>(
        find.byType(PaletteStrip),
      ))
        s.labels,
    ],
    'brands': [
      for (final s in tester.widgetList<PaletteStrip>(
        find.byType(PaletteStrip),
      ))
        s.brandLabels,
    ],
  };
}

PaletteStrip strip(WidgetTester tester) =>
    tester.widgetList<PaletteStrip>(find.byType(PaletteStrip)).first;

PaletteBaseAndSize baseField(WidgetTester tester) =>
    tester.widget<PaletteBaseAndSize>(find.byType(PaletteBaseAndSize));

/// Ohuhu's default set plus two DecoTime markers, with "Mix my brands" on.
Future<void> mixOhuhuAndDecoTime(AppScope scope) async {
  await scope.settings.setOwnedMarkerCodes({'decotime:91', 'decotime:92'});
  await scope.settings.setScope(BrandScope.mixedBrands);
}

/// Saves the palette on screen as [name].
Future<SavedPalette> savePaletteAs(
  WidgetTester tester,
  AppScope scope,
  String name,
) async {
  await tester.ensureVisible(key('palette-save'));
  await tester.tap(key('palette-save'));
  await tester.pumpAndSettle();
  await tester.enterText(key('palette-name-field'), name);
  await tester.tap(key('palette-save-confirm'));
  await tester.pumpAndSettle();
  return scope.savedPalettes.all.firstWhere((p) => p.name == name);
}

Future<void> undo(WidgetTester tester) async {
  expect(key('palette-changed'), findsOneWidget);
  await tester.tap(find.text(l10n.paletteUndoButton));
  await tester.pumpAndSettle();
}

void main() {
  for (final Size size in [const Size(390, 844), const Size(844, 390)]) {
    for (final double scale in [1.0, 2.0]) {
      testWidgets(
        'Undo floats above Save and leaves it tappable ($size, x$scale)',
        (tester) async {
          await pumpPalette(tester);
          tester.view.physicalSize = size;
          tester.platformDispatcher.textScaleFactorTestValue = scale;
          addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
          await tester.pumpAndSettle();
          await enterBaseCode(tester, 'B08');
          final Finder scrollable = find
              .descendant(
                of: find.byType(ListView),
                matching: find.byType(Scrollable),
              )
              .first;
          await tester.scrollUntilVisible(
            key('palette-regenerate'),
            200,
            scrollable: scrollable,
          );
          await tester.tap(key('palette-regenerate'));
          await tester.pumpAndSettle();
          await tester.scrollUntilVisible(
            key('palette-save'),
            200,
            scrollable: scrollable,
          );
          final position = tester.state<ScrollableState>(scrollable).position;
          position.jumpTo(position.maxScrollExtent);
          await tester.pumpAndSettle();
          final Rect save = tester.getRect(key('palette-save'));
          final Rect snack = tester.getRect(
            find
                .descendant(
                  of: find.byType(SnackBar),
                  matching: find.byType(Material),
                )
                .first,
          );
          expect(snack.bottom, lessThanOrEqualTo(save.top));
          expect(save.bottom, lessThanOrEqualTo(size.height));
          await tester.tap(key('palette-save'));
          await tester.pumpAndSettle();
          expect(key('palette-name-field'), findsOneWidget);
          expect(tester.takeException(), isNull);
        },
      );
    }
  }

  testWidgets('same-code mixed markers have independent locks', (tester) async {
    final scope = await pumpPalette(
      tester,
      setup: (scope) async {
        await scope.settings.setOwnedMarkerCodes({'decotime:120'});
        await scope.settings.setScope(BrandScope.mixedBrands);
      },
    );
    final ohuhu = (await scope.markers.loadColors(MarkerBrand.ohuhuOahu))
        .firstWhere((c) => c.newCode == '120');
    final deco = (await scope.markers.loadColors(MarkerBrand.decoTime))
        .firstWhere((c) => c.newCode == '120');
    paletteDraft.value = PaletteDraft(
      suggestions: [
        PaletteSuggestion(color: ohuhu, reason: 'Base'),
        PaletteSuggestion(color: deco, reason: 'Accent'),
      ],
    );
    await tester.pumpAndSettle();
    List<PaletteSuggestionRow> rows() => tester
        .widgetList<PaletteSuggestionRow>(find.byType(PaletteSuggestionRow))
        .toList();
    rows()[0].onToggleLock!();
    await tester.pumpAndSettle();
    expect(rows().map((r) => r.locked), [true, false]);
    rows()[1].onToggleLock!();
    await tester.pumpAndSettle();
    rows()[0].onToggleLock!();
    await tester.pumpAndSettle();
    expect(rows().map((r) => r.locked), [false, true]);
  });
  testWidgets(
    'a bare shared base code asks for its brand and scoped input resolves',
    (tester) async {
      await pumpPalette(
        tester,
        setup: (scope) async {
          await scope.settings.setOwnedMarkerCodes({
            'decotime:120',
            'decotime:91',
          });
          await scope.settings.setScope(BrandScope.mixedBrands);
        },
      );
      await tester.enterText(key('palette-base-input'), '120');
      await tester.pumpAndSettle();
      expect(find.text(l10n.paletteAmbiguousBase), findsOneWidget);
      final field = tester.widget<PaletteBaseAndSize>(
        find.byType(PaletteBaseAndSize),
      );
      expect(field.resolvedBase, isNull);
      await enterBaseCode(tester, 'decotime:120');
      expect(
        tester
            .widget<PaletteBaseAndSize>(find.byType(PaletteBaseAndSize))
            .resolvedBase!
            .brandId,
        'decotime',
      );
    },
  );
  setUpAll(loadAppFonts);
  tearDown(() {
    paletteSavedDraft.value = null;
  });
  for (final action in [
    'regenerate',
    'variation',
    'type',
    'size',
    'scenes',
    'scene',
  ]) {
    testWidgets('undo $action restores palette inputs, markers and locks', (
      tester,
    ) async {
      await pumpPalette(tester);
      await enterBaseCode(tester, 'B08');
      if (action == 'scene') {
        await choosePaletteType(tester, 'palette-scenario-toggle');
      }
      if (action == 'regenerate' || action == 'variation' || action == 'size') {
        tester
            .widgetList<PaletteSuggestionRow>(find.byType(PaletteSuggestionRow))
            .first
            .onToggleLock!();
        await tester.pumpAndSettle();
      }
      final before = snapshot(tester);
      switch (action) {
        case 'regenerate':
          await tester.tap(key('palette-regenerate'));
        case 'variation':
          await tester.tap(find.text(l10n.variationLabelMoreVibrant));
        case 'type':
          await choosePaletteType(tester, 'palette-mode-triad');
        case 'size':
          tester
              .widget<PaletteBaseAndSize>(find.byType(PaletteBaseAndSize))
              .onSizeChanged(3);
        case 'scenes':
          await choosePaletteType(tester, 'palette-scenario-toggle');
        case 'scene':
          await openPaletteSceneSheet(tester);
          await tester.tap(key('palette-scene-cuteCharacter'));
          await tester.pumpAndSettle();
      }
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
      await undo(tester);
      expect(snapshot(tester), before);
    });
  }
  testWidgets('a losing lock asks first; cancel leaves every field intact', (
    tester,
  ) async {
    await pumpPalette(tester);
    await enterBaseCode(tester, 'B08');
    tester
        .widgetList<PaletteSuggestionRow>(find.byType(PaletteSuggestionRow))
        .last
        .onToggleLock!();
    await tester.pumpAndSettle();
    final before = snapshot(tester);
    await choosePaletteType(tester, 'palette-mode-triad');
    expect(find.text(l10n.paletteReplaceTitle), findsOneWidget);
    await tester.tap(find.text(l10n.settingsCancel));
    await tester.pumpAndSettle();
    expect(snapshot(tester), before);
    await choosePaletteType(tester, 'palette-mode-triad');
    await tester.tap(find.text(l10n.paletteReplaceButton));
    await tester.pumpAndSettle();
    await undo(tester);
    expect(snapshot(tester), before);
  });
  testWidgets(
    'a loaded palette asks only after an edit, and undo restores its notice',
    (tester) async {
      await pumpPalette(tester);
      paletteSavedDraft.value = SavedPalette(
        id: 'stored',
        name: 'Stored',
        baseCode: 'B08',
        baseName: 'Blue',
        mode: PaletteMode.triad,
        paletteSize: 3,
        createdAtEpochMs: 0,
        colorCodes: ['B08', '120', 'BV19'],
      );
      await tester.pumpAndSettle();
      final row = tester
          .widgetList<PaletteSuggestionRow>(find.byType(PaletteSuggestionRow))
          .first;
      row.onToggleLock!();
      await tester.pumpAndSettle();
      final before = snapshot(tester);
      await tester.tap(key('palette-regenerate'));
      await tester.pumpAndSettle();
      expect(find.text(l10n.paletteReplaceTitle), findsOneWidget);
      await tester.tap(find.text(l10n.paletteReplaceButton));
      await tester.pumpAndSettle();
      await undo(tester);
      expect(snapshot(tester), before);
      expect(find.text(l10n.paletteLoadedNotice('Stored')), findsOneWidget);
    },
  );
  testWidgets(
    'an untouched loaded palette never asks, and agreeing once is enough',
    (tester) async {
      await pumpPalette(tester);
      paletteSavedDraft.value = SavedPalette(
        id: 'stored',
        name: 'Stored',
        baseCode: 'B08',
        baseName: 'Blue',
        mode: PaletteMode.triad,
        paletteSize: 3,
        createdAtEpochMs: 0,
        colorCodes: ['B08', '120', 'BV19'],
      );
      await tester.pumpAndSettle();
      final loaded = snapshot(tester);
      // Nothing was changed by hand: Regenerate replaces it and Undo covers it.
      await tester.tap(key('palette-regenerate'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
      // The note about the palette that was replaced went with it.
      expect(find.text(l10n.paletteLoadedNotice('Stored')), findsNothing);
      await undo(tester);
      expect(snapshot(tester), loaded);
      // A lock is work on the loaded palette: now the replacement asks...
      tester
          .widgetList<PaletteSuggestionRow>(find.byType(PaletteSuggestionRow))
          .first
          .onToggleLock!();
      await tester.pumpAndSettle();
      await tester.tap(key('palette-regenerate'));
      await tester.pumpAndSettle();
      expect(find.text(l10n.paletteReplaceTitle), findsOneWidget);
      expect(find.text(l10n.paletteReplaceBody), findsOneWidget);
      await tester.tap(find.text(l10n.paletteReplaceButton));
      await tester.pumpAndSettle();
      // ...once: what is on screen now is a fresh result.
      await tester.tap(key('palette-regenerate'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
    },
  );
  testWidgets('a size that cannot keep every lock asks first', (tester) async {
    await pumpPalette(tester);
    await enterBaseCode(tester, 'B08');
    for (var i = 0; i < 3; i++) {
      tester
          .widgetList<PaletteSuggestionRow>(find.byType(PaletteSuggestionRow))
          .elementAt(i)
          .onToggleLock!();
      await tester.pumpAndSettle();
    }
    final before = snapshot(tester);
    void size(int value) => tester
        .widget<PaletteBaseAndSize>(find.byType(PaletteBaseAndSize))
        .onSizeChanged(value);
    // Four colours keep the three locked companions: nothing to ask.
    size(4);
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    await undo(tester);
    expect(snapshot(tester), before);
    // Three colours have room for two of them only.
    size(3);
    await tester.pumpAndSettle();
    expect(find.text(l10n.paletteReplaceTitle), findsOneWidget);
    await tester.tap(find.text(l10n.settingsCancel));
    await tester.pumpAndSettle();
    expect(snapshot(tester), before);
  });
  testWidgets('typing a base keeps Undo on the palette the user started from', (
    tester,
  ) async {
    await pumpPalette(
      tester,
      brand: MarkerBrand.decoTime,
      ownedMarkerCodes: {
        for (final code in ['03', '05', '07', '12', '91', '92', '120'])
          'decotime:$code',
      },
    );
    await enterBaseCode(tester, '91');
    final before = snapshot(tester);
    // "12" is a marker on the way to "120": two palettes replace the first.
    await tester.enterText(key('palette-base-input'), '12');
    await tester.pump();
    expect(key('palette-changed'), findsOneWidget);
    await tester.enterText(key('palette-base-input'), '120');
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    await undo(tester);
    expect(snapshot(tester), before);
  });
  testWidgets('doing the same again changes nothing and offers no undo', (
    tester,
  ) async {
    await pumpPalette(tester);
    await enterBaseCode(tester, 'B08');
    tester
        .widget<PaletteBaseAndSize>(find.byType(PaletteBaseAndSize))
        .onSizeChanged(5);
    await tester.pumpAndSettle();
    expect(key('palette-changed'), findsNothing);
  });
  testWidgets(
    'a saved palette stores the brand of each marker only when brands mix',
    (tester) async {
      final scope = await pumpPalette(tester);
      Future<SavedPalette> saveAs(String name) async {
        await tester.ensureVisible(key('palette-save'));
        await tester.tap(key('palette-save'));
        await tester.pumpAndSettle();
        await tester.enterText(key('palette-name-field'), name);
        await tester.tap(key('palette-save-confirm'));
        await tester.pumpAndSettle();
        return scope.savedPalettes
            .palettesOf(MarkerBrand.ohuhuOahu)
            .firstWhere((p) => p.name == name);
      }

      // One brand: bare codes of the palette's brand, as always.
      await enterBaseCode(tester, 'B08');
      final single = await saveAs('Single');
      expect(single.baseCode, 'B08');
      expect(single.colorCodes.any((c) => c.contains(':')), isFalse);
      expect(single.showsBrandsUnder(single.brandId), isFalse);
      // Mixed: every marker with its brand, under the active brand.
      await scope.settings.setOwnedMarkerCodes({'decotime:91', 'decotime:92'});
      await scope.settings.setScope(BrandScope.mixedBrands);
      await tester.pumpAndSettle();
      await enterBaseCode(tester, 'DecoTime 91');
      final mixed = await saveAs('Mixed');
      expect(mixed.baseCode, 'decotime:91');
      expect(mixed.colorCodes.every((c) => c.contains(':')), isTrue);
      expect(mixed.brandIds, {'decotime', 'ohuhu_oahu'});
      expect(mixed.colorIds.first, 'decotime:91');
    },
  );
  testWidgets(
    'mixed base picker groups brands and the palette prefixes every code',
    (tester) async {
      await pumpPalette(
        tester,
        setup: (scope) async {
          await scope.settings.setOwnedMarkerCodes({
            'decotime:91',
            'decotime:92',
          });
          await scope.settings.setScope(BrandScope.mixedBrands);
        },
      );
      await enterBaseCode(tester, 'decotime:91');
      // The strip: the bare code, never scaled, under its brand.
      final labels = strip(tester).labels!;
      final brands = strip(tester).brandLabels!;
      expect(labels.first, '91');
      expect(brands.first, 'DecoTime');
      expect(brands, hasLength(labels.length));
      expect(brands.toSet(), {'Ohuhu', 'DecoTime'});
      expect(labels.any((l) => l.contains(' ')), isFalse);
      expect(
        find.descendant(
          of: find.byType(PaletteStrip),
          matching: find.byType(FittedBox),
        ),
        findsNothing,
      );
      // Every row names its marker with the one shared widget.
      final rows = tester
          .widgetList<PaletteSuggestionRow>(find.byType(PaletteSuggestionRow))
          .toList();
      expect(
        find.descendant(
          of: find.byType(PaletteSuggestionRow),
          matching: find.byType(BrandedCode),
        ),
        findsNWidgets(rows.length),
      );
      final choices = tester.widget<PaletteBaseAndSize>(
        find.byType(PaletteBaseAndSize),
      );
      choices.onPickBase();
      await tester.pumpAndSettle();
      expect(find.byType(PaletteBasePickerSheet), findsOneWidget);
      // Each brand is a group under its name.
      expect(key('palette-picker-brand-ohuhu_oahu'), findsOneWidget);
      expect(find.text(AppTypography.caps('Ohuhu')), findsOneWidget);
      await tester.enterText(key('palette-picker-search'), 'DecoTime');
      await tester.pumpAndSettle();
      expect(key('palette-picker-brand-ohuhu_oahu'), findsNothing);
      expect(find.text(AppTypography.caps('DecoTime')), findsOneWidget);
      // Under its brand's head a row shows the bare code, as with one brand.
      expect(
        find.descendant(
          of: key('palette-picker-decotime:91'),
          matching: find.text('91'),
        ),
        findsOneWidget,
      );
      expect(find.text('DecoTime 91'), findsNothing);
    },
  );

  // ---- Review: a change of brand or of the mix never destroys the palette.
  testWidgets(
    'turning the mix off keeps the mixed palette, with no false error',
    (tester) async {
      final scope = await pumpPalette(tester, setup: mixOhuhuAndDecoTime);
      await enterBaseCode(tester, 'DecoTime 91');
      final before = snapshot(tester);
      expect(before['rows'], isNotEmpty);
      expect(strip(tester).brandLabels, isNotNull);

      await scope.settings.setScope(BrandScope.singleBrand);
      await tester.pumpAndSettle();
      // Nothing moved: the same markers, each still with its brand, the same
      // base, and nothing to undo because nothing was replaced.
      expect(snapshot(tester), before);
      expect(baseField(tester).resolvedBase!.colorId, 'decotime:91');
      expect(find.byType(PaletteErrorNote), findsNothing);
      expect(key('palette-changed'), findsNothing);

      // The next palette is the user's move. Its base is of a brand that is
      // not in use, which is what the page says (not "not in your
      // collection": the user owns it), and Undo brings the palette back.
      await tester.tap(key('palette-regenerate'));
      await tester.pumpAndSettle();
      expect(find.textContaining('is a DecoTime marker'), findsOneWidget);
      expect(find.textContaining('is not in your collection'), findsNothing);
      await undo(tester);
      expect(snapshot(tester), before);
    },
  );
  testWidgets(
    'a palette is not kept with a marker the user can no longer use',
    (tester) async {
      final scope = await pumpPalette(
        tester,
        setup: (scope) async {
          await scope.settings.setOwnedMarkerCodes({'decotime:91'});
          await scope.settings.setScope(BrandScope.mixedBrands);
        },
      );
      await enterBaseCode(tester, 'DecoTime 91');
      expect(find.byType(PaletteStrip), findsOneWidget);
      // The only DecoTime marker runs dry: there is nothing left to mix, and
      // the palette built on it goes, with the true reason.
      await scope.dried.add('decotime:91');
      await tester.pumpAndSettle();
      expect(find.byType(PaletteStrip), findsNothing);
      expect(find.text(l10n.paletteBaseDried('DECOTIME 91')), findsOneWidget);
    },
  );
  testWidgets('changing brand keeps the palette and names its brand', (
    tester,
  ) async {
    final scope = await pumpPalette(
      tester,
      ownedMarkerCodes: {'decotime:91', 'decotime:92'},
    );
    await enterBaseCode(tester, 'B08');
    final before = snapshot(tester);
    expect(strip(tester).brandLabels, isNull);

    await scope.settings.setBrand(MarkerBrand.decoTime);
    await tester.pumpAndSettle();
    expect(snapshot(tester)['rows'], before['rows']);
    expect(snapshot(tester)['strip'], before['strip']);
    // "B08" alone would now be read as a DecoTime code.
    expect(baseField(tester).baseController.text, 'Ohuhu B08');
    expect(baseField(tester).resolvedBase!.colorId, 'ohuhu_oahu:B08');
    expect(strip(tester).brandLabels, everyElement('Ohuhu'));
    expect(find.byType(PaletteErrorNote), findsNothing);
    expect(key('palette-changed'), findsNothing);

    // Back to its brand it is the single-brand page again, untouched.
    await scope.settings.setBrand(MarkerBrand.ohuhuOahu);
    await tester.pumpAndSettle();
    expect(snapshot(tester), before);
  });
  testWidgets(
    'a change of collection takes down the Undo and the flags of the old one',
    (tester) async {
      final scope = await pumpPalette(tester);
      paletteSavedDraft.value = SavedPalette(
        id: 'stored',
        name: 'Stored',
        baseCode: 'B08',
        baseName: 'Blue',
        mode: PaletteMode.triad,
        paletteSize: 3,
        createdAtEpochMs: 0,
        colorCodes: ['B08', '120', 'BV19'],
      );
      await tester.pumpAndSettle();
      await tester.tap(key('palette-regenerate'));
      await tester.pumpAndSettle();
      await undo(tester);
      await tester.tap(key('palette-regenerate'));
      await tester.pumpAndSettle();
      expect(key('palette-changed'), findsOneWidget);
      // A marker of the palette leaves the collection: the palette is built
      // again without it, as always...
      final String gone = rowCodes(tester).first;
      await scope.dried.add('ohuhu_oahu:$gone');
      await tester.pumpAndSettle();
      expect(rowCodes(tester), isNot(contains(gone)));
      // ...and the Undo of the old collection is gone with it: it would bring
      // the dried marker back.
      expect(key('palette-changed'), findsNothing);
      expect(find.text(l10n.paletteUndoButton), findsNothing);
    },
  );
  testWidgets(
    'a loaded palette replaced by a change of collection is a fresh result',
    (tester) async {
      final scope = await pumpPalette(tester);
      paletteSavedDraft.value = SavedPalette(
        id: 'stored',
        name: 'Stored',
        baseCode: 'B08',
        baseName: 'Blue',
        mode: PaletteMode.triad,
        paletteSize: 3,
        createdAtEpochMs: 0,
        colorCodes: ['B08', '120', 'BV19'],
      );
      await tester.pumpAndSettle();
      expect(rowCodes(tester), ['120', 'BV19']);
      await scope.dried.add('ohuhu_oahu:BV19');
      await tester.pumpAndSettle();
      expect(rowCodes(tester), isNot(contains('BV19')));
      // Its note went with it, and a lock on the new result is not an edit
      // of a palette the user keeps: Regenerate does not ask.
      expect(find.text(l10n.paletteLoadedNotice('Stored')), findsNothing);
      tester
          .widgetList<PaletteSuggestionRow>(find.byType(PaletteSuggestionRow))
          .first
          .onToggleLock!();
      await tester.pumpAndSettle();
      await tester.tap(key('palette-regenerate'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
    },
  );

  // ---- Review: the same base again is not a replacement.
  testWidgets(
    'the same base handed over or picked again changes nothing and asks nothing',
    (tester) async {
      final scope = await pumpPalette(tester);
      final ohuhu = await scope.markers.loadColors(MarkerBrand.ohuhuOahu);
      MarkerColor marker(String code) =>
          ohuhu.firstWhere((c) => c.newCode == code);
      await enterBaseCode(tester, 'B08');
      await tester.tap(key('palette-regenerate'));
      await tester.pumpAndSettle();
      tester
          .widgetList<PaletteSuggestionRow>(find.byType(PaletteSuggestionRow))
          .first
          .onToggleLock!();
      await tester.pumpAndSettle();
      final before = snapshot(tester);

      // Swatches hands the same marker over.
      paletteBaseDraft.value = marker('B08');
      await tester.pumpAndSettle();
      expect(paletteBaseDraft.value, isNull);
      expect(find.byType(AlertDialog), findsNothing);
      expect(key('palette-base-replaced'), findsNothing);
      expect(snapshot(tester), before);

      // The same marker picked in the list.
      baseField(tester).onPickBase();
      await tester.pumpAndSettle();
      await tester.enterText(key('palette-picker-search'), 'B08');
      await tester.pumpAndSettle();
      await tester.tap(key('palette-picker-B08'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
      expect(snapshot(tester), before);

      // Another marker is a replacement that loses the lock: it asks.
      paletteBaseDraft.value = marker('120');
      await tester.pumpAndSettle();
      expect(find.text(l10n.paletteReplaceTitle), findsOneWidget);
      await tester.tap(find.text(l10n.settingsCancel));
      await tester.pumpAndSettle();
      expect(snapshot(tester), before);
    },
  );

  // ---- Review: the rule for asking, both ways.
  testWidgets(
    'a fresh palette with a lock asks only when the action drops the lock',
    (tester) async {
      await pumpPalette(tester);
      await enterBaseCode(tester, 'B08');
      tester
          .widgetList<PaletteSuggestionRow>(find.byType(PaletteSuggestionRow))
          .first
          .onToggleLock!();
      await tester.pumpAndSettle();
      final String locked = rowCodes(tester).first;
      // Regenerate and a variation keep the lock: nothing to ask.
      await tester.tap(key('palette-regenerate'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
      expect(rowCodes(tester).first, locked);
      await tester.tap(find.text(l10n.variationLabelMoreVibrant));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
      expect(rowCodes(tester).first, locked);
      // Another type drops it: that one asks.
      await choosePaletteType(tester, 'palette-mode-triad');
      expect(find.text(l10n.paletteReplaceTitle), findsOneWidget);
      await tester.tap(find.text(l10n.settingsCancel));
      await tester.pumpAndSettle();
      expect(rowCodes(tester).first, locked);
    },
  );

  // ---- Review: a mixed palette is listed under each of its brands, once.
  testWidgets(
    'a saved mixed palette is listed under each of its brands and saved once',
    (tester) async {
      final scope = await pumpPalette(tester, setup: mixOhuhuAndDecoTime);
      await enterBaseCode(tester, 'DecoTime 91');
      final SavedPalette saved = await savePaletteAs(tester, scope, 'Mixed');
      expect(saved.brandId, 'ohuhu_oahu');
      expect(saved.brandIds, {'decotime', 'ohuhu_oahu'});
      expect(find.text(l10n.paletteSavedButton), findsOneWidget);

      // The other brand of the mix becomes the active one.
      await scope.settings.setBrand(MarkerBrand.decoTime);
      await tester.pumpAndSettle();
      // The palette on screen is still the saved one: it cannot be saved a
      // second time under this brand.
      expect(find.text(l10n.paletteSavedButton), findsOneWidget);
      expect(tester.widget<InkButton>(key('palette-save')).onPressed, isNull);
      expect(scope.savedPalettes.all, hasLength(1));

      // And it is in this brand's list too, each code under its brand.
      await openSavedPalettesSheet(tester);
      expect(key('palette-load-${saved.id}'), findsOneWidget);
      final PaletteStrip row = tester.widget<PaletteStrip>(
        find.descendant(
          of: key('palette-saved-list'),
          matching: find.byType(PaletteStrip),
        ),
      );
      expect(row.labels!.first, '91');
      expect(row.brandLabels!.toSet(), {'Ohuhu', 'DecoTime'});

      // Deleted from this list, it is gone from storage: under the brand it
      // was saved with, not the brand of the list.
      await tapOverflowItem(
        tester,
        'palette-saved-menu-${saved.id}',
        'palette-delete-${saved.id}',
      );
      await tester.tap(key('palette-delete-confirm'));
      await tester.pumpAndSettle();
      expect(scope.savedPalettes.all, isEmpty);
      expect(key('palette-load-${saved.id}'), findsNothing);
      await closeSheet(tester);
      // Saveable again.
      expect(find.text(l10n.paletteSaveButton), findsOneWidget);
    },
  );
  testWidgets(
    'a saved palette is named after its base with the brand it needs',
    (tester) async {
      final scope = await pumpPalette(tester, setup: mixOhuhuAndDecoTime);
      await enterBaseCode(tester, 'DecoTime 91');
      await tester.ensureVisible(key('palette-save'));
      await tester.tap(key('palette-save'));
      await tester.pumpAndSettle();
      expect(
        tester.widget<TextField>(key('palette-name-field')).controller!.text,
        'DecoTime 91 ${l10n.modeLabel(PaletteMode.recommended)}',
      );
      await tester.tap(find.text(l10n.paletteSaveDialogCancel));
      await tester.pumpAndSettle();
      // With one brand the name is the bare code, as always.
      await scope.settings.setScope(BrandScope.singleBrand);
      await tester.pumpAndSettle();
      await enterBaseCode(tester, 'B08');
      await tester.ensureVisible(key('palette-save'));
      await tester.tap(key('palette-save'));
      await tester.pumpAndSettle();
      expect(
        tester.widget<TextField>(key('palette-name-field')).controller!.text,
        'B08 ${l10n.modeLabel(PaletteMode.recommended)}',
      );
    },
  );

  // ---- Review: the picker with one brand searches as it always did.
  testWidgets(
    'with one brand the picker searches by code and name, and by the whole '
    'brand name',
    (tester) async {
      await pumpPalette(tester);
      baseField(tester).onPickBase();
      await tester.pumpAndSettle();
      Future<void> search(String text) async {
        await tester.enterText(key('palette-picker-search'), text);
        await tester.pumpAndSettle();
      }

      // A few letters are a search by code and name: they must not match the
      // brand's own name and list every marker.
      await search('uhu');
      expect(find.text(l10n.palettePickerEmpty), findsOneWidget);
      // The whole brand name is read as "this brand".
      await search('Ohuhu');
      expect(find.text(l10n.palettePickerEmpty), findsNothing);
      await search('ohuhu b08');
      expect(key('palette-picker-B08'), findsOneWidget);
      await search('ohuhu zz99');
      expect(find.text(l10n.palettePickerEmpty), findsOneWidget);
      // No group heads and no brand in a list of one brand.
      await search('B08');
      expect(key('palette-picker-brand-ohuhu_oahu'), findsNothing);
      expect(find.byType(BrandedCode), findsNothing);
    },
  );

  testWidgets('the whole-range note of a mixed chain names no single brand', (
    tester,
  ) async {
    // Three markers in all: too few for a chain, so the range is offered.
    await pumpPalette(
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
    await enterBaseCode(tester, 'DecoTime 91');
    await tester.ensureVisible(key('palette-chain-whole-range'));
    await tester.tap(key('palette-chain-whole-range'));
    await tester.pumpAndSettle();
    // The range is the one of both brands: no single brand is named.
    expect(find.text(l10n.paletteChainWholeRangeNoteMixed), findsOneWidget);
    expect(find.text(l10n.paletteChainWholeRangeNote('Ohuhu')), findsNothing);
    expect(
      find.text(l10n.paletteChainWholeRangeNote('DecoTime')),
      findsNothing,
    );
  });
}
