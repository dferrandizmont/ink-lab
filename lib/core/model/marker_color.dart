import '../json_value.dart';
import 'marker_brand.dart';
import 'marker_line.dart';

enum NameDisplayMode {
  both,
  newOnly,
  oldOnly;

  String toJson() => enumJson(this);
  static NameDisplayMode fromJson(Object? json) => decodeEnum(values, json);
}

final class MarkerColor with JsonValue {
  MarkerColor({
    this.brandId = 'ohuhu_oahu',
    required this.newCode,
    required this.newName,
    required this.oldCode,
    required this.oldName,
    required this.hex,
    required List<String> sets,
    List<String> lines = const [],
  }) : sets = List.unmodifiable(sets),
       lines = List.unmodifiable(lines);

  final String brandId, newCode, newName, oldCode, oldName, hex;
  final List<String> sets;

  /// Ids of the [MarkerLine]s this colour is sold in (`oahu`, `honolulu`,
  /// `kaala`). Empty for brands without lines (DecoTime) and for payloads
  /// written before lines existed.
  final List<String> lines;
  bool inLine(MarkerLine line) => lines.contains(line.id);
  String get colorId => '$brandId:${newCode.toUpperCase()}';
  String displayCode(NameDisplayMode mode) => switch (mode) {
    NameDisplayMode.newOnly => newCode,
    NameDisplayMode.oldOnly => oldCode,
    NameDisplayMode.both =>
      newCode == oldCode ? newCode : '$newCode / $oldCode',
  };
  String displayName(NameDisplayMode mode) => switch (mode) {
    NameDisplayMode.newOnly => newName,
    NameDisplayMode.oldOnly => oldName,
    NameDisplayMode.both =>
      newName == oldName ? newName : '$newName / $oldName',
  };
  MarkerColor copyWith({
    String? brandId,
    String? newCode,
    String? newName,
    String? oldCode,
    String? oldName,
    String? hex,
    List<String>? sets,
    List<String>? lines,
  }) => MarkerColor(
    brandId: brandId ?? this.brandId,
    newCode: newCode ?? this.newCode,
    newName: newName ?? this.newName,
    oldCode: oldCode ?? this.oldCode,
    oldName: oldName ?? this.oldName,
    hex: hex ?? this.hex,
    sets: sets ?? this.sets,
    lines: lines ?? this.lines,
  );
  factory MarkerColor.fromJson(Map<String, dynamic> json) => MarkerColor(
    brandId: jsonDefault(json, 'brandId', MarkerBrand.ohuhuOahu.id),
    newCode: json['newCode'] as String,
    newName: json['newName'] as String,
    oldCode: json['oldCode'] as String,
    oldName: json['oldName'] as String,
    hex: json['hex'] as String,
    sets: (json['sets'] as List).cast<String>(),
    lines: jsonDefault<List<dynamic>>(json, 'lines', const []).cast<String>(),
  );
  @override
  Map<String, dynamic> toJson() => {
    'brandId': brandId,
    'newCode': newCode,
    'newName': newName,
    'oldCode': oldCode,
    'oldName': oldName,
    'hex': hex,
    'sets': sets,
    // Omitted when empty so line-less payloads keep their original shape.
    if (lines.isNotEmpty) 'lines': lines,
  };
}
