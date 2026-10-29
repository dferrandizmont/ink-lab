final _tokens = RegExp(r'\d+|\D+');

int naturalCodeComparator(String left, String right) {
  final a = _tokens.allMatches(left.toUpperCase()).map((m) => m[0]!).toList();
  final b = _tokens.allMatches(right.toUpperCase()).map((m) => m[0]!).toList();
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
