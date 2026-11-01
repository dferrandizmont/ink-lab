import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/pages/ideas/ideas_page.dart';
import 'package:ink_lab/ui/pages/match/image_picker_service.dart';
import 'package:ink_lab/ui/pages/palette/palette_page.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';

import '../../support/l10n.dart';
export '../match/match_test_support.dart' show FakeImagePickerService, tinyPng;

/// A marker repository that reads the real asset JSON from disk.
MarkerRepository diskMarkerRepository() =>
    MarkerRepository(loadAsset: (String path) => File(path).readAsStringSync());

/// A diary over in-memory stores; the photo store is exposed so a test can
/// see which files exist.
({StoredArtworkDiaryRepository diary, InMemoryArtworkPhotoStore photos})
newDiary() {
  final InMemoryArtworkPhotoStore photos = InMemoryArtworkPhotoStore();
  return (
    diary: StoredArtworkDiaryRepository(
      InMemoryKeyValueStore(),
      photos: photos,
    ),
    photos: photos,
  );
}

/// A diary entry with sensible defaults.
ArtworkEntry entry({
  String id = 'e1',
  String title = 'Forest page',
  DateTime? date,
  String onWhat = '',
  ArtworkStatus status = ArtworkStatus.finished,
  List<String> markerIds = const <String>[],
  String? paletteId,
  String notes = '',
  List<String> photos = const <String>[],
  int createdAtEpochMs = 1000,
}) => ArtworkEntry(
  id: id,
  title: title,
  date: date ?? DateTime(2026, 10, 30),
  onWhat: onWhat,
  status: status,
  markerIds: markerIds,
  paletteId: paletteId,
  notes: notes,
  photos: photos,
  createdAtEpochMs: createdAtEpochMs,
);

/// A saved palette with sensible defaults.
SavedPalette savedPalette({
  String id = 'p1',
  String name = 'Sunrise',
  List<String> codes = const <String>['B08', 'R101'],
  String brandId = 'ohuhu_oahu',
}) => SavedPalette(
  id: id,
  brandId: brandId,
  name: name,
  baseCode: codes.first,
  baseName: 'Base',
  mode: PaletteMode.triad,
  paletteSize: codes.length.clamp(3, 5),
  createdAtEpochMs: 1,
  colorCodes: codes,
);

/// Pumps [page] inside an in-memory scope and a Material app.
Future<AppScope> pumpDiaryPage(
  WidgetTester tester,
  Widget page, {
  StoredArtworkDiaryRepository? diary,
  Size size = const Size(800, 4000),
  Future<void> Function(AppScope scope)? setup,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  final AppScope scope = AppScope.inMemory(
    markers: diskMarkerRepository(),
    artworkDiary: diary,
    child: MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: Scaffold(body: page),
    ),
  );
  await setup?.call(scope);
  await tester.pumpWidget(scope);
  await tester.pumpAndSettle();
  return scope;
}

/// The Ideas page opened on its Diary segment.
Future<AppScope> pumpDiary(
  WidgetTester tester, {
  ImagePickerService? picker,
  StoredArtworkDiaryRepository? diary,
  Future<void> Function(AppScope scope)? setup,
}) async {
  final AppScope scope = await pumpDiaryPage(
    tester,
    IdeasPage(today: DateTime(2026, 10, 29), picker: picker),
    diary: diary,
    setup: setup,
  );
  await tester.tap(find.text(l10n.ideasDiarySegment));
  await tester.pumpAndSettle();
  return scope;
}

/// The palette page with a saved palette on the list.
Future<AppScope> pumpPaletteWithSaved(
  WidgetTester tester,
  SavedPalette palette, {
  ImagePickerService? picker,
}) => pumpDiaryPage(
  tester,
  PalettePage(picker: picker),
  setup: (AppScope scope) => scope.savedPalettes.save(palette),
);

Finder key(String value) => find.byKey(ValueKey<String>(value));
