import '../json_value.dart';
import 'marker_color.dart';
import 'drawing_scenario.dart';
import 'palette_mode.dart';

final class AiPaletteRequest with JsonValue {
  AiPaletteRequest({
    required this.brandId,
    required this.brandLabel,
    required this.baseColor,
    required List<MarkerColor> candidates,
    required this.scenario,
    required this.mode,
    required this.paletteSize,
    this.userGoal,
    this.imageDataUrl,
    this.imageHint,
  }) : candidates = List.unmodifiable(candidates);
  final String brandId;
  final String brandLabel;
  final MarkerColor? baseColor;
  final List<MarkerColor> candidates;
  final DrawingScenario? scenario;
  final PaletteMode mode;
  final int paletteSize;
  final String? userGoal;
  final String? imageDataUrl;
  final String? imageHint;
  factory AiPaletteRequest.fromJson(Map<String, dynamic> json) =>
      AiPaletteRequest(
        brandId: json['brandId'] as String,
        brandLabel: json['brandLabel'] as String,
        baseColor: json['baseColor'] == null
            ? null
            : MarkerColor.fromJson(json['baseColor'] as Map<String, dynamic>),
        candidates: (json['candidates'] as List)
            .map((value) => MarkerColor.fromJson(value as Map<String, dynamic>))
            .toList(),
        scenario: json['scenario'] == null
            ? null
            : DrawingScenario.fromJson(json['scenario']),
        mode: PaletteMode.fromJson(json['mode']),
        paletteSize: json['paletteSize'] as int,
        userGoal: json['userGoal'] as String?,
        imageDataUrl: json['imageDataUrl'] as String?,
        imageHint: json['imageHint'] as String?,
      );
  @override
  Map<String, dynamic> toJson() => {
    'brandId': brandId,
    'brandLabel': brandLabel,
    'baseColor': baseColor?.toJson(),
    'candidates': candidates.map((value) => value.toJson()).toList(),
    'scenario': scenario?.toJson(),
    'mode': mode.toJson(),
    'paletteSize': paletteSize,
    'userGoal': userGoal,
    'imageDataUrl': imageDataUrl,
    'imageHint': imageHint,
  };
}

final class AiProviderPaletteResponse with JsonValue {
  AiProviderPaletteResponse({
    required List<AiPaletteItem> items,
    required List<String> tips,
  }) : items = List.unmodifiable(items),
       tips = List.unmodifiable(tips);
  final List<AiPaletteItem> items;
  final List<String> tips;
  factory AiProviderPaletteResponse.fromJson(Map<String, dynamic> json) =>
      AiProviderPaletteResponse(
        items: (json['items'] as List)
            .map(
              (value) => AiPaletteItem.fromJson(value as Map<String, dynamic>),
            )
            .toList(),
        tips: (json['tips'] as List).cast<String>(),
      );
  @override
  Map<String, dynamic> toJson() => {
    'items': items.map((value) => value.toJson()).toList(),
    'tips': tips,
  };
}

final class AiPaletteItem with JsonValue {
  AiPaletteItem({
    required this.code,
    required this.role,
    required this.reason,
    this.name = '',
    this.hex = '',
    this.rawCode = '',
  });
  final String code;
  final String role;
  final String reason;

  /// Colour name the model gave, when any (small models often answer with it).
  final String name;

  /// Hex value the model gave (with or without `#`), when any.
  final String hex;

  /// The code text exactly as the model wrote it, before normalisation.
  final String rawCode;
  factory AiPaletteItem.fromJson(Map<String, dynamic> json) => AiPaletteItem(
    code: json['code'] as String,
    role: json['role'] as String,
    reason: json['reason'] as String,
    name: json['name'] as String? ?? '',
    hex: json['hex'] as String? ?? '',
    rawCode: json['rawCode'] as String? ?? '',
  );
  @override
  Map<String, dynamic> toJson() => {
    'code': code,
    'role': role,
    'reason': reason,
    if (name.isNotEmpty) 'name': name,
    if (hex.isNotEmpty) 'hex': hex,
    if (rawCode.isNotEmpty) 'rawCode': rawCode,
  };
}

final class AiPaletteJsonEnvelope with JsonValue {
  AiPaletteJsonEnvelope({
    List<AiPaletteJsonItem> palette = const [],
    List<String> tips = const [],
  }) : palette = List.unmodifiable(palette),
       tips = List.unmodifiable(tips);
  final List<AiPaletteJsonItem> palette;
  final List<String> tips;
  factory AiPaletteJsonEnvelope.fromJson(Map<String, dynamic> json) =>
      AiPaletteJsonEnvelope(
        palette: jsonDefault<List<dynamic>>(json, 'palette', const [])
            .map(
              (value) =>
                  AiPaletteJsonItem.fromJson(value as Map<String, dynamic>),
            )
            .toList(),
        tips: jsonDefault<List<dynamic>>(json, 'tips', const []).cast<String>(),
      );
  @override
  Map<String, dynamic> toJson() => {
    'palette': palette.map((value) => value.toJson()).toList(),
    'tips': tips,
  };
}

final class AiPaletteJsonItem with JsonValue {
  AiPaletteJsonItem({
    this.code = '',
    this.role,
    this.reason,
    this.name,
    this.hex,
    this.rawCode,
  });
  final String code;
  final String? role;
  final String? reason;
  final String? name;
  final String? hex;

  /// The code text as the model wrote it, before normalisation.
  final String? rawCode;
  factory AiPaletteJsonItem.fromJson(Map<String, dynamic> json) =>
      AiPaletteJsonItem(
        code: jsonDefault(json, 'code', ''),
        role: json['role'] as String?,
        reason: json['reason'] as String?,
        name: json['name'] as String?,
        hex: json['hex'] as String?,
        rawCode: json['rawCode'] as String?,
      );
  @override
  Map<String, dynamic> toJson() => {
    'code': code,
    'role': role,
    'reason': reason,
    if (name != null) 'name': name,
    if (hex != null) 'hex': hex,
    if (rawCode != null) 'rawCode': rawCode,
  };
}
