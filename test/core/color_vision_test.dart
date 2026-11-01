import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/color_vision.dart';
import 'package:ink_lab/core/match_quality.dart';

String simulate(String hex, ColorVisionType type) =>
    ColorVision.simulate(hex, type);

void main() {
  group('ColorVision.simulate', () {
    test('the confusable threshold is the app very close band', () {
      expect(
        ColorVision.confusableThreshold,
        MatchQuality.veryClose.maxDeltaE,
      );
    });

    test('a colour that is not a colour comes back unchanged', () {
      for (final bad in ['', 'nope', '#12', 'zzzzzz']) {
        expect(simulate(bad, ColorVisionType.protanopia), bad, reason: bad);
      }
    });

    test('the simulated colour is six lower-case hex digits', () {
      final String seen = simulate('FF0000', ColorVisionType.protanopia);
      expect(seen, matches(RegExp(r'^[0-9a-f]{6}$')));
    });

    test('achromatopsia leaves only the lightness', () {
      for (final hex in ['ff0000', '00ff00', '0000ff', '123456', 'ffffff']) {
        final String seen = simulate(hex, ColorVisionType.achromatopsia);
        expect(seen.substring(0, 2), seen.substring(2, 4), reason: hex);
        expect(seen.substring(2, 4), seen.substring(4, 6), reason: hex);
      }
    });

    test('a colour stays a colour, opaque', () {
      expect(
        ColorVision.simulateInt(0x80ff0000, ColorVisionType.protanopia) >> 24,
        0xff,
      );
    });

    test('red and green get much closer under deuteranopia', () {
      final double original = ColorVision.distance('ff0000', '00ff00');
      final double simulated = ColorVision.distance(
        simulate('ff0000', ColorVisionType.deuteranopia),
        simulate('00ff00', ColorVisionType.deuteranopia),
      );
      expect(original, greaterThan(100));
      expect(simulated, lessThan(original / 2));
    });

    test('red and green stay apart under tritanopia', () {
      final double simulated = ColorVision.distance(
        simulate('ff0000', ColorVisionType.tritanopia),
        simulate('00ff00', ColorVisionType.tritanopia),
      );
      expect(simulated, greaterThan(60));
    });

    test('the simulation of a colour is not the colour itself', () {
      expect(
        simulate('ff0000', ColorVisionType.protanopia),
        isNot('ff0000'),
      );
      expect(
        simulate('ff0000', ColorVisionType.deuteranopia),
        isNot('ff0000'),
      );
    });
  });

  group('ColorVision.confusablePairs', () {
    test('an empty palette and a single colour have no pairs', () {
      expect(
        ColorVision.confusablePairs(
          const <String>[],
          type: ColorVisionType.deuteranopia,
        ),
        isEmpty,
      );
      expect(
        ColorVision.confusablePairs(
          const <String>['ff0000'],
          type: ColorVisionType.deuteranopia,
        ),
        isEmpty,
      );
    });

    test('red and green are a pair under deuteranopia', () {
      final pairs = ColorVision.confusablePairs(
        const <String>['ff0000', '00ff00'],
        type: ColorVisionType.deuteranopia,
        threshold: 30,
      );
      expect(pairs, hasLength(1));
      expect(pairs.single.firstIndex, 0);
      expect(pairs.single.secondIndex, 1);
      expect(pairs.single.firstHex, 'ff0000');
      expect(pairs.single.secondHex, '00ff00');
      expect(pairs.single.distance, lessThan(30));
      expect(pairs.single.originalDistance, greaterThan(100));
      expect(pairs.single.quality, MatchQuality.of(pairs.single.distance));
    });

    test('the same colours are always a pair', () {
      final pairs = ColorVision.confusablePairs(
        const <String>['ff0000', 'ff0000'],
        type: ColorVisionType.deuteranopia,
      );
      expect(pairs, hasLength(1));
      expect(pairs.single.distance, 0);
    });

    test('red and green are not a pair under tritanopia', () {
      expect(
        ColorVision.confusablePairs(
          const <String>['ff0000', '00ff00'],
          type: ColorVisionType.tritanopia,
          threshold: 30,
        ),
        isEmpty,
      );
    });

    test('the pairs come with the closest one first', () {
      final pairs = ColorVision.confusablePairs(
        const <String>['ff0000', '00ff00', 'ffff00'],
        type: ColorVisionType.deuteranopia,
        threshold: 60,
      );
      expect(pairs, isNotEmpty);
      for (int i = 1; i < pairs.length; i++) {
        expect(pairs[i].distance, greaterThanOrEqualTo(pairs[i - 1].distance));
      }
    });

    test('a colour that is not a colour is skipped', () {
      final pairs = ColorVision.confusablePairs(
        const <String>['ff0000', 'nope', '00ff00'],
        type: ColorVisionType.deuteranopia,
        threshold: 30,
      );
      expect(pairs, hasLength(1));
      expect(pairs.single.firstIndex, 0);
      expect(pairs.single.secondIndex, 2);
    });

    test('every type gets its own pairs', () {
      final byType = ColorVision.confusablePairsByType(
        const <String>['ff0000', '00ff00'],
        threshold: 30,
      );
      expect(byType.keys, ColorVisionType.values);
      expect(byType[ColorVisionType.deuteranopia], hasLength(1));
      expect(byType[ColorVisionType.tritanopia], isEmpty);
    });

    test('the distance of a colour that is not a colour is infinite', () {
      expect(ColorVision.distance('ff0000', 'nope'), double.infinity);
      expect(ColorVision.distance('ff0000', 'ff0000'), 0);
    });
  });
}
