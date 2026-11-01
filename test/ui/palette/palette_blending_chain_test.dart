import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/blending_chain.dart';
import 'package:ink_lab/core/color_utils.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/ui/pages/palette/palette_draft.dart';
import 'package:ink_lab/ui/theme/app_typography.dart';
import 'package:ink_lab/ui/widgets/ink_segmented.dart';
import 'package:ink_lab/ui/widgets/palette_strip.dart';

import '../../support/fake_share_sink.dart';
import '../../support/l10n.dart';
import 'palette_test_support.dart';

Finder _key(String key) => find.byKey(ValueKey<String>(key));

/// The colours of the result strip (the first strip of the page).
List<String> _stripColors(WidgetTester tester) =>
    tester.widget<PaletteStrip>(find.byType(PaletteStrip).first).colors;

List<String> _stripLabels(WidgetTester tester) =>
    tester.widget<PaletteStrip>(find.byType(PaletteStrip).first).labels!;

String _typeValue(WidgetTester tester) =>
    tester.widget<Text>(_key('palette-type-value')).data!;

/// Only these markers are the user's collection.
Future<void> _own(AppScope scope, Set<String> codes) =>
    scope.settings.setCollection(
      AppSettings(ownedSetIds: const <String>{}, extraMarkerIds: codes),
    );

Future<AppScope> _pumpChain(
  WidgetTester tester, {
  String base = 'B08',
  Set<String>? owned,
  Future<void> Function(AppScope scope)? setup,
}) async {
  final AppScope scope = await pumpPalette(
    tester,
    setup: (AppScope scope) async {
      if (owned != null) await _own(scope, owned);
      if (setup != null) await setup(scope);
    },
  );
  await choosePaletteType(tester, 'palette-mode-blendingChain');
  await enterBaseCode(tester, base);
  return scope;
}

