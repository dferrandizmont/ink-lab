import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/ui/pages/match/color_sampling.dart';
import 'package:ink_lab/ui/pages/match/image_picker_service.dart';
import 'package:ink_lab/ui/pages/match/match_page.dart';
import 'package:ink_lab/ui/pages/match/match_result_tile.dart';
import 'package:ink_lab/ui/theme/app_typography.dart';

import 'match_test_support.dart';
import '../../support/l10n.dart';

/// Opens the camera and taps the centre of the canvas, where the fake image is
/// a single, uniform colour.
Future<void> pickAndSample(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey<String>('match-camera')));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey<String>('match-canvas')));
  await tester.pumpAndSettle();
}

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

  testWidgets('a collection not set up matches the whole range', (
    WidgetTester tester,
  ) async {
    final FakeImagePickerService picker = FakeImagePickerService(
      PhotoPicked(tinyPng),
    );
    await pumpMatch(
      tester,
      picker: picker,
      image: sampledImage(32, 32, <int>[255, 0, 0]),
      brand: MarkerBrand.decoTime,
    );

    await pickAndSample(tester);

    // The page explains that the whole range is used, with a way to set the
    // collection up.
    expect(find.text(l10n.matchSubtitleEmpty), findsOneWidget);
    expect(find.text(l10n.matchWholeRangeBody('DecoTime')), findsOneWidget);
    expect(
      find.byKey(const ValueKey<String>('match-whole-range-setup')),
      findsOneWidget,
    );
    // The best match comes from the whole range and is not flagged as
    // missing: the whole range is what is being matched.
    expect(find.byType(BestMatchTile), findsWidgets);
    expect(
      tester.widget<BestMatchTile>(find.byType(BestMatchTile).first).notOwned,
      isFalse,
    );
  });

  testWidgets('no close match: says so and offers the whole range', (
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
      brand: MarkerBrand.decoTime,
      ownedMarkerCodes: <String>{'decotime:01'},
    );

    await pickAndSample(tester);

    expect(
      find.byKey(const ValueKey<String>('match-no-close')),
      findsOneWidget,
    );
    // The closest owned marker stays visible with an honest label.
    expect(find.byKey(const ValueKey<String>('match-best-01')), findsOneWidget);
    expect(
      find.text(AppTypography.caps(l10n.matchQualityApproximate)),
      findsWidgets,
    );
    expect(find.text(l10n.matchRangeTitle('DecoTime')), findsOneWidget);
    final Iterable<BestMatchTile> tiles = tester.widgetList<BestMatchTile>(
      find.byType(BestMatchTile),
    );
    expect(tiles.where((BestMatchTile t) => t.notOwned), hasLength(1));

    // The suggestion can be turned off in Settings.
    await scope.settings.setMatchSuggestUnowned(false);
    await tester.pumpAndSettle();
    expect(find.text(l10n.matchRangeTitle('DecoTime')), findsNothing);
    expect(
      find.byKey(const ValueKey<String>('match-no-close')),
      findsOneWidget,
    );
  });

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
}
