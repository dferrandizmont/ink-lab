import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/color_utils.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/ui/pages/match/color_sampling.dart';
import 'package:ink_lab/ui/pages/match/image_picker_service.dart';
import 'package:ink_lab/ui/pages/match/match_example.dart';
import 'package:ink_lab/ui/pages/match/match_page.dart';
import 'package:ink_lab/ui/pages/match/match_result_tile.dart';
import 'package:ink_lab/ui/widgets/ink_button.dart';

import '../../support/l10n.dart';
import '../../support/layout_stability.dart';
import '../../support/truncation.dart';
import 'match_test_support.dart';

const ValueKey<String> _button = ValueKey<String>('match-example');
const ValueKey<String> _preview = ValueKey<String>('match-example-preview');
const ValueKey<String> _tap = ValueKey<String>('match-example-tap');
const ValueKey<String> _chip = ValueKey<String>('match-example-chip');

/// The bundled photo, read from the project like the app reads it from its
/// bundle.
Uint8List _photoBytes() => File(matchExampleAsset).readAsBytesSync();

/// The sample of [matchExamplePoint] with the radius Match uses.
int _sampleOf(SampledImage photo, {Offset? at, double? radius}) =>
    averageColorOfRegion(
      photo,
      at ?? matchExamplePoint,
      radiusFraction: radius ?? defaultSamplingRadiusFraction,
    );

/// The distances to [sample] of every candidate, nearest first, computed here
/// and not by the matcher: same colour-difference function (CIE76), written
/// out as a plain loop.
List<({MarkerColor color, double deltaE})> _distances(
  int sample,
  List<MarkerColor> candidates,
) {
  final LabColor lab = colorIntToLab(sample);
  final List<({MarkerColor color, double deltaE})> all =
      <({MarkerColor color, double deltaE})>[
        for (final MarkerColor c in candidates)
          (color: c, deltaE: deltaE76(lab, hexToLab(c.hex))),
      ];
  all.sort(
    (
      ({MarkerColor color, double deltaE}) a,
      ({MarkerColor color, double deltaE}) b,
    ) => a.deltaE.compareTo(b.deltaE),
  );
  return all;
}

/// The whole Ohuhu range, which is what Match uses with no collection.
Future<List<MarkerColor>> _ohuhuRange() async => brandRangeColors(
  colors: await diskMarkerRepository().loadColors(MarkerBrand.ohuhuOahu),
  brand: MarkerBrand.ohuhuOahu,
);

/// The real photo decoded the way Match decodes it, once.
Future<SampledImage> _decodedPhoto(WidgetTester tester) async {
  final Uint8List bytes = _photoBytes();
  return (await tester.runAsync(() => decodePhoto(bytes)))!;
}

/// The page with the real photo, which the decoder hands back already decoded
/// (a real decode needs real async, which a widget test does not give).
Future<AppScope> _pumpReal(
  WidgetTester tester,
  SampledImage photo, {
  Set<String>? owned,
  Size size = const Size(360, 780),
}) {
  final FakeImagePickerService picker = FakeImagePickerService(
    const PhotoPickCancelled(),
  );
  return pumpMatch(
    tester,
    picker: picker,
    image: photo,
    decoder: (Uint8List bytes) async => photo,
    exampleLoader: () async => _photoBytes(),
    ownedMarkerCodes: owned,
    size: size,
  );
}

String _chipCode(WidgetTester tester) => tester
    .widgetList<Text>(
      find.descendant(of: find.byKey(_chip), matching: find.byType(Text)),
    )
    .first
    .data!;

