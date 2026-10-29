/// English identifiers of the reasons the palette page itself writes. They are
/// kept in English like the ones of the core engines and localised for display
/// (see `reasonLabel` in `l10n/core_labels.dart`).
abstract final class PaletteReasons {
  /// A color restored from a saved palette.
  static const String loaded = 'Loaded palette';

  /// A color applied from the Ideas page.
  static const String draft = 'Applied from Ideas';
}
