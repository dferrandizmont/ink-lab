import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ui/pages/match/photo_box.dart';

double _height(
  double aspect, {
  double width = 358,
  double viewport = 800,
  double safe = 0,
}) => photoBoxHeight(
  width: width,
  aspectRatio: aspect,
  viewportHeight: viewport,
  safeAreaVertical: safe,
);

void main() {
  group('photoBoxHeight', () {
    test('a portrait photo fills the width', () {
      // 3:4 at 358 wide is 477.33 tall, under 60 % of 800 (480).
      expect(_height(3 / 4), closeTo(358 * 4 / 3, 1e-9));
    });

    test('a portrait photo is capped by the viewport share', () {
      // 9:16 would be 636 tall; 60 % of (800 - 100 safe) is 420.
      expect(_height(9 / 16, safe: 100), closeTo(420, 1e-9));
    });

    test('a portrait photo is capped by the absolute maximum', () {
      expect(_height(9 / 16, viewport: 3000), maxPhotoBoxHeight);
    });

    test('a wide photo keeps the minimum height', () {
      expect(_height(2), minPhotoBoxHeight);
      expect(_height(358 / 196), minPhotoBoxHeight);
    });

    test('a mildly landscape photo fills the width', () {
      expect(_height(4 / 3), closeTo(358 * 3 / 4, 1e-9));
    });

    test('a square photo follows the width between the limits', () {
      expect(_height(1), 358);
      expect(_height(1, width: 150), minPhotoBoxHeight);
    });

    test('an extreme panorama keeps the minimum height', () {
      expect(_height(10), minPhotoBoxHeight);
    });

    test('an extreme portrait stops at the cap', () {
      expect(_height(0.1, viewport: 3000), maxPhotoBoxHeight);
    });

    test('a tiny viewport never goes under the minimum', () {
      // 60 % of 240 would be 144, under 196.
      expect(_height(0.5, viewport: 240), minPhotoBoxHeight);
      expect(_height(0.5, viewport: 100, safe: 150), minPhotoBoxHeight);
    });

    test('without a usable ratio it is the minimum height', () {
      for (final double? ratio in <double?>[
        null,
        0,
        -1,
        double.nan,
        double.infinity,
      ]) {
        expect(
          photoBoxHeight(width: 358, aspectRatio: ratio, viewportHeight: 800),
          minPhotoBoxHeight,
        );
      }
    });

    test('a degenerate width gives the minimum height', () {
      expect(_height(0.5, width: 0), minPhotoBoxHeight);
      expect(_height(0.5, width: -5), minPhotoBoxHeight);
    });
  });
}
