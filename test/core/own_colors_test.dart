import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/own_colors.dart';

import 'fixtures.dart';

final class _Source implements OwnColorSource {
  _Source(this.activeOwnColors, this.revision);

  @override
  Map<String, String> activeOwnColors;

  @override
  int revision;
}

String catalogue() => jsonEncode([
  color('R1', 'aa1122').toJson(),
  color('G1', '00ff00').toJson(),
]);

void main() {
  group('normalizeOwnHex', () {
    test('accepts 3 and 6 digits, with or without #, any case', () {
      expect(normalizeOwnHex('#A1B2C3'), 'a1b2c3');
      expect(normalizeOwnHex(' a1b2c3 '), 'a1b2c3');
      expect(normalizeOwnHex('#F0A'), 'ff00aa');
      expect(normalizeOwnHex('fa0'), 'ffaa00');
    });

    test('refuses anything else', () {
      for (final bad in [
        '',
        '#',
        '12345',
        '1234567',
        'ggg',
        '#12 456',
        'zzzzzz',
      ]) {
        expect(normalizeOwnHex(bad), isNull, reason: bad);
      }
    });
  });

  group('applyOwnColors', () {
    final colors = [color('R1', 'aa1122'), color('G1', '00ff00')];

    test('swaps the hex of the marker and remembers the catalogue one', () {
      final out = applyOwnColors(colors, {'ohuhu_oahu:R1': '112233'});
      expect(out[0].hex, '112233');
      expect(out[0].catalogHex, 'aa1122');
      expect(out[0].hasOwnColor, isTrue);
      expect(out[0].originalHex, 'aa1122');
      expect(out[1], same(colors[1]));
      expect(out[1].hasOwnColor, isFalse);
      expect(out[1].originalHex, '00ff00');
    });

    test('the brand is part of the key', () {
      final out = applyOwnColors(colors, {'decotime:R1': '112233'});
      expect(out, same(colors));
    });

    test(
      'an entry equal to the catalogue, or not a colour, changes nothing',
      () {
        final out = applyOwnColors(colors, {
          'ohuhu_oahu:R1': 'AA1122',
          'ohuhu_oahu:G1': 'nope',
        });
        expect(out, same(colors));
      },
    );

    test('no colours of their own gives the same list back', () {
      expect(applyOwnColors(colors, const {}), same(colors));
    });

    test('the own colour never reaches the JSON', () {
      final own = colors.first.withOwnHex('112233');
      expect(own.toJson()['hex'], '112233');
      expect(own.toJson().containsKey('catalogHex'), isFalse);
      // Applying twice keeps the first catalogue hex.
      expect(own.withOwnHex('445566').catalogHex, 'aa1122');
    });
  });

  group('MarkerRepository with own colours', () {
    MarkerRepository repo(OwnColorSource? source) {
      final repository = MarkerRepository(loadAsset: (_) => catalogue());
      repository.ownColors = source;
      return repository;
    }

    test('loadColors is the single point that applies them', () async {
      final repository = repo(_Source({'ohuhu_oahu:R1': '112233'}, 3));
      final colors = await repository.loadColors(MarkerBrand.ohuhuOahu);
      expect(colors.first.hex, '112233');
      expect(colors.first.catalogHex, 'aa1122');
    });

    test('the same future comes back until the revision changes', () async {
      final source = _Source({'ohuhu_oahu:R1': '112233'}, 3);
      final repository = repo(source);
      final first = repository.loadColors(MarkerBrand.ohuhuOahu);
      expect(repository.loadColors(MarkerBrand.ohuhuOahu), same(first));

      source
        ..activeOwnColors = {'ohuhu_oahu:R1': '445566'}
        ..revision = 4;
      final second = repository.loadColors(MarkerBrand.ohuhuOahu);
      expect(second, isNot(same(first)));
      expect((await second).first.hex, '445566');
      // The first answer is not rewritten behind its owner's back.
      expect((await first).first.hex, '112233');
    });

    test(
      'without colours of their own the catalogue is returned as is',
      () async {
        final repository = repo(_Source(const {}, 1));
        final plain = repository.loadColors(MarkerBrand.ohuhuOahu);
        expect(repository.loadColors(MarkerBrand.ohuhuOahu), same(plain));
        expect((await plain).first.hex, 'aa1122');
        expect((await plain).first.hasOwnColor, isFalse);
      },
    );

    test(
      'peekColors answers at once once the catalogue is in memory',
      () async {
        final source = _Source({'ohuhu_oahu:R1': '112233'}, 3);
        final repository = repo(source);
        expect(repository.peekColors(MarkerBrand.ohuhuOahu), isNull);
        await repository.loadColors(MarkerBrand.ohuhuOahu);
        expect(
          repository.peekColors(MarkerBrand.ohuhuOahu)!.first.hex,
          '112233',
        );
        source
          ..activeOwnColors = const {}
          ..revision = 4;
        expect(
          repository.peekColors(MarkerBrand.ohuhuOahu)!.first.hex,
          'aa1122',
        );
      },
    );

    test('colorRevision follows the source', () {
      expect(repo(_Source(const {}, 7)).colorRevision, 7);
      expect(repo(null).colorRevision, 0);
    });

    test(
      'replacing the source forgets what was cached for the old one',
      () async {
        final repository = repo(_Source({'ohuhu_oahu:R1': '112233'}, 3));
        await repository.loadColors(MarkerBrand.ohuhuOahu);
        repository.ownColors = _Source({'ohuhu_oahu:R1': '778899'}, 3);
        expect(
          (await repository.loadColors(MarkerBrand.ohuhuOahu)).first.hex,
          '778899',
        );
      },
    );
  });
}
