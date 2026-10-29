import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/pages/settings/constants.dart';
import 'package:ink_lab/ui/pages/settings/settings_page.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/theme/app_typography.dart';
import 'package:ink_lab/ui/widgets/ink_chip.dart';

import '../../support/l10n.dart';

/// A marker repository that reads the real datasets from disk.
///
/// The read is synchronous on purpose: a widget test runs in a fake-async
/// zone where real file I/O never completes.
MarkerRepository diskMarkers() =>
    MarkerRepository(loadAsset: (String path) => File(path).readAsStringSync());

/// Pumps the settings page over an in-memory scope and returns the scope, so
/// the test can drive the repositories directly.
Future<AppScope> pumpSettings(WidgetTester tester) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  final AppScope scope = AppScope.inMemory(
    markers: diskMarkers(),
    child: const SettingsPage(),
  );
  await tester.pumpWidget(
    MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      theme: AppTheme.light(),
      // The shell hosts the page inside its own Scaffold.
      home: Scaffold(body: scope),
    ),
  );
  await tester.pumpAndSettle();
  return scope;
}

/// The scrollable of the page itself (the settings list).
///
/// The page holds other scrollables (the owned markers, the text fields), so
/// the first vertical one of the page is the one that is driven.
Finder get _pageScrollable => find
    .descendant(
      of: find.byType(ListView).first,
      matching: find.byWidgetPredicate(
        (Widget widget) =>
            widget is Scrollable && widget.axisDirection == AxisDirection.down,
      ),
    )
    .first;

/// Scrolls the settings list until [finder] is on screen.
///
/// The page holds a second, inner list (the owned markers), so the gesture
/// based helpers can be swallowed by it: the outer scrollable is driven
/// directly instead.
Future<void> scrollTo(WidgetTester tester, Finder finder) async {
  final ScrollableState scrollable = tester.state<ScrollableState>(
    _pageScrollable,
  );
  for (int step = 0; step < 80 && finder.evaluate().isEmpty; step++) {
    final ScrollPosition position = scrollable.position;
    final double next = (position.pixels + 200).clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );
    if (next == position.pixels) break;
    position.jumpTo(next);
    await tester.pump();
  }
  await tester.pumpAndSettle();
  expect(finder, findsWidgets, reason: 'the settings page must show $finder');

  // Centre the item in the viewport of the page.
  final RenderBox viewportBox =
      scrollable.context.findRenderObject()! as RenderBox;
  final Rect viewport =
      viewportBox.localToGlobal(Offset.zero) & viewportBox.size;
  final Rect target = tester.getRect(finder);
  final ScrollPosition position = scrollable.position;
  position.jumpTo(
    (position.pixels + target.center.dy - viewport.center.dy).clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    ),
  );
  await tester.pumpAndSettle();
}

/// The text field of a labelled field.
Finder labelledField(String label) => find.byWidgetPredicate(
  (Widget widget) =>
      widget is TextField && widget.decoration?.labelText == label,
);

