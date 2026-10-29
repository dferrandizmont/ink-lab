import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ink_lab/ai/ai.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/core/palette_generator.dart';
import 'package:ink_lab/core/photo_palette.dart';
import 'package:ink_lab/ui/pages/match/color_sampling.dart';
import 'package:ink_lab/ui/pages/match/image_picker_service.dart';
import 'package:ink_lab/ui/pages/palette/palette_page.dart';
import 'package:ink_lab/ui/pages/palette/palette_photo_scene.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/widgets/ink_segmented.dart';
import 'package:ink_lab/ui/widgets/section_card.dart';
import 'package:ink_lab/ui/widgets/palette_strip.dart';

import '../../ai/ai_test_support.dart';
import '../../support/l10n.dart';
import '../match/match_test_support.dart' hide diskMarkerRepository;
import 'palette_test_support.dart';

Finder _key(String key) => find.byKey(ValueKey<String>(key));

/// Five colour bands side by side, widest first: red 30 %, then green, blue
/// and yellow at 20 % and purple at 10 %. Each is the exact colour of a
/// catalogue marker, so every band has a marker with no difference at all.
const List<List<int>> _bandColours = <List<int>>[
  <int>[0xdf, 0x3e, 0x35], // R014
  <int>[0x13, 0x90, 0x4d], // G312
  <int>[0x26, 0x4f, 0xb3], // BV310
  <int>[0xf3, 0xcf, 0x48], // Y19
  <int>[0x87, 0x48, 0x7d], // RV315
];
const List<int> _bandColumns = <int>[3, 2, 2, 2, 1];

SampledImage _bandsImage() {
  final List<List<int>> row = <List<int>>[
    for (var band = 0; band < _bandColours.length; band++)
      for (var i = 0; i < _bandColumns[band]; i++) _bandColours[band],
  ];
  return imageFromRgb(10, 10, <List<int>>[for (var y = 0; y < 10; y++) ...row]);
}

/// The closest catalogue markers to the five bands (see the catalogue).
const List<String> _bandMarkers = <String>[
  'R014',
  'G312',
  'BV310',
  'Y19',
  'RV315',
];

/// The real extractor, run in place (a test needs no isolate).
Future<Map<int, List<PhotoColor>>> _extractNow(SampledImage image) async =>
    extractPhotoColorSets(image.rgba, image.width, image.height);

Future<Map<int, List<PhotoColor>>> _extractNothing(SampledImage image) async =>
    const <int, List<PhotoColor>>{};

/// The same five bands, widest first the other way round: purple leads.
SampledImage _otherImage() {
  final List<List<int>> row = <List<int>>[
    for (var band = _bandColours.length - 1; band >= 0; band--)
      for (var i = 0; i < _bandColumns[_bandColumns.length - 1 - band]; i++)
        _bandColours[band],
  ];
  return imageFromRgb(10, 10, <List<int>>[for (var y = 0; y < 10; y++) ...row]);
}

Future<AppScope> _pumpPhotoPalette(
  WidgetTester tester, {
  required ImagePickerService picker,
  PhotoColorExtractor extractor = _extractNow,
  PhotoDecoder? decoder,
  Set<String> owned = const <String>{
    'R014',
    'G312',
    'BV310',
    'Y19',
    'RV315',
    'B08',
  },
  Locale locale = const Locale('en'),
  AiService? aiService,
  SecretStore? secrets,
  AiSettingsRepository? aiSettings,
}) async {
  tester.view.physicalSize = const Size(600, 3000);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  final AppScope scope = AppScope.inMemory(
    markers: diskMarkerRepository(),
    secrets: secrets,
    aiSettings: aiSettings,
    aiService: aiService,
    child: MaterialApp(
      locale: locale,
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: Scaffold(
        body: PalettePage(
          picker: picker,
          decoder: decoder ?? fixedDecoder(_bandsImage()),
          photoExtractor: extractor,
        ),
      ),
    ),
  );
  // Only these markers: the default collection (a whole set) would be too
  // many to tell which one the photo picked.
  await scope.settings.setCollection(
    AppSettings(ownedSetIds: const <String>{}, extraMarkerIds: owned),
  );
  await tester.pumpWidget(scope);
  await tester.pumpAndSettle();
  return scope;
}

