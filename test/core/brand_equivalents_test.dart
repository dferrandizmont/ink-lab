import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/brand_equivalents.dart';
import 'package:ink_lab/core/color_utils.dart';
import 'package:ink_lab/core/match_quality.dart';
import 'package:ink_lab/core/models.dart';

import 'fixtures.dart';

/// A small catalogue with the three brands: two reds and a green of Ohuhu, a
/// red, a dark red and a green of DecoTime, and a blue of Copic.
List<MarkerColor> catalogue() => <MarkerColor>[
  color('R1', 'ff0000'),
  color('R2', 'fe0000'),
  color('G1', '00ff00'),
  color('B1', '0000ff'),
  color('01', 'ff0000', brandId: 'decotime'),
  color('02', 'ee1100', brandId: 'decotime'),
  color('03', '00ff00', brandId: 'decotime'),
  color('04', '0000ff', brandId: 'copic'),
];

void main() {
  group('BrandEquivalentFinder', () {
    test('an empty catalogue has no equivalents', () {
      final finder = BrandEquivalentFinder(const <MarkerColor>[]);
      expect(finder.brands, isEmpty);
      expect(finder.closestTo(color('R1', 'ff0000')), isEmpty);
    });

    test('a catalogue with one brand offers nothing of that brand', () {
      final finder = BrandEquivalentFinder(<MarkerColor>[
        color('R1', 'ff0000'),
      ]);
      expect(finder.brands, ['ohuhu_oahu']);
      expect(finder.closestTo(color('R1', 'ff0000')), isEmpty);
    });

    test('a marker of another brand still finds the ones of the catalogue', () {
      final finder = BrandEquivalentFinder(<MarkerColor>[
        color('R1', 'ff0000'),
      ]);
      final groups = finder.closestTo(
        color('01', 'ff0000', brandId: 'decotime'),
      );
      expect(groups.single.brandId, 'ohuhu_oahu');
      expect(groups.single.brand, MarkerBrand.ohuhuOahu);
      expect(groups.single.closest!.color.newCode, 'R1');
    });

    test('the closest marker of every other brand comes first', () {
      final finder = BrandEquivalentFinder(catalogue());
      final groups = finder.closestTo(catalogue().first);
      expect(groups.map((BrandEquivalentGroup g) => g.brandId), [
        'decotime',
        'copic',
      ]);
      final decotime = groups.first;
      expect(
        decotime.matches.map((BrandEquivalent m) => m.color.newCode),
        ['01', '02', '03'],
      );
      expect(decotime.matches.first.deltaE, 0);
      expect(decotime.matches.first.quality, MatchQuality.nearlyExact);
      expect(groups.last.matches.single.color.newCode, '04');
    });

    test('the groups come in the app brand order', () {
      final finder = BrandEquivalentFinder(<MarkerColor>[
        color('04', '0000ff', brandId: 'copic'),
        color('01', 'ff0000', brandId: 'decotime'),
        color('R1', 'ff0000'),
      ]);
      expect(finder.brands, ['ohuhu_oahu', 'decotime', 'copic']);
      final groups = finder.closestTo(color('Z9', '123456', brandId: 'copic'));
      expect(groups.map((BrandEquivalentGroup g) => g.brandId), [
        'ohuhu_oahu',
        'decotime',
      ]);
    });

    test('the limit says how many markers each brand gets', () {
      final finder = BrandEquivalentFinder(catalogue());
      expect(
        finder.closestTo(catalogue().first, limit: 1).first.matches,
        hasLength(1),
      );
      expect(finder.closestTo(catalogue().first, limit: 0), isEmpty);
    });

    test('only the markers the user owns are offered', () {
      final finder = BrandEquivalentFinder(catalogue());
      final groups = finder.closestTo(
        catalogue().first,
        ownedIds: <String>{'decotime:03', 'copic:04'},
      );
      expect(
        groups.first.matches.map((BrandEquivalent m) => m.color.newCode),
        ['03'],
      );
      expect(groups.last.matches.single.color.newCode, '04');
    });

    test('with no owned marker there is no group at all', () {
      final finder = BrandEquivalentFinder(catalogue());
      final groups = finder.closestTo(
        catalogue().first,
        ownedIds: const <String>{},
      );
      expect(groups, isEmpty);
    });

    test('the dried-out markers are left out', () {
      final finder = BrandEquivalentFinder(catalogue());
      final groups = finder.closestTo(
        catalogue().first,
        skipDried: true,
        driedIds: const <String>{'decotime:01'},
      );
      expect(
        groups.first.matches.map((BrandEquivalent m) => m.color.newCode),
        ['02', '03'],
      );
      // Without the switch the dried marker is there again.
      expect(
        finder
            .closestTo(catalogue().first)
            .first
            .matches
            .map((BrandEquivalent m) => m.color.newCode),
        ['01', '02', '03'],
      );
    });

    test('the colour the user stored is the one that counts', () {
      final finder = BrandEquivalentFinder(
        catalogue(),
        ownColors: const <String, String>{'ohuhu_oahu:R1': '00ff00'},
      );
      final groups = finder.closestTo(catalogue().first);
      // The marker is green now, so the green of DecoTime is the closest.
      expect(
        groups.first.matches.map((BrandEquivalent m) => m.color.newCode),
        ['03', '02', '01'],
      );
      expect(groups.first.matches.first.deltaE, 0);
    });

    test('the colours are copied, so a later change changes nothing', () {
      final Map<String, String> own = <String, String>{
        'ohuhu_oahu:R1': '00ff00',
      };
      final finder = BrandEquivalentFinder(catalogue(), ownColors: own);

      // The map the caller keeps changes: the finder still answers with the
      // colours it was built with, so both sides of the comparison are of the
      // same revision.
      own['ohuhu_oahu:R1'] = '0000ff';

      final groups = finder.closestTo(catalogue().first);
      expect(groups.first.matches.first.color.newCode, '03');
      expect(groups.first.matches.first.deltaE, 0);
    });

    test('a marker with a colour of its own keeps it', () {
      final finder = BrandEquivalentFinder(
        catalogue(),
        ownColors: const <String, String>{'decotime:02': '112233'},
      );
      final match = finder
          .closestTo(catalogue().first)
          .first
          .matches
          .firstWhere((BrandEquivalent m) => m.color.newCode == '02');
      expect(match.color.hex, '112233');
      expect(match.color.catalogHex, 'ee1100');
      expect(match.color.originalHex, 'ee1100');
    });

    test('a broken colour is left out of the catalogue', () {
      final finder = BrandEquivalentFinder(<MarkerColor>[
        color('X1', 'not-a-colour'),
        color('01', 'ff0000', brandId: 'decotime'),
      ]);
      expect(finder.brands, ['decotime']);
      // The broken marker is not in any group: it is not a colour.
      expect(
        finder
            .closestTo(color('R1', 'ff0000'))
            .single
            .matches
            .map((BrandEquivalent m) => m.color.newCode),
        ['01'],
      );
    });

    test('the distance is the one the app uses everywhere', () {
      final finder = BrandEquivalentFinder(catalogue());
      final match = finder
          .closestTo(catalogue().first)
          .first
          .matches
          .firstWhere((BrandEquivalent m) => m.color.newCode == '02');
      expect(
        match.deltaE,
        closeTo(deltaE76(hexToLab('ff0000'), hexToLab('ee1100')), 1e-9),
      );
      expect(match.quality, MatchQuality.of(match.deltaE));
    });

    test('a marker that is not in the catalogue can be asked about', () {
      final finder = BrandEquivalentFinder(catalogue());
      final groups = finder.closestTo(color('Z9', '00ff00', brandId: 'copic'));
      expect(groups.map((BrandEquivalentGroup g) => g.brandId), [
        'ohuhu_oahu',
        'decotime',
      ]);
      expect(groups.first.matches.first.color.newCode, 'G1');
    });
  });
}
