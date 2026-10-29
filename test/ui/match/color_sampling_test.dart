import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ui/pages/match/color_sampling.dart';

import 'match_test_support.dart';

void main() {
  group('averageColorOfRegion', () {
    test('averages a square region of a generated image', () {
      // A 2x2 image of the four corners, so the mean of red/green/blue/white
      // is a mid grey.
      final SampledImage image = imageFromRgb(2, 2, <List<int>>[
        <int>[255, 0, 0],
        <int>[0, 255, 0],
        <int>[0, 0, 255],
        <int>[255, 255, 255],
      ]);
      expect(
        averageColorOfRegion(
          image,
          const ui.Offset(0.5, 0.5),
          radiusFraction: 1,
        ),
        0xff7f7f7f,
      );
    });

    test('stays inside the picked region and clamps at the edges', () {
      final SampledImage image = imageFromRgb(4, 4, <List<int>>[
        for (var y = 0; y < 4; y++)
          for (var x = 0; x < 4; x++)
            x < 2 ? <int>[255, 0, 0] : <int>[0, 0, 255],
      ]);
      // The top-left corner samples only the red half.
      expect(
        averageColorOfRegion(image, const ui.Offset(0, 0), radiusFraction: 0.1),
        0xffff0000,
      );
      // The bottom-right corner samples only the blue half.
      expect(
        averageColorOfRegion(image, const ui.Offset(1, 1), radiusFraction: 0.1),
        0xff0000ff,
      );
    });

    test('alpha is ignored, the result is always opaque', () {
      final SampledImage image = sampledImage(3, 3, <int>[10, 20, 30]);
      final int colour = averageColorOfRegion(image, const ui.Offset(0.5, 0.5));
      expect(colour, 0xff0a141e);
    });
  });

  group('layout maths', () {
    test('containRect fits a wide image to the container width', () {
      expect(
        containRect(const ui.Size(200, 100), 2),
        const ui.Rect.fromLTWH(0, 0, 200, 100),
      );
    });

    test('containRect letterboxes a tall image', () {
      final ui.Rect rect = containRect(const ui.Size(200, 200), 0.5);
      expect(rect.left, 50);
      expect(rect.top, 0);
      expect(rect.width, 100);
      expect(rect.height, 200);
    });

    test('containRect degenerates safely', () {
      expect(containRect(ui.Size.zero, 1), ui.Rect.zero);
      expect(containRect(const ui.Size(10, 10), 0), ui.Rect.zero);
    });

    test('fractionForPoint maps and clamps points onto the image', () {
      const ui.Rect fitted = ui.Rect.fromLTWH(10, 20, 100, 50);
      expect(
        fractionForPoint(const ui.Offset(60, 45), fitted),
        const ui.Offset(0.5, 0.5),
      );
      expect(fractionForPoint(const ui.Offset(0, 0), fitted), ui.Offset.zero);
      expect(
        fractionForPoint(const ui.Offset(999, 999), fitted),
        const ui.Offset(1, 1),
      );
    });
  });

  group('decodePhoto', () {
    testWidgets('decodes a generated PNG and keeps its colours', (
      WidgetTester tester,
    ) async {
      final SampledImage? sampled = await tester.runAsync(
        () => decodePhoto(tinyPng),
      );
      expect(sampled, isNotNull);
      expect(sampled!.width, 8);
      expect(sampled.height, 8);
      expect(
        averageColorOfRegion(
          sampled,
          const ui.Offset(0.25, 0.5),
          radiusFraction: 0.1,
        ),
        0xffff0000,
      );
      expect(
        averageColorOfRegion(
          sampled,
          const ui.Offset(0.75, 0.5),
          radiusFraction: 0.1,
        ),
        0xff0000ff,
      );
    });

    testWidgets('downscales to maxDimension', (WidgetTester tester) async {
      final SampledImage? sampled = await tester.runAsync(
        () => decodePhoto(tinyPng, maxDimension: 4),
      );
      expect(sampled, isNotNull);
      expect(sampled!.width, 4);
      expect(sampled.height, 4);
    });

    testWidgets('rejects empty and unreadable bytes', (
      WidgetTester tester,
    ) async {
      await tester.runAsync(() async {
        await expectLater(
          decodePhoto(Uint8List(0)),
          throwsA(isA<PhotoDecodeException>()),
        );
        await expectLater(
          decodePhoto(Uint8List.fromList(<int>[1, 2, 3, 4])),
          throwsA(isA<PhotoDecodeException>()),
        );
      });
    });
  });
}
