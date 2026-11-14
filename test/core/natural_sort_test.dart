import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/natural_sort.dart';

final List<String> _edgeCases = <String>[
  '',
  'A',
  'a',
  'A01',
  'A1',
  'A001B',
  '10',
  '9',
  'BV04',
  'Y0',
  '0.5',
  '01',
  'R${'9' * 30}',
  'R${'1' * 30}',
  'ß',
  'SS',
  'ss',
  'ẞ',
  'ﬁ',
  'FI',
  'fi',
  '١٢',
  '１２',
  'A١',
  'AB',
  'ABC',
  'A',
  'A1',
  '000000000000000000000012',
  '12',
];

int _legacy(String left, String right) {
  final tokens = RegExp(r'\d+|\D+');
  final a = tokens.allMatches(left.toUpperCase()).map((m) => m[0]!).toList();
  final b = tokens.allMatches(right.toUpperCase()).map((m) => m[0]!).toList();
  for (var i = 0; i < a.length && i < b.length; i++) {
    final numericA = BigInt.tryParse(a[i]);
    final numericB = BigInt.tryParse(b[i]);
    final result = numericA != null && numericB != null
        ? numericA.compareTo(numericB)
        : a[i].compareTo(b[i]);
    if (result != 0) return result;
  }
  return a.length.compareTo(b.length);
}

void main() {
  test('naturalCodeComparator agrees with the legacy oracle on real catalog codes', () {
    final codes = <String>[];
    for (final brand in <MarkerBrand>[
      MarkerBrand.ohuhuOahu,
      MarkerBrand.copic,
      MarkerBrand.decoTime,
      MarkerBrand.prismacolor,
    ]) {
      final raw = File(brand.assetPath).readAsStringSync();
      final colors = parseColors(raw, brand: brand);
      codes.addAll(colors.map((c) => c.newCode));
    }
    final sample = <String>[];
    final step = (codes.length / 260).ceil().clamp(1, 1000);
    for (var i = 0; i < codes.length; i += step) {
      sample.add(codes[i]);
    }
    final unique = sample.toSet().toList();
    final all = <String>{...unique, ..._edgeCases}.toList();
    for (var i = 0; i < all.length; i++) {
      for (var j = 0; j < all.length; j++) {
        expect(
          naturalCodeComparator(all[i], all[j]).sign,
          _legacy(all[i], all[j]).sign,
          reason: '${all[i]} vs ${all[j]}',
        );
      }
    }
  });

  test('naturalCodeComparator agrees with the legacy oracle on edge cases', () {
    final cases = _edgeCases;
    for (final a in cases) {
      for (final b in cases) {
        expect(
          naturalCodeComparator(a, b).sign,
          _legacy(a, b).sign,
          reason: '$a vs $b',
        );
      }
    }
    expect(naturalCodeComparator('01', '1'), 0);
    expect(naturalCodeComparator('001', '01'), 0);
    expect(naturalCodeComparator('', 'R'), lessThan(0));
    expect(naturalCodeComparator('0.5', '01'), lessThan(0));
    expect(
      naturalCodeComparator('R${'9' * 20}', 'R10'),
      greaterThan(0),
    );
  });
}