void main() {
  testWidgets('the page shows its sections', (WidgetTester tester) async {
    await pumpSettings(tester);

    expect(find.byKey(SettingsPage.pageKey), findsOneWidget);
    expect(find.text(l10n.settingsBrandTitle), findsOneWidget);
    expect(find.text(l10n.settingsPacksTitle), findsOneWidget);

    // Group heads are drawn in capitals.
    final Finder aboutHead = find.text(
      AppTypography.caps(l10n.settingsAboutTitle),
    );
    await scrollTo(tester, aboutHead);
    expect(aboutHead, findsOneWidget);
    expect(find.text(SettingsConstants.appVersion), findsOneWidget);
    expect(find.text(l10n.settingsDisclaimer), findsOneWidget);
  });

  testWidgets('the brand control hints that DecoTime shows owned markers', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester);

    expect(
      find.text('DecoTime shows only the markers you mark as owned.'),
      findsOneWidget,
    );
  });

  testWidgets('the brand switch stores the active brand', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpSettings(tester);

    await tester.tap(find.text(MarkerBrand.decoTime.label));
    await tester.pumpAndSettle();

    expect(scope.settings.brand, MarkerBrand.decoTime);
  });

  testWidgets('the first-run flag is not shown to users', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester);

    expect(find.text('First-run setup completed'), findsNothing);
  });

  testWidgets('a pack can be selected', (WidgetTester tester) async {
    final AppScope scope = await pumpSettings(tester);

    await scrollTo(tester, find.widgetWithText(InkChip, '120 New'));
    await tester.tap(find.widgetWithText(InkChip, '120 New'));
    await tester.pumpAndSettle();

    expect(scope.settings.settings.selectedCoreSetIds, contains('new_120'));
  });

  testWidgets('the pack selection mode is stored', (WidgetTester tester) async {
    final AppScope scope = await pumpSettings(tester);

    await scrollTo(tester, find.text(PackSelectionMode.compare.label));
    await tester.tap(find.text(PackSelectionMode.compare.label));
    await tester.pumpAndSettle();

    expect(
      scope.settings.settings.packSelectionMode,
      PackSelectionMode.compare,
    );
  });

  testWidgets('an owned marker can be ticked', (WidgetTester tester) async {
    final AppScope scope = await pumpSettings(tester);

    await scrollTo(tester, find.widgetWithText(CheckboxListTile, 'BV04'));
    await tester.tap(find.widgetWithText(CheckboxListTile, 'BV04'));
    await tester.pumpAndSettle();

    expect(
      scope.settings.settings.ownedMarkerCodes,
      contains('ohuhu_oahu:BV04'),
    );
  });

  testWidgets('the owned markers can be selected and unselected at once', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpSettings(tester);

    await scrollTo(tester, find.text(l10n.settingsSelectAll));
    await tester.tap(find.text(l10n.settingsSelectAll));
    await tester.pumpAndSettle();
    expect(scope.settings.settings.ownedMarkerCodes, isNotEmpty);

    await tester.tap(find.text(l10n.settingsSelectNone));
    await tester.pumpAndSettle();
    expect(scope.settings.settings.ownedMarkerCodes, isEmpty);
  });

  testWidgets('clearing the owned markers asks for a confirmation', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpSettings(tester);
    await scope.settings.setOwnedMarkerCodes(<String>{'ohuhu_oahu:BV04'});
    await tester.pumpAndSettle();

    await scrollTo(tester, find.text(l10n.settingsClearOwned));
    await tester.tap(find.text(l10n.settingsClearOwned));
    await tester.pumpAndSettle();

    expect(find.text(l10n.settingsClearOwnedTitle), findsOneWidget);
    // The markers are still owned while the dialog is open.
    expect(scope.settings.settings.ownedMarkerCodes, isNotEmpty);

    await tester.tap(
      find.widgetWithText(FilledButton, l10n.settingsClearOwned),
    );
    await tester.pumpAndSettle();

    expect(scope.settings.settings.ownedMarkerCodes, isEmpty);
  });

  testWidgets('a saved palette can be deleted', (WidgetTester tester) async {
    final AppScope scope = await pumpSettings(tester);
    await scope.savedPalettes.save(
      SavedPalette(
        id: 'p1',
        brandId: 'ohuhu_oahu',
        name: 'Sunrise',
        baseCode: 'R1',
        baseName: 'Red',
        mode: PaletteMode.triad,
        paletteSize: 3,
        createdAtEpochMs: 1000,
        colorCodes: const <String>['R1', 'G1', 'B1'],
      ),
    );
    await tester.pumpAndSettle();

    await scrollTo(tester, find.text('Sunrise'));
    expect(find.text('Sunrise'), findsOneWidget);

    await tester.tap(find.byTooltip(l10n.settingsDeletePalette));
    await tester.pumpAndSettle();

    expect(scope.savedPalettes.palettesOf(MarkerBrand.ohuhuOahu), isEmpty);
  });

  testWidgets('a favorite can be removed', (WidgetTester tester) async {
    final AppScope scope = await pumpSettings(tester);
    await scope.settings.setFavorites(<String>{'ohuhu_oahu:YR114'});
    await tester.pumpAndSettle();

    await scrollTo(tester, find.widgetWithText(ListTile, 'YR114'));
    await tester.tap(find.byTooltip(l10n.settingsDeleteFavorite));
    await tester.pumpAndSettle();

    expect(scope.settings.favorites, isEmpty);
  });

  testWidgets('the name display mode is stored', (WidgetTester tester) async {
    final AppScope scope = await pumpSettings(tester);

    await scrollTo(tester, find.text(l10n.settingsOldLabels));
    await tester.tap(find.text(l10n.settingsOldLabels));
    await tester.pumpAndSettle();

    expect(scope.settings.nameDisplayMode, NameDisplayMode.oldOnly);
  });

  testWidgets('the export copies the backup to the clipboard', (
    WidgetTester tester,
  ) async {
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (MethodCall call) async {
        if (call.method == 'Clipboard.setData') {
          copied = (call.arguments as Map<Object?, Object?>)['text'] as String;
        }
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );

    await pumpSettings(tester);
    await scrollTo(tester, find.text(l10n.settingsExportBackup));
    await tester.tap(find.text(l10n.settingsExportBackup));
    await tester.pumpAndSettle();

    expect(copied, isNotNull);
    final Map<String, Object?> backup =
        jsonDecode(copied!) as Map<String, Object?>;
    expect(backup['version'], 1);
    expect(find.text(l10n.settingsBackupExported), findsOneWidget);
  });

  testWidgets('an invalid backup is refused with a message', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester);

    await scrollTo(tester, find.text(l10n.settingsImportBackup));
    await tester.tap(find.text(l10n.settingsImportBackup));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.byType(TextField),
      ),
      'this is not json',
    );
    await tester.tap(
      find.widgetWithText(FilledButton, l10n.settingsImportConfirm),
    );
    await tester.pumpAndSettle();

    expect(find.text(l10n.settingsImportInvalidJson), findsOneWidget);
  });

  testWidgets('a backup is imported after a confirmation', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpSettings(tester);
    final String backup = jsonEncode(<String, Object?>{
      'version': 1,
      'appSettings': <String, Object?>{
        'brand': 'decotime',
        'nameDisplayMode': 'OldOnly',
      },
    });

    await scrollTo(tester, find.text(l10n.settingsImportBackup));
    await tester.tap(find.text(l10n.settingsImportBackup));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.byType(TextField),
      ),
      backup,
    );
    await tester.tap(
      find.widgetWithText(FilledButton, l10n.settingsImportConfirm),
    );
    await tester.pumpAndSettle();

    // The import asks before it replaces anything.
    expect(find.text(l10n.settingsImportConfirmTitle), findsOneWidget);
    expect(scope.settings.brand, MarkerBrand.ohuhuOahu);

    await tester.tap(
      find.widgetWithText(FilledButton, l10n.settingsImportConfirm),
    );
    await tester.pumpAndSettle();

    expect(scope.settings.brand, MarkerBrand.decoTime);
    expect(scope.settings.nameDisplayMode, NameDisplayMode.oldOnly);
    expect(find.text(l10n.settingsBackupImported), findsOneWidget);
  });

  testWidgets('the AI settings are stored', (WidgetTester tester) async {
    final AppScope scope = await pumpSettings(tester);

    await scrollTo(tester, find.text(l10n.settingsAiEnabled));
    await tester.tap(find.text(l10n.settingsAiEnabled));
    await tester.pumpAndSettle();
    // Turning it on is gated behind the disclosure.
    expect(find.text(l10n.settingsAiDisclosureColourTheory), findsOneWidget);
    await tester.tap(
      find.byKey(const ValueKey<String>('ai-disclosure-confirm')),
    );
    await tester.pumpAndSettle();
    expect(scope.aiSettings.value.enabled, isTrue);

    await scrollTo(tester, find.text(l10n.settingsAiProviderOpenRouter));
    await tester.tap(find.text(l10n.settingsAiProviderOpenRouter));
    await tester.pumpAndSettle();
    expect(scope.aiSettings.value.provider, AiProvider.openRouter);

    final Finder modelRow = find.byKey(
      const ValueKey<String>('ai-text-model-row'),
    );
    await scrollTo(tester, modelRow);
    await tester.tap(modelRow);
    await tester.pumpAndSettle();
    await tester.enterText(
      find.descendant(
        of: find.byKey(const ValueKey<String>('ai-model-search')),
        matching: find.byType(TextField),
      ),
      'a-model',
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey<String>('ai-model-use-typed')));
    await tester.pumpAndSettle();
    expect(scope.aiSettings.value.textModel, 'a-model');

    await scrollTo(tester, labelledField(l10n.settingsAiMaxTokens));
    await tester.enterText(labelledField(l10n.settingsAiMaxTokens), '42');
    await tester.pumpAndSettle();
    expect(scope.aiSettings.value.maxTokens, 42);

    await scrollTo(tester, find.text(l10n.settingsAiAutoFallback));
    await tester.tap(find.text(l10n.settingsAiAutoFallback));
    await tester.pumpAndSettle();
    expect(scope.aiSettings.value.autoFallback, isFalse);
  });

  testWidgets('the API key field is masked', (WidgetTester tester) async {
    await pumpSettings(tester);

    await scrollTo(tester, find.text(l10n.settingsAiProviderOpenRouter));
    await tester.tap(find.text(l10n.settingsAiProviderOpenRouter));
    await tester.pumpAndSettle();

    await scrollTo(
      tester,
      find.byKey(const ValueKey<String>('ai-api-key-field')),
    );
    final TextField field = tester.widget<TextField>(
      find.byKey(const ValueKey<String>('ai-api-key-field')),
    );
    expect(field.obscureText, isTrue);
    expect(field.autocorrect, isFalse);
  });

  testWidgets('the appearance control is stored', (WidgetTester tester) async {
    final AppScope scope = await pumpSettings(tester);
    expect(scope.settings.themeMode, AppThemeMode.system);

    await scrollTo(tester, find.text(l10n.settingsAppearanceDark));
    await tester.tap(find.text(l10n.settingsAppearanceDark));
    await tester.pumpAndSettle();

    expect(scope.settings.themeMode, AppThemeMode.dark);
  });
}
