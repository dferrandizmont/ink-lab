import 'package:flutter/semantics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/ui/icons/ink_icons.dart';
import 'package:ink_lab/ui/pages/palette/palette_type_picker.dart';
import 'package:ink_lab/ui/widgets/palette_strip.dart';

import '../../support/l10n.dart';
import 'palette_test_support.dart';

Finder _key(String key) => find.byKey(ValueKey<String>(key));

/// The colours of the result strip (the first strip of the page).
List<String> _resultColors(WidgetTester tester) =>
    tester.widget<PaletteStrip>(find.byType(PaletteStrip).first).colors;

/// The text of the type field's value.
String _typeValue(WidgetTester tester) =>
    tester.widget<Text>(_key('palette-type-value')).data!;

void main() {
  group('the palette type field', () {
    testWidgets('lists the colour-theory modes and Scenes in a sheet', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      expect(_typeValue(tester), l10n.modeRecommended);
      // The old chip row and scene wrap are gone.
      expect(_key('palette-mode-triad'), findsNothing);
      expect(_key('palette-scene-ghostCharacter'), findsNothing);

      await openPaletteTypeSheet(tester);
      expect(_key('palette-type-sheet'), findsOneWidget);
      for (final PaletteMode mode in paletteTypeModes) {
        expect(_key('palette-mode-${mode.name}'), findsOneWidget);
        expect(find.text(l10n.modeLabel(mode)), findsWidgets);
      }
      expect(_key('palette-scenario-toggle'), findsOneWidget);
      expect(
        find.text(l10n.paletteTypeTheoryGroup.toUpperCase()),
        findsOneWidget,
      );
      expect(
        find.text(l10n.paletteTypeScenesGroup.toUpperCase()),
        findsOneWidget,
      );
      expect(find.text(l10n.paletteTypeDescTriad), findsOneWidget);
      expect(find.text(l10n.paletteTypeScenesHint), findsOneWidget);
      // Every mode of the app is offered.
      expect(paletteTypeModes.toSet(), PaletteMode.values.toSet());
    });

    testWidgets('only the selected type row shows a check and is announced '
        'once', (WidgetTester tester) async {
      await pumpPalette(tester);
      await openPaletteTypeSheet(tester);

      Finder check(String key) => find.descendant(
        of: _key(key),
        matching: find.byWidgetPredicate(
          (Widget w) => w is InkIcon && w.icon == InkIcons.check,
        ),
      );
      expect(check('palette-mode-recommended'), findsOneWidget);
      expect(check('palette-mode-triad'), findsNothing);
      expect(check('palette-scenario-toggle'), findsNothing);

      final SemanticsHandle handle = tester.ensureSemantics();
      final SemanticsNode node = tester.getSemantics(
        _key('palette-mode-recommended'),
      );
      expect(node.label, contains(l10n.modeLabel(PaletteMode.recommended)));
      // One merged node: the title and its description share it.
      expect(node.label, contains(l10n.paletteTypeDescRecommended));
      expect(
        find.semantics.byLabel(RegExp(l10n.modeLabel(PaletteMode.recommended))),
        findsOneWidget,
      );
      handle.dispose();
    });

    testWidgets('choosing a mode shows it in the field', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      await enterBaseCode(tester, 'B08');

      await choosePaletteType(tester, 'palette-mode-triad');

      expect(_typeValue(tester), l10n.modeLabel(PaletteMode.triad));
      expect(_key('palette-type-sheet'), findsNothing);
      expect(_key('palette-scene-field'), findsNothing);
    });

    testWidgets('Scenes shows the scene field, with a colour strip', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      expect(_key('palette-scene-field'), findsNothing);

      await choosePaletteType(tester, 'palette-scenario-toggle');

      expect(_typeValue(tester), l10n.paletteScenarioToggle);
      expect(_key('palette-scene-field'), findsOneWidget);
      expect(
        find.descendant(
          of: _key('palette-scene-field'),
          matching: find.byType(SceneStrip),
        ),
        findsOneWidget,
      );
      expect(
        tester.widget<Text>(_key('palette-scene-value')).data,
        'Ghost Character',
      );
      expect(find.textContaining('as the default base'), findsOneWidget);
    });

    testWidgets(
      'Scenes, then Complementary, then Recommended each take effect',
      (WidgetTester tester) async {
        // Regression: once Scenes was on, a mode chip looked dead.
        await pumpPalette(tester);
        await enterBaseCode(tester, 'B08');
        final List<String> recommended = _resultColors(tester);
        expect(_typeValue(tester), l10n.modeRecommended);

        await choosePaletteType(tester, 'palette-scenario-toggle');
        expect(_typeValue(tester), l10n.paletteScenarioToggle);
        expect(_key('palette-scene-field'), findsOneWidget);
        expect(_resultColors(tester), isNot(recommended));
        final List<String> scenes = _resultColors(tester);

        await choosePaletteType(tester, 'palette-mode-complementary');
        expect(_typeValue(tester), l10n.modeLabel(PaletteMode.complementary));
        expect(_key('palette-scene-field'), findsNothing);
        final List<String> complementary = _resultColors(tester);
        expect(complementary, isNot(scenes));
        expect(complementary, isNot(recommended));
        // The subtitle only counts the markers: the mode is in the field.
        expect(find.textContaining('markers available'), findsWidgets);

        await choosePaletteType(tester, 'palette-mode-recommended');
        expect(_typeValue(tester), l10n.modeRecommended);
        expect(_key('palette-scene-field'), findsNothing);
        expect(_resultColors(tester), recommended);
      },
    );

    testWidgets('picking Scenes again keeps the scene that was chosen', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      await choosePaletteType(tester, 'palette-scenario-toggle');
      await openPaletteSceneSheet(tester);
      await tester.enterText(_key('palette-scene-search'), 'dragon');
      await tester.pumpAndSettle();
      await tester.tap(_key('palette-scene-dragon'));
      await tester.pumpAndSettle();

      await choosePaletteType(tester, 'palette-mode-square');
      await choosePaletteType(tester, 'palette-scenario-toggle');

      expect(tester.widget<Text>(_key('palette-scene-value')).data, 'Dragon');
    });
  });

  group('the scene sheet', () {
    Future<void> openScenes(WidgetTester tester) async {
      await pumpPalette(tester);
      await choosePaletteType(tester, 'palette-scenario-toggle');
      await openPaletteSceneSheet(tester);
      expect(_key('palette-scene-sheet'), findsOneWidget);
    }

    testWidgets('the selected scene row shows a check', (
      WidgetTester tester,
    ) async {
      await openScenes(tester);
      Finder checks() => find.byWidgetPredicate(
        (Widget w) => w is InkIcon && w.icon == InkIcons.check,
      );
      await tester.enterText(_key('palette-scene-search'), 'dragon');
      await tester.pumpAndSettle();
      await tester.tap(_key('palette-scene-dragon'));
      await tester.pumpAndSettle();
      await openPaletteSceneSheet(tester);
      await tester.enterText(_key('palette-scene-search'), 'dragon');
      await tester.pumpAndSettle();
      expect(checks(), findsOneWidget);
      expect(
        find.descendant(of: _key('palette-scene-dragon'), matching: checks()),
        findsOneWidget,
      );
    });

    testWidgets('groups the scenes under category headers', (
      WidgetTester tester,
    ) async {
      await openScenes(tester);

      expect(_key('palette-scene-category-characters'), findsOneWidget);
      expect(_key('palette-scene-ghostCharacter'), findsOneWidget);
      expect(
        find.descendant(
          of: _key('palette-scene-ghostCharacter'),
          matching: find.byType(SceneStrip),
        ),
        findsOneWidget,
      );
      expect(find.text('CHARACTERS'), findsOneWidget);
    });

    testWidgets(
      'search filters by name, in both languages and without accents',
      (WidgetTester tester) async {
        await openScenes(tester);
        expect(_key('palette-scene-ghostCharacter'), findsOneWidget);

        Future<void> search(String text) async {
          await tester.enterText(_key('palette-scene-search'), text);
          await tester.pumpAndSettle();
        }

        await search('dragon');
        expect(_key('palette-scene-dragon'), findsOneWidget);
        expect(_key('palette-scene-ghostCharacter'), findsNothing);
        expect(_key('palette-scene-category-fantasy'), findsOneWidget);
        expect(_key('palette-scene-category-characters'), findsNothing);

        // Accents do not matter: the Spanish name is "Dragón".
        await search('DRAGÓN');
        expect(_key('palette-scene-dragon'), findsOneWidget);

        // The Spanish name finds the scene while the app is in English.
        await search('sirena');
        expect(_key('palette-scene-mermaid'), findsOneWidget);
        expect(_key('palette-scene-dragon'), findsNothing);
      },
    );

    testWidgets('search also matches the category, in either language', (
      WidgetTester tester,
    ) async {
      await openScenes(tester);

      await tester.enterText(_key('palette-scene-search'), 'animals');
      await tester.pumpAndSettle();
      expect(_key('palette-scene-orangeCat'), findsOneWidget);
      expect(_key('palette-scene-category-animals'), findsOneWidget);
      expect(_key('palette-scene-dragon'), findsNothing);

      // "Pieles y retratos" is the Spanish name of "Skin and portraits".
      await tester.enterText(_key('palette-scene-search'), 'retratos');
      await tester.pumpAndSettle();
      expect(_key('palette-scene-skinDeep'), findsOneWidget);
      expect(_key('palette-scene-orangeCat'), findsNothing);

      await tester.enterText(_key('palette-scene-search'), 'porcelana piel');
      await tester.pumpAndSettle();
      expect(_key('palette-scene-skinPorcelain'), findsOneWidget);
      expect(_key('palette-scene-skinDeep'), findsNothing);
    });

    testWidgets('a search without matches says so, and clearing restores all', (
      WidgetTester tester,
    ) async {
      await openScenes(tester);

      await tester.enterText(_key('palette-scene-search'), 'zzzzqq');
      await tester.pumpAndSettle();
      expect(_key('palette-scene-empty'), findsOneWidget);
      expect(find.text(l10n.paletteSceneEmpty), findsOneWidget);

      await tester.enterText(_key('palette-scene-search'), '');
      await tester.pumpAndSettle();
      expect(_key('palette-scene-empty'), findsNothing);
      expect(_key('palette-scene-ghostCharacter'), findsOneWidget);
    });

    testWidgets('picking a scene closes the sheet and regenerates', (
      WidgetTester tester,
    ) async {
      await openScenes(tester);
      final List<String> before = _resultColors(tester);
      expect(
        find.textContaining('default base for Ghost Character'),
        findsOneWidget,
      );

      await tester.enterText(_key('palette-scene-search'), 'dragon');
      await tester.pumpAndSettle();
      await tester.tap(_key('palette-scene-dragon'));
      await tester.pumpAndSettle();

      expect(_key('palette-scene-sheet'), findsNothing);
      expect(tester.widget<Text>(_key('palette-scene-value')).data, 'Dragon');
      expect(find.textContaining('default base for Dragon'), findsOneWidget);
      expect(_resultColors(tester), isNot(before));
      // The roles of the new scene are the reasons of the new result.
      expect(find.textContaining('Ember glow'), findsWidgets);
    });

    testWidgets('a typed base marker is kept when the scene changes', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      await enterBaseCode(tester, 'B08');
      await choosePaletteType(tester, 'palette-scenario-toggle');
      await openPaletteSceneSheet(tester);
      await tester.tap(_key('palette-scene-clearSky'));
      await tester.pumpAndSettle();

      expect(find.textContaining('as the default base'), findsNothing);
      expect(
        tester.widget<Text>(_key('palette-scene-value')).data,
        'Clear Sky',
      );
      expect(_resultColors(tester).first, isNotEmpty);
    });
  });

  test('the search folds case and accents', () {
    expect(foldForSearch('Dragón ÁÉÍÓÚ ñ ü'), 'dragon aeiou n u');
  });
}
