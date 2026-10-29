import '../json_value.dart';
import 'marker_line.dart';

enum MarkerBrand {
  /// The Ohuhu brand. The constant and the stored id keep the historical
  /// "Oahu" spelling so colour ids (`ohuhu_oahu:BV04`), favourites, owned
  /// markers, saved palettes and backups keep working; the brand itself now
  /// covers the [MarkerLine]s Oahu, Honolulu and Kaala (`ohuhu_colors.json`).
  ohuhuOahu('ohuhu_oahu', 'Ohuhu Oahu', 'ohuhu_colors.json', MarkerLine.values),
  decoTime('decotime', 'DecoTime', 'decotime_colors.json');

  const MarkerBrand(
    this.id,
    this.label,
    this.assetFile, [
    this.lines = const <MarkerLine>[],
  ]);
  final String id;
  final String label;
  final String assetFile;

  /// Product lines sold under this brand. Empty for single-line brands.
  final List<MarkerLine> lines;
  String get assetPath => 'assets/data/$assetFile';
  static final Map<String, MarkerBrand> byId = {
    for (final value in values) value.id: value,
  };
  static MarkerBrand fromId(String? raw) => byId[raw?.trim()] ?? ohuhuOahu;
  String toJson() => enumJson(this);
  static MarkerBrand fromJson(Object? json) => decodeEnum(values, json);
}

enum BrandScope {
  singleBrand('Single brand'),
  mixedBrands('Mixed brands');

  const BrandScope(this.label);
  final String label;
  String toJson() => enumJson(this);
  static BrandScope fromJson(Object? json) => decodeEnum(values, json);
}
