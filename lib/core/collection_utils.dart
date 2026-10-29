/// Kotlin sortedBy is stable; Dart List.sort does not guarantee stability.
List<T> stableSorted<T>(Iterable<T> values, int Function(T, T) compare) {
  final indexed = values.indexed.toList();
  indexed.sort((a, b) {
    final result = compare(a.$2, b.$2);
    return result == 0 ? a.$1.compareTo(b.$1) : result;
  });
  return indexed.map((e) => e.$2).toList();
}

List<T> stableSortedBy<T>(Iterable<T> values, num Function(T) score) {
  final indexed = values.indexed.map((e) => (e.$1, e.$2, score(e.$2))).toList();
  indexed.sort((a, b) {
    final result = a.$3.compareTo(b.$3);
    return result == 0 ? a.$1.compareTo(b.$1) : result;
  });
  return indexed.map((e) => e.$2).toList();
}

T? minBy<T>(Iterable<T> values, num Function(T) score) {
  T? best;
  num? bestScore;
  for (final value in values) {
    final next = score(value);
    if (bestScore == null || next < bestScore) {
      best = value;
      bestScore = next;
    }
  }
  return best;
}

List<T> distinctBy<T>(Iterable<T> values, String Function(T) key) {
  final seen = <String>{};
  return values.where((value) => seen.add(key(value))).toList();
}
