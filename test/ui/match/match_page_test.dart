import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/ui/pages/match/color_sampling.dart';
import 'package:ink_lab/ui/pages/match/image_picker_service.dart';
import 'package:ink_lab/ui/pages/match/match_page.dart';
import 'package:ink_lab/ui/pages/match/match_result_tile.dart';
import 'package:ink_lab/ui/pages/match/photo_box.dart';
import 'package:ink_lab/ui/theme/app_typography.dart';
import 'package:ink_lab/ui/widgets/ink_button.dart';
import 'package:ink_lab/ui/widgets/page_header.dart';

import 'match_test_support.dart';
import '../../support/layout_stability.dart';
import '../../support/l10n.dart';

/// Opens the camera and taps the centre of the canvas, where the fake image is
/// a single, uniform colour.
Future<void> pickAndSample(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey<String>('match-camera')));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey<String>('match-canvas')));
  await tester.pumpAndSettle();
}

/// A wide photo (the box keeps its height) with warm paper on the left half
/// and a dark stroke on the right one.
SampledImage widePaperAndInk() => imageFromRgb(96, 16, <List<int>>[
  for (int y = 0; y < 16; y++)
    for (int x = 0; x < 96; x++)
      x < 48 ? <int>[230, 210, 180] : <int>[30, 40, 120],
]);