Future<void> _selectSize(WidgetTester tester, int size) async {
  await tester.tap(
    find.descendant(
      of: find.byType(InkSegmented<int>),
      matching: find.text('$size'),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  group('the Blending Chain type', () {
    testWidgets('is in the type sheet and is shown in the type field', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      await openPaletteTypeSheet(tester);
      expect(_key('palette-mode-blendingChain'), findsOneWidget);
      expect(
        find.text(l10n.modeLabel(PaletteMode.blendingChain)),
        findsWidgets,
      );
      expect(find.text(l10n.paletteTypeDescBlendingChain), findsOneWidget);
      await tester.tap(_key('palette-mode-blendingChain'));
      await tester.pumpAndSettle();
      expect(_typeValue(tester), l10n.modeLabel(PaletteMode.blendingChain));
      expect(_typeValue(tester), 'Blending Chain');
      // No scene field, like every colour-theory type.
      expect(_key('palette-scene-field'), findsNothing);
    });

    testWidgets('a base marker gives a chain, light to dark, base in it', (
      WidgetTester tester,
    ) async {
      await _pumpChain(tester, base: 'B411');

      final List<String> colors = _stripColors(tester);
      final List<String> labels = _stripLabels(tester);
      // The default size is five markers, base included.
      expect(colors, hasLength(5));
      expect(labels, contains('B411'));
      expect(find.text(l10n.paletteChainResultTitle(5)), findsOneWidget);
      final List<double> lightness = <double>[
        for (final String hex in colors) hexToOklab(hex).l,
      ];
      for (int i = 0; i + 1 < lightness.length; i++) {
        expect(lightness[i], greaterThan(lightness[i + 1]));
      }
      // Rows: one per step, lightest first, the base marked as the base.
      final int baseAt = labels.indexOf('B411');
      for (int i = 0; i < 5; i++) {
        final String role = i == baseAt
            ? l10n.roleBase
            : i == 0
            ? l10n.roleLightest
            : i == 4
            ? l10n.roleDarkest
            : i < baseAt
            ? l10n.roleLighter
            : l10n.roleDarker;
        expect(
          find.text(AppTypography.caps(l10n.paletteChainStep(i + 1, role))),
          findsOneWidget,
          reason: 'step ${i + 1}',
        );
      }
      for (final String code in labels) {
        expect(_key('palette-row-$code'), findsOneWidget);
      }
      // The technique hint; no variations for a chain.
      expect(_key('palette-chain-hint'), findsOneWidget);
      expect(find.text(l10n.paletteChainHint), findsOneWidget);
      expect(find.text(l10n.paletteVariationsLabel), findsNothing);
    });

    testWidgets('the size control is the number of markers of the chain', (
      WidgetTester tester,
    ) async {
      await _pumpChain(tester);
      await _selectSize(tester, 3);
      expect(_stripColors(tester), hasLength(3));
      expect(find.text(l10n.paletteChainResultTitle(3)), findsOneWidget);
      await _selectSize(tester, 4);
      expect(_stripColors(tester), hasLength(4));
      expect(find.text(l10n.paletteChainResultTitle(4)), findsOneWidget);
    });

    testWidgets('the paint order follows the chain, light to dark', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpChain(tester, base: 'B411');
      await _selectSize(tester, 4);
      final List<String> labels = _stripLabels(tester);
      final List<MarkerColor> catalog = await scope.markers.loadColors(
        MarkerBrand.ohuhuOahu,
      );
      String nameOf(String code) =>
          catalog.firstWhere((MarkerColor c) => c.newCode == code).newName;
      await tester.ensureVisible(_key('palette-step-name-4'));
      await tester.pumpAndSettle();

      expect(find.text(l10n.palettePaintPlanTitle), findsOneWidget);
      // No "block the shape with the base" tip: the base is a step like any.
      expect(find.text(l10n.palettePaintTipBase), findsNothing);
      String text(String key) => tester
          .widget<Text>(
            find.descendant(of: _key(key), matching: find.byType(Text)),
          )
          .data!;
      for (int i = 0; i < 4; i++) {
        expect(text('palette-step-name-${i + 1}'), nameOf(labels[i]));
      }
      final int baseAt = labels.indexOf('B411');
      if (baseAt != 0) expect(text('palette-step-zone-1'), l10n.roleLightest);
      if (baseAt != 3) expect(text('palette-step-zone-4'), l10n.roleDarkest);
      expect(text('palette-step-zone-${baseAt + 1}'), l10n.roleBase);
    });

    testWidgets('offers other chains as options and switches between them', (
      WidgetTester tester,
    ) async {
      await _pumpChain(tester, base: 'B411');
      await _selectSize(tester, 4);
      expect(_key('palette-chain-option-0'), findsOneWidget);
      expect(_key('palette-chain-option-1'), findsOneWidget);
      expect(find.text(l10n.paletteChainOption(1)), findsOneWidget);
      final List<String> first = _stripLabels(tester);

      await tester.ensureVisible(_key('palette-chain-option-1'));
      await tester.tap(_key('palette-chain-option-1'));
      await tester.pumpAndSettle();
      final List<String> second = _stripLabels(tester);
      expect(second, isNot(first));
      expect(second, contains('B411'));
      expect(second, hasLength(4));

      await tester.tap(_key('palette-chain-option-0'));
      await tester.pumpAndSettle();
      expect(_stripLabels(tester), first);
    });

    testWidgets('Generate and Clear still work', (WidgetTester tester) async {
      await _pumpChain(tester);
      final List<String> before = _stripLabels(tester);
      await tester.ensureVisible(_key('palette-generate'));
      await tester.tap(_key('palette-generate'));
      await tester.pumpAndSettle();
      expect(_stripLabels(tester), before);

      await tester.tap(_key('palette-clear'));
      await tester.pumpAndSettle();
      expect(find.byType(PaletteStrip), findsNothing);
      expect(find.text(l10n.paletteEmptyHint), findsOneWidget);
    });

    testWidgets('changing the type leaves the chain', (
      WidgetTester tester,
    ) async {
      await _pumpChain(tester);
      await choosePaletteType(tester, 'palette-mode-triad');
      expect(_key('palette-chain-hint'), findsNothing);
      expect(find.textContaining('Combinations ('), findsOneWidget);
      // And back again: the chain is rebuilt for the same base.
      await choosePaletteType(tester, 'palette-mode-blendingChain');
      expect(_key('palette-chain-hint'), findsOneWidget);
    });
  });

  group('when the collection cannot make the chain', () {
    testWidgets('says what is missing and offers the whole range', (
      WidgetTester tester,
    ) async {
      await _pumpChain(tester, owned: const <String>{'B08', 'R38', 'Y611'});

      expect(find.byType(PaletteStrip), findsNothing);
      expect(find.text(l10n.paletteChainNeedBoth), findsOneWidget);
      expect(find.text(l10n.paletteEmptyHint), findsNothing);
      expect(_key('palette-save'), findsNothing);

      await tester.ensureVisible(_key('palette-chain-whole-range'));
      await tester.tap(_key('palette-chain-whole-range'));
      await tester.pumpAndSettle();

      // A chain from the whole range, with the markers the user lacks marked.
      expect(find.byType(PaletteStrip), findsWidgets);
      expect(
        find.text(l10n.paletteChainWholeRangeNote(MarkerBrand.ohuhuOahu.label)),
        findsOneWidget,
      );
      expect(find.textContaining(l10n.matchNotOwnedBadge), findsWidgets);
      expect(_stripLabels(tester), contains('B08'));
      expect(_key('palette-chain-whole-range'), findsNothing);

      await tester.ensureVisible(_key('palette-chain-my-markers'));
      await tester.tap(_key('palette-chain-my-markers'));
      await tester.pumpAndSettle();
      expect(find.text(l10n.paletteChainNeedBoth), findsOneWidget);
      expect(find.byType(PaletteStrip), findsNothing);
    });

    testWidgets('names the lighter or darker marker that is missing', (
      WidgetTester tester,
    ) async {
      // Only a darker marker of the family: a lighter one is needed.
      await _pumpChain(
        tester,
        base: 'B010',
        owned: const <String>{'B010', 'B411'},
      );
      expect(find.text(l10n.paletteChainNeedLighter), findsOneWidget);
      expect(find.byType(PaletteStrip), findsNothing);

      // And the other way round.
      await enterBaseCode(tester, 'B411');
      expect(find.text(l10n.paletteChainNeedDarker), findsOneWidget);
      expect(find.text(l10n.paletteChainNeedLighter), findsNothing);
    });

    testWidgets('a short chain is shown with a note, never padded', (
      WidgetTester tester,
    ) async {
      // Three markers that chain, and the default five asked for.
      await _pumpChain(tester, owned: const <String>{'B08', 'B010', 'B411'});

      expect(_stripColors(tester), hasLength(3));
      expect(find.text(l10n.paletteChainResultTitle(3)), findsOneWidget);
      final String note = tester
          .widget<Text>(
            find.descendant(
              of: _key('palette-chain-note'),
              matching: find.byType(Text),
            ),
          )
          .data!;
      expect(note, contains(l10n.paletteChainShort(3, 5)));
      // B08 is the lightest of the three and nothing lighter is owned.
      expect(note, contains(l10n.paletteChainBaseLightest));
      expect(_key('palette-chain-whole-range'), findsOneWidget);
    });

    testWidgets('a base outside the collection is refused like in any type', (
      WidgetTester tester,
    ) async {
      await _pumpChain(
        tester,
        base: 'R38',
        owned: const <String>{'B08', 'B010', 'B411'},
      );
      expect(find.textContaining('R38'), findsWidgets);
      expect(find.byType(PaletteStrip), findsNothing);
      expect(_key('palette-save'), findsNothing);
    });
  });

  group('saving, loading and sharing', () {
    testWidgets('a chain is saved in painting order and loads back', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpChain(tester);
      await _selectSize(tester, 4);
      final List<String> shown = _stripLabels(tester);

      await tester.ensureVisible(_key('palette-save'));
      await tester.tap(_key('palette-save'));
      await tester.pumpAndSettle();
      await tester.enterText(_key('palette-name-field'), 'Sky blend');
      await tester.tap(_key('palette-save-confirm'));
      await tester.pumpAndSettle();

      final List<SavedPalette> saved = scope.savedPalettes.palettesOf(
        MarkerBrand.ohuhuOahu,
      );
      expect(saved, hasLength(1));
      expect(saved.single.mode, PaletteMode.blendingChain);
      expect(saved.single.baseCode, 'B08');
      expect(saved.single.colorCodes, shown);
      expect(saved.single.paletteSize, 4);
      // Its mode survives the JSON round trip.
      expect(
        SavedPalette.fromJson(saved.single.toJson()).mode,
        PaletteMode.blendingChain,
      );
      expect(
        find.text(
          l10n.paletteSavedSubtitle(
            l10n.modeLabel(PaletteMode.blendingChain),
            4,
          ),
        ),
        findsOneWidget,
      );

      await tester.tap(_key('palette-clear'));
      await tester.pumpAndSettle();
      expect(find.byType(PaletteStrip).evaluate().length, 1); // saved row only

      await tester.ensureVisible(_key('palette-load-${saved.single.id}'));
      await tester.tap(_key('palette-load-${saved.single.id}'));
      await tester.pumpAndSettle();

      expect(_typeValue(tester), l10n.modeLabel(PaletteMode.blendingChain));
      expect(_stripLabels(tester), shown);
      expect(find.text(l10n.paletteChainResultTitle(4)), findsOneWidget);
      expect(_key('palette-chain-hint'), findsOneWidget);
      // The base keeps its place in the middle of the strip.
      expect(
        find.text(
          AppTypography.caps(
            l10n.paletteChainStep(shown.indexOf('B08') + 1, l10n.roleBase),
          ),
        ),
        findsOneWidget,
      );
    });

    testWidgets('a saved chain whose markers are gone still loads', (
      WidgetTester tester,
    ) async {
      await pumpPalette(
        tester,
        setup: (AppScope scope) => scope.savedPalettes.save(
          SavedPalette(
            id: 'c1',
            name: 'Old chain',
            baseCode: 'B08',
            baseName: 'Cotton Candy Blue',
            mode: PaletteMode.blendingChain,
            paletteSize: 4,
            createdAtEpochMs: 1,
            colorCodes: const <String>['B08', 'NOPE1', 'NOPE2', 'B010'],
          ),
        ),
      );
      await tester.ensureVisible(_key('palette-load-c1'));
      await tester.tap(_key('palette-load-c1'));
      await tester.pumpAndSettle();
      expect(_stripLabels(tester), <String>['B08', 'B010']);
    });

    testWidgets('a chain is shared as an image in chain order', (
      WidgetTester tester,
    ) async {
      final FakeShareSink sink = FakeShareSink();
      await pumpPalette(tester, shareSink: sink);
      await choosePaletteType(tester, 'palette-mode-blendingChain');
      await enterBaseCode(tester, 'B08');
      await _selectSize(tester, 4);

      await tester.ensureVisible(_key('palette-share'));
      await tester.tap(_key('palette-share'));
      await tester.pump();
      await tester.runAsync(() async {
        for (int i = 0; i < 600 && sink.shared.isEmpty; i++) {
          await Future<void>.delayed(const Duration(milliseconds: 50));
          await tester.pump();
        }
        await Future<void>.delayed(const Duration(milliseconds: 100));
        await tester.pump();
      });
      await tester.pumpAndSettle();

      expect(sink.shared, hasLength(1));
      expect(sink.subjects.single, l10n.modeLabel(PaletteMode.blendingChain));
      expect(pngSize(sink.shared.single.single.bytes)?.width, 1080);
    });
  });

  group('the hand-off from Swatches', () {
    testWidgets('a base with the chain type opens the chain', (
      WidgetTester tester,
    ) async {
      addTearDown(() {
        paletteBaseDraft.value = null;
        paletteBaseMode.value = null;
      });
      await pumpPalette(tester);

      paletteBaseMode.value = PaletteMode.blendingChain;
      paletteBaseDraft.value = markerColor('B08', '#82dcfa');
      await tester.pumpAndSettle();

      expect(paletteBaseMode.value, isNull);
      expect(paletteBaseDraft.value, isNull);
      expect(_typeValue(tester), l10n.modeLabel(PaletteMode.blendingChain));
      expect(_stripLabels(tester), contains('B08'));
      expect(_key('palette-chain-hint'), findsOneWidget);
    });

    testWidgets('a plain base keeps the type already chosen', (
      WidgetTester tester,
    ) async {
      addTearDown(() => paletteBaseDraft.value = null);
      await pumpPalette(tester);
      await choosePaletteType(tester, 'palette-mode-blendingChain');

      paletteBaseDraft.value = markerColor('B08', '#82dcfa');
      await tester.pumpAndSettle();

      expect(_typeValue(tester), l10n.modeLabel(PaletteMode.blendingChain));
      expect(_stripLabels(tester), contains('B08'));
    });

    testWidgets('replacing a palette offers undo that brings it back', (
      WidgetTester tester,
    ) async {
      addTearDown(() {
        paletteBaseDraft.value = null;
        paletteBaseMode.value = null;
      });
      await pumpPalette(tester);
      await enterBaseCode(tester, 'R16');
      final List<String> before = _stripLabels(tester);
      expect(_typeValue(tester), l10n.modeRecommended);

      paletteBaseMode.value = PaletteMode.blendingChain;
      paletteBaseDraft.value = markerColor('B08', '#82dcfa');
      await tester.pumpAndSettle();
      expect(_typeValue(tester), l10n.modeLabel(PaletteMode.blendingChain));
      expect(find.text(l10n.paletteBaseReplaced('B08')), findsOneWidget);

      await tester.tap(find.text(l10n.paletteUndoButton));
      await tester.pumpAndSettle();
      expect(_typeValue(tester), l10n.modeRecommended);
      expect(_stripLabels(tester), before);
      expect(_key('palette-chain-hint'), findsNothing);
    });

    testWidgets('undo of a chain brings the chain back', (
      WidgetTester tester,
    ) async {
      addTearDown(() {
        paletteBaseDraft.value = null;
        paletteBaseMode.value = null;
      });
      await _pumpChain(tester, base: 'R16');
      final List<String> before = _stripLabels(tester);

      paletteBaseDraft.value = markerColor('B08', '#82dcfa');
      await tester.pumpAndSettle();
      expect(_stripLabels(tester), isNot(before));

      await tester.tap(find.text(l10n.paletteUndoButton));
      await tester.pumpAndSettle();
      expect(_typeValue(tester), l10n.modeLabel(PaletteMode.blendingChain));
      expect(_stripLabels(tester), before);
      expect(_key('palette-chain-hint'), findsOneWidget);
    });
  });

  group('with a Spanish device', () {
    testWidgets('texts are the Spanish ones', (WidgetTester tester) async {
      expect(l10nEs.modeBlendingChain, 'Degradado para fundir');
      expect(l10nEs.paletteChainStep(2, l10nEs.roleBase), 'Paso 2 · Base');
      expect(
        l10nEs.paletteChainResultTitle(4),
        isNot(l10n.paletteChainResultTitle(4)),
      );
      expect(
        blendingChainRoles(
          BlendingChain(
            colors: <MarkerColor>[
              markerColor('A', '#ffffff'),
              markerColor('B', '#cccccc'),
              markerColor('C', '#999999'),
            ],
            base: markerColor('B', '#cccccc'),
          ),
        ).map(l10nEs.roleLabel),
        <String>['Más claro', 'Base', 'Más oscuro'],
      );
    });
  });
}
