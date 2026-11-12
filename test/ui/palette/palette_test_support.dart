import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ai/ai.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/pages/palette/palette_page.dart';
import 'package:ink_lab/ui/pages/palette/palette_suggestion_row.dart';
import 'package:ink_lab/ui/screen_awake.dart';
import 'package:ink_lab/ui/share/share_sink.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';

import '../../support/l10n.dart';

/// A marker repository that reads the real asset JSON from disk.
///
/// The loader is synchronous on purpose: the load future then completes on a
/// microtask, so widget tests settle without `tester.runAsync`.
MarkerRepository diskMarkerRepository() =>
    MarkerRepository(loadAsset: (String path) => File(path).readAsStringSync());

/// The palette page inside an in-memory scope and a minimal Material app.
///
/// [secrets], [aiSettings] and [aiService] let a test configure the optional AI
/// advisor with a deterministic transport.
AppScope paletteScope({
  SecretStore? secrets,
  AiSettingsRepository? aiSettings,
  AiService? aiService,
  Future<bool> Function(Uri uri)? launchEmail,
  ShareSink? shareSink,
  ScreenAwake? screenAwake,
  StoreReviewer? storeReviewer,
}) => AppScope.inMemory(
  markers: diskMarkerRepository(),
  storeReviewer: storeReviewer,
  secrets: secrets,
  aiSettings: aiSettings,
  aiService: aiService,
  child: MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: testLocalizationsDelegates,
    supportedLocales: testSupportedLocales,
    theme: AppTheme.light(),
    darkTheme: AppTheme.dark(),
    home: Scaffold(
      body: PalettePage(
        launchEmail: launchEmail,
        shareSink: shareSink,
        screenAwake: screenAwake ?? const _NoScreenAwake(),
      ),
    ),
  ),
);

/// A screen-awake seam that does nothing, so a test never reaches the
/// wakelock plugin.
class _NoScreenAwake implements ScreenAwake {
  const _NoScreenAwake();

  @override
  Future<void> enable() async {}

  @override
  Future<void> disable() async {}
}

/// Pumps the palette page inside a fresh in-memory scope.
///
/// [brand] and [ownedMarkerCodes] configure the scope before the widget tree is
/// built; [setup] runs last, to seed saved palettes. The optional AI arguments
/// are forwarded to [paletteScope].
Future<AppScope> pumpPalette(
  WidgetTester tester, {
  MarkerBrand brand = MarkerBrand.ohuhuOahu,
  Set<String>? ownedMarkerCodes,
  Future<void> Function(AppScope scope)? setup,
  SecretStore? secrets,
  AiSettingsRepository? aiSettings,
  AiService? aiService,
  Future<bool> Function(Uri uri)? launchEmail,
  ShareSink? shareSink,
  ScreenAwake? screenAwake,
  StoreReviewer? storeReviewer,
}) async {
  tester.view.physicalSize = const Size(600, 3000);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  final AppScope scope = paletteScope(
    secrets: secrets,
    aiSettings: aiSettings,
    aiService: aiService,
    launchEmail: launchEmail,
    shareSink: shareSink,
    screenAwake: screenAwake,
    storeReviewer: storeReviewer,
  );
  if (brand != MarkerBrand.ohuhuOahu) {
    await scope.settings.setBrand(brand);
  }
  if (ownedMarkerCodes != null) {
    await scope.settings.setOwnedMarkerCodes(ownedMarkerCodes);
  }
  if (setup != null) await setup(scope);

  await tester.pumpWidget(scope);
  await tester.pumpAndSettle();
  return scope;
}

/// Types [code] into the base-code field and dismisses the autocomplete.
Future<void> enterBaseCode(WidgetTester tester, String code) async {
  await tester.enterText(
    find.byKey(const ValueKey<String>('palette-base-input')),
    code,
  );
  await tester.pumpAndSettle();
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpAndSettle();
}

