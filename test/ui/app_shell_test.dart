import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/pages/palette/palette_draft.dart';
import 'package:ink_lab/ui/pages/ideas/ideas_page.dart';
import 'package:ink_lab/ui/pages/match/match_page.dart';
import 'package:ink_lab/ui/pages/palette/palette_page.dart';
import 'package:ink_lab/ui/pages/settings/settings_page.dart';
import 'package:ink_lab/ui/pages/swatches/swatches_page.dart';
import 'package:ink_lab/ui/shell/app_shell.dart';
import 'package:ink_lab/ui/theme/tokens.dart';
import 'package:ink_lab/ui/widgets/page_header.dart';

import '../support/l10n.dart';

const List<String> labels = <String>[
  'Swatches',
  'Match',
  'Palette',
  'Ideas',
  'Settings',
];

Future<void> pumpShell(
  WidgetTester tester, {
  Size size = const Size(390, 844),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  useEnglishDevice(tester);
  await tester.pumpWidget(const InkLabApp());
  await tester.pumpAndSettle();
}

Finder navItem(String label) => find.descendant(
  of: find.byType(InkNavigationBar),
  matching: find.text(label),
);

void main() {
  testWidgets('a phone shows the five labelled destinations in the G bar', (
    WidgetTester tester,
  ) async {
    await pumpShell(tester);

    expect(find.byType(InkNavigationBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
    expect(tester.getSize(find.byType(InkNavigationBar)).height, 72);
    for (final String label in labels) {
      expect(navItem(label), findsOneWidget, reason: '$label is missing');
    }
    expect(find.byKey(SwatchesPage.pageKey), findsOneWidget);
  });

  testWidgets('the active destination sits on a pale pill in action colour', (
    WidgetTester tester,
  ) async {
    await pumpShell(tester);

    final Text active = tester.widget(navItem('Swatches'));
    final Text idle = tester.widget(navItem('Match'));
    expect(active.style?.color, InkColors.light.action);
    expect(idle.style?.color, InkColors.light.fg2);

    final Iterable<AnimatedContainer> pills = tester
        .widgetList<AnimatedContainer>(
          find.descendant(
            of: find.byType(InkNavigationBar),
            matching: find.byType(AnimatedContainer),
          ),
        );
    final List<Color?> fills = pills
        .map((AnimatedContainer c) => (c.decoration as ShapeDecoration?)?.color)
        .toList();
    expect(fills.where((Color? c) => c == InkColors.light.pale).length, 1);
  });

  testWidgets('tapping a destination switches the page', (
    WidgetTester tester,
  ) async {
    await pumpShell(tester);

    await tester.tap(navItem('Palette'));
    await tester.pumpAndSettle();
    expect(find.byKey(PalettePage.pageKey), findsOneWidget);
    expect(find.byKey(SwatchesPage.pageKey), findsNothing);

    await tester.tap(navItem('Match'));
    await tester.pumpAndSettle();
    expect(find.byKey(MatchPage.pageKey), findsOneWidget);
    expect(find.byKey(PalettePage.pageKey), findsNothing);

    await tester.tap(navItem('Ideas'));
    await tester.pumpAndSettle();
    expect(find.byKey(IdeasPage.pageKey), findsOneWidget);

    await tester.tap(navItem('Settings'));
    await tester.pumpAndSettle();
    expect(find.byKey(SettingsPage.pageKey), findsOneWidget);

    await tester.tap(navItem('Swatches'));
    await tester.pumpAndSettle();
    expect(find.byKey(SwatchesPage.pageKey), findsOneWidget);
  });

  testWidgets('every page title starts below the system status bar', (
    WidgetTester tester,
  ) async {
    tester.view.padding = const FakeViewPadding(top: 48);
    addTearDown(tester.view.resetPadding);
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    useEnglishDevice(tester);
    await tester.pumpWidget(
      AppScope.inMemory(
        markers: MarkerRepository(
          loadAsset: (String path) => File(path).readAsStringSync(),
        ),
        child: const InkLabApp(),
      ),
    );
    await tester.pumpAndSettle();

    for (final String label in labels) {
      await tester.tap(navItem(label));
      await tester.pumpAndSettle();
      final Finder title = find
          .descendant(
            of: find.byType(InkPageHeader),
            matching: find.text(label),
          )
          .hitTestable();
      expect(title, findsOneWidget, reason: '$label title is missing');
      expect(
        tester.getTopLeft(title).dy,
        greaterThanOrEqualTo(48),
        reason: '$label title is drawn under the status bar',
      );
    }
  });

  testWidgets('switching tabs keeps the state of a visited page', (
    WidgetTester tester,
  ) async {
    await pumpShell(tester);

    final State swatches = tester.state(find.byType(SwatchesPage));

    await tester.tap(navItem('Palette'));
    await tester.pumpAndSettle();
    final State palette = tester.state(find.byType(PalettePage));
    await tester.tap(navItem('Swatches'));
    await tester.pumpAndSettle();

    expect(tester.state(find.byType(SwatchesPage)), same(swatches));
    await tester.tap(navItem('Palette'));
    await tester.pumpAndSettle();
    expect(tester.state(find.byType(PalettePage)), same(palette));
  });

  testWidgets(
    'a wide screen shows the five destinations in a navigation rail',
    (WidgetTester tester) async {
      await pumpShell(tester, size: const Size(1280, 800));

      expect(find.byType(NavigationRail), findsOneWidget);
      expect(find.byType(InkNavigationBar), findsNothing);

      final NavigationRail rail = tester.widget(find.byType(NavigationRail));
      expect(rail.destinations.length, 5);
      for (final String label in labels) {
        expect(
          find.descendant(
            of: find.byType(NavigationRail),
            matching: find.text(label),
          ),
          findsOneWidget,
          reason: 'the navigation rail should show the $label destination',
        );
      }
      expect(find.byKey(SwatchesPage.pageKey), findsOneWidget);
    },
  );

  testWidgets(
    'Add to palette sends the marker to the Palette tab as its base',
    (WidgetTester tester) async {
      addTearDown(() => paletteBaseDraft.value = null);
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      useEnglishDevice(tester);
      await tester.pumpWidget(
        AppScope.inMemory(
          markers: MarkerRepository(
            loadAsset: (String path) => File(path).readAsStringSync(),
          ),
          child: const InkLabApp(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('B08'));
      await tester.pumpAndSettle();
      await tester.tap(find.text(l10n.swatchesAddToPalette));
      await tester.pumpAndSettle();

      expect(paletteBaseDraft.value, isNull);
      expect(find.byKey(SwatchesPage.pageKey).hitTestable(), findsNothing);
      final TextField base = tester.widget(
        find.byKey(const ValueKey<String>('palette-base-input')),
      );
      expect(base.controller?.text, 'B08');
    },
  );

  testWidgets('the stored appearance drives the app theme mode', (
    WidgetTester tester,
  ) async {
    final AppScope scope = AppScope.inMemory(
      markers: MarkerRepository(
        loadAsset: (String path) => File(path).readAsStringSync(),
      ),
      child: const InkLabApp(),
    );
    useEnglishDevice(tester);
    await tester.pumpWidget(scope);
    await tester.pumpAndSettle();
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.system,
    );

    await scope.settings.setThemeMode(AppThemeMode.dark);
    await tester.pumpAndSettle();
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.dark,
    );
    await scope.settings.setThemeMode(AppThemeMode.light);
    await tester.pumpAndSettle();
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.light,
    );
  });
}
