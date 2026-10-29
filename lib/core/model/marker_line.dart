import '../json_value.dart';

/// A product line of a brand. Ohuhu sells Oahu, Honolulu and Kaala markers
/// that share one colour-code system (since 2023), so the three lines live
/// inside the single Ohuhu brand instead of being separate brands.
enum MarkerLine {
  oahu('oahu', 'Oahu'),
  honolulu('honolulu', 'Honolulu'),
  kaala('kaala', 'Kaala');

  const MarkerLine(this.id, this.label);

  /// Stable id stored in `ohuhu_colors.json` (`lines`) and in set ids.
  final String id;
  final String label;

  static final Map<String, MarkerLine> byId = {
    for (final value in values) value.id: value,
  };

  /// Unknown ids return null so future lines in newer catalogs are ignored
  /// instead of failing the whole catalog.
  static MarkerLine? fromId(String? raw) => byId[raw?.trim()];

  String toJson() => enumJson(this);
  static MarkerLine fromJson(Object? json) => decodeEnum(values, json);
}
