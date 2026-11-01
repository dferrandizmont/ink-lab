import '../json_value.dart';

enum PaletteMode {
  recommended('Recommended'),
  complementary('Complementary'),
  analogous('Analogous'),
  splitComplementary('Split Complementary'),
  triad('Triad'),
  square('Square'),
  rectangle('Rectangle'),
  monochrome('Monochrome'),
  blendingChain('Blending Chain'),
  customPalette('Custom Palette'),
  shadow('Shadow');

  const PaletteMode(this.label);
  final String label;
  String toJson() => enumJson(this);
  static PaletteMode fromJson(Object? json) => decodeEnum(values, json);
}
