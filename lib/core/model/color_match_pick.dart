import '../json_value.dart';

final class ColorMatchPick with JsonValue {
  const ColorMatchPick({
    required this.id,
    this.brandId = 'ohuhu_oahu',
    required this.sampledHex,
    required this.matchedCode,
    required this.matchedName,
    required this.matchedHex,
    required this.deltaE,
    required this.createdAtEpochMs,
  });

  final String id, brandId, sampledHex, matchedCode, matchedName, matchedHex;
  final double deltaE;
  final int createdAtEpochMs;

  factory ColorMatchPick.fromJson(Map<String, dynamic> json) => ColorMatchPick(
    id: json['id'] as String,
    brandId: jsonDefault(json, 'brandId', 'ohuhu_oahu'),
    sampledHex: json['sampledHex'] as String,
    matchedCode: json['matchedCode'] as String,
    matchedName: json['matchedName'] as String,
    matchedHex: json['matchedHex'] as String,
    deltaE: (json['deltaE'] as num).toDouble(),
    createdAtEpochMs: json['createdAtEpochMs'] as int,
  );

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'brandId': brandId,
    'sampledHex': sampledHex,
    'matchedCode': matchedCode,
    'matchedName': matchedName,
    'matchedHex': matchedHex,
    'deltaE': deltaE,
    'createdAtEpochMs': createdAtEpochMs,
  };
}
