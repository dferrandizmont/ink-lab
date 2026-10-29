import '../json_value.dart';
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