/// Scenes > From a photo > [source].
Future<void> _fromPhoto(
  WidgetTester tester, {
  String source = 'palette-photo-camera',
}) async {
  await choosePaletteType(tester, 'palette-scenario-toggle');
  await openPaletteSceneSheet(tester);
  await tester.tap(_key('palette-scene-photo'));
  await tester.pumpAndSettle();
  await tester.tap(_key(source));
  await tester.pumpAndSettle();
}

/// The marker codes of the result strip, base first.
List<String> _stripCodes(WidgetTester tester) =>
    tester.widget<PaletteStrip>(find.byType(PaletteStrip).first).labels!;

/// The text of the role line of the row of [code].
String _roleOf(WidgetTester tester, String code) => tester
    .widget<Text>(
      find.descendant(
        of: _key('palette-row-role-$code'),
        matching: find.byType(Text),
      ),
    )
    .data!;

FakeImagePickerService _picks() => FakeImagePickerService(PhotoPicked(tinyPng));

void main() {
  group('the scene sheet entry', () {
    testWidgets('is the first row, above the categories', (
      WidgetTester tester,
    ) async {
      await _pumpPhotoPalette(tester, picker: _picks());
      await choosePaletteType(tester, 'palette-scenario-toggle');
      await openPaletteSceneSheet(tester);

      expect(_key('palette-scene-photo'), findsOneWidget);
      expect(find.text(l10n.paletteFromPhotoTitle), findsOneWidget);
      expect(find.text(l10n.paletteFromPhotoHint), findsOneWidget);
      final double photoTop = tester.getTopLeft(_key('palette-scene-photo')).dy;
      final double firstCategory = tester
          .getTopLeft(find.byType(InkGroupHead).first)
          .dy;
      expect(photoTop, lessThan(firstCategory));
    });

    testWidgets('hides while searching, unless the query is photo or foto', (
      WidgetTester tester,
    ) async {
      await _pumpPhotoPalette(tester, picker: _picks());
      await choosePaletteType(tester, 'palette-scenario-toggle');
      await openPaletteSceneSheet(tester);

      Future<void> search(String text) async {
        await tester.enterText(_key('palette-scene-search'), text);
        await tester.pumpAndSettle();
      }

      await search('piel');
      expect(_key('palette-scene-photo'), findsNothing);
      await search('Photo');
      expect(_key('palette-scene-photo'), findsOneWidget);
      await search('foto');
      expect(_key('palette-scene-photo'), findsOneWidget);
      await search('');
      expect(_key('palette-scene-photo'), findsOneWidget);
    });

    testWidgets('asks for the source: camera or gallery', (
      WidgetTester tester,
    ) async {
      final FakeImagePickerService picker = _picks();
      await _pumpPhotoPalette(tester, picker: picker);
      await choosePaletteType(tester, 'palette-scenario-toggle');
      await openPaletteSceneSheet(tester);
      await tester.tap(_key('palette-scene-photo'));
      await tester.pumpAndSettle();

      expect(_key('palette-photo-source-sheet'), findsOneWidget);
      expect(_key('palette-photo-camera'), findsOneWidget);
      expect(_key('palette-photo-gallery'), findsOneWidget);
      await tester.tap(_key('palette-photo-gallery'));
      await tester.pumpAndSettle();
      expect(picker.calls, <PhotoSource>[PhotoSource.gallery]);
    });

    testWidgets('closing the source sheet changes nothing', (
      WidgetTester tester,
    ) async {
      final FakeImagePickerService picker = _picks();
      await _pumpPhotoPalette(tester, picker: picker);
      await choosePaletteType(tester, 'palette-scenario-toggle');
      await openPaletteSceneSheet(tester);
      await tester.tap(_key('palette-scene-photo'));
      await tester.pumpAndSettle();
      Navigator.of(tester.element(_key('palette-photo-source-sheet'))).pop();
      await tester.pumpAndSettle();

      expect(picker.calls, isEmpty);
      expect(_key('palette-photo-thumb'), findsNothing);
      expect(
        tester.widget<Text>(_key('palette-scene-value')).data,
        isNot(l10n.paletteFromPhotoValue),
      );
    });
  });

  group('a palette from a photo', () {
    testWidgets('shows the nearest owned markers, share by share', (
      WidgetTester tester,
    ) async {
      final FakeImagePickerService picker = _picks();
      await _pumpPhotoPalette(tester, picker: picker);
      await _fromPhoto(tester);

      expect(picker.calls, <PhotoSource>[PhotoSource.camera]);
      // The field names the photo and shows its thumbnail and real colours.
      expect(
        tester.widget<Text>(_key('palette-scene-value')).data,
        l10n.paletteFromPhotoValue,
      );
      expect(_key('palette-photo-thumb'), findsOneWidget);
      expect(_key('palette-photo-strip'), findsOneWidget);
      // The red band is the biggest: the base is the marker closest to it.
      final List<String> codes = _stripCodes(tester);
      expect(codes, hasLength(5));
      expect(codes.first, 'R014');
      expect(codes.toSet(), hasLength(5));
      expect(codes, containsAll(_bandMarkers));
      // Rows are the companions: role line with the share, then the name.
      expect(_roleOf(tester, 'G312').toUpperCase(), contains('PHOTO COLOUR'));
      expect(_roleOf(tester, 'G312'), contains('20 %'));
      // The second line is the marker's name, not a reason.
      expect(
        tester
            .widget<Text>(
              find.descendant(
                of: _key('palette-row-why-G312'),
                matching: find.byType(Text),
              ),
            )
            .data,
        isNot(_roleOf(tester, 'G312')),
      );
      // The base is the photo's: no base field; nothing to lock, vary or
      // regenerate; and no note while every colour has a close marker.
      expect(_key('palette-base-input'), findsNothing);
      expect(_key('palette-regenerate'), findsNothing);
      expect(_key('palette-generate'), findsNothing);
      expect(_key('palette-suggest-ai'), findsNothing);
      expect(find.text(l10n.paletteLockButton), findsNothing);
      expect(find.byTooltip(l10n.paletteLockButton), findsNothing);
      expect(
        find.text(l10n.variationName(QuickPaletteVariation.values.first)),
        findsNothing,
      );
      expect(_key('palette-photo-far-note'), findsNothing);
      // The paint order keeps the same order.
      expect(_key('palette-step-zone-1'), findsOneWidget);
      expect(_key('palette-save'), findsOneWidget);
      expect(_key('palette-clear'), findsOneWidget);
    });

    testWidgets('every size is found at once; a new size only picks a list', (
      WidgetTester tester,
    ) async {
      int extractions = 0;
      int decodes = 0;
      await _pumpPhotoPalette(
        tester,
        picker: _picks(),
        decoder: (_) async {
          decodes++;
          return _bandsImage();
        },
        extractor: (SampledImage image) {
          extractions++;
          return _extractNow(image);
        },
      );
      await _fromPhoto(tester);
      expect(_stripCodes(tester), hasLength(5));

      Finder size(String value) => find.descendant(
        of: find.byType(InkSegmented<int>),
        matching: find.text(value),
      );
      await tester.tap(size('3'));
      await tester.pump();
      // No spinner, no waiting: the lists were cached when the photo was read.
      expect(_key('palette-photo-busy'), findsNothing);
      expect(_stripCodes(tester), hasLength(3));
      expect(_stripCodes(tester).first, 'R014');
      await tester.tap(size('4'));
      await tester.pump();
      expect(_stripCodes(tester), hasLength(4));
      expect(_stripCodes(tester), everyElement(isIn(_bandMarkers)));
      await tester.tap(size('5'));
      await tester.pump();
      expect(_stripCodes(tester), hasLength(5));
      expect(extractions, 1);
      expect(decodes, 1);
    });

    testWidgets('a small vivid accent survives a short palette', (
      WidgetTester tester,
    ) async {
      // A sunset: four sky shades (60 %), a dark green ground (35 %) and a
      // saturated blue house (5 %). Each has a marker with no difference.
      const List<List<int>> sky = <List<int>>[
        <int>[0xf8, 0xad, 0x66], // YR19
        <int>[0xf4, 0x7c, 0x60], // YR513
        <int>[0xe5, 0x72, 0x7e], // R111
        <int>[0xbd, 0x6e, 0x9c], // RV210
      ];
      const List<int> ground = <int>[0x00, 0x4b, 0x26]; // G315
      const List<int> house = <int>[0x26, 0x4f, 0xb3]; // BV310
      final List<List<int>> rows = <List<int>>[
        for (final List<int> shade in sky)
          for (var i = 0; i < 3; i++) shade,
        for (var i = 0; i < 7; i++) ground,
        house,
      ];
      final SampledImage sunset = imageFromRgb(20, 20, <List<int>>[
        for (final List<int> row in rows)
          for (var x = 0; x < 20; x++) row,
      ]);
      await _pumpPhotoPalette(
        tester,
        picker: _picks(),
        decoder: fixedDecoder(sunset),
        owned: const <String>{
          'YR19',
          'YR513',
          'R111',
          'RV210',
          'G315',
          'BV310',
        },
      );
      await _fromPhoto(tester);

      Finder size(String value) => find.descendant(
        of: find.byType(InkSegmented<int>),
        matching: find.text(value),
      );
      // The ground leads, and the blue house is still there at 5 and at 4.
      expect(_stripCodes(tester), hasLength(5));
      expect(_stripCodes(tester).first, 'G315');
      expect(_stripCodes(tester), contains('BV310'));
      await tester.tap(size('4'));
      await tester.pumpAndSettle();
      expect(_stripCodes(tester), hasLength(4));
      expect(_stripCodes(tester), contains('BV310'));
    });

    testWidgets('another type, a scene or Clear leaves the photo', (
      WidgetTester tester,
    ) async {
      await _pumpPhotoPalette(tester, picker: _picks());

      await _fromPhoto(tester);
      await choosePaletteType(tester, 'palette-mode-complementary');
      expect(_key('palette-photo-thumb'), findsNothing);
      expect(_key('palette-scene-field'), findsNothing);
      expect(_key('palette-base-input'), findsOneWidget);

      await _fromPhoto(tester);
      expect(_key('palette-photo-thumb'), findsOneWidget);
      await openPaletteSceneSheet(tester);
      await tester.tap(_key('palette-scene-ghostCharacter'));
      await tester.pumpAndSettle();
      expect(_key('palette-photo-thumb'), findsNothing);
      expect(_key('palette-scene-field'), findsOneWidget);
      expect(
        tester.widget<Text>(_key('palette-scene-value')).data,
        isNot(l10n.paletteFromPhotoValue),
      );

      await _fromPhoto(tester);
      await tester.ensureVisible(_key('palette-clear'));
      await tester.tap(_key('palette-clear'));
      await tester.pumpAndSettle();
      expect(_key('palette-photo-thumb'), findsNothing);
      expect(_key('palette-save'), findsNothing);
    });

    testWidgets('picking a photo again replaces the first one', (
      WidgetTester tester,
    ) async {
      final FakeImagePickerService picker = _picks();
      int reads = 0;
      await _pumpPhotoPalette(
        tester,
        picker: picker,
        decoder: (_) async => reads++ == 0 ? _bandsImage() : _otherImage(),
      );
      await _fromPhoto(tester);
      final List<String> first = _stripCodes(tester);
      final ImageProvider firstThumb = tester
          .widget<PhotoThumb>(_key('palette-photo-thumb'))
          .image;
      expect(first.first, 'R014');

      // The scene sheet shows the photo entry as the current choice.
      await openPaletteSceneSheet(tester);
      await tester.tap(_key('palette-scene-photo'));
      await tester.pumpAndSettle();
      await tester.tap(_key('palette-photo-gallery'));
      await tester.pumpAndSettle();

      expect(picker.calls, <PhotoSource>[
        PhotoSource.camera,
        PhotoSource.gallery,
      ]);
      // The second image has purple as its widest band: the result changed.
      final List<String> second = _stripCodes(tester);
      expect(second.first, 'RV315');
      expect(second, isNot(first));
      expect(second, hasLength(5));
      expect(_key('palette-photo-thumb'), findsOneWidget);
      expect(
        identical(
          tester.widget<PhotoThumb>(_key('palette-photo-thumb')).image,
          firstThumb,
        ),
        isFalse,
      );
    });

    testWidgets('saves as From a photo and the saved row says so', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await _pumpPhotoPalette(tester, picker: _picks());
      await _fromPhoto(tester);
      final List<String> codes = _stripCodes(tester);

      await tester.ensureVisible(_key('palette-save'));
      await tester.tap(_key('palette-save'));
      await tester.pumpAndSettle();
      // The default name is the base and the kind.
      expect(
        find.widgetWithText(TextField, 'R014 ${l10n.paletteFromPhotoTitle}'),
        findsOneWidget,
      );
      await tester.tap(_key('palette-save-confirm'));
      await tester.pumpAndSettle();

      final List<SavedPalette> saved = scope.savedPalettes.palettesOf(
        MarkerBrand.ohuhuOahu,
      );
      expect(saved, hasLength(1));
      expect(saved.single.scenarioName, PhotoScene.savedName);
      expect(saved.single.baseCode, 'R014');
      expect(saved.single.colorCodes, codes);

      final Finder subtitle = find.descendant(
        of: _key('palette-saved-subtitle-${saved.single.id}'),
        matching: find.byType(Text),
      );
      await tester.ensureVisible(subtitle);
      expect(
        tester.widget<Text>(subtitle).data,
        contains(l10n.paletteFromPhotoTitle),
      );

      // Loading it works like any saved palette: the photo is not kept.
      await tester.ensureVisible(_key('palette-load-${saved.single.id}'));
      await tester.tap(_key('palette-load-${saved.single.id}'));
      await tester.pumpAndSettle();
      expect(_key('palette-photo-thumb'), findsNothing);
      // The result on screen (not the saved row's strip) is the saved one,
      // every colour of it.
      expect(find.textContaining('Combinations ('), findsOneWidget);
      expect(_stripCodes(tester), codes);
      for (final String code in codes.skip(1)) {
        expect(_key('palette-row-$code'), findsOneWidget);
      }
    });

    testWidgets('notes that a photo colour has no close marker', (
      WidgetTester tester,
    ) async {
      await _pumpPhotoPalette(
        tester,
        picker: _picks(),
        // Nothing close to the blue, green, yellow or purple bands.
        owned: const <String>{'R014', '0', 'B08'},
      );
      await _fromPhoto(tester);

      expect(_key('palette-photo-far-note'), findsOneWidget);
      expect(find.text(l10n.paletteFromPhotoFarNote), findsOneWidget);
    });
  });

  group('when the photo cannot be used', () {
    testWidgets('a refused camera shows the Match message', (
      WidgetTester tester,
    ) async {
      await _pumpPhotoPalette(
        tester,
        picker: FakeImagePickerService(
          const PhotoPickDenied(PhotoSource.camera),
        ),
      );
      await _fromPhoto(tester);

      expect(find.text(l10n.matchCameraDenied), findsOneWidget);
      expect(_key('palette-photo-thumb'), findsNothing);
      expect(_key('palette-photo-busy'), findsNothing);
    });

    testWidgets('a refused gallery and a failed picker too', (
      WidgetTester tester,
    ) async {
      final FakeImagePickerService picker = FakeImagePickerService(
        const PhotoPickDenied(PhotoSource.gallery),
      );
      await _pumpPhotoPalette(tester, picker: picker);
      await _fromPhoto(tester, source: 'palette-photo-gallery');
      expect(find.text(l10n.matchGalleryDenied), findsOneWidget);

      picker.result = const PhotoPickFailed('boom');
      await openPaletteSceneSheet(tester);
      await tester.tap(_key('palette-scene-photo'));
      await tester.pumpAndSettle();
      await tester.tap(_key('palette-photo-gallery'));
      await tester.pumpAndSettle();
      expect(find.text(l10n.matchGalleryDenied), findsNothing);
      expect(find.text(l10n.matchPickFailed), findsOneWidget);
    });

    testWidgets('cancelling the picker changes nothing', (
      WidgetTester tester,
    ) async {
      await _pumpPhotoPalette(
        tester,
        picker: FakeImagePickerService(const PhotoPickCancelled()),
      );
      await _fromPhoto(tester);

      expect(_key('palette-photo-thumb'), findsNothing);
      expect(_key('palette-photo-busy'), findsNothing);
      expect(find.text(l10n.paletteFromPhotoEmpty), findsNothing);
      expect(find.text(l10n.matchCameraDenied), findsNothing);
    });

    testWidgets('a photo that cannot be decoded shows the Match message', (
      WidgetTester tester,
    ) async {
      await _pumpPhotoPalette(
        tester,
        picker: _picks(),
        decoder: (_) async => throw const PhotoDecodeException('nope'),
      );
      await _fromPhoto(tester);

      expect(find.text(l10n.matchDecodeFailed), findsOneWidget);
      expect(_key('palette-photo-thumb'), findsNothing);
    });

    testWidgets('a photo without colours says so', (WidgetTester tester) async {
      await _pumpPhotoPalette(
        tester,
        picker: _picks(),
        extractor: _extractNothing,
      );
      await _fromPhoto(tester);

      expect(find.text(l10n.paletteFromPhotoEmpty), findsOneWidget);
      expect(_key('palette-photo-thumb'), findsNothing);
    });

    testWidgets('one owned marker is not enough for a palette', (
      WidgetTester tester,
    ) async {
      await _pumpPhotoPalette(
        tester,
        picker: _picks(),
        owned: const <String>{'R014'},
      );
      await _fromPhoto(tester);

      expect(find.text(l10n.paletteFromPhotoEmpty), findsOneWidget);
      expect(_key('palette-photo-thumb'), findsNothing);
      expect(
        tester.widget<Text>(_key('palette-scene-value')).data,
        isNot(l10n.paletteFromPhotoValue),
      );
    });

    testWidgets('a failed photo keeps the palette that was on screen', (
      WidgetTester tester,
    ) async {
      final FakeImagePickerService picker = _picks();
      await _pumpPhotoPalette(tester, picker: picker);
      await _fromPhoto(tester);
      final List<String> before = _stripCodes(tester);

      picker.result = const PhotoPickDenied(PhotoSource.camera);
      await openPaletteSceneSheet(tester);
      await tester.tap(_key('palette-scene-photo'));
      await tester.pumpAndSettle();
      await tester.tap(_key('palette-photo-camera'));
      await tester.pumpAndSettle();

      expect(find.text(l10n.matchCameraDenied), findsOneWidget);
      expect(_stripCodes(tester), before);
      expect(_key('palette-photo-thumb'), findsOneWidget);
    });
  });

  group('while the photo is still being read', () {
    /// Lets sheets and animations run without waiting for a spinner to stop.
    Future<void> pumpFor(WidgetTester tester) async {
      for (var i = 0; i < 8; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
    }

    /// Scenes > From a photo > camera, leaving the photo unread.
    Future<void> startPhoto(WidgetTester tester) async {
      await choosePaletteType(tester, 'palette-scenario-toggle');
      await tester.ensureVisible(_key('palette-scene-field'));
      await tester.tap(_key('palette-scene-field'));
      await pumpFor(tester);
      await tester.tap(_key('palette-scene-photo'));
      await pumpFor(tester);
      await tester.tap(_key('palette-photo-camera'));
      await pumpFor(tester);
    }

    testWidgets('Clear during the read: the late photo is ignored', (
      WidgetTester tester,
    ) async {
      final Completer<SampledImage> decoding = Completer<SampledImage>();
      await _pumpPhotoPalette(
        tester,
        picker: _picks(),
        decoder: (_) => decoding.future,
      );
      await startPhoto(tester);
      expect(_key('palette-photo-busy'), findsOneWidget);

      await tester.ensureVisible(_key('palette-clear'));
      await tester.tap(_key('palette-clear'));
      await pumpFor(tester);
      // Clear ended the read: no spinner left.
      expect(_key('palette-photo-busy'), findsNothing);

      decoding.complete(_bandsImage());
      await tester.pumpAndSettle();
      expect(_key('palette-photo-thumb'), findsNothing);
      expect(_key('palette-photo-busy'), findsNothing);
      expect(_key('palette-save'), findsNothing);
      expect(find.text(l10n.paletteFromPhotoEmpty), findsNothing);
    });

    testWidgets('another type during the read: the late photo is ignored', (
      WidgetTester tester,
    ) async {
      final Completer<Map<int, List<PhotoColor>>> extracting =
          Completer<Map<int, List<PhotoColor>>>();
      await _pumpPhotoPalette(
        tester,
        picker: _picks(),
        extractor: (_) => extracting.future,
      );
      await startPhoto(tester);
      expect(_key('palette-photo-busy'), findsOneWidget);

      await tester.ensureVisible(_key('palette-type-field'));
      await tester.tap(_key('palette-type-field'));
      await pumpFor(tester);
      await tester.tap(_key('palette-mode-complementary'));
      await pumpFor(tester);
      expect(_key('palette-photo-busy'), findsNothing);

      extracting.complete(
        extractPhotoColorSets(
          _bandsImage().rgba,
          _bandsImage().width,
          _bandsImage().height,
        ),
      );
      await tester.pumpAndSettle();
      expect(_key('palette-photo-thumb'), findsNothing);
      expect(_key('palette-scene-field'), findsNothing);
      expect(
        tester.widget<Text>(_key('palette-type-value')).data,
        l10n.modeLabel(PaletteMode.complementary),
      );
    });

    testWidgets('an AI answer arriving after the photo does not replace it', (
      WidgetTester tester,
    ) async {
      final Completer<void> gate = Completer<void>();
      int requests = 0;
      final InMemorySecretStore secrets = InMemorySecretStore(<String, String>{
        openRouterApiKeyName: 'sk-or-v1-abcdef0123456789abcdef0123456789',
      });
      final StoredAiSettingsRepository repo = StoredAiSettingsRepository(
        InMemoryKeyValueStore(),
      );
      await repo.replace(
        AiSettings(
          enabled: true,
          provider: AiProvider.openRouter,
          textModel: 'model-a',
        ),
      );
      final AiService service = AiService(
        aiSettings: repo,
        secrets: secrets,
        clientFactory: () => MockClient((http.Request request) async {
          requests++;
          await gate.future;
          final Map<String, dynamic> body =
              jsonDecode(request.body) as Map<String, dynamic>;
          final String prompt =
              ((body['messages'] as List).last as Map)['content'] as String;
          final Iterable<String> codes = prompt
              .split('AVAILABLE_COLORS=')
              .last
              .split(',')
              .take(2)
              .map((String entry) => entry.split('#').first);
          return completionResponse(
            paletteJson(<Map<String, String>>[
              for (final String code in codes)
                <String, String>{
                  'code': code,
                  'role': 'Shadow',
                  'reason': 'deep',
                },
            ]),
          );
        }),
      );
      await _pumpPhotoPalette(
        tester,
        picker: _picks(),
        aiService: service,
        secrets: secrets,
        aiSettings: repo,
      );
      await choosePaletteType(tester, 'palette-scenario-toggle');
      await tester.ensureVisible(_key('palette-suggest-ai'));
      await tester.tap(_key('palette-suggest-ai'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(requests, 1);

      // Meanwhile the user builds the palette from a photo.
      await tester.ensureVisible(_key('palette-scene-field'));
      await tester.tap(_key('palette-scene-field'));
      await pumpFor(tester);
      await tester.tap(_key('palette-scene-photo'));
      await pumpFor(tester);
      await tester.tap(_key('palette-photo-camera'));
      await pumpFor(tester);
      expect(_key('palette-photo-thumb'), findsOneWidget);
      final List<String> photo = _stripCodes(tester);
      expect(photo.first, 'R014');

      gate.complete();
      await tester.pumpAndSettle();
      expect(_stripCodes(tester), photo);
      expect(_key('palette-ai-badge'), findsNothing);
      expect(_key('palette-ai-error'), findsNothing);
      expect(_key('palette-photo-thumb'), findsOneWidget);
    });
  });

  testWidgets('Spanish names the photo and its colours', (
    WidgetTester tester,
  ) async {
    await _pumpPhotoPalette(
      tester,
      picker: _picks(),
      locale: const Locale('es'),
    );
    await _fromPhoto(tester);

    expect(
      tester.widget<Text>(_key('palette-scene-value')).data,
      l10nEs.paletteFromPhotoValue,
    );
    expect(
      _roleOf(tester, 'G312'),
      l10nEs.paletteFromPhotoRole(20).toUpperCase(),
    );
  });
}