void main() {
  test('the example photo is bundled, registered and credited', () {
    expect(_photoBytes().length, greaterThan(100000));
    expect(
      File('pubspec.yaml').readAsStringSync(),
      contains(matchExampleAsset),
    );
    expect(
      File('assets/images/CREDITS.md').readAsStringSync(),
      allOf(contains('match_example.jpg'), contains('CC0')),
    );
  });

  testWidgets(
    'the marker of the example is the truly closest one, in the chip and in '
    'the result',
    (WidgetTester tester) async {
      final SampledImage photo = await _decodedPhoto(tester);
      final List<MarkerColor> range = await _ohuhuRange();
      expect(range.length, greaterThan(300));

      // Independent of the matcher: every candidate, one by one.
      final int sample = _sampleOf(photo);
      final List<({MarkerColor color, double deltaE})> ranked = _distances(
        sample,
        range,
      );
      final MarkerColor closest = ranked.first.color;
      final List<ColorDistanceMatch> matched = findClosestMarkerMatches(
        sample,
        range,
        limit: 6,
      );
      expect(matched.first.color.colorId, closest.colorId);
      expect(matched.first.deltaE, closeTo(ranked.first.deltaE, 1e-9));
      // The point is well chosen: the runner-up is clearly further away, so a
      // pixel more or less does not change the marker.
      expect(
        ranked[1].deltaE - ranked.first.deltaE,
        greaterThanOrEqualTo(2.0),
        reason:
            'closest ${closest.newCode} ${ranked.first.deltaE}, runner-up '
            '${ranked[1].color.newCode} ${ranked[1].deltaE}',
      );
      // ...for every radius and every small offset of the point.
      for (final double radius in <double>[0.01, 0.015, 0.02, 0.025, 0.03]) {
        for (final Offset shift in const <Offset>[
          Offset.zero,
          Offset(0.01, 0),
          Offset(-0.01, 0),
          Offset(0, 0.01),
          Offset(0, -0.01),
        ]) {
          final int nearby = _sampleOf(
            photo,
            at: matchExamplePoint + shift,
            radius: radius,
          );
          expect(
            _distances(nearby, range).first.color.colorId,
            closest.colorId,
            reason: 'radius $radius shifted by $shift',
          );
        }
      }

      final AppScope scope = await _pumpReal(
        tester,
        photo,
        size: const Size(360, 2400),
      );
      // No collection: Match uses the whole range of the brand.
      await scope.settings.setOwnedSetIds(<String>{});
      await tester.pumpAndSettle();
      expect(find.text(l10n.matchSubtitleEmpty), findsOneWidget);
      // The chip of the empty state...
      expect(_chipCode(tester), closest.newCode);
      expect(
        find.descendant(
          of: find.byKey(_chip),
          matching: find.text(closest.newName),
        ),
        findsOneWidget,
      );
      // ...and what Match says after «Try an example photo».
      await tester.tap(find.byKey(_button));
      await tester.pumpAndSettle();
      expect(
        find.byKey(ValueKey<String>('match-best-${closest.newCode}')),
        findsOneWidget,
      );
      final BestMatchTile best = tester.widget<BestMatchTile>(
        find.byType(BestMatchTile),
      );
      expect(best.match.color.colorId, closest.colorId);
      expect(best.match.deltaE, closeTo(ranked.first.deltaE, 1e-9));
      expect(
        tester
            .widget<Text>(
              find.byKey(const ValueKey<String>('match-sampled-hex')),
            )
            .data,
        '#${colorIntToHex(sample)}',
      );
      // The alternatives are the next ones, in order.
      for (int i = 1; i < 6; i++) {
        expect(
          find.byKey(
            ValueKey<String>('match-result-${ranked[i].color.newCode}'),
          ),
          findsOneWidget,
          reason: 'alternative $i',
        );
      }
    },
  );

  testWidgets('with a collection the chip uses the markers the user owns', (
    WidgetTester tester,
  ) async {
    final SampledImage photo = await _decodedPhoto(tester);
    final List<MarkerColor> catalog = await diskMarkerRepository().loadColors(
      MarkerBrand.ohuhuOahu,
    );
    // What the scope owns by default (a set), plus a few single markers.
    const Set<String> extra = <String>{'R014', 'B08', 'G312', 'Y19', '120'};
    final List<MarkerColor> pool = ownedColors(
      colors: catalog,
      brand: MarkerBrand.ohuhuOahu,
      ownedSetIds: const <String>{'classic_160'},
      ownedMarkerCodes: extra,
    );
    final List<MarkerColor> range = await _ohuhuRange();
    expect(pool, isNotEmpty);
    expect(pool.length, lessThan(range.length));
    final MarkerColor closest = _distances(_sampleOf(photo), pool).first.color;

    await _pumpReal(tester, photo, owned: extra);
    expect(_chipCode(tester), closest.newCode);
    await tester.tap(find.byKey(_button));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<BestMatchTile>(find.byType(BestMatchTile))
          .match
          .color
          .newCode,
      closest.newCode,
    );
  });

  testWidgets('the preview and the button are there, equal in reach', (
    WidgetTester tester,
  ) async {
    await pumpMatch(
      tester,
      picker: FakeImagePickerService(PhotoPicked(tinyPng)),
      image: sampledImage(64, 64, <int>[250, 195, 157]),
      size: const Size(360, 740),
    );

    expect(find.byKey(_preview), findsOneWidget);
    expect(find.byKey(_tap), findsOneWidget);
    expect(find.byKey(_chip), findsOneWidget);
    expect(find.text(l10n.matchExampleButton), findsOneWidget);
    // The third button is the same as the other two: secondary, full width.
    final Rect camera = tester.getRect(
      find.byKey(const ValueKey<String>('match-camera')),
    );
    final Rect gallery = tester.getRect(
      find.byKey(const ValueKey<String>('match-gallery')),
    );
    final Rect example = tester.getRect(find.byKey(_button));
    expect(example.width, camera.width);
    expect(example.height, camera.height);
    expect(example.left, camera.left);
    expect(example.top, greaterThan(gallery.bottom));
    final InkButton widget = tester.widget<InkButton>(find.byKey(_button));
    expect(widget.variant, InkButtonVariant.secondary);
    expect(widget.onPressed, isNotNull);
    // The preview is inside the column of the buttons and over them.
    final Rect preview = tester.getRect(find.byKey(_preview));
    expect(preview.width, lessThanOrEqualTo(camera.width + 0.01));
    expect(preview.bottom, lessThan(camera.top));
    // It reads as a button to a screen reader.
    final SemanticsHandle handle = tester.ensureSemantics();
    expect(
      tester.getSemantics(
        find.bySemanticsLabel(l10n.matchExamplePreviewSemantics),
      ),
      isSemantics(
        label: l10n.matchExamplePreviewSemantics,
        isButton: true,
        hasTapAction: true,
      ),
    );
    handle.dispose();
  });

  for (final String how in <String>['the button', 'the preview']) {
    testWidgets('$how loads the example, sampled, with no picker', (
      WidgetTester tester,
    ) async {
      final FakeImagePickerService picker = FakeImagePickerService(
        const PhotoPickCancelled(),
      );
      final AppScope scope = await pumpMatch(
        tester,
        picker: picker,
        image: sampledImage(64, 64, <int>[250, 195, 157]),
        size: const Size(360, 2400),
      );
      expect(find.byKey(const ValueKey<String>('match-canvas')), findsNothing);

      await tester.tap(find.byKey(how == 'the button' ? _button : _tap));
      await tester.pumpAndSettle();

      // No camera, no gallery, no permission.
      expect(picker.calls, isEmpty);
      // The photo is on screen and the point already sampled.
      expect(find.byKey(const ValueKey<String>('match-empty')), findsNothing);
      expect(
        find.byKey(const ValueKey<String>('match-canvas')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('match-sampled-hex')),
        findsOneWidget,
      );
      expect(find.byType(BestMatchTile), findsOneWidget);
      expect(find.byType(MatchResultTile), findsNWidgets(5));
      // Nothing is saved unless the user saves a match.
      expect(scope.matchHistory.entries, isEmpty);
    });
  }

  testWidgets(
    'activating while the example is still being prepared decodes it once '
    'and disables every button',
    (WidgetTester tester) async {
      final Completer<SampledImage> reading = Completer<SampledImage>();
      final SampledImage ready = sampledImage(64, 64, <int>[250, 195, 157]);
      int decodes = 0;
      await pumpMatch(
        tester,
        picker: FakeImagePickerService(PhotoPicked(tinyPng)),
        image: ready,
        // The preparation starts the only read; it is still pending.
        decoder: (Uint8List bytes) {
          decodes++;
          return reading.future;
        },
        size: const Size(360, 780),
      );
      expect(decodes, 1);

      await tester.tap(find.byKey(_button));
      await tester.pump();
      expect(find.text(l10n.matchLoadingPhoto), findsOneWidget);
      for (final ValueKey<String> key in <ValueKey<String>>[
        _button,
        const ValueKey<String>('match-camera'),
        const ValueKey<String>('match-gallery'),
      ]) {
        expect(tester.widget<InkButton>(find.byKey(key)).onPressed, isNull);
      }
      // The preview ignores taps too.
      await tester.tap(find.byKey(_tap));
      await tester.pump();

      reading.complete(ready);
      await tester.pumpAndSettle();
      expect(find.byType(BestMatchTile), findsOneWidget);
      expect(decodes, 1);
    },
  );

  testWidgets('an example that was prepared is not decoded again', (
    WidgetTester tester,
  ) async {
    final SampledImage ready = sampledImage(64, 64, <int>[250, 195, 157]);
    int decodes = 0;
    int reads = 0;
    await pumpMatch(
      tester,
      picker: FakeImagePickerService(PhotoPicked(tinyPng)),
      image: ready,
      decoder: (Uint8List bytes) async {
        decodes++;
        return ready;
      },
      exampleLoader: () async {
        reads++;
        return tinyPng;
      },
      size: const Size(360, 2400),
    );
    expect((decodes, reads), (1, 1));
    await tester.tap(find.byKey(_button));
    await tester.pumpAndSettle();
    expect(find.byType(BestMatchTile), findsOneWidget);
    expect((decodes, reads), (1, 1));
  });

  testWidgets('a failed read is cleared, so the next try reads again', (
    WidgetTester tester,
  ) async {
    int reads = 0;
    await pumpMatch(
      tester,
      picker: FakeImagePickerService(PhotoPicked(tinyPng)),
      image: sampledImage(64, 64, <int>[250, 195, 157]),
      exampleLoader: () async {
        // The preparation fails; the button's try works.
        if (reads++ == 0) throw StateError('not yet');
        return tinyPng;
      },
      size: const Size(360, 2400),
    );
    expect(reads, 1);
    await tester.tap(find.byKey(_button));
    await tester.pumpAndSettle();
    expect(reads, 2);
    expect(find.text(l10n.matchPickFailed), findsNothing);
    expect(find.byType(BestMatchTile), findsOneWidget);
  });

  testWidgets('an example that cannot be read says so', (
    WidgetTester tester,
  ) async {
    await pumpMatch(
      tester,
      picker: FakeImagePickerService(PhotoPicked(tinyPng)),
      image: sampledImage(64, 64, <int>[250, 195, 157]),
      exampleLoader: () async => throw StateError('gone'),
      size: const Size(360, 780),
    );
    // No photo, no chip, but the room for it and a button that answers.
    expect(find.byKey(_chip), findsOneWidget);
    await tester.tap(find.byKey(_button));
    await tester.pumpAndSettle();
    expect(find.text(l10n.matchPickFailed), findsOneWidget);
    expect(tester.widget<InkButton>(find.byKey(_button)).onPressed, isNotNull);
  });

  testWidgets('nothing moves when the example finishes loading', (
    WidgetTester tester,
  ) async {
    final Completer<Uint8List> slow = Completer<Uint8List>();
    await pumpMatch(
      tester,
      picker: FakeImagePickerService(PhotoPicked(tinyPng)),
      image: sampledImage(64, 64, <int>[250, 195, 157]),
      exampleLoader: () => slow.future,
      size: const Size(360, 780),
    );
    Map<String, Rect> rects() => <String, Rect>{
      for (final ValueKey<String> key in <ValueKey<String>>[
        _preview,
        _button,
        const ValueKey<String>('match-camera'),
        const ValueKey<String>('match-gallery'),
        const ValueKey<String>('match-empty'),
      ])
        key.value: tester.getRect(find.byKey(key)),
    };
    final Map<String, Rect> before = rects();
    final double chipHeight = tester.getSize(find.byKey(_chip)).height;

    slow.complete(tinyPng);
    await tester.pumpAndSettle();
    expect(rects(), before);
    expect(tester.getSize(find.byKey(_chip)).height, chipHeight);
  });

  for (final double scale in <double>[1.0, 2.0]) {
    testWidgets('360 dp wide at text scale $scale: nothing overflows', (
      WidgetTester tester,
    ) async {
      tester.platformDispatcher.textScaleFactorTestValue = scale;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      final SampledImage photo = await _decodedPhoto(tester);
      await _pumpReal(tester, photo);

      expect(tester.takeException(), isNull);
      // Everything of the empty state is reachable: the buttons are inside
      // the page (it scrolls) and the chip keeps to one line.
      final Rect chip = tester.getRect(find.byKey(_chip));
      expect(chip.left, greaterThanOrEqualTo(0));
      expect(chip.right, lessThanOrEqualTo(360));
      final Rect card = tester.getRect(
        find.byKey(const ValueKey<String>('match-empty')),
      );
      for (final ValueKey<String> key in <ValueKey<String>>[
        _preview,
        _button,
      ]) {
        final Rect r = tester.getRect(find.byKey(key));
        expect(r.left, greaterThanOrEqualTo(card.left - 0.01));
        expect(r.right, lessThanOrEqualTo(card.right + 0.01));
      }
      await tester.ensureVisible(find.byKey(_button));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }

  // The accessibility size, in every language, with the real fonts: no
  // label of the empty state may be cut, and the example finishing its load
  // may not move anything.
  group('text scale 2.0 in every language', () {
    setUpAll(loadAppFonts);
    for (final Locale locale in AppLocalizations.supportedLocales) {
      final StabilityEnv env = StabilityEnv(locale, 360, 2.0);

      testWidgets('${env.tag}: no label is cut', (WidgetTester tester) async {
        await pumpStability(
          tester,
          env,
          MatchPage(
            picker: FakeImagePickerService(PhotoPicked(tinyPng)),
            decoder: fixedDecoder(sampledImage(64, 64, <int>[242, 195, 157])),
            exampleLoader: () async => tinyPng,
          ),
        );
        expectNoTruncation(tester, '${env.tag} empty state');
        expect(find.text(env.t.matchExampleButton), findsOneWidget);
        await scrollThrough(
          tester,
          find.byType(Scrollable).first,
          (int step) => expectNoTruncation(tester, '${env.tag} step $step'),
        );
        // The three labels are whole, and the buttons may grow but stay
        // inside the column.
        await tester.ensureVisible(find.byKey(_button));
        await tester.pumpAndSettle();
        final Rect card = tester.getRect(
          find.byKey(const ValueKey<String>('match-empty')),
        );
        for (final String key in <String>[
          'match-camera',
          'match-gallery',
          'match-example',
        ]) {
          final Rect r = tester.getRect(find.byKey(ValueKey<String>(key)));
          expect(r.left, greaterThanOrEqualTo(card.left - 0.01), reason: key);
          expect(r.right, lessThanOrEqualTo(card.right + 0.01), reason: key);
        }
      });

      testWidgets('${env.tag}: nothing moves when the example loads', (
        WidgetTester tester,
      ) async {
        final Completer<Uint8List> slow = Completer<Uint8List>();
        await pumpStability(
          tester,
          env,
          MatchPage(
            picker: FakeImagePickerService(PhotoPicked(tinyPng)),
            decoder: fixedDecoder(sampledImage(64, 64, <int>[242, 195, 157])),
            exampleLoader: () => slow.future,
          ),
        );
        Map<String, Rect> rects() => <String, Rect>{
          for (final ValueKey<String> key in <ValueKey<String>>[
            _preview,
            _button,
            const ValueKey<String>('match-camera'),
            const ValueKey<String>('match-gallery'),
            const ValueKey<String>('match-empty'),
          ])
            key.value: tester.getRect(find.byKey(key)),
        };
        final Map<String, Rect> before = rects();
        final double chipHeight = tester.getSize(find.byKey(_chip)).height;

        slow.complete(tinyPng);
        await tester.pumpAndSettle();
        expect(rects(), before, reason: env.tag);
        expect(
          tester.getSize(find.byKey(_chip)).height,
          chipHeight,
          reason: env.tag,
        );
        expect(tester.takeException(), isNull);
      });
    }
  });

  testWidgets(
    'two brand loads that finish out of order leave the newer brand in '
    'Match and in the example chip',
    (WidgetTester tester) async {
      final SampledImage photo = await _decodedPhoto(tester);
      final Map<String, Completer<String>> pending =
          <String, Completer<String>>{};
      final MarkerRepository markers = MarkerRepository(
        loadAsset: (String path) {
          // The brands under test answer when the test says so; the rest
          // (the first brand, the cards) are read at once.
          if (path == MarkerBrand.decoTime.assetPath ||
              path == MarkerBrand.copic.assetPath) {
            return pending.putIfAbsent(path, () => Completer<String>()).future;
          }
          return File(path).readAsStringSync();
        },
      );
      final AppScope scope = await pumpMatch(
        tester,
        picker: FakeImagePickerService(const PhotoPickCancelled()),
        image: photo,
        decoder: (Uint8List bytes) async => photo,
        exampleLoader: () async => _photoBytes(),
        markers: markers,
        size: const Size(360, 2400),
      );

      final int sample = _sampleOf(photo);
      Future<List<MarkerColor>> rangeOf(MarkerBrand brand) async =>
          brandRangeColors(
            colors: await diskMarkerRepository().loadColors(brand),
            brand: brand,
          );
      final MarkerColor older = _distances(
        sample,
        await rangeOf(MarkerBrand.decoTime),
      ).first.color;
      final MarkerColor newer = _distances(
        sample,
        await rangeOf(MarkerBrand.copic),
      ).first.color;
      expect(older.colorId, isNot(newer.colorId));

      // Two reloads in a row: the first (DecoTime) is slow, the second
      // (Copic) is the one the user ended on.
      await scope.settings.setBrand(MarkerBrand.decoTime);
      await tester.pump();
      await scope.settings.setBrand(MarkerBrand.copic);
      await tester.pump();
      expect(
        pending.keys,
        containsAll(<String>[
          MarkerBrand.decoTime.assetPath,
          MarkerBrand.copic.assetPath,
        ]),
      );

      // The newer one finishes first, then the older one, late.
      pending[MarkerBrand.copic.assetPath]!.complete(
        File(MarkerBrand.copic.assetPath).readAsStringSync(),
      );
      await tester.pumpAndSettle();
      pending[MarkerBrand.decoTime.assetPath]!.complete(
        File(MarkerBrand.decoTime.assetPath).readAsStringSync(),
      );
      await tester.pumpAndSettle();

      // Match works with Copic: the whole range notice and the chip say so...
      expect(
        find.text(l10n.matchWholeRangeBody(MarkerBrand.copic.label)),
        findsOneWidget,
      );
      expect(_chipCode(tester), newer.newCode);
      // ...and so does the result of the example.
      await tester.tap(find.byKey(_button));
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<BestMatchTile>(find.byType(BestMatchTile))
            .match
            .color
            .colorId,
        newer.colorId,
      );
    },
  );

  testWidgets('a short landscape window still reaches the example', (
    WidgetTester tester,
  ) async {
    final SampledImage photo = await _decodedPhoto(tester);
    final FakeImagePickerService picker = FakeImagePickerService(
      const PhotoPickCancelled(),
    );
    await pumpMatch(
      tester,
      picker: picker,
      image: photo,
      decoder: (Uint8List bytes) async => photo,
      exampleLoader: () async => _photoBytes(),
      size: const Size(640, 320),
    );
    expect(tester.takeException(), isNull);
    await tester.ensureVisible(find.byKey(_button));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(_button));
    await tester.pumpAndSettle();
    expect(find.byType(BestMatchTile), findsOneWidget);
  });

  testWidgets('a tablet shows the example in the photo half', (
    WidgetTester tester,
  ) async {
    final SampledImage photo = await _decodedPhoto(tester);
    await pumpMatch(
      tester,
      picker: FakeImagePickerService(const PhotoPickCancelled()),
      image: photo,
      decoder: (Uint8List bytes) async => photo,
      exampleLoader: () async => _photoBytes(),
      size: const Size(1280, 800),
    );
    expect(tester.takeException(), isNull);
    expect(
      find.byKey(const ValueKey<String>('match-photo-side')),
      findsOneWidget,
    );
    await tester.tap(find.byKey(_button));
    await tester.pumpAndSettle();
    // The result is on the other side, and nothing was lost on the way.
    expect(
      find.descendant(
        of: find.byKey(const ValueKey<String>('match-result-side')),
        matching: find.byType(BestMatchTile),
      ),
      findsOneWidget,
    );
  });

  testWidgets('dark theme draws the preview without errors', (
    WidgetTester tester,
  ) async {
    final SampledImage photo = await _decodedPhoto(tester);
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
    await _pumpReal(tester, photo);
    expect(find.byKey(_preview), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