void main() {
  testWidgets('picking a photo samples a colour and ranks six markers', (
    WidgetTester tester,
  ) async {
    final FakeImagePickerService picker = FakeImagePickerService(
      PhotoPicked(tinyPng),
    );
    await pumpMatch(
      tester,
      picker: picker,
      image: sampledImage(64, 64, <int>[255, 0, 0]),
    );

    expect(find.byKey(MatchPage.pageKey), findsOneWidget);
    // Photos never leave the device: the caption says so.
    expect(find.text(l10n.matchPrivacyCaption), findsOneWidget);

    await pickAndSample(tester);

    expect(picker.calls, <PhotoSource>[PhotoSource.camera]);
    expect(
      find.byKey(const ValueKey<String>('match-sampled-hex')),
      findsOneWidget,
    );
    expect(find.text('#FF0000'), findsOneWidget);
    // One best match and five alternates.
    expect(find.byType(BestMatchTile), findsOneWidget);
    expect(find.byType(MatchResultTile), findsNWidgets(5));
    expect(find.textContaining('ΔE'), findsWidgets);
  });

  testWidgets('the gallery is used when asked for', (
    WidgetTester tester,
  ) async {
    final FakeImagePickerService picker = FakeImagePickerService(
      PhotoPicked(tinyPng),
    );
    await pumpMatch(
      tester,
      picker: picker,
      image: sampledImage(32, 32, <int>[0, 128, 255]),
    );

    await tester.tap(find.byKey(const ValueKey<String>('match-gallery')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey<String>('match-canvas')));
    await tester.pumpAndSettle();

    expect(picker.calls, <PhotoSource>[PhotoSource.gallery]);
    expect(find.text('#0080FF'), findsOneWidget);
  });

  testWidgets('tapping a match records it and remove works', (
    WidgetTester tester,
  ) async {
    final FakeImagePickerService picker = FakeImagePickerService(
      PhotoPicked(tinyPng),
    );
    final AppScope scope = await pumpMatch(
      tester,
      picker: picker,
      image: sampledImage(64, 64, <int>[255, 0, 0]),
    );

    await pickAndSample(tester);
    await tester.tap(find.byType(BestMatchTile));
    await tester.pumpAndSettle();

    expect(scope.matchHistory.entries, hasLength(1));
    final ColorMatchPick pick = scope.matchHistory.entries.first;
    expect(pick.sampledHex, 'FF0000');
    expect(pick.brandId, MarkerBrand.ohuhuOahu.id);

    // A recent pick opens its details, where it can be removed.
    await tester.tap(find.byKey(ValueKey<String>('match-pick-${pick.id}')));
    await tester.pumpAndSettle();
    final Finder remove = find.byKey(
      ValueKey<String>('match-pick-remove-${pick.id}'),
    );
    expect(remove, findsOneWidget);
    await tester.tap(remove);
    await tester.pumpAndSettle();

    expect(scope.matchHistory.entries, isEmpty);
    expect(find.text(l10n.matchRecentEmpty), findsOneWidget);
  });

  testWidgets('an alternate match can be recorded too', (
    WidgetTester tester,
  ) async {
    final FakeImagePickerService picker = FakeImagePickerService(
      PhotoPicked(tinyPng),
    );
    final AppScope scope = await pumpMatch(
      tester,
      picker: picker,
      image: sampledImage(64, 64, <int>[255, 0, 0]),
    );

    await pickAndSample(tester);
    await tester.tap(find.byType(MatchResultTile).first);
    await tester.pumpAndSettle();

    expect(scope.matchHistory.entries, hasLength(1));
    expect(scope.matchHistory.entries.first.matchedCode, isNotEmpty);
  });

  testWidgets('clear removes every recent pick after confirmation', (
    WidgetTester tester,
  ) async {
    final FakeImagePickerService picker = FakeImagePickerService(
      PhotoPicked(tinyPng),
    );
    final AppScope scope = await pumpMatch(
      tester,
      picker: picker,
      image: sampledImage(64, 64, <int>[255, 0, 0]),
    );

    await pickAndSample(tester);
    await tester.tap(find.byType(BestMatchTile));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(MatchResultTile).first);
    await tester.pumpAndSettle();
    expect(scope.matchHistory.entries, hasLength(2));

    await tester.tap(find.byKey(const ValueKey<String>('match-history-clear')));
    await tester.pumpAndSettle();
    await tester.tap(
      find.byKey(const ValueKey<String>('match-history-clear-confirm')),
    );
    await tester.pumpAndSettle();

    expect(scope.matchHistory.entries, isEmpty);
    expect(find.text(l10n.matchRecentEmpty), findsOneWidget);
  });

  testWidgets('a denied camera shows a clear message', (
    WidgetTester tester,
  ) async {
    final FakeImagePickerService picker = FakeImagePickerService(
      const PhotoPickDenied(PhotoSource.camera),
    );
    await pumpMatch(
      tester,
      picker: picker,
      image: sampledImage(16, 16, <int>[0, 0, 0]),
    );

    await tester.tap(find.byKey(const ValueKey<String>('match-camera')));
    await tester.pumpAndSettle();

    expect(find.text(l10n.matchCameraDenied), findsOneWidget);
    expect(find.byKey(const ValueKey<String>('match-canvas')), findsNothing);
  });

  testWidgets('a denied gallery shows a clear message', (
    WidgetTester tester,
  ) async {
    final FakeImagePickerService picker = FakeImagePickerService(
      const PhotoPickDenied(PhotoSource.gallery),
    );
    await pumpMatch(
      tester,
      picker: picker,
      image: sampledImage(16, 16, <int>[0, 0, 0]),
    );

    await tester.tap(find.byKey(const ValueKey<String>('match-gallery')));
    await tester.pumpAndSettle();

    expect(find.text(l10n.matchGalleryDenied), findsOneWidget);
  });

  testWidgets('cancelling the picker shows a soft notice', (
    WidgetTester tester,
  ) async {
    final FakeImagePickerService picker = FakeImagePickerService(
      const PhotoPickCancelled(),
    );
    await pumpMatch(
      tester,
      picker: picker,
      image: sampledImage(16, 16, <int>[0, 0, 0]),
    );

    await tester.tap(find.byKey(const ValueKey<String>('match-camera')));
    await tester.pumpAndSettle();

    expect(find.text(l10n.matchCancelNotice), findsOneWidget);
  });

  testWidgets('an unreadable photo shows a clear message', (
    WidgetTester tester,
  ) async {
    final FakeImagePickerService picker = FakeImagePickerService(
      PhotoPicked(tinyPng),
    );
    await pumpMatch(
      tester,
      picker: picker,
      image: sampledImage(16, 16, <int>[0, 0, 0]),
      decoder: (Uint8List bytes) async =>
          throw const PhotoDecodeException('boom'),
    );

    await tester.tap(find.byKey(const ValueKey<String>('match-camera')));
    await tester.pumpAndSettle();

    expect(find.text(l10n.matchDecodeFailed), findsOneWidget);
  });

  for (final brand in [
    MarkerBrand.decoTime,
    MarkerBrand.copic,
    MarkerBrand.finecolour,
  ]) {
    testWidgets(
      '${brand.label}: a collection not set up matches the whole range',
      (WidgetTester tester) async {
        final FakeImagePickerService picker = FakeImagePickerService(
          PhotoPicked(tinyPng),
        );
        await pumpMatch(
          tester,
          picker: picker,
          image: sampledImage(32, 32, <int>[255, 0, 0]),
          brand: brand,
        );

        await pickAndSample(tester);

        // The page explains that the whole range is used, with a way to set the
        // collection up.
        expect(find.text(l10n.matchSubtitleEmpty), findsOneWidget);
        expect(
          find.text(l10n.matchWholeRangeBody(brand.label)),
          findsOneWidget,
        );
        expect(
          find.byKey(const ValueKey<String>('match-whole-range-setup')),
          findsOneWidget,
        );
        // The best match comes from the whole range and is not flagged as
        // missing: the whole range is what is being matched.
        expect(find.byType(BestMatchTile), findsWidgets);
        expect(
          tester
              .widget<BestMatchTile>(find.byType(BestMatchTile).first)
              .notOwned,
          isFalse,
        );
      },
    );

    testWidgets('${brand.label}: no close match offers the whole range', (
      WidgetTester tester,
    ) async {
      final FakeImagePickerService picker = FakeImagePickerService(
        PhotoPicked(tinyPng),
      );
      // A single wine red against a pure blue sample.
      final AppScope scope = await pumpMatch(
        tester,
        picker: picker,
        image: sampledImage(32, 32, <int>[0, 0, 255]),
        brand: brand,
        ownedMarkerCodes: <String>{
          brand == MarkerBrand.finecolour
              ? 'finecolour:R140'
              : brand == MarkerBrand.copic
              ? 'copic:R29'
              : 'decotime:01',
        },
      );

      await pickAndSample(tester);

      expect(
        find.byKey(const ValueKey<String>('match-no-close')),
        findsOneWidget,
      );
      // The closest owned marker stays visible with an honest label.
      expect(
        find.byKey(
          ValueKey<String>(
            brand == MarkerBrand.finecolour
                ? 'match-best-R140'
                : brand == MarkerBrand.copic
                ? 'match-best-R29'
                : 'match-best-01',
          ),
        ),
        findsOneWidget,
      );
      expect(
        find.text(AppTypography.caps(l10n.matchQualityApproximate)),
        findsWidgets,
      );
      // The best of the whole range is folded: the summary shows its code
      // and its distance, and opening it shows the marker itself.
      expect(find.text(l10n.matchBestOfRange(brand.label)), findsOneWidget);
      expect(find.byKey(const ValueKey<String>('match-range')), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey<String>('match-range')));
      await tester.pumpAndSettle();
      final Iterable<BestMatchTile> tiles = tester.widgetList<BestMatchTile>(
        find.byType(BestMatchTile),
      );
      expect(tiles.where((BestMatchTile t) => t.notOwned), hasLength(1));
      // Not a badge: a quiet line.
      expect(find.text(l10n.matchNotOwnedLine), findsOneWidget);

      // The suggestion can be turned off in Settings.
      await scope.settings.setMatchSuggestUnowned(false);
      await tester.pumpAndSettle();
      expect(find.text(l10n.matchBestOfRange(brand.label)), findsNothing);
      expect(
        find.byKey(const ValueKey<String>('match-no-close')),
        findsOneWidget,
      );
    });
  }

  testWidgets('recent picks are kept per brand', (WidgetTester tester) async {
    final FakeImagePickerService picker = FakeImagePickerService(
      PhotoPicked(tinyPng),
    );
    final AppScope scope = await pumpMatch(
      tester,
      picker: picker,
      image: sampledImage(64, 64, <int>[255, 0, 0]),
    );
    await pickAndSample(tester);
    await tester.tap(find.byType(BestMatchTile).first);
    await tester.pumpAndSettle();
    final ColorMatchPick pick = scope.matchHistory.entries.single;
    final Finder tile = find.byKey(ValueKey<String>('match-pick-${pick.id}'));
    expect(tile, findsOneWidget);

    await scope.settings.setBrand(MarkerBrand.decoTime);
    await tester.pumpAndSettle();
    expect(tile, findsNothing);
    expect(find.text(l10n.matchRecentEmpty), findsOneWidget);
    // The Ohuhu pick is kept, not deleted.
    expect(scope.matchHistory.entries, hasLength(1));

    await scope.settings.setBrand(MarkerBrand.ohuhuOahu);
    await tester.pumpAndSettle();
    expect(tile, findsOneWidget);
  });

  testWidgets('a portrait photo fills the box and taps map to the photo', (
    WidgetTester tester,
  ) async {
    // 8x16: red on the left half, blue on the right half.
    final SampledImage portrait = imageFromRgb(8, 16, <List<int>>[
      for (var y = 0; y < 16; y++)
        for (var x = 0; x < 8; x++) x < 4 ? <int>[255, 0, 0] : <int>[0, 0, 255],
    ]);
    final FakeImagePickerService picker = FakeImagePickerService(
      PhotoPicked(tinyPng),
    );
    await pumpMatch(tester, picker: picker, image: portrait);
    final Finder canvas = find.byKey(const ValueKey<String>('match-canvas'));

    await tester.tap(find.byKey(const ValueKey<String>('match-camera')));
    await tester.pumpAndSettle();

    // The box grew past the old 196 and the photo fills it, whole.
    final Rect box = tester.getRect(canvas);
    expect(box.height, greaterThan(196));
    // 600 wide x 3200 high: the 520 cap, less the 1 px border on each side.
    expect(box.height, closeTo(maxPhotoBoxHeight - 2, 1e-6));
    final Rect fitted = containRect(box.size, portrait.aspectRatio);
    expect(fitted.width, closeTo(box.height / 2, 1e-6));

    // A quarter of the way across the photo is red, three quarters is blue.
    await tester.tapAt(
      Offset(
        box.left + fitted.left + fitted.width / 4,
        box.top + fitted.height / 2,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('#FF0000'), findsOneWidget);
    await tester.tapAt(
      Offset(
        box.left + fitted.left + fitted.width * 3 / 4,
        box.top + fitted.height / 2,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('#0000FF'), findsOneWidget);
  });

  testWidgets('a panoramic photo keeps the box at its old height', (
    WidgetTester tester,
  ) async {
    final FakeImagePickerService picker = FakeImagePickerService(
      PhotoPicked(tinyPng),
    );
    await pumpMatch(
      tester,
      picker: picker,
      image: sampledImage(96, 16, <int>[255, 0, 0]),
    );
    await tester.tap(find.byKey(const ValueKey<String>('match-camera')));
    await tester.pumpAndSettle();
    expect(
      tester.getSize(find.byKey(const ValueKey<String>('match-canvas'))).height,
      196 - 2,
    );
  });

  testWidgets('the camera and the gallery are in view with a result', (
    WidgetTester tester,
  ) async {
    final FakeImagePickerService picker = FakeImagePickerService(
      PhotoPicked(tinyPng),
    );
    await pumpMatch(
      tester,
      picker: picker,
      image: sampledImage(96, 16, <int>[255, 0, 0]),
      size: const Size(360, 740),
    );

    await pickAndSample(tester);

    // The result is there...
    expect(find.byType(BestMatchTile), findsOneWidget);
    // ...and the buttons to take another photo are above the fold: the page
    // did not have to be scrolled to reach them.
    final ScrollableState scroll = tester.state<ScrollableState>(
      find.byType(Scrollable).first,
    );
    expect(scroll.position.pixels, 0);
    for (final String key in <String>['match-camera', 'match-gallery']) {
      final Rect button = tester.getRect(find.byKey(ValueKey<String>(key)));
      expect(button.top, greaterThanOrEqualTo(0), reason: key);
      expect(button.bottom, lessThanOrEqualTo(740), reason: key);
    }
  });

  testWidgets('the row of actions holds the camera, the gallery and the fix', (
    WidgetTester tester,
  ) async {
    await pumpMatch(
      tester,
      picker: FakeImagePickerService(PhotoPicked(tinyPng)),
      image: sampledImage(96, 16, <int>[255, 0, 0]),
      size: const Size(360, 740),
    );

    // The fix waits for a photo, but the row is always the same.
    final Finder start = find.byKey(
      const ValueKey<String>('white-balance-start'),
    );
    expect(start, findsOneWidget);
    expect(tester.widget<InkButton>(start).onPressed, isNull);

    await tester.tap(find.byKey(const ValueKey<String>('match-camera')));
    await tester.pumpAndSettle();

    expect(tester.widget<InkButton>(start).onPressed, isNotNull);
    // Both buttons of the row are secondary: the page has no loud button.
    for (final String key in <String>['match-camera', 'match-gallery']) {
      expect(
        tester.widget<InkButton>(find.byKey(ValueKey<String>(key))).variant,
        InkButtonVariant.smallSecondary,
        reason: key,
      );
    }
  });

  testWidgets('the recent picks show six and the rest in a picker', (
    WidgetTester tester,
  ) async {
    final FakeImagePickerService picker = FakeImagePickerService(
      PhotoPicked(tinyPng),
    );
    final AppScope scope = await pumpMatch(
      tester,
      picker: picker,
      // Two colours: a pick is remembered with the colour it was made with.
      image: imageFromRgb(64, 64, <List<int>>[
        for (int y = 0; y < 64; y++)
          for (int x = 0; x < 64; x++)
            x < 32 ? <int>[255, 0, 0] : <int>[0, 0, 255],
      ]),
    );

    Future<void> sampleAt(double fraction) async {
      final Rect canvas = tester.getRect(
        find.byKey(const ValueKey<String>('match-canvas')),
      );
      await tester.tapAt(
        Offset(canvas.left + canvas.width * fraction, canvas.center.dy),
      );
      await tester.pumpAndSettle();
    }

    await tester.tap(find.byKey(const ValueKey<String>('match-camera')));
    await tester.pumpAndSettle();
    await sampleAt(0.25);
    // The best match and its five alternates.
    await tester.tap(find.byType(BestMatchTile).first);
    await tester.pumpAndSettle();
    for (int i = 0; i < 5; i++) {
      await tester.tap(find.byType(MatchResultTile).at(i));
      await tester.pumpAndSettle();
    }
    // Another colour: two more picks.
    await sampleAt(0.75);
    await tester.tap(find.byType(BestMatchTile).first);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(MatchResultTile).first);
    await tester.pumpAndSettle();

    expect(scope.matchHistory.entries, hasLength(8));

    // Six on the page, the rest behind "See all".
    expect(
      find.byWidgetPredicate(
        (Widget w) =>
            w.key is ValueKey<String> &&
            (w.key! as ValueKey<String>).value.startsWith('match-pick-'),
      ),
      findsNWidgets(6),
    );
    expect(
      find.byKey(const ValueKey<String>('match-history-see-all')),
      findsOneWidget,
    );
    expect(find.text(l10n.matchSeeAll(8)), findsOneWidget);

    await tester.tap(
      find.byKey(const ValueKey<String>('match-history-see-all')),
    );
    await tester.pumpAndSettle();

    // Every pick is in the sheet.
    expect(
      find.byWidgetPredicate(
        (Widget w) =>
            w.key is ValueKey<String> &&
            (w.key! as ValueKey<String>).value.startsWith('match-history-row-'),
      ),
      findsNWidgets(8),
    );
  });

  stabilityTest('match: the row of actions never moves', (
    WidgetTester tester,
    StabilityEnv env,
  ) async {
    await pumpStability(
      tester,
      env,
      MatchPage(
        picker: FakeImagePickerService(PhotoPicked(tinyPng)),
        decoder: fixedDecoder(widePaperAndInk()),
      ),
    );

    Future<void> pickPhoto() async {
      await tester.tap(find.byKey(const ValueKey<String>('match-camera')));
      await tester.pumpAndSettle();
    }

    Future<void> fixWhites() async {
      await tester.tap(
        find.byKey(const ValueKey<String>('white-balance-start')),
      );
      await tester.pumpAndSettle();
      // The left half of the photo is the paper.
      final Rect canvas = tester.getRect(
        find.byKey(const ValueKey<String>('match-canvas')),
      );
      await tester.tapAt(
        Offset(canvas.left + canvas.width / 4, canvas.center.dy),
      );
      await tester.pumpAndSettle();
    }

    await expectStableAcrossSegments(
      tester,
      env: env,
      anchors: <String, Finder>{
        'header': find.byType(InkPageHeader),
        'actions': find.byKey(const ValueKey<String>('match-actions')),
        'camera': find.byKey(const ValueKey<String>('match-camera')),
        'gallery': find.byKey(const ValueKey<String>('match-gallery')),
        'white balance': find.byKey(
          const ValueKey<String>('white-balance-start'),
        ),
      },
      segments: <StabilitySegment>[
        (name: 'no photo', activate: () async {}),
        (name: 'with photo', activate: pickPhoto),
        (name: 'whites fixed', activate: fixWhites),
        (name: 'no photo again', activate: () async {}),
      ],
    );
  });
}
