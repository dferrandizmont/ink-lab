bool _isDigit(int codeUnit) => codeUnit >= 0x30 && codeUnit <= 0x39;

int naturalCodeCompareUpper(String a, String b) {
  int i = 0;
  int j = 0;
  final aLen = a.length;
  final bLen = b.length;
  while (i < aLen && j < bLen) {
    final aStart = i;
    final aDigit = _isDigit(a.codeUnitAt(i));
    while (i < aLen && _isDigit(a.codeUnitAt(i)) == aDigit) {
      i++;
    }
    final bStart = j;
    final bDigit = _isDigit(b.codeUnitAt(j));
    while (j < bLen && _isDigit(b.codeUnitAt(j)) == bDigit) {
      j++;
    }
    if (aDigit && bDigit) {
      int ai = aStart;
      while (ai < i && a.codeUnitAt(ai) == 0x30) {
        ai++;
      }
      int bi = bStart;
      while (bi < j && b.codeUnitAt(bi) == 0x30) {
        bi++;
      }
      final aNumLen = i - ai;
      final bNumLen = j - bi;
      if (aNumLen != bNumLen) {
        return aNumLen.compareTo(bNumLen);
      }
      for (var k = 0; k < aNumLen; k++) {
        final diff = a.codeUnitAt(ai + k) - b.codeUnitAt(bi + k);
        if (diff != 0) return diff;
      }
    } else {
      final aRunLen = i - aStart;
      final bRunLen = j - bStart;
      final minLen = aRunLen < bRunLen ? aRunLen : bRunLen;
      for (var k = 0; k < minLen; k++) {
        final diff = a.codeUnitAt(aStart + k) - b.codeUnitAt(bStart + k);
        if (diff != 0) return diff;
      }
      if (aRunLen != bRunLen) {
        return aRunLen.compareTo(bRunLen);
      }
    }
  }
  if (i < aLen) return 1;
  if (j < bLen) return -1;
  return 0;
}

int naturalCodeComparator(String left, String right) =>
    naturalCodeCompareUpper(left.toUpperCase(), right.toUpperCase());