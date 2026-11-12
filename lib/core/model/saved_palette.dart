import '../json_value.dart';
import 'marker_brand.dart';
import 'palette_mode.dart';

final class SavedPalette with JsonValue {
  SavedPalette({
    required this.id,
    this.brandId = 'ohuhu_oahu',
    required this.name,
    required this.baseCode,
    required this.baseName,
    required this.mode,
    required this.paletteSize,
    required this.createdAtEpochMs,
    required List<String> colorCodes,
    this.isCustom = false,
    this.scenarioName,
  }) : colorCodes = List.unmodifiable(colorCodes);
  final String id, brandId, name, baseCode, baseName;
  final PaletteMode mode;
  final int paletteSize, createdAtEpochMs;
  final List<String> colorCodes;
  final bool isCustom;
  final String? scenarioName;

  /// The colour id (`brandId:CODE`) of a stored [code]. A palette of one
  /// brand stores bare codes, which belong to [brandId] (every palette saved
  /// before brands could be mixed); a palette that mixes brands stores each
  /// marker as a colour id already.
  String colorIdFor(String code) =>
      code.contains(':') ? code : '$brandId:$code';

  /// [colorCodes] as colour ids, in order.
  List<String> get colorIds => colorCodes.map(colorIdFor).toList();

  /// [baseCode] as a colour id.
  String get baseColorId => colorIdFor(baseCode);

  /// The ids of the brands of its markers.
  Set<String> get brandIds => <String>{
    for (final String id in colorIds) id.substring(0, id.indexOf(':')),
  };

  /// Whether its markers are of more than one brand.
  bool get mixed => brandIds.length > 1;

  /// Whether its codes are shown with their brand in the list of the brand
  /// [listBrandId]: it holds a marker of another brand. A palette that mixes
  /// brands is listed under each of them (see
  /// `SavedPaletteRepository.listedFor`).
  bool showsBrandsUnder(String listBrandId) =>
      brandIds.any((String id) => id != listBrandId);

  /// The brand of a stored [code].
  MarkerBrand brandOf(String code) {
    final String id = colorIdFor(code);
    return MarkerBrand.fromId(id.substring(0, id.indexOf(':')));
  }

  /// A stored [code] without its brand.
  String bareCode(String code) => code.substring(code.indexOf(':') + 1);

  factory SavedPalette.fromJson(Map<String, dynamic> json) => SavedPalette(
    id: json['id'] as String,
    brandId: jsonDefault(json, 'brandId', 'ohuhu_oahu'),
    name: json['name'] as String,
    baseCode: json['baseCode'] as String,
    baseName: json['baseName'] as String,
    mode: PaletteMode.fromJson(json['mode']),
    paletteSize: json['paletteSize'] as int,
    createdAtEpochMs: json['createdAtEpochMs'] as int,
    colorCodes: (json['colorCodes'] as List).cast<String>(),
    isCustom: jsonDefault(json, 'isCustom', false),
    scenarioName: json['scenarioName'] as String?,
  );
  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'brandId': brandId,
    'name': name,
    'baseCode': baseCode,
    'baseName': baseName,
    'mode': mode.toJson(),
    'paletteSize': paletteSize,
    'createdAtEpochMs': createdAtEpochMs,
    'colorCodes': colorCodes,
    'isCustom': isCustom,
    'scenarioName': scenarioName,
  };
}
