import 'package:flutter/material.dart';

/// Design G type scale.
///
/// Archivo 800 for page and sheet titles, Inter for the interface and
/// JetBrains Mono (tabular figures) for marker codes and data. All three are
/// bundled variable fonts, so every style also sets its `wght` (and Inter its
/// `opsz`) axis explicitly. Styles carry no colour: the theme applies `fg`,
/// and callers use `fg2` for secondary text.
abstract final class AppTypography {
  static const String titleFontFamily = 'Archivo';
  static const String bodyFontFamily = 'Inter';
  static const String monoFontFamily = 'JetBrainsMono';

  /// Legacy name of [titleFontFamily].
  static const String displayFontFamily = titleFontFamily;

  static const List<String> _titleFallback = <String>[bodyFontFamily];

  static TextStyle _archivo(double size, double line, double tracking) =>
      TextStyle(
        fontFamily: titleFontFamily,
        fontFamilyFallback: _titleFallback,
        fontSize: size,
        height: line / size,
        fontWeight: FontWeight.w800,
        letterSpacing: tracking,
        leadingDistribution: TextLeadingDistribution.even,
        fontVariations: const <FontVariation>[FontVariation('wght', 800)],
      );

  static TextStyle _inter(
    double size,
    double line,
    FontWeight weight, {
    double tracking = 0,
  }) => TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: size,
    height: line / size,
    fontWeight: weight,
    letterSpacing: tracking,
    leadingDistribution: TextLeadingDistribution.even,
    fontVariations: <FontVariation>[
      FontVariation('wght', weight.value.toDouble()),
      FontVariation('opsz', size),
    ],
  );

  static TextStyle _mono(double size, double line) => TextStyle(
    fontFamily: monoFontFamily,
    fontSize: size,
    height: line / size,
    fontWeight: FontWeight.w500,
    leadingDistribution: TextLeadingDistribution.even,
    fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
    fontVariations: const <FontVariation>[FontVariation('wght', 500)],
  );

  /// Page title, one per screen. Archivo 800 40/40, -1.2.
  static final TextStyle title = _archivo(40, 40, -1.2);

  /// Detail-sheet marker name, best match, featured idea. Archivo 800 26/28.
  static final TextStyle sheetTitle = _archivo(26, 28, -0.5);

  /// Section headings, idea titles. Inter 600 18/24.
  static final TextStyle section = _inter(18, 24, FontWeight.w600);

  /// Search input, settings row labels. Inter 400 16/24.
  static final TextStyle body = _inter(16, 24, FontWeight.w400);

  /// Subtitles, names in the grid, reasons, values. Inter 400 14/20.
  static final TextStyle secondary = _inter(14, 20, FontWeight.w400);

  /// Field labels, roles, badges. Inter 500 12/16, +0.96 tracking.
  ///
  /// Flutter has no text-transform: pass upper-case text (see [caps]).
  static final TextStyle capsStyle = _inter(
    12,
    16,
    FontWeight.w500,
    tracking: 0.96,
  );

  /// Bottom nav labels. Inter 500 12/16.
  static final TextStyle nav = _inter(12, 16, FontWeight.w500);

  /// Buttons, chips, segments. Inter 600 14/20.
  static final TextStyle button = _inter(14, 20, FontWeight.w600);

  /// Marker codes, numeric segments, masked key. JetBrains Mono 500 16/22.
  static final TextStyle code = _mono(16, 22);

  /// Hex, RGB, ΔE, counts, old codes, step numbers. JetBrains Mono 500 12/16.
  static final TextStyle data = _mono(12, 16);

  /// Small caption (not in the spec table; backs the legacy `bodySmall`).
  static final TextStyle caption = _inter(12, 16, FontWeight.w400);

  /// Upper-cases [text] for the [capsStyle] role.
  static String caps(String text) => text.toUpperCase();

  /// The Material text theme, mapped onto the G roles.
  static final TextTheme textTheme = TextTheme(
    displayLarge: title,
    displayMedium: title,
    displaySmall: sheetTitle,
    headlineLarge: title,
    headlineMedium: sheetTitle,
    headlineSmall: sheetTitle,
    titleLarge: section,
    titleMedium: _inter(16, 24, FontWeight.w600),
    titleSmall: button,
    bodyLarge: body,
    bodyMedium: secondary,
    bodySmall: caption,
    labelLarge: button,
    labelMedium: nav,
    labelSmall: capsStyle,
  );
}
