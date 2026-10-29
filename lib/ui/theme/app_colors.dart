import 'package:flutter/material.dart';

import 'tokens.dart';

/// Legacy colour names, kept as aliases of the design G tokens
/// ([InkColors]) so older code keeps compiling. New code reads
/// `InkColors.of(context)`.
abstract final class AppColors {
  // Dark.
  static const Color noirBackground = Color(0xFF181A18);
  static const Color noirSurface = Color(0xFF202320);
  static const Color noirSurfaceElevated = Color(0xFF2B2F2B);
  static const Color noirSurfaceStrong = Color(0xFF2B2F2B);
  static const Color inkText = Color(0xFFF2F3EF);
  static const Color mutedText = Color(0xFFB7BDB3);
  static const Color dividerLine = Color(0xFF363B36);

  // Light.
  static const Color dayBackground = Color(0xFFF5F5F3);
  static const Color daySurface = Color(0xFFFFFFFF);
  static const Color daySurfaceElevated = Color(0xFFFFFFFF);
  static const Color daySurfaceStrong = Color(0xFFE3E8DD);
  static const Color dayInkText = Color(0xFF20211F);
  static const Color dayMutedText = Color(0xFF5C5F59);
  static const Color dayDividerLine = Color(0xFFD5D7D1);

  // Action (the single accent of design G).
  static const Color emberPrimary = Color(0xFF30382F);
  static const Color emberPrimarySoft = Color(0xFFD7DFCF);
  static const Color emberPrimaryDeep = Color(0xFF30382F);
  static const Color slateSelection = Color(0xFF30382F);

  /// Design G has a single neutral accent; kept for API compatibility.
  static const List<Color> accentPresets = <Color>[emberPrimary];
  static const List<Color> selectionPresets = <Color>[slateSelection];

  /// Pure black or white, whichever reads best on [background] (WCAG).
  static Color contentColorFor(Color background) => inkOn(background);
}
