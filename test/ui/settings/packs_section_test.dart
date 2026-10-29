import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/ui/pages/settings/settings_page.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/widgets/ink_chip.dart';
import 'package:ink_lab/ui/widgets/ink_disclosure.dart';

import '../../support/l10n.dart';

MarkerRepository _markers() =>
    MarkerRepository(loadAsset: (String path) => File(path).readAsStringSync());

/// Pumps the settings page on a 360 dp phone, the narrowest supported width.
Future<AppScope> _pump(
  WidgetTester tester,
  Locale locale, {
  Set<String>? selectedCore,
}) async {
  tester.view.physicalSize = const Size(360, 800);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  final AppScope scope = AppScope.inMemory(
    markers: _markers(),
    child: const SettingsPage(),
  );
  await tester.pumpWidget(
    MaterialApp(
      locale: locale,
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      theme: AppTheme.light(),
      home: Scaffold(body: scope),
    ),
  );
  await tester.pumpAndSettle();
  if (selectedCore != null) {
    await scope.settings.setSelectedCoreSetIds(selectedCore);
    await tester.pumpAndSettle();
  }
  return scope;
}

/// Scrolls the settings list until [finder] is on screen.
Future<void> _show(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(
    finder,
    200,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pumpAndSettle();
}

Finder _lineChip(String line) => find.widgetWithText(InkChip, line);

Finder _lineHeader(String line) =>
    find.descendant(of: find.byType(InkDisclosure), matching: find.text(line));

void main() {
  setUpAll(loadAppFonts);

  for (final Locale locale in const <Locale>[Locale('en'), Locale('es')]) {
    final AppLocalizations t = lookupAppLocalizations(locale);
    final String lang = locale.languageCode;

    group('Collection packs ($lang)', () {
      testWidgets('start with the Oahu line only, as before', (
        WidgetTester tester,
      ) async {
        final AppScope scope = await _pump(tester, locale);

        await _show(tester, find.text(t.settingsLinesTitle.toUpperCase()));
        expect(_lineChip('Oahu'), findsOneWidget);
        expect(_lineChip('Honolulu'), findsOneWidget);
        expect(_lineChip('Kaala'), findsOneWidget);
        expect(_lineHeader('Oahu'), findsOneWidget);
        expect(_lineHeader('Honolulu'), findsNothing);
        expect(_lineHeader('Kaala'), findsNothing);

        // The classic packs are right there, nothing needs opening.
        final Finder classic160 = find.widgetWithText(InkChip, '160');
        await _show(tester, classic160);
        expect(classic160, findsOneWidget);
        expect(scope.settings.settings.selectedCoreSetIds, <String>{
          'classic_160',
        });
        expect(tester.takeException(), isNull);
      });

      testWidgets('a line chip adds the packs of that line', (
        WidgetTester tester,
      ) async {
        final AppScope scope = await _pump(tester, locale);

        await _show(tester, _lineChip('Honolulu'));
        await tester.tap(_lineChip('Honolulu'));
        await tester.pumpAndSettle();
        expect(_lineHeader('Honolulu'), findsOneWidget);

        // Honolulu has a pack named just "48"; Oahu has no such pack.
        final Finder pack48 = find.widgetWithText(InkChip, '48');
        await _show(tester, pack48);
        await tester.tap(pack48);
        await tester.pumpAndSettle();

        expect(
          scope.settings.settings.selectedCoreSetIds,
          contains('honolulu_48'),
        );
        expect(tester.takeException(), isNull);
      });

      testWidgets('older packs are grouped and carry the community note', (
        WidgetTester tester,
      ) async {
        final AppScope scope = await _pump(tester, locale);
        await _show(tester, _lineChip('Honolulu'));
        await tester.tap(_lineChip('Honolulu'));
        await tester.pumpAndSettle();

        final int legacyCount = OahuSet.forLine(MarkerLine.honolulu)
            .where((OahuSet set) => set.isLegacy)
            .length;
        final int currentCount =
            OahuSet.forLine(MarkerLine.honolulu).length - legacyCount;
        final Finder current = find.text(
          t.settingsCurrentPacks(currentCount).toUpperCase(),
        );
        await _show(tester, current);
        expect(current, findsOneWidget);

        // The older packs start closed, with a count in the header.
        final Finder legacyHeader = find.text(
          t.settingsLegacyPacks(legacyCount),
        );
        await _show(tester, legacyHeader);
        expect(find.text(t.settingsLegacyPacksNote), findsNothing);
        await tester.tap(legacyHeader);
        await tester.pumpAndSettle();
        expect(find.text(t.settingsLegacyPacksNote), findsOneWidget);

        final Finder white = find.widgetWithText(
          InkChip,
          t.packSetLabel(OahuSet.honoluluWhite24V1),
        );
        await _show(tester, white);
        await tester.tap(white);
        await tester.pumpAndSettle();
        expect(
          scope.settings.settings.selectedCoreSetIds,
          contains('honolulu_white_24_v1'),
        );
        expect(tester.takeException(), isNull);
      });

      testWidgets('packs of several lines can be compared', (
        WidgetTester tester,
      ) async {
        final AppScope scope = await _pump(tester, locale);
        await scope.settings.setPackSelectionMode(PackSelectionMode.compare);
        await tester.pumpAndSettle();

        await _show(tester, _lineChip('Kaala'));
        await tester.tap(_lineChip('Kaala'));
        await tester.pumpAndSettle();
        final Finder illustration = find.widgetWithText(
          InkChip,
          t.packSetLabel(OahuSet.kaalaIllustration60),
        );
        await _show(tester, illustration);
        await tester.tap(illustration);
        await tester.pumpAndSettle();

        expect(scope.settings.settings.effectiveSetIds(), <String>{
          'classic_160',
          'kaala_illustration_60',
        });
        expect(tester.takeException(), isNull);
      });

      testWidgets('turning a line off drops its packs, the last line stays', (
        WidgetTester tester,
      ) async {
        final AppScope scope = await _pump(
          tester,
          locale,
          selectedCore: <String>{'honolulu_48'},
        );

        // Honolulu is shown because a pack of it is selected.
        expect(_lineHeader('Honolulu'), findsOneWidget);
        await _show(tester, _lineChip('Honolulu'));
        await tester.tap(_lineChip('Honolulu'));
        await tester.pumpAndSettle();
        expect(_lineHeader('Honolulu'), findsNothing);
        expect(
          scope.settings.settings.selectedCoreSetIds,
          isNot(contains('honolulu_48')),
        );

        // Oahu is the only line left: it cannot be switched off.
        await _show(tester, _lineChip('Oahu'));
        await tester.tap(_lineChip('Oahu'));
        await tester.pumpAndSettle();
        expect(_lineHeader('Oahu'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('owned markers keep working next to several lines', (
        WidgetTester tester,
      ) async {
        final AppScope scope = await _pump(
          tester,
          locale,
          selectedCore: <String>{'honolulu_48'},
        );
        await scope.settings.setOwnedMarkerCodes(<String>{'B08'});
        await tester.pumpAndSettle();

        expect(
          scopedCodesForBrand(
            scope.settings.settings.ownedMarkerCodes,
            MarkerBrand.ohuhuOahu.id,
          ),
          contains('B08'),
        );
        expect(scope.settings.settings.effectiveSetIds(), <String>{
          'honolulu_48',
        });
        expect(tester.takeException(), isNull);
      });
    });
  }
}
