import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart' show LogicalKeyboardKey;
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/icons/ink_icons.dart';
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
import '../support/truncation.dart';

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

  group('the navigation rail folds and unfolds from 1100 dp on', () {
    NavigationRail rail(WidgetTester tester) =>
        tester.widget(find.byType(NavigationRail));

    AppSettingsRepository settingsOf(WidgetTester tester) =>
        AppScope.of(tester.element(find.byType(AppShell))).settings;

    Future<void> pumpWith(
      WidgetTester tester,
      Size size, {
      bool railExpanded = false,
    }) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      useEnglishDevice(tester);
      await tester.pumpWidget(
        AppScope.inMemory(
          markers: MarkerRepository(
            loadAsset: (String path) => File(path).readAsStringSync(),
          ),
          settingsState: AppSettingsState(
            onboardingCompleted: true,
            railExpanded: railExpanded,
          ),
          child: const InkLabApp(),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('below 1100 dp the rail is compact and has no button', (
      WidgetTester tester,
    ) async {
      for (final double width in const <double>[720, 1000, 1099]) {
        await pumpWith(tester, Size(width, 800));
        expect(find.byType(NavigationRail), findsOneWidget, reason: '$width');
        expect(find.byKey(railToggleKey), findsNothing, reason: '$width');
        expect(rail(tester).extended, isFalse, reason: '$width');
        expect(
          rail(tester).labelType,
          NavigationRailLabelType.all,
          reason: '$width',
        );
      }
    });

    testWidgets('a remembered unfolded rail stays compact below 1100 dp', (
      WidgetTester tester,
    ) async {
      await pumpWith(tester, const Size(1000, 800), railExpanded: true);
      expect(find.byKey(railToggleKey), findsNothing);
      expect(rail(tester).extended, isFalse);
      expect(rail(tester).labelType, NavigationRailLabelType.all);
    });

    testWidgets('from 1100 dp it starts folded, with the expand button', (
      WidgetTester tester,
    ) async {
      for (final double width in const <double>[1100, 1280]) {
        await pumpWith(tester, Size(width, 800));
        expect(find.byKey(railToggleKey), findsOneWidget, reason: '$width');
        expect(rail(tester).extended, isFalse, reason: '$width');
        expect(
          rail(tester).labelType,
          NavigationRailLabelType.all,
          reason: '$width',
        );
        expect(find.byTooltip(l10n.navRailExpand), findsOneWidget);
        expect(find.byTooltip(l10n.navRailCollapse), findsNothing);
        expect(settingsOf(tester).railExpanded, isFalse);
        // A 48 dp target, so it is easy to hit.
        expect(tester.getSize(find.byKey(railToggleKey)), const Size(48, 48));
      }
    });

    testWidgets('the button unfolds the rail, folds it back and remembers', (
      WidgetTester tester,
    ) async {
      await pumpWith(tester, const Size(1280, 800));
      final double folded = tester.getSize(find.byType(NavigationRail)).width;
      expect(folded, greaterThanOrEqualTo(InkGeometry.railWidth));

      await tester.tap(find.byKey(railToggleKey));
      await tester.pumpAndSettle();
      expect(find.byType(NavigationRail), findsNothing);
      expect(find.byKey(extendedRailKey), findsOneWidget);
      expect(
        tester.getSize(find.byKey(extendedRailKey)).width,
        greaterThan(folded),
      );
      expect(find.byTooltip(l10n.navRailCollapse), findsOneWidget);
      expect(find.byTooltip(l10n.navRailExpand), findsNothing);
      for (final String label in labels) {
        expect(
          find.descendant(
            of: find.byKey(extendedRailKey),
            matching: find.text(label),
          ),
          findsOneWidget,
          reason: label,
        );
      }
      expect(settingsOf(tester).railExpanded, isTrue);

      await tester.tap(find.byKey(railToggleKey));
      await tester.pumpAndSettle();
      expect(find.byKey(extendedRailKey), findsNothing);
      expect(rail(tester).extended, isFalse);
      expect(rail(tester).labelType, NavigationRailLabelType.all);
      expect(tester.getSize(find.byType(NavigationRail)).width, folded);
      expect(find.byTooltip(l10n.navRailExpand), findsOneWidget);
      expect(settingsOf(tester).railExpanded, isFalse);
    });

    testWidgets('a rail left unfolded comes back unfolded', (
      WidgetTester tester,
    ) async {
      await pumpWith(tester, const Size(1280, 800), railExpanded: true);
      expect(find.byType(NavigationRail), findsNothing);
      expect(find.byKey(extendedRailKey), findsOneWidget);
      expect(find.byTooltip(l10n.navRailCollapse), findsOneWidget);
    });

    testWidgets('the choice survives a narrower window and comes back', (
      WidgetTester tester,
    ) async {
      await pumpWith(tester, const Size(1280, 800));
      await tester.tap(find.byKey(railToggleKey));
      await tester.pumpAndSettle();
      expect(find.byKey(extendedRailKey), findsOneWidget);

      tester.view.physicalSize = const Size(1000, 800);
      await tester.pumpAndSettle();
      expect(find.byKey(railToggleKey), findsNothing);
      expect(rail(tester).extended, isFalse);
      expect(find.byKey(extendedRailKey), findsNothing);
      expect(settingsOf(tester).railExpanded, isTrue);

      tester.view.physicalSize = const Size(1280, 800);
      await tester.pumpAndSettle();
      expect(find.byKey(extendedRailKey), findsOneWidget);
      expect(find.byKey(railToggleKey), findsOneWidget);
    });

    testWidgets('a phone has neither the rail nor the button', (
      WidgetTester tester,
    ) async {
      await pumpWith(tester, const Size(390, 844));
      expect(find.byType(NavigationRail), findsNothing);
      expect(find.byKey(railToggleKey), findsNothing);
    });

    testWidgets('the button sits over the icons of the rail, folded or not', (
      WidgetTester tester,
    ) async {
      Future<void> check(String state) async {
        final double toggle = tester.getCenter(find.byKey(railToggleKey)).dx;
        final Finder firstIcon = find.descendant(
          of: state == 'folded'
              ? find.byType(NavigationRail)
              : find.byKey(extendedRailKey),
          matching: find.byWidgetPredicate(
            (Widget w) => w is InkIcon && w.icon == InkIcons.grid,
          ),
        );
        expect(
          toggle,
          moreOrLessEquals(tester.getCenter(firstIcon).dx, epsilon: 0.5),
          reason: state,
        );
      }

      await pumpWith(tester, const Size(1280, 800));
      await check('folded');
      await tester.tap(find.byKey(railToggleKey));
      await tester.pumpAndSettle();
      await check('unfolded');
    });

    testWidgets('is announced to screen readers with what it will do', (
      WidgetTester tester,
    ) async {
      final SemanticsHandle semantics = tester.ensureSemantics();
      await pumpWith(tester, const Size(1280, 800));
      expect(
        tester.getSemantics(find.byKey(railToggleKey)).tooltip,
        l10n.navRailExpand,
      );
      semantics.dispose();
    });
  });

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

  testWidgets(
    'Blending chain on a swatch opens the Palette tab with the chain type',
    (WidgetTester tester) async {
      addTearDown(() {
        paletteBaseDraft.value = null;
        paletteBaseMode.value = null;
      });
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
      // The blending chain lives in the "⋯" menu of the sheet.
      await tester.tap(find.byTooltip(l10n.commonMoreActions));
      await tester.pumpAndSettle();
      await tester.tap(find.text(l10n.swatchesBlendingChain));
      await tester.pumpAndSettle();

      expect(paletteBaseDraft.value, isNull);
      expect(paletteBaseMode.value, isNull);
      expect(find.byKey(SwatchesPage.pageKey).hitTestable(), findsNothing);
      final TextField base = tester.widget(
        find.byKey(const ValueKey<String>('palette-base-input')),
      );
      expect(base.controller?.text, 'B08');
      expect(
        tester
            .widget<Text>(
              find.byKey(const ValueKey<String>('palette-type-value')),
            )
            .data,
        l10n.modeLabel(PaletteMode.blendingChain),
      );
      // The chain itself: a title and a strip of five markers.
      expect(find.text(l10n.paletteChainResultTitle(5)), findsOneWidget);
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

  group('the unfolded navigation rail', () {
    // Real fonts, so labels are measured with the metrics of the app. Last in
    // the file: the other tests here run with the test font.
    setUpAll(loadAppFonts);

    Future<void> pump(
      WidgetTester tester, {
      Locale locale = const Locale('en'),
      double scale = 1.0,
      bool expanded = true,
      AppThemeMode themeMode = AppThemeMode.light,
    }) async {
      tester.view.physicalSize = const Size(1280, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      useDeviceLocales(tester, <Locale>[locale]);
      tester.platformDispatcher.textScaleFactorTestValue = scale;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await tester.pumpWidget(
        AppScope.inMemory(
          markers: MarkerRepository(
            loadAsset: (String path) => File(path).readAsStringSync(),
          ),
          settingsState: AppSettingsState(
            onboardingCompleted: true,
            railExpanded: expanded,
            themeMode: themeMode,
          ),
          child: const InkLabApp(),
        ),
      );
      await tester.pumpAndSettle();
    }

    Finder icon(AppDestination d, Finder scope) => find.descendant(
      of: scope,
      matching: find.byWidgetPredicate(
        (Widget w) => w is InkIcon && w.icon == d.inkIcon,
      ),
    );

    /// Centre height of the toggle and of each destination's icon.
    List<double> heights(WidgetTester tester, Finder scope) => <double>[
      tester.getCenter(find.byKey(railToggleKey)).dy,
      for (final AppDestination d in appDestinations)
        tester.getCenter(icon(d, scope)).dy,
    ];

    const Iterable<Locale> locales = AppLocalizations.supportedLocales;

    Finder inRail(String text) => find.descendant(
      of: find.byKey(extendedRailKey),
      matching: find.text(text),
    );

    testWidgets('is 200-220 dp wide in every language at normal text', (
      WidgetTester tester,
    ) async {
      for (final Locale locale in locales) {
        await pump(tester, locale: locale);
        final double width = tester.getSize(find.byKey(extendedRailKey)).width;
        expect(
          width,
          inInclusiveRange(extendedRailMinWidth, 220),
          reason: '$locale',
        );
      }
    });

    testWidgets('grows with the text scale, within its bounds', (
      WidgetTester tester,
    ) async {
      double previous = 0;
      for (final double scale in const <double>[1.0, 1.3, 1.5, 2.0]) {
        await pump(tester, locale: const Locale('de'), scale: scale);
        final double width = tester.getSize(find.byKey(extendedRailKey)).width;
        expect(
          width,
          inInclusiveRange(extendedRailMinWidth, extendedRailMaxWidth),
          reason: 'x$scale',
        );
        expect(width, greaterThanOrEqualTo(previous), reason: 'x$scale');
        previous = width;
      }
    });

    testWidgets('every label is one line, not cut, in all languages', (
      WidgetTester tester,
    ) async {
      for (final Locale locale in locales) {
        final AppLocalizations t = lookupAppLocalizations(locale);
        for (final double scale in const <double>[1.0, 1.3, 1.5]) {
          await pump(tester, locale: locale, scale: scale);
          final String why = '$locale x$scale';
          expect(truncatedTexts(tester), isEmpty, reason: why);
          for (final AppDestination d in appDestinations) {
            final Finder text = find.descendant(
              of: find.byKey(extendedRailKey),
              matching: find.text(d.label(t)),
            );
            expect(text, findsOneWidget, reason: '$why ${d.id}');
            // One line: a 16/24 label is 24 dp high at normal text.
            expect(
              tester.getSize(text).height,
              lessThanOrEqualTo(24 * scale + 1),
              reason: '$why ${d.label(t)}',
            );
          }
          expect(tester.takeException(), isNull, reason: why);
        }
      }
    });

    testWidgets('the label is 16 sp, medium when selected, beside the icon', (
      WidgetTester tester,
    ) async {
      await pump(tester);
      Text label(String text) => tester.widget<Text>(
        find.descendant(
          of: find.byKey(extendedRailKey),
          matching: find.text(text),
        ),
      );
      expect(label('Swatches').style?.fontSize, 16);
      expect(label('Swatches').style?.fontWeight, FontWeight.w500);
      expect(label('Swatches').style?.color, InkColors.light.action);
      expect(label('Match').style?.fontWeight, FontWeight.w400);
      expect(label('Match').style?.color, InkColors.light.fg2);

      // 12 dp between the icon and its label.
      final Rect iconBox = tester.getRect(
        icon(appDestinations.first, find.byKey(extendedRailKey)),
      );
      final Rect labelBox = tester.getRect(inRail('Swatches'));
      expect(labelBox.left - iconBox.right, moreOrLessEquals(12, epsilon: 0.5));
    });

    testWidgets('the selected pill holds the icon and the label together', (
      WidgetTester tester,
    ) async {
      await pump(tester);
      final Rect rail = tester.getRect(find.byKey(extendedRailKey));
      final Material pill = tester.widget(
        find.byKey(extendedRailItemKey('Swatches')),
      );
      final Rect box = tester.getRect(
        find.byKey(extendedRailItemKey('Swatches')),
      );
      expect(pill.color, InkColors.light.pale);
      expect(pill.shape, isA<RoundedRectangleBorder>());
      // The full row minus the margins, 48 dp high.
      expect(box.left - rail.left, 12);
      expect(rail.right - box.right, 12);
      expect(box.height, 48);
      final Rect icon0 = tester.getRect(
        icon(appDestinations.first, find.byKey(extendedRailKey)),
      );
      final Rect label0 = tester.getRect(inRail('Swatches'));
      expect(box.contains(icon0.topLeft), isTrue);
      expect(box.contains(icon0.bottomRight), isTrue);
      expect(box.contains(label0.topLeft), isTrue);
      expect(box.contains(label0.bottomRight), isTrue);

      // The others have no fill; the pill follows the selection.
      final Material other = tester.widget(
        find.byKey(extendedRailItemKey('Match')),
      );
      expect(other.color?.a, 0);
      await tester.tap(find.byKey(extendedRailItemKey('Match')));
      await tester.pumpAndSettle();
      expect(
        tester.widget<Material>(find.byKey(extendedRailItemKey('Match'))).color,
        InkColors.light.pale,
      );
      expect(
        tester
            .widget<Material>(find.byKey(extendedRailItemKey('Swatches')))
            .color
            ?.a,
        0,
      );
      expect(find.byKey(MatchPage.pageKey), findsOneWidget);
    });

    testWidgets('uses the dark colours in dark mode', (
      WidgetTester tester,
    ) async {
      await pump(tester, themeMode: AppThemeMode.dark);
      expect(
        tester
            .widget<Material>(find.byKey(extendedRailItemKey('Swatches')))
            .color,
        InkColors.dark.pale,
      );
      final Text selected = tester.widget(inRail('Swatches'));
      expect(selected.style?.color, InkColors.dark.action);
      final Text idle = tester.widget(inRail('Match'));
      expect(idle.style?.color, InkColors.dark.fg2);
    });

    testWidgets('keeps the semantics of a tab and 48 dp targets', (
      WidgetTester tester,
    ) async {
      final SemanticsHandle semantics = tester.ensureSemantics();
      await pump(tester);
      for (int i = 0; i < appDestinations.length; i++) {
        final AppDestination d = appDestinations[i];
        final SemanticsNode node = tester.getSemantics(
          find.byKey(extendedRailItemKey(d.id)),
        );
        expect(node.label, d.label(l10n));
        expect(node.hint, l10n.navTabHint(i + 1, appDestinations.length));
        expect(
          node.getSemanticsData().flagsCollection.isSelected,
          i == 0 ? ui.Tristate.isTrue : ui.Tristate.isFalse,
        );
        expect(node.getSemanticsData().flagsCollection.isButton, isTrue);
        expect(
          tester.getSize(find.byKey(extendedRailItemKey(d.id))).height,
          greaterThanOrEqualTo(48),
        );
      }
      semantics.dispose();
    });

    testWidgets('can be reached and used with the keyboard', (
      WidgetTester tester,
    ) async {
      await pump(tester);
      // Tab to the button, then to the first and second destinations; Enter
      // selects the second.
      for (int i = 0; i < 3; i++) {
        await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      }
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();
      expect(find.byKey(MatchPage.pageKey), findsOneWidget);
    });

    testWidgets('folding and unfolding do not move anything vertically', (
      WidgetTester tester,
    ) async {
      for (final double scale in const <double>[1.0, 1.3, 1.5]) {
        await pump(tester, scale: scale, expanded: false);
        final List<double> folded = heights(
          tester,
          find.byType(NavigationRail),
        );
        await tester.tap(find.byKey(railToggleKey));
        await tester.pumpAndSettle();
        final List<double> unfolded = heights(
          tester,
          find.byKey(extendedRailKey),
        );
        expect(unfolded.length, folded.length);
        for (int i = 0; i < folded.length; i++) {
          expect(
            unfolded[i],
            moreOrLessEquals(folded[i], epsilon: 1),
            reason: 'x$scale item $i: folded $folded, unfolded $unfolded',
          );
        }
        // And back.
        await tester.tap(find.byKey(railToggleKey));
        await tester.pumpAndSettle();
        expect(heights(tester, find.byType(NavigationRail)), folded);
      }
    });
  });

  group('folding and unfolding the rail is animated', () {
    // Real fonts, so the labels have the metrics of the app.
    setUpAll(loadAppFonts);

    Future<void> pump(
      WidgetTester tester, {
      Locale locale = const Locale('en'),
      double scale = 1.0,
      bool expanded = false,
      Size size = const Size(1280, 800),
      bool settle = true,
    }) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      useDeviceLocales(tester, <Locale>[locale]);
      tester.platformDispatcher.textScaleFactorTestValue = scale;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await tester.pumpWidget(
        AppScope.inMemory(
          markers: MarkerRepository(
            loadAsset: (String path) => File(path).readAsStringSync(),
          ),
          settingsState: AppSettingsState(
            onboardingCompleted: true,
            railExpanded: expanded,
          ),
          child: const InkLabApp(),
        ),
      );
      if (settle) await tester.pumpAndSettle();
    }

    double railWidth(WidgetTester tester) =>
        tester.getSize(find.byKey(railBoxKey)).width;

    /// Centres of the button and of every icon of the rail (both layers while
    /// the rail moves).
    List<Offset> iconCentres(WidgetTester tester) {
      final Finder icons = find.descendant(
        of: find.byKey(railBoxKey),
        matching: find.byWidgetPredicate(
          (Widget w) =>
              w is InkIcon &&
              appDestinations.any((AppDestination d) => d.inkIcon == w.icon),
        ),
      );
      return <Offset>[
        tester.getCenter(find.byKey(railToggleKey)),
        for (int i = 0; i < icons.evaluate().length; i++)
          tester.getCenter(icons.at(i)),
      ];
    }

    const Duration frame = Duration(milliseconds: 16);

    testWidgets('the width goes smoothly between the folded and unfolded', (
      WidgetTester tester,
    ) async {
      await pump(tester);
      final double folded = railWidth(tester);
      await tester.tap(find.byKey(railToggleKey));
      // The first frame of the move: it has not jumped.
      await tester.pump();
      expect(railWidth(tester), moreOrLessEquals(folded, epsilon: 2));

      final List<double> widths = <double>[];
      for (int i = 0; i < 30; i++) {
        await tester.pump(frame);
        widths.add(railWidth(tester));
      }
      final double unfolded = widths.last;
      expect(unfolded, greaterThanOrEqualTo(extendedRailMinWidth));
      // 200-250 ms: 220 ms is 14 frames of 16 ms.
      final int frames = widths.indexOf(unfolded) + 1;
      expect(frames, inInclusiveRange(13, 16));
      widths.removeRange(frames, widths.length);
      for (int i = 0; i < widths.length; i++) {
        expect(widths[i], inInclusiveRange(folded, unfolded), reason: '$i');
        if (i > 0) {
          expect(widths[i], greaterThanOrEqualTo(widths[i - 1]), reason: '$i');
        }
      }
      expect(
        widths.where((double w) => w > folded + 5 && w < unfolded - 5),
        isNotEmpty,
        reason: 'frames in between',
      );
      // An ease-in-out: it starts and ends slowly, and is fastest midway.
      final List<double> steps = <double>[
        for (int i = 1; i < widths.length; i++) widths[i] - widths[i - 1],
      ];
      final double fastest = steps.reduce(
        (double a, double b) => a > b ? a : b,
      );
      expect(steps.first, lessThan(fastest / 2));
      expect(steps.last, lessThan(fastest / 2));

      await tester.pumpAndSettle();
      expect(railWidth(tester), unfolded);
      expect(find.byType(NavigationRail), findsNothing);

      // And back.
      await tester.tap(find.byKey(railToggleKey));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 110));
      expect(railWidth(tester), inExclusiveRange(folded + 5, unfolded - 5));
      await tester.pumpAndSettle();
      expect(railWidth(tester), folded);
      expect(find.byKey(extendedRailKey), findsNothing);
    });

    testWidgets('no overflow or cut label at any width, in es and de', (
      WidgetTester tester,
    ) async {
      for (final Locale locale in const <Locale>[Locale('es'), Locale('de')]) {
        for (final double scale in const <double>[1.0, 1.5]) {
          await pump(tester, locale: locale, scale: scale);
          final String why = '$locale x$scale';
          for (int round = 0; round < 2; round++) {
            await tester.tap(find.byKey(railToggleKey));
            await tester.pump();
            for (int i = 0; i < 18; i++) {
              await tester.pump(frame);
              expect(tester.takeException(), isNull, reason: '$why $round/$i');
              expect(truncatedTexts(tester), isEmpty, reason: '$why $round/$i');
              // Labels stay on one line however narrow the rail is.
              final Finder texts = find.descendant(
                of: find.byKey(extendedRailKey),
                matching: find.byType(Text),
              );
              for (int t = 0; t < texts.evaluate().length; t++) {
                expect(
                  tester.getSize(texts.at(t)).height,
                  lessThanOrEqualTo(24 * scale + 1),
                  reason: '$why $round/$i',
                );
              }
            }
            await tester.pumpAndSettle();
            expect(tester.takeException(), isNull, reason: why);
          }
        }
      }
    });

    testWidgets('the labels fade in at the end and out first', (
      WidgetTester tester,
    ) async {
      await pump(tester);
      double labelOpacity() {
        final Finder opacity = find.ancestor(
          of: find.descendant(
            of: find.byKey(extendedRailKey),
            matching: find.text('Match'),
          ),
          matching: find.byType(Opacity),
        );
        return opacity.evaluate().isEmpty
            ? 1
            : tester.widget<Opacity>(opacity.first).opacity;
      }

      await tester.tap(find.byKey(railToggleKey));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 60));
      // Early in the opening the labels are not there yet.
      expect(labelOpacity(), 0);
      await tester.pump(const Duration(milliseconds: 80));
      expect(labelOpacity(), inExclusiveRange(0, 1));
      await tester.pumpAndSettle();
      expect(labelOpacity(), 1);

      // Closing: they are already going when the width has hardly moved.
      final double open = railWidth(tester);
      await tester.tap(find.byKey(railToggleKey));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 40));
      expect(railWidth(tester), greaterThan(open - 25));
      expect(labelOpacity(), lessThan(1));
    });

    testWidgets('the icons and the button do not move, even a pixel', (
      WidgetTester tester,
    ) async {
      for (final Locale locale in const <Locale>[Locale('en'), Locale('de')]) {
        for (final double scale in const <double>[1.0, 1.5, 2.0]) {
          await pump(tester, locale: locale, scale: scale);
          final String why = '$locale x$scale';
          final List<Offset> rest = iconCentres(tester);
          expect(rest.length, 1 + appDestinations.length, reason: why);
          for (int round = 0; round < 2; round++) {
            await tester.tap(find.byKey(railToggleKey));
            await tester.pump();
            for (int i = 0; i < 16; i++) {
              await tester.pump(frame);
              final List<Offset> now = iconCentres(tester);
              // The icons of both layers (and the button) sit on the ones at
              // rest.
              expect(now.length, greaterThanOrEqualTo(rest.length));
              for (final Offset c in now) {
                expect(
                  rest.any(
                    (Offset r) =>
                        (r.dx - c.dx).abs() < 0.5 && (r.dy - c.dy).abs() < 0.5,
                  ),
                  isTrue,
                  reason: '$why $round/$i: $c is not one of $rest',
                );
              }
            }
            await tester.pumpAndSettle();
            final List<Offset> end = iconCentres(tester);
            expect(end.length, rest.length, reason: why);
            for (int i = 0; i < rest.length; i++) {
              expect(end[i].dx, moreOrLessEquals(rest[i].dx, epsilon: 0.5));
              expect(end[i].dy, moreOrLessEquals(rest[i].dy, epsilon: 0.5));
            }
          }
        }
      }
    });

    testWidgets('the button works, and keeps the focus, while the rail moves', (
      WidgetTester tester,
    ) async {
      await pump(tester);
      final double folded = railWidth(tester);
      // Reverse half way: it turns round from where it is.
      await tester.tap(find.byKey(railToggleKey));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      final double half = railWidth(tester);
      expect(half, greaterThan(folded));
      await tester.tap(find.byKey(railToggleKey));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 30));
      expect(railWidth(tester), lessThan(half));
      await tester.pumpAndSettle();
      expect(railWidth(tester), folded);
      expect(find.byTooltip(l10n.navRailExpand), findsOneWidget);

      // The keyboard: Tab to the button, Enter unfolds, and the button still
      // has the focus when the rail has opened.
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();
      expect(find.byKey(extendedRailKey), findsOneWidget);
      expect(
        tester
            .widget<IconButton>(find.byKey(railToggleKey))
            .focusNode!
            .hasFocus,
        isTrue,
      );
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();
      expect(find.byKey(extendedRailKey), findsNothing);
      expect(
        tester
            .widget<IconButton>(find.byKey(railToggleKey))
            .focusNode!
            .hasFocus,
        isTrue,
      );
    });

    testWidgets('is instant when animations are disabled', (
      WidgetTester tester,
    ) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue =
          const FakeAccessibilityFeatures(disableAnimations: true);
      addTearDown(
        tester.platformDispatcher.clearAccessibilityFeaturesTestValue,
      );
      await pump(tester);
      final double folded = railWidth(tester);

      await tester.tap(find.byKey(railToggleKey));
      await tester.pump();
      expect(find.byType(NavigationRail), findsNothing);
      expect(find.byKey(extendedRailKey), findsOneWidget);
      final double unfolded = railWidth(tester);
      expect(unfolded, greaterThan(folded));
      expect(unfolded, tester.getSize(find.byKey(extendedRailKey)).width);

      await tester.tap(find.byKey(railToggleKey));
      await tester.pump();
      expect(find.byKey(extendedRailKey), findsNothing);
      expect(railWidth(tester), folded);
    });

    testWidgets('is not animated on the first build', (
      WidgetTester tester,
    ) async {
      await pump(tester, expanded: true, settle: false);
      // The first frames already show it unfolded, and nothing moves.
      for (int i = 0; i < 3; i++) {
        await tester.pump(const Duration(milliseconds: 30));
        expect(find.byType(NavigationRail), findsNothing, reason: '$i');
        expect(
          railWidth(tester),
          tester.getSize(find.byKey(extendedRailKey)).width,
          reason: '$i',
        );
      }
      await tester.pumpAndSettle();
      expect(railWidth(tester), greaterThanOrEqualTo(extendedRailMinWidth));
    });

    testWidgets('is not animated on the first build, folded', (
      WidgetTester tester,
    ) async {
      await pump(tester, settle: false);
      for (int i = 0; i < 3; i++) {
        await tester.pump(const Duration(milliseconds: 30));
        expect(find.byKey(extendedRailKey), findsNothing, reason: '$i');
        expect(find.byType(NavigationRail), findsOneWidget, reason: '$i');
      }
    });

    testWidgets('a window that crosses 1100 dp does not animate the rail', (
      WidgetTester tester,
    ) async {
      await pump(tester, expanded: true);
      final double unfolded = railWidth(tester);
      tester.view.physicalSize = const Size(1000, 800);
      await tester.pump();
      expect(find.byKey(railBoxKey), findsNothing);
      tester.view.physicalSize = const Size(1280, 800);
      await tester.pump();
      expect(railWidth(tester), unfolded);
      expect(find.byType(NavigationRail), findsNothing);
    });
  });
}
