import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ai/ai.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/pages/palette/palette_page.dart';
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
}) => AppScope.inMemory(
  markers: diskMarkerRepository(),
  secrets: secrets,
  aiSettings: aiSettings,
  aiService: aiService,
  child: MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: testLocalizationsDelegates,
    supportedLocales: testSupportedLocales,
    theme: AppTheme.light(),
    darkTheme: AppTheme.dark(),
    home: Scaffold(body: PalettePage(launchEmail: launchEmail)),
  ),
);

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
}) async {
  tester.view.physicalSize = const Size(600, 3000);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  final AppScope scope = paletteScope(
    secrets: secrets,
    aiSettings: aiSettings,
    aiService: aiService,
    launchEmail: launchEmail,
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
