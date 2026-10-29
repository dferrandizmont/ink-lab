import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/ui/pages/ideas/ideas_page.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';

import '../../support/l10n.dart';

/// A marker repository that reads the real asset JSON from disk.
///
/// The loader is synchronous on purpose: the load future then completes on a
/// microtask, so widget tests settle without `tester.runAsync`.
MarkerRepository diskMarkerRepository() =>
    MarkerRepository(loadAsset: (String path) => File(path).readAsStringSync());

/// The ideas page inside an in-memory scope and a minimal Material app.
AppScope ideasScope() => AppScope.inMemory(
  markers: diskMarkerRepository(),
  child: MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: testLocalizationsDelegates,
    supportedLocales: testSupportedLocales,
    theme: AppTheme.light(),
    darkTheme: AppTheme.dark(),
    home: const Scaffold(body: IdeasPage()),
  ),
);

/// Pumps the ideas page inside a fresh in-memory scope.
Future<AppScope> pumpIdeas(
  WidgetTester tester, {
  MarkerBrand brand = MarkerBrand.ohuhuOahu,
  Set<String>? ownedMarkerCodes,
}) async {
  tester.view.physicalSize = const Size(800, 4000);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  final AppScope scope = ideasScope();
  if (brand != MarkerBrand.ohuhuOahu) {
    await scope.settings.setBrand(brand);
  }
  if (ownedMarkerCodes != null) {
    await scope.settings.setOwnedMarkerCodes(ownedMarkerCodes);
  }

  await tester.pumpWidget(scope);
  await tester.pumpAndSettle();
  return scope;
}