/// A synthetic catalog colour, for draft and saved-palette fixtures.
MarkerColor markerColor(String code, String hex) => MarkerColor(
  brandId: MarkerBrand.ohuhuOahu.id,
  newCode: code,
  newName: 'Name $code',
  oldCode: code,
  oldName: 'Name $code',
  hex: hex,
  sets: const <String>['classic_160'],
);

/// Opens the palette type sheet from the type field.
Future<void> openPaletteTypeSheet(WidgetTester tester) async {
  await tester.ensureVisible(
    find.byKey(const ValueKey<String>('palette-type-field')),
  );
  await tester.tap(find.byKey(const ValueKey<String>('palette-type-field')));
  await tester.pumpAndSettle();
}

/// Picks the type row with [rowKey] (palette-mode-NAME or
/// palette-scenario-toggle) in the type sheet; the sheet closes.
Future<void> choosePaletteType(WidgetTester tester, String rowKey) async {
  await openPaletteTypeSheet(tester);
  final Finder row = find.byKey(ValueKey<String>(rowKey));
  await tester.ensureVisible(row);
  await tester.pumpAndSettle();
  await tester.tap(row);
  await tester.pumpAndSettle();
}

/// Opens the scene sheet from the scene field (Scenes must be the type).
Future<void> openPaletteSceneSheet(WidgetTester tester) async {
  await tester.ensureVisible(
    find.byKey(const ValueKey<String>('palette-scene-field')),
  );
  await tester.tap(find.byKey(const ValueKey<String>('palette-scene-field')));
  await tester.pumpAndSettle();
}

/// Opens the saved-palettes sheet from the page header action.
Future<void> openSavedPalettesSheet(WidgetTester tester) async {
  await tester.tap(
    find.byKey(const ValueKey<String>('palette-saved-palettes')),
  );
  await tester.pumpAndSettle();
}

/// Closes the top sheet or dialog.
Future<void> closeSheet(WidgetTester tester) async {
  tester.state<NavigatorState>(find.byType(Navigator).first).pop();
  await tester.pumpAndSettle();
}

/// Opens the overflow menu [menuKey] and taps its item [itemKey]. The entries
/// of an [InkOverflowMenu] only exist while the menu is open, so a test must
/// open it first. Use `settle: false` for an action that starts real async
/// work (a share), where the caller drives the clock itself.
Future<void> tapOverflowItem(
  WidgetTester tester,
  String menuKey,
  String itemKey, {
  bool settle = true,
}) async {
  await tester.tap(find.byKey(ValueKey<String>(menuKey)));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(ValueKey<String>(itemKey)));
  if (settle) {
    await tester.pumpAndSettle();
  } else {
    await tester.pump();
  }
}

/// Opens the result's "⋯" menu and taps the item [itemKey].
Future<void> tapResultItem(
  WidgetTester tester,
  String itemKey, {
  bool settle = true,
}) => tapOverflowItem(
  tester,
  'palette-overflow',
  itemKey,
  settle: settle,
);

/// The codes of the suggestion rows, in the order they are on screen.
List<String> rowCodes(WidgetTester tester) => tester
    .widgetList<PaletteSuggestionRow>(find.byType(PaletteSuggestionRow))
    .map((PaletteSuggestionRow row) => row.suggestion.color.newCode)
    .toList();

/// Taps the lock (or unlock) button of the row of [code].
Future<void> toggleRowLock(WidgetTester tester, String code) async {
  final Finder row = find.byKey(ValueKey<String>('palette-row-$code'));
  final Finder lock = find.descendant(
    of: row,
    matching: find.byTooltip(l10n.paletteLockButton),
  );
  final Finder button = lock.evaluate().isNotEmpty
      ? lock
      : find.descendant(
          of: row,
          matching: find.byTooltip(l10n.paletteUnlockButton),
        );
  await tester.ensureVisible(button.first);
  await tester.tap(button.first);
  await tester.pumpAndSettle();
}
