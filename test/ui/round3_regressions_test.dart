import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/ui/pages/palette/palette_page.dart';
import 'package:ink_lab/ui/pages/settings/saved_palettes_section.dart';
import 'package:ink_lab/ui/pages/collection/collection_page.dart';
import 'package:ink_lab/ui/pages/settings/settings_page.dart';
import 'package:ink_lab/ui/shell/app_shell.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';

import '../support/l10n.dart';

const List<String> _labels = <String>[
  'Swatches',
  'Match',
  'Palette',
  'Ideas',
  'Settings',
];

MarkerRepository _markers() =>
    MarkerRepository(loadAsset: (String path) => File(path).readAsStringSync());

Finder _navItem(String label) => find.descendant(
  of: find.byType(InkNavigationBar),
  matching: find.text(label),
);

SavedPalette _palette(String id, MarkerBrand brand) => SavedPalette(
  id: id,
  brandId: brand.id,
  name: 'Palette $id',
  baseCode: 'B08',
  baseName: 'Name',
  mode: PaletteMode.recommended,
  paletteSize: 3,
  createdAtEpochMs: 1000,
  colorCodes: const <String>['B08', 'B10', 'B12'],
);

Future<AppScope> _pumpApp(
  WidgetTester tester, {
  Future<void> Function(AppScope scope)? setup,
}) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  final AppScope scope = AppScope.inMemory(
    markers: _markers(),
    child: const InkLabApp(),
  );
  if (setup != null) await setup(scope);
  useEnglishDevice(tester);
  await tester.pumpWidget(scope);
  await tester.pumpAndSettle();
  return scope;
}

void main() {
  group('streams survive rebuilds and tab switches', () {
    testWidgets('switching through every tab several times never throws', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpApp(
        tester,
        setup: (AppScope scope) =>
            scope.savedPalettes.save(_palette('a', MarkerBrand.ohuhuOahu)),
      );

      for (int round = 0; round < 3; round++) {
        for (final String label in _labels) {
          await tester.tap(_navItem(label));
          await tester.pumpAndSettle();
          expect(
            tester.takeException(),
            isNull,
            reason: '$label, round $round',
          );
        }
        // A settings change rebuilds every page that listens to it.
        await scope.settings.setBrand(
          round.isEven ? MarkerBrand.decoTime : MarkerBrand.ohuhuOahu,
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }
      await tester.tap(_navItem('Palette'));
      await tester.pumpAndSettle();
      expect(find.byKey(PalettePage.pageKey), findsOneWidget);
      expect(find.text('Saved palettes'), findsOneWidget);
    });

    testWidgets('the saved palettes list can be mounted again', (
      WidgetTester tester,
    ) async {
      final AppScope scope = AppScope.inMemory(
        markers: _markers(),
        child: const SizedBox.shrink(),
      );
      await scope.savedPalettes.save(_palette('a', MarkerBrand.ohuhuOahu));
      // One stream object shared by every mount, as the settings page does.
      final Stream<List<SavedPalette>> stream = scope.savedPalettes.watch(
        MarkerBrand.ohuhuOahu,
      );
      final ValueNotifier<bool> shown = ValueNotifier<bool>(true);
      addTearDown(shown.dispose);

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: testLocalizationsDelegates,
          supportedLocales: testSupportedLocales,
          theme: AppTheme.light(),
          home: Scaffold(
            body: ValueListenableBuilder<bool>(
              valueListenable: shown,
              builder: (BuildContext context, bool value, Widget? child) =>
                  value
                  ? SavedPalettesSection(
                      scope: scope,
                      state: scope.settings.state,
                      palettes: stream,
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      for (int i = 0; i < 3; i++) {
        shown.value = false;
        await tester.pumpAndSettle();
        shown.value = true;
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(find.text('Palette a'), findsOneWidget);
      }
    });

    testWidgets('the settings page survives repeated brand changes', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      final AppScope scope = AppScope.inMemory(
        markers: _markers(),
        child: const SettingsPage(),
      );
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: testLocalizationsDelegates,
          supportedLocales: testSupportedLocales,
          theme: AppTheme.light(),
          home: Scaffold(body: scope),
        ),
      );
      await tester.pumpAndSettle();

      for (int i = 0; i < 4; i++) {
        await scope.settings.setBrand(
          i.isEven ? MarkerBrand.decoTime : MarkerBrand.ohuhuOahu,
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }
    });
  });

  testWidgets('Set up my collection opens the collection screen', (
    WidgetTester tester,
  ) async {
    await _pumpApp(
      tester,
      setup: (AppScope scope) => scope.settings.setBrand(MarkerBrand.decoTime),
    );

    // "All" shows the whole DecoTime range; "Mine" is empty.
    await tester.tap(find.byKey(const ValueKey<String>('swatches-mine')));
    await tester.pumpAndSettle();
    expect(find.text(l10n.swatchesEmptyNoOwnedAction), findsOneWidget);
    await tester.tap(find.text(l10n.swatchesEmptyNoOwnedAction));
    await tester.pumpAndSettle();

    expect(find.byKey(CollectionPage.pageKey), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
