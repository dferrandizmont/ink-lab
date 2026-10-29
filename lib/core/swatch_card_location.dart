import 'dart:convert';

import 'model/marker_color.dart';

Map<String, Map<String, int>> decodeSwatchCardLocationCatalog(String raw) {
  try {
    final json = jsonDecode(raw) as Map<String, dynamic>;
    if (json['version'] is! int) return {};
    final result = <String, Map<String, int>>{};
    for (final profile in json['profiles'] as List) {
      final item = profile as Map<String, dynamic>;
      final mapping = <String, int>{};
      for (final entry
          in (item['codeToCard'] as Map<String, dynamic>).entries) {
        final code = entry.key.trim().toUpperCase();
        final card = entry.value as int;
        if (code.isNotEmpty) mapping[code] = card;
      }
      result[item['setId'] as String] = mapping;
    }
    return result;
  } on FormatException {
    return {};
  } on TypeError {
    return {};
  }
}

Map<String, String> buildSwatchCardLocationLabels(
  List<MarkerColor> allColors,
  Set<String> activeSetIds,
  Map<String, Map<String, int>> catalogBySetId,
) {
  if (activeSetIds.length != 1) return {};
  final setId = activeSetIds.single;
  final mapping = catalogBySetId[setId];
  if (mapping == null) return {};
  final available = allColors
      .where((c) => c.sets.contains(setId))
      .map((c) => c.newCode.trim().toUpperCase())
      .toSet();
  return {
    for (final entry in mapping.entries)
      if (available.contains(entry.key) && entry.value > 0)
        entry.key: 'Card ${entry.value}',
  };
}
