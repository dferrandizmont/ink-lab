import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/color_utils.dart';
import 'package:ink_lab/core/match_quality.dart';
import 'package:ink_lab/core/photo_palette.dart';

import 'fixtures.dart';

/// A raw RGBA buffer of [width] x [height] pixels, one colour per pixel.
Uint8List _image(int width, int height, List<int> argb) {
  final rgba = Uint8List(width * height * 4);
  for (var i = 0; i < width * height; i++) {
    final color = argb[i];
    rgba[i * 4] = (color >> 16) & 255;
    rgba[i * 4 + 1] = (color >> 8) & 255;
    rgba[i * 4 + 2] = color & 255;
    rgba[i * 4 + 3] = (color >> 24) & 255;
  }
  return rgba;
}

/// A raw RGBA buffer made of bands of colours, in order.
Uint8List _bands(int width, int height, List<({int argb, int pixels})> bands) {
  final pixels = <int>[];
  for (final band in bands) {
    pixels.addAll(List<int>.filled(band.pixels, band.argb));
  }
  return _image(width, height, pixels);
}

/// ΔE76 between a photo colour and the expected hex.
double _distanceTo(int colorInt, String hex) =>
    deltaE76(colorIntToLab(colorInt), hexToLab(hex));

void main() {
  test('a uniform photo gives one colour with the whole share', () {
    final rgba = _image(8, 8, List<int>.filled(64, 0xffff0000));
    final colors = extractDominantColors(rgba, 8, 8);
    expect(colors, hasLength(1));
    expect(colors.single.colorInt, 0xffff0000);
    expect(colors.single.share, 1.0);
  });

  test('three colour bands come back in share order', () {
    final rgba = _bands(10, 10, [
      (argb: 0xffff0000, pixels: 50),
      (argb: 0xff0000ff, pixels: 30),
      (argb: 0xff00ff00, pixels: 20),
    ]);
    final colors = extractDominantColors(rgba, 10, 10);
    expect(colors, hasLength(3));
    expect(colors[0].share, closeTo(0.5, 0.001));
    expect(colors[1].share, closeTo(0.3, 0.001));
    expect(colors[2].share, closeTo(0.2, 0.001));
    expect(_distanceTo(colors[0].colorInt, 'ff0000'), lessThan(2));
    expect(_distanceTo(colors[1].colorInt, '0000ff'), lessThan(2));
    expect(_distanceTo(colors[2].colorInt, '00ff00'), lessThan(2));
  });

  test('transparent pixels are ignored', () {
    final rgba = _bands(10, 10, [
      (argb: 0xffff0000, pixels: 40),
      (argb: 0x0000ff00, pixels: 30), // fully transparent
      (argb: 0x7f0000ff, pixels: 20), // alpha 127, ignored
      (argb: 0x8000ffff, pixels: 10), // alpha 128, visible
    ]);
    final colors = extractDominantColors(rgba, 10, 10);
    expect(colors, hasLength(2));
    final hexes = colors.map((tone) => colorIntToHex(tone.colorInt)).toSet();
    expect(hexes, contains('FF0000'));
    expect(hexes, contains('00FFFF')); // alpha 128 is visible
    expect(hexes, isNot(contains('0000FF'))); // alpha 127 is ignored
    expect(hexes, isNot(contains('00FF00'))); // fully transparent is ignored
    // The ignored pixels do not count in the share either.
    expect(colors.first.share, closeTo(0.8, 0.001));
  });

  test('a fully transparent photo gives no colours', () {
    final rgba = _image(4, 4, List<int>.filled(16, 0x00ff0000));
    expect(extractDominantColors(rgba, 4, 4), isEmpty);
  });

  test('two near-identical shades are merged into one colour', () {
    final rgba = _bands(10, 10, [
      (argb: 0xffc8c8c8, pixels: 50),
      (argb: 0xffcccccc, pixels: 50),
    ]);
    final colors = extractDominantColors(rgba, 10, 10);
    expect(colors, hasLength(1));
    expect(colors.single.share, closeTo(1.0, 0.001));
  });

  test('a small vivid accent survives next to near-greys', () {
    final rgba = _bands(10, 10, [
      (argb: 0xff3a3a3a, pixels: 45),
      (argb: 0xff6a6a6a, pixels: 25),
      (argb: 0xff9a9a9a, pixels: 15),
      (argb: 0xffc4c4c4, pixels: 12),
      (argb: 0xffff7a00, pixels: 3),
    ]);
    final colors = extractDominantColors(rgba, 10, 10, count: 4);
    expect(colors, hasLength(4));
    // The accent is the smallest colour, but it takes the slot of a near-grey.
    expect(colors.last.share, closeTo(0.03, 0.001));
    expect(_distanceTo(colors.last.colorInt, 'ff7a00'), lessThan(2));
  });

  test('a vivid accent never replaces the only colour', () {
    final rgba = _bands(10, 10, [
      (argb: 0xff8a8a8a, pixels: 97),
      (argb: 0xffff7a00, pixels: 3),
    ]);
    final colors = extractDominantColors(rgba, 10, 10, count: 1);
    expect(colors, hasLength(1));
    expect(colors.single.share, closeTo(0.97, 0.001));
    expect(_distanceTo(colors.single.colorInt, '8a8a8a'), lessThan(2));
    // A count below one is clamped to one, with the same result.
    expect(extractDominantColors(rgba, 10, 10, count: 0), hasLength(1));
  });

  test('a small saturated accent survives among sunset tones', () {
    final rgba = _bands(10, 10, [
      (argb: 0xffc1440e, pixels: 38),
      (argb: 0xffe88d24, pixels: 27),
      (argb: 0xff8c3b0b, pixels: 15),
      (argb: 0xfff2b872, pixels: 10),
      (argb: 0xff6b2d0f, pixels: 7),
      (argb: 0xff0033ff, pixels: 3),
    ]);
    final colors = extractDominantColors(rgba, 10, 10, count: 5);
    expect(colors, hasLength(5));
    // The dominant tones are untouched.
    expect(colors.first.share, closeTo(0.38, 0.001));
    expect(_distanceTo(colors.first.colorInt, 'c1440e'), lessThan(3));
    // The blue takes the slot of the tone it repeats the most.
    expect(colors.last.share, closeTo(0.03, 0.001));
    expect(_distanceTo(colors.last.colorInt, '0033ff'), lessThan(3));
    // Without a limit there are six tones: the blue is the last one, so it
    // only survives in five colours by replacing a redundant tone.
    expect(extractDominantColors(rgba, 10, 10, count: 8), hasLength(6));
  });

  test('the same photo always gives the same colours', () {
    final rgba = _bands(10, 10, [
      (argb: 0xff3a3a3a, pixels: 45),
      (argb: 0xff6a6a6a, pixels: 25),
      (argb: 0xff9a9a9a, pixels: 15),
      (argb: 0xffc4c4c4, pixels: 12),
      (argb: 0xffff7a00, pixels: 3),
    ]);
    final first = extractDominantColors(rgba, 10, 10);
    final second = extractDominantColors(rgba, 10, 10);
    expect(first.length, second.length);
    for (var i = 0; i < first.length; i++) {
      expect(first[i].colorInt, second[i].colorInt);
      expect(first[i].share, second[i].share);
    }
  });

  test('the number of colours is clamped between one and eight', () {
    final rgba = _bands(10, 10, [
      for (var hue = 0; hue < 10; hue++)
        (argb: hsvToRgb(hue * 36.0, 1, 1).colorInt, pixels: 10),
    ]);
    expect(extractDominantColors(rgba, 10, 10, count: 0), hasLength(1));
    expect(extractDominantColors(rgba, 10, 10, count: 20), hasLength(8));
  });

  test('every photo colour takes a different marker', () {
    final colors = [
      const PhotoColor(colorInt: 0xffff0000, share: 0.5),
      const PhotoColor(colorInt: 0xff0000ff, share: 0.5),
    ];
    final owned = [color('red', 'ff0000'), color('blue', '0000ff')];
    final picks = matchPhotoColorsToMarkers(colors, owned);
    expect(picks, hasLength(2));
    expect(picks[0].marker.newCode, 'red');
    expect(picks[1].marker.newCode, 'blue');
    expect(picks[0].deltaE, 0);
    // The same metric the Match page reads.
    expect(MatchQuality.of(picks[0].deltaE), MatchQuality.nearlyExact);
  });

  test('a colour whose nearest marker is taken takes the nearest free one', () {
    final colors = [
      const PhotoColor(colorInt: 0xffff0000, share: 0.5),
      const PhotoColor(colorInt: 0xfff01000, share: 0.5),
    ];
    final owned = [
      color('red', 'ff0000'),
      color('far red', '7f0000'), // free, but the farthest of the two
      color('near red', 'ff1a00'), // free and the nearest one
    ];
    final picks = matchPhotoColorsToMarkers(colors, owned);
    expect(picks, hasLength(2));
    expect(picks[0].marker.newCode, 'red');
    expect(picks[1].marker.newCode, 'near red');
    // The metric is a real distance, not an exact match.
    final expected = deltaE76(hexToLab('f01000'), hexToLab('ff1a00'));
    expect(expected, greaterThan(0));
    expect(picks[1].deltaE, closeTo(expected, 0.001));
  });

  test('the same marker twice in owned is only used once', () {
    final colors = [
      const PhotoColor(colorInt: 0xffff0000, share: 0.5),
      const PhotoColor(colorInt: 0xff0000ff, share: 0.5),
    ];
    final red = color('red', 'ff0000');
    final owned = [red, red, color('blue', '0000ff')];
    final picks = matchPhotoColorsToMarkers(colors, owned);
    expect(picks, hasLength(2));
    expect(picks[0].marker.newCode, 'red');
    expect(picks[1].marker.newCode, 'blue');
    expect(picks[0].marker.colorId, isNot(picks[1].marker.colorId));
  });

  test('two markers with the same brand and code are one marker', () {
    final colors = [
      const PhotoColor(colorInt: 0xffff0000, share: 0.5),
      const PhotoColor(colorInt: 0xff0000ff, share: 0.5),
    ];
    // The same marker twice, as two separate objects.
    final owned = [
      color('red', 'ff0000'),
      color('red', 'ff0000'),
      color('blue', '0000ff'),
    ];
    final picks = matchPhotoColorsToMarkers(colors, owned);
    expect(picks, hasLength(2));
    expect(picks[0].marker.newCode, 'red');
    expect(picks[1].marker.newCode, 'blue');
    expect(picks[0].marker.colorId, isNot(picks[1].marker.colorId));
  });

  test('the same code in two brands is two markers', () {
    final colors = [
      const PhotoColor(colorInt: 0xffff0000, share: 0.5),
      const PhotoColor(colorInt: 0xfff01000, share: 0.5),
    ];
    final owned = [
      color('red', 'ff0000', brandId: 'ohuhu_oahu'),
      color('red', 'ff0000', brandId: 'deco_time'),
    ];
    final picks = matchPhotoColorsToMarkers(colors, owned);
    expect(picks, hasLength(2));
    expect(picks.map((pick) => pick.marker.brandId), [
      'ohuhu_oahu',
      'deco_time',
    ]);
  });

  test('without owned markers there are no picks', () {
    expect(
      matchPhotoColorsToMarkers(const [
        PhotoColor(colorInt: 0xffff0000, share: 1),
      ], const []),
      isEmpty,
    );
  });

  test('more colours than markers gives one pick per marker', () {
    final colors = [
      const PhotoColor(colorInt: 0xffff0000, share: 0.4),
      const PhotoColor(colorInt: 0xff00ff00, share: 0.3),
      const PhotoColor(colorInt: 0xff0000ff, share: 0.3),
    ];
    final owned = [color('red', 'ff0000'), color('green', '00ff00')];
    final picks = matchPhotoColorsToMarkers(colors, owned);
    expect(picks, hasLength(2));
    expect(picks.map((pick) => pick.marker.newCode), ['red', 'green']);
  });
}
