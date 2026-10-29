import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/color_utils.dart';

import 'fixtures.dart';

void main() {
  final cases = [
    ('000000', [0.0, 0.0, 0.0], [0.0, 0.0, 0.0], [0.0, 0.0, 0.0]),
    ('ffffff', [0.0, 0.0, 1.0], [0.0, 0.0, 1.0], [100.0, 0.0053, -0.0104]),
    ('ff0000', [0.0, 1.0, 1.0], [0.0, 1.0, 0.5], [53.2329, 80.1093, 67.2201]),
    (
      '00ff00',
      [120.0, 1.0, 1.0],
      [120.0, 1.0, 0.5],
      [87.7370, -86.1846, 83.1812],
    ),
    (
      '0000ff',
      [240.0, 1.0, 1.0],
      [240.0, 1.0, 0.5],
      [32.3026, 79.1967, -107.8637],
    ),
    (
      '808080',
      [0.0, 0.0, 128 / 255],
      [0.0, 0.0, 128 / 255],
      [53.5850, 0.0032, -0.0062],
    ),
  ];
  for (final (hex, hsv, hsl, lab) in cases) {
    test('$hex known HSV/HSL/CIELAB values and inverse conversions', () {
      final actualHsv = hexToHsv(hex);
      final actualHsl = hexToHsl(hex);
      final actualLab = hexToLab(hex);
      for (var i = 0; i < 3; i++) {
        expect(actualHsv[i], closeTo(hsv[i], 1e-8));
        expect(actualHsl[i], closeTo(hsl[i], 1e-8));
      }
      expect(actualLab.l, closeTo(lab[0], 0.001));
      expect(actualLab.a, closeTo(lab[1], 0.001));
      expect(actualLab.b, closeTo(lab[2], 0.001));
      expect(rgbToHex(hexToRgb(hex)), hex.toUpperCase());
      expect(rgbToHex(hsvToRgb(hsv[0], hsv[1], hsv[2])), hex.toUpperCase());
      expect(rgbToHex(hslToRgb(hsl[0], hsl[1], hsl[2])), hex.toUpperCase());
      expect(rgbToHex(labToRgb(actualLab)), hex.toUpperCase());
      expect(rgbToHex(oklabToRgb(hexToOklab(hex))), hex.toUpperCase());
    });
  }
  test(
    'hex parsing follows Android numeric forms and ignores alpha for RGB',
    () {
      expect(hexToColorInt('#12aBcD'), 0xff12abcd);
      for (final shorthand in ['#aBc', '0xaBc', '0XaBc', 'aBc']) {
        expect(hexToColorInt(shorthand), 0xffaabbcc);
      }
      expect(hexToColorInt('0x12aBcD'), 0xff12abcd);
      expect(hexToColorInt('0X8012aBcD'), 0x8012abcd);
      expect(hexToColorInt('#8012aBcD'), 0x8012abcd);
      expect(colorIntToHex(hexToColorInt('#0012abcd')), '12ABCD');
      for (final invalid in [
        '#ffff',
        '0x12345',
        '0x',
        '#0xff0000',
        'red',
        '12345',
        'gg0000',
        ' ff0000',
        '',
      ]) {
        expect(() => hexToColorInt(invalid), throwsFormatException);
      }
      expect(hueDistance(355, 5), 10);
      expect(isColorDark('909090'), isTrue);
      expect(isColorDark('919191'), isFalse);
      expect(isColorDark('ff0000'), isTrue);
    },
  );
  test('sRGB piecewise boundary and HSL hue wrapping', () {
    expect(linearizeSrgbChannel(0.04045), closeTo(0.04045 / 12.92, 1e-12));
    expect(rgbToHex(hslToRgb(-120, 1, 0.5)), '0000FF');
    expect(rgbToHex(hsvToRgb(480, 1, 1)), '00FF00');
  });
  test('OKLab known red and white, distance units and CIE76 reference', () {
    final red = hexToOklab('ff0000');
    expect(red.l, closeTo(0.62795536, 1e-7));
    expect(red.a, closeTo(0.22486306, 1e-7));
    expect(red.b, closeTo(0.12584630, 1e-7));
    final white = hexToOklab('ffffff');
    expect(white.l, closeTo(1, 1e-7));
    expect(white.a, closeTo(0, 1e-7));
    expect(white.b, closeTo(0, 1e-7));
    expect(deltaEOklab(white, hexToOklab('000000')), closeTo(1, 1e-7));
    expect(deltaE76(const LabColor(10, 20, 30), const LabColor(13, 24, 30)), 5);
    expect(deltaE76(hexToLab('abcdef'), hexToLab('abcdef')), 0);
  });
  test(
    'closest matches skip invalid hex, keep tie order and clamp limit to one',
    () {
      final colors = [
        color('bad', 'broken'),
        color('white', 'ffffff'),
        color('first', 'ff0000'),
        color('second', '#ff0000'),
      ];
      final matches = findClosestMarkerMatches(0xffff0000, colors);
      expect(matches.map((m) => m.color.newCode), ['first', 'second', 'white']);
      expect(matches.first.deltaE, 0);
      expect(findClosestMarkerMatches(0xffff0000, colors, limit: 0).length, 1);
      expect(findClosestMarkerMatches(0, []), isEmpty);
    },
  );
  test('closest matches return six by default and honor explicit limits', () {
    final candidates = List.generate(8, (i) => color('R$i', 'ff0000'));
    expect(
      findClosestMarkerMatches(0xffff0000, candidates).map((m) => m.color),
      candidates.take(6),
    );
    expect(
      findClosestMarkerMatches(0xffff0000, candidates, limit: 8).length,
      8,
    );
  });
}
