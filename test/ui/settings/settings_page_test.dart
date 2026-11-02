import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ai/ai.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/pages/collection/collection_page.dart';
import 'package:ink_lab/ui/pages/onboarding/onboarding_page.dart';
import 'package:ink_lab/ui/pages/settings/constants.dart';
import 'package:ink_lab/ui/pages/settings/favorites_section.dart';
import 'package:ink_lab/ui/pages/settings/settings_page.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/theme/app_typography.dart';
import 'package:ink_lab/ui/widgets/ink_chip.dart';
import 'package:ink_lab/ui/widgets/ink_sheet.dart';

import '../../support/l10n.dart';

/// A marker repository that reads the real datasets from disk.
///
/// The read is synchronous on purpose: a widget test runs in a fake-async
/// zone where real file I/O never completes.
MarkerRepository diskMarkers() =>
    MarkerRepository(loadAsset: (String path) => File(path).readAsStringSync());

/// Pumps the settings page over an in-memory scope and returns the scope, so
/// the test can drive the repositories directly.
Future<AppScope> pumpSettings(
  WidgetTester tester, {
  bool noOnDevice = false,
  String language = 'en',
}) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  final StoredAiSettingsRepository aiSettings = StoredAiSettingsRepository(
    InMemoryKeyValueStore(),
  );
  final InMemorySecretStore secrets = InMemorySecretStore();
  final AppScope scope = AppScope.inMemory(
    markers: diskMarkers(),
    aiSettings: aiSettings,
    secrets: secrets,
    // Tests run as Android, which has an on-device path; the iOS/desktop case
    // is a platform without one.
    aiService: noOnDevice
        ? AiService(
            aiSettings: aiSettings,
            secrets: secrets,
            onDevice: const UnsupportedOnDeviceAi(),
          )
        : null,
    child: const SettingsPage(),
  );
  await tester.pumpWidget(
    MaterialApp(
      locale: Locale(language),
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

/// How much the settings list scrolls: the height of its content.
double _contentHeight(WidgetTester tester) => tester
    .state<ScrollableState>(_pageScrollable)
    .position
    .maxScrollExtent;

/// Opens the folded copy by text of the backup card.
Future<void> openTextBackup(WidgetTester tester) async {
  await scrollTo(tester, find.text(l10n.settingsBackupTextTitle));
  await tester.tap(find.text(l10n.settingsBackupTextTitle));
  await tester.pumpAndSettle();
}

/// Turns the AI on, accepting the disclosure it asks for.
Future<void> enableAi(WidgetTester tester) async {
  await scrollTo(tester, find.text(l10n.settingsAiEnabled));
  await tester.tap(find.text(l10n.settingsAiEnabled));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey<String>('ai-disclosure-confirm')));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('the sections come in the agreed order', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester);

    expect(find.byKey(SettingsPage.pageKey), findsOneWidget);
    final List<String> heads = <String>[
      l10n.settingsCollectionGroup,
      l10n.settingsDisplayGroup,
      l10n.settingsMatchingGroup,
      l10n.settingsAiGroup,
      l10n.settingsDataGroup,
      l10n.settingsAboutTitle,
    ].map(AppTypography.caps).toList();
    double last = -1;
    for (final String head in heads) {
      final Finder f = find.text(head);
      await scrollTo(tester, f);
      final ScrollableState s = tester.state<ScrollableState>(_pageScrollable);
      final double y = tester.getTopLeft(f.first).dy + s.position.pixels;
      expect(y, greaterThan(last), reason: head);
      last = y;
    }
    expect(find.text(SettingsConstants.appVersion), findsOneWidget);
    expect(find.text(l10n.settingsDisclaimer), findsOneWidget);
  });

  testWidgets('My collection is one summary row', (WidgetTester tester) async {
    await pumpSettings(tester);

    final Finder row = find.byKey(
      const ValueKey<String>('settings-collection-row'),
    );
    expect(row, findsOneWidget);
    // The preview collection is Oahu 160 (161 markers with the blender).
    expect(
      find.descendant(of: row, matching: find.text('Ohuhu')),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: row,
        matching: find.text('Oahu · 1 set · 161 markers'),
      ),
      findsOneWidget,
    );
    // The old collection controls are gone from Settings.
    expect(find.byType(InkChip), findsNothing);
    expect(find.byType(CheckboxListTile), findsNothing);
  });

  testWidgets('the collection row opens the collection screen', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester);

    await tester.tap(
      find.byKey(const ValueKey<String>('settings-collection-row')),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(CollectionPage.pageKey), findsOneWidget);
  });

  testWidgets('the setup can be run again from Settings', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester);

    await tester.tap(
      find.byKey(const ValueKey<String>('settings-setup-again')),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(OnboardingPage.pageKey), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey<String>('onboarding-skip')));
    await tester.pumpAndSettle();
    expect(find.byKey(OnboardingPage.pageKey), findsNothing);
    expect(find.byKey(SettingsPage.pageKey), findsOneWidget);
  });

  testWidgets('name display is only offered for Ohuhu', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpSettings(tester);
    await scrollTo(tester, find.text(l10n.settingsLabelsTitle));
    expect(find.text(l10n.settingsLabelsTitle), findsOneWidget);

    await scope.settings.setBrand(MarkerBrand.decoTime);
    await tester.pumpAndSettle();
    expect(find.text(l10n.settingsLabelsTitle), findsNothing);
  });

  testWidgets('the colour matching switch is stored', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpSettings(tester);
    final Finder row = find.byKey(
      const ValueKey<String>('settings-match-unowned'),
    );
    await scrollTo(tester, row);
    await tester.tap(row);
    await tester.pumpAndSettle();

    expect(scope.settings.state.matchSuggestUnowned, isFalse);
  });

  testWidgets('the first-run flag is not shown to users', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester);

    expect(find.text('First-run setup completed'), findsNothing);
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

    final Finder row = find.byKey(
      const ValueKey<String>('settings-saved-palettes'),
    );
    await scrollTo(tester, row);
    await tester.tap(row);
    await tester.pumpAndSettle();

    await tester.tap(
      find.byKey(const ValueKey<String>('palette-saved-menu-p1')),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey<String>('palette-delete-p1')));
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(const ValueKey<String>('palette-delete-confirm')),
    );
    await tester.pumpAndSettle();

    expect(scope.savedPalettes.palettesOf(MarkerBrand.ohuhuOahu), isEmpty);
  });

  testWidgets('a favorite can be removed from the sheet', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpSettings(tester);
    await scope.settings.setFavorites(<String>{'ohuhu_oahu:YR114'});
    await tester.pumpAndSettle();

    // The list is not in the page: the row opens it.
    expect(find.text('YR114'), findsNothing);
    await scrollTo(tester, find.byKey(FavoritesSection.rowKey));
    await tester.tap(find.byKey(FavoritesSection.rowKey));
    await tester.pumpAndSettle();

    expect(find.text('YR114'), findsOneWidget);
    await tester.tap(find.byTooltip(l10n.settingsDeleteFavorite));
    await tester.pumpAndSettle();

    expect(scope.settings.favorites, isEmpty);
  });

  testWidgets('the favorites row opens the list at half the height', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpSettings(tester);
    await scope.settings.setFavorites(<String>{'ohuhu_oahu:YR114'});
    await tester.pumpAndSettle();

    await scrollTo(tester, find.byKey(FavoritesSection.rowKey));
    await tester.tap(find.byKey(FavoritesSection.rowKey));
    await tester.pumpAndSettle();

    // The sheet opens at the half, with the list inside it.
    expect(
      tester.getTopLeft(find.byType(InkSheet)).dy,
      moreOrLessEquals(844 / 2, epsilon: 2),
    );
    expect(
      find.descendant(
        of: find.byType(InkSheet),
        matching: find.text(l10n.settingsFavoritesTitle),
      ),
      findsOneWidget,
    );
    expect(find.text('YR114'), findsOneWidget);
  });

  testWidgets('the menu of the sheet clears every favorite', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpSettings(tester);
    await scope.settings.setFavorites(<String>{
      'ohuhu_oahu:YR114',
      'ohuhu_oahu:YR115',
    });
    await tester.pumpAndSettle();

    await scrollTo(tester, find.byKey(FavoritesSection.rowKey));
    await tester.tap(find.byKey(FavoritesSection.rowKey));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip(l10n.commonMoreActions));
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(const ValueKey<String>('settings-favorites-clear')),
    );
    await tester.pumpAndSettle();

    // It asks first.
    expect(find.text(l10n.settingsClearFavoritesTitle), findsOneWidget);
    await tester.tap(
      find.widgetWithText(FilledButton, l10n.settingsClearFavorites),
    );
    await tester.pumpAndSettle();

    expect(scope.settings.favorites, isEmpty);
    expect(find.text('YR114'), findsNothing);
  });

  testWidgets('many favorites do not make the page longer', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpSettings(tester);
    final double empty = _contentHeight(tester);

    await scope.settings.setFavorites(<String>{
      for (int i = 1; i <= 40; i++) 'ohuhu_oahu:YR$i',
    });
    await tester.pumpAndSettle();

    // The list is behind the sheet: the page is exactly as long as before.
    expect(_contentHeight(tester), empty);
    expect(find.byKey(FavoritesSection.rowKey), findsOneWidget);
    // The row tells how many there are.
    expect(
      find.descendant(
        of: find.byKey(FavoritesSection.rowKey),
        matching: find.text('40'),
      ),
      findsOneWidget,
    );
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
    await openTextBackup(tester);
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

    await openTextBackup(tester);
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

    await openTextBackup(tester);
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

  testWidgets('About lists the privacy policy link in English', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester);

    await scrollTo(tester, find.text(l10n.settingsPrivacyPolicy));
    expect(find.text(l10n.settingsPrivacyPolicy), findsOneWidget);
    expect(find.text(SettingsConstants.privacyUrlEn), findsOneWidget);
  });

  group('About links the privacy policy page in the language of the app', () {
    const Map<String, String> pages = <String, String>{
      'en': 'https://inklab.mainshai.com/privacy/',
      'es': 'https://inklab.mainshai.com/es/privacy/',
      'de': 'https://inklab.mainshai.com/de/privacy/',
      'fr': 'https://inklab.mainshai.com/fr/privacy/',
      'pt': 'https://inklab.mainshai.com/pt/privacy/',
      'it': 'https://inklab.mainshai.com/it/privacy/',
    };
    for (final MapEntry<String, String> page in pages.entries) {
      testWidgets(page.key, (WidgetTester tester) async {
        await pumpSettings(tester, language: page.key);
        final AppLocalizations t = lookupAppLocalizations(Locale(page.key));
        await scrollTo(tester, find.text(t.settingsPrivacyPolicy));
        expect(find.text(page.value), findsOneWidget);
      });
    }

    test('a language without a page gets the English one', () {
      expect(SettingsConstants.privacyUrlFor('ja'), pages['en']);
      for (final MapEntry<String, String> page in pages.entries) {
        expect(SettingsConstants.privacyUrlFor(page.key), page.value);
      }
    });
  });

  testWidgets('the AI helper text only names On-device when it is offered', (
    WidgetTester tester,
  ) async {
    // A platform with no on-device model path (iOS, web, desktop).
    await pumpSettings(tester, noOnDevice: true);

    await scrollTo(tester, find.text(l10n.settingsAiEnabled));
    // With the AI off the card shows the switch and one line, nothing else.
    expect(find.text(l10n.settingsAiSubtitle), findsOneWidget);
    expect(
      find.text(l10n.settingsAiEnabledSubtitleColourTheoryNoOnDevice),
      findsNothing,
    );
    expect(find.text(l10n.settingsAiProvider), findsNothing);

    await enableAi(tester);

    expect(
      find.text(l10n.settingsAiEnabledSubtitleColourTheoryNoOnDevice),
      findsOneWidget,
    );
    expect(find.text(l10n.settingsAiEnabledSubtitleColourTheory), findsNothing);
  });

  testWidgets('the AI settings are stored', (WidgetTester tester) async {
    final AppScope scope = await pumpSettings(tester, noOnDevice: true);

    await scrollTo(tester, find.text(l10n.settingsAiEnabled));
    await tester.tap(find.text(l10n.settingsAiEnabled));
    await tester.pumpAndSettle();
    // Turning it on is gated behind the disclosure.
    expect(
      find.text(l10n.settingsAiDisclosureColourTheoryNoOnDevice),
      findsOneWidget,
    );
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
    // The provider (and its key) only come with the AI.
    await enableAi(tester);

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

  testWidgets('"Use my colours" is on by default and stored', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpSettings(tester);
    final Finder row = find.byKey(
      const ValueKey<String>('settings-own-colors'),
    );
    await scrollTo(tester, row);
    expect(find.text(l10n.settingsOwnColors), findsOneWidget);
    expect(find.text(l10n.settingsOwnColorsSubtitle), findsOneWidget);
    expect(scope.settings.state.useOwnColors, isTrue);

    await tester.tap(row);
    await tester.pumpAndSettle();
    expect(scope.settings.state.useOwnColors, isFalse);

    await tester.tap(row);
    await tester.pumpAndSettle();
    expect(scope.settings.state.useOwnColors, isTrue);
  });

  testWidgets('the colours of their own are counted and can be reset', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpSettings(tester);
    final Finder count = find.byKey(
      const ValueKey<String>('settings-own-colors-count'),
    );
    final Finder reset = find.byKey(
      const ValueKey<String>('settings-own-colors-reset'),
    );
    await scrollTo(tester, count);
    expect(find.text(l10n.settingsOwnColorsCount(0)), findsOneWidget);
    expect(reset, findsNothing);

    await scope.ownColors.set('R1', 'aabbcc');
    await scope.ownColors.set('decotime:01', '112233');
    await tester.pumpAndSettle();
    expect(find.text(l10n.settingsOwnColorsCount(2)), findsOneWidget);
    await scope.ownColors.remove('decotime:01');
    await tester.pumpAndSettle();
    expect(find.text(l10n.settingsOwnColorsCount(1)), findsOneWidget);

    // Cancelling keeps them.
    await tester.tap(reset);
    await tester.pumpAndSettle();
    expect(find.text(l10n.settingsOwnColorsResetTitle), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, l10n.settingsCancel));
    await tester.pumpAndSettle();
    expect(scope.ownColors.colors, isNotEmpty);

    // Confirming brings every marker back to its catalogue colour.
    await tester.tap(reset);
    await tester.pumpAndSettle();
    await tester.tap(
      find.widgetWithText(FilledButton, l10n.settingsOwnColorsReset),
    );
    await tester.pumpAndSettle();
    expect(scope.ownColors.colors, isEmpty);
    expect(find.text(l10n.settingsOwnColorsCount(0)), findsOneWidget);
    expect(reset, findsNothing);
  });

  testWidgets('the beta row shows the group and copies the link', (
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
    final Finder row = find.byKey(const ValueKey<String>('settings-beta'));
    await scrollTo(tester, row);
    expect(find.text(l10n.settingsJoinBeta), findsOneWidget);
    expect(find.text(SettingsConstants.betaGroupUrl), findsOneWidget);
    expect(
      SettingsConstants.betaGroupUrl,
      'https://groups.google.com/g/ink-lab-testers',
    );

    await tester.tap(
      find.descendant(
        of: row,
        matching: find.byTooltip(l10n.settingsCopyRepository),
      ),
    );
    await tester.pumpAndSettle();
    expect(copied, SettingsConstants.betaGroupUrl);
    expect(find.text(l10n.settingsRepositoryCopied), findsOneWidget);
  });
}
