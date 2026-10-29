import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/ui/pages/match/color_sampling.dart';
import 'package:ink_lab/ui/pages/match/image_picker_service.dart';
import 'package:ink_lab/ui/pages/match/match_page.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';

import '../../support/l10n.dart';

/// A real 8x8 PNG: the left half is pure red, the right half pure blue.
///
/// Embedded so the page's `Image.memory` and the decoder test work without
/// touching the file system or the network.
final Uint8List tinyPng = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAIAAABLbSncAAAAFElEQVR4nGP4z8AAR0jM/wxD'
  'SwIA6TA/wRjsoYgAAAAASUVORK5CYII=',
);

/// A [SampledImage] of [width]x[height] filled with one RGB colour.
SampledImage sampledImage(int width, int height, List<int> rgb) =>
    imageFromRgb(width, height, List<List<int>>.filled(width * height, rgb));

/// A [SampledImage] from one RGB triple per pixel, in row-major order.
SampledImage imageFromRgb(int width, int height, List<List<int>> pixels) {
  assert(pixels.length == width * height);
  final Uint8List rgba = Uint8List(width * height * 4);
  for (var i = 0; i < pixels.length; i++) {
    rgba[i * 4] = pixels[i][0];
    rgba[i * 4 + 1] = pixels[i][1];
    rgba[i * 4 + 2] = pixels[i][2];
    rgba[i * 4 + 3] = 255;
  }
  return SampledImage(width: width, height: height, rgba: rgba);
}

/// A picker that always returns the same [result] and records its calls.
final class FakeImagePickerService implements ImagePickerService {
  FakeImagePickerService(this.result);

  /// What the next [pick] returns.
  PhotoPickResult result;

  /// The sources it has been asked for, in order.
  final List<PhotoSource> calls = <PhotoSource>[];

  @override
  Future<PhotoPickResult> pick(PhotoSource source) async {
    calls.add(source);
    return result;
  }
}

/// A decoder that ignores its input and returns [image].
PhotoDecoder fixedDecoder(SampledImage image) =>
    (Uint8List bytes) async => image;

/// A marker repository that reads the real asset JSON from disk.
///
/// The loader is synchronous on purpose: the load future then completes on a
/// microtask, so widget tests settle without `tester.runAsync`.
MarkerRepository diskMarkerRepository() =>
    MarkerRepository(loadAsset: (String path) => File(path).readAsStringSync());

/// The match page inside an in-memory scope and a minimal Material app.
AppScope matchScope({
  required ImagePickerService picker,
  required PhotoDecoder decoder,
}) => AppScope.inMemory(
  markers: diskMarkerRepository(),
  child: MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: testLocalizationsDelegates,
    supportedLocales: testSupportedLocales,
    theme: AppTheme.light(),
    darkTheme: AppTheme.dark(),
    home: Scaffold(
      body: MatchPage(picker: picker, decoder: decoder),
    ),
  ),
);

/// Pumps the match page inside a fresh in-memory scope.
///
/// [image] is what the injected decoder returns; [decoder] overrides it for
/// error cases. [brand] and [ownedMarkerCodes] configure the scope before the
/// widget tree is built.
Future<AppScope> pumpMatch(
  WidgetTester tester, {
  required ImagePickerService picker,
  required SampledImage image,
  PhotoDecoder? decoder,
  MarkerBrand brand = MarkerBrand.ohuhuOahu,
  Set<String>? ownedMarkerCodes,
}) async {
  tester.view.physicalSize = const Size(600, 3200);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  final AppScope scope = matchScope(
    picker: picker,
    decoder: decoder ?? fixedDecoder(image),
  );
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
