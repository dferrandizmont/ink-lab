import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/color_utils.dart';
import 'package:ink_lab/core/white_balance.dart';

WhiteBalance balanceFor(String hex) {
  final fit = WhiteBalanceFit.fromReference(hexToColorInt(hex));
  expect(fit, isA<WhiteBalanceApplied>(), reason: hex);
  return (fit as WhiteBalanceApplied).balance;
}

WhiteBalanceRejection? rejectionFor(String hex) {
  final fit = WhiteBalanceFit.fromReference(hexToColorInt(hex));
  return fit is WhiteBalanceRejected ? fit.reason : null;
}

void main() {
  group('WhiteBalance', () {
    test('the identity changes nothing and is opaque', () {
      expect(WhiteBalance.identity.isIdentity, isTrue);
      expect(WhiteBalance.identity.apply(0xFF336699), 0xFF336699);
      expect(WhiteBalance.identity.apply(0x00336699), 0xFF336699);
    });

    test('the tapped point becomes white', () {
      for (final hex in ['f2e6d0', 'dcdcdc', 'c9d4e8', 'ffffff', 'e8e8e8']) {
        final balance = balanceFor(hex);
        final white = colorIntToRgb(balance.apply(hexToColorInt(hex)));
        expect(white.r, greaterThanOrEqualTo(254), reason: hex);
        expect(white.g, greaterThanOrEqualTo(254), reason: hex);
        expect(white.b, greaterThanOrEqualTo(254), reason: hex);
      }
    });

    test('a warm paper loses its cast and other colours follow', () {
      final balance = balanceFor('f2dcb4');
      // A neutral grey under the same light looks warm; it comes back neutral.
      final warmGrey = hexToColorInt('8a7a5f');
      final fixed = colorIntToRgb(balance.apply(warmGrey));
      expect((fixed.r - fixed.g).abs(), lessThan(24));
      expect((fixed.g - fixed.b).abs(), lessThan(24));
      // Blue is boosted more than red, as the gains say.
      expect(balance.gainB, greaterThan(balance.gainR));
    });

    test('an already neutral white is a no-op', () {
      final balance = balanceFor('ffffff');
      expect(balance.isIdentity, isTrue);
      expect(balance.apply(0xFF123456), 0xFF123456);
    });

    test('gains are applied on linear light, not on sRGB values', () {
      final balance = balanceFor('b4b4b4');
      final expected = encodeSrgbChannel(
        linearizeSrgbChannel(0x80 / 255) / linearizeSrgbChannel(0xb4 / 255),
      );
      final r = colorIntToRgb(balance.apply(0xFF808080)).r;
      expect(r, (expected * 255).round());
    });

    test('never overflows: results stay in range', () {
      final balance = balanceFor('9a9a9a');
      final out = colorIntToRgb(balance.apply(0xFFFFFFFF));
      expect([out.r, out.g, out.b], [255, 255, 255]);
    });

    test('the preview matrix carries the three gains', () {
      final balance = balanceFor('f2dcb4');
      final m = balance.linearMatrix;
      expect(m, hasLength(20));
      expect(
        [m[0], m[6], m[12], m[18]],
        [balance.gainR, balance.gainG, balance.gainB, 1],
      );
      expect(m.where((v) => v != 0).length, 4);
    });

    test('equal gains are equal balances', () {
      expect(balanceFor('f2dcb4'), balanceFor('f2dcb4'));
      expect(balanceFor('f2dcb4').hashCode, balanceFor('f2dcb4').hashCode);
      expect(balanceFor('f2dcb4'), isNot(balanceFor('e0e0e0')));
    });
  });

  group('WhiteBalanceFit', () {
    test('a dark point is refused as too dark', () {
      expect(rejectionFor('202020'), WhiteBalanceRejection.tooDark);
      expect(rejectionFor('000000'), WhiteBalanceRejection.tooDark);
      expect(rejectionFor('5a5a5a'), WhiteBalanceRejection.tooDark);
    });

    test('a vivid point is refused as too colourful', () {
      expect(rejectionFor('ffe610'), WhiteBalanceRejection.tooColourful);
      expect(rejectionFor('ff5050'), WhiteBalanceRejection.tooColourful);
      expect(rejectionFor('80f0ff'), WhiteBalanceRejection.tooColourful);
    });

    test('middle grey is the floor for a paper', () {
      expect(rejectionFor('7c7c7c'), WhiteBalanceRejection.tooDark);
      expect(rejectionFor('8a8a8a'), isNull);
    });

    test('accepted gains stay inside the sane range', () {
      for (final hex in ['8a8a8a', 'f2dcb4', 'a8b4c8', 'ffffff', 'e6c8a0']) {
        final b = balanceFor(hex);
        for (final g in [b.gainR, b.gainG, b.gainB]) {
          expect(
            g,
            inInclusiveRange(WhiteBalance.minGain, WhiteBalance.maxGain),
          );
        }
      }
    });
  });
}
