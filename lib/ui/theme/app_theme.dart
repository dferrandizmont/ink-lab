import 'package:flutter/material.dart';

import 'app_typography.dart';
import 'tokens.dart';

/// Material 3 themes for Ink Lab, design G.
///
/// Flat: no surface tint, no elevation overlays, no shadows. Every colour
/// comes from [InkColors]; component themes are set so that stock Material
/// widgets already follow the spec (8-radius buttons and chips, 1 px borders,
/// pale active tokens).
abstract final class AppTheme {
  /// The light theme. The legacy `accent` / `selection` parameters are
  /// accepted for compatibility and ignored: design G has one neutral action.
  static ThemeData light({Color? accent, Color? selection}) =>
      build(InkColors.light, Brightness.light);

  /// The dark theme. See [light] for the ignored legacy parameters.
  static ThemeData dark({Color? accent, Color? selection}) =>
      build(InkColors.dark, Brightness.dark);

  /// The [ColorScheme] that maps the G roles onto Material roles.
  static ColorScheme colorScheme(InkColors c, Brightness brightness) =>
      ColorScheme(
        brightness: brightness,
        primary: c.action,
        onPrimary: c.onAction,
        primaryContainer: c.pale,
        onPrimaryContainer: c.action,
        primaryFixed: c.pale,
        primaryFixedDim: c.pale,
        onPrimaryFixed: c.action,
        onPrimaryFixedVariant: c.action,
        secondary: c.action,
        onSecondary: c.onAction,
        secondaryContainer: c.pale,
        onSecondaryContainer: c.action,
        tertiary: c.action,
        onTertiary: c.onAction,
        tertiaryContainer: c.pale,
        onTertiaryContainer: c.action,
        error: c.error,
        onError: c.bg,
        errorContainer: c.surface,
        onErrorContainer: c.error,
        surface: c.surface,
        onSurface: c.fg,
        onSurfaceVariant: c.fg2,
        surfaceDim: c.bg,
        surfaceBright: c.raised,
        surfaceContainerLowest: c.surface,
        surfaceContainerLow: c.surface,
        surfaceContainer: c.surface,
        surfaceContainerHigh: c.raised,
        surfaceContainerHighest: c.line,
        outline: c.strong,
        outlineVariant: c.line,
        shadow: Colors.transparent,
        scrim: c.scrim,
        inverseSurface: c.fg,
        onInverseSurface: c.bg,
        inversePrimary: c.pale,
        surfaceTint: Colors.transparent,
      );

  /// Builds a theme from a set of G tokens.
  static ThemeData build(InkColors c, Brightness brightness) {
    final ColorScheme scheme = colorScheme(c, brightness);
    final TextTheme textTheme = AppTypography.textTheme.apply(
      bodyColor: c.fg,
      displayColor: c.fg,
    );
    // Design G small radius family: controls are 8-radius rectangles, no pills.
    const RoundedRectangleBorder control = RoundedRectangleBorder(
      borderRadius: InkRadii.controlRadius,
    );
    final BorderSide lineSide = BorderSide(color: c.line);
    final BorderSide strongSide = BorderSide(color: c.strong);
    final TextStyle button = AppTypography.button;

    OutlineInputBorder inputBorder(Color color) => OutlineInputBorder(
      borderRadius: InkRadii.inputRadius,
      borderSide: BorderSide(color: color),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      textTheme: textTheme,
      fontFamily: AppTypography.bodyFontFamily,
      extensions: <ThemeExtension<dynamic>>[c],
      scaffoldBackgroundColor: c.bg,
      canvasColor: c.bg,
      cardColor: c.surface,
      dividerColor: c.line,
      shadowColor: Colors.transparent,
      applyElevationOverlayColor: false,
      splashFactory: InkRipple.splashFactory,
      iconTheme: IconThemeData(color: c.fg, size: InkGeometry.iconSize),
      primaryIconTheme: IconThemeData(color: c.onAction),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: c.action,
        selectionColor: c.pale,
        selectionHandleColor: c.action,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: c.bg,
        foregroundColor: c.fg,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.section.copyWith(color: c.fg),
      ),
      cardTheme: CardThemeData(
        color: c.surface,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: InkRadii.cardRadius,
          side: lineSide,
        ),
        clipBehavior: Clip.antiAlias,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.raised,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        barrierColor: c.scrim,
        shape: RoundedRectangleBorder(
          borderRadius: InkRadii.cardRadius,
          side: lineSide,
        ),
        titleTextStyle: AppTypography.section.copyWith(color: c.fg),
        contentTextStyle: AppTypography.secondary.copyWith(color: c.fg),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.raised,
        modalBackgroundColor: c.raised,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        modalElevation: 0,
        modalBarrierColor: c.scrim,
        shape: RoundedRectangleBorder(
          borderRadius: InkRadii.sheetRadius,
          side: lineSide,
        ),
        clipBehavior: Clip.antiAlias,
        showDragHandle: true,
        dragHandleColor: c.strong,
        dragHandleSize: const Size(
          InkGeometry.grabberWidth,
          InkGeometry.grabberHeight,
        ),
      ),
      dividerTheme: DividerThemeData(color: c.line, thickness: 1, space: 1),
      navigationBarTheme: NavigationBarThemeData(
        height: InkGeometry.navHeight,
        backgroundColor: c.surface,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        indicatorColor: c.pale,
        indicatorShape: control,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (Set<WidgetState> s) => AppTypography.nav.copyWith(
            color: s.contains(WidgetState.selected) ? c.action : c.fg2,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (Set<WidgetState> s) => IconThemeData(
            size: InkGeometry.iconSize,
            color: s.contains(WidgetState.selected) ? c.action : c.fg2,
          ),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: c.surface,
        elevation: 0,
        useIndicator: true,
        indicatorColor: c.pale,
        indicatorShape: control,
        selectedIconTheme: IconThemeData(color: c.action, size: 24),
        unselectedIconTheme: IconThemeData(color: c.fg2, size: 24),
        selectedLabelTextStyle: AppTypography.nav.copyWith(color: c.action),
        unselectedLabelTextStyle: AppTypography.nav.copyWith(color: c.fg2),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: c.action,
          foregroundColor: c.onAction,
          disabledBackgroundColor: c.line,
          disabledForegroundColor: c.fg2,
          minimumSize: const Size(InkGeometry.target, InkGeometry.buttonHeight),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: control,
          elevation: 0,
          shadowColor: Colors.transparent,
          textStyle: button,
          iconSize: InkGeometry.smallIcon,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: c.action,
          foregroundColor: c.onAction,
          disabledBackgroundColor: c.line,
          disabledForegroundColor: c.fg2,
          minimumSize: const Size(InkGeometry.target, InkGeometry.buttonHeight),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: control,
          elevation: 0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          textStyle: button,
          iconSize: InkGeometry.smallIcon,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: c.fg,
          disabledForegroundColor: c.fg2,
          side: strongSide,
          minimumSize: const Size(InkGeometry.target, InkGeometry.buttonHeight),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: control,
          textStyle: button,
          iconSize: InkGeometry.smallIcon,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: c.action,
          disabledForegroundColor: c.fg2,
          minimumSize: const Size(InkGeometry.target, InkGeometry.buttonHeight),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: control,
          textStyle: button,
          iconSize: InkGeometry.smallIcon,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: c.fg,
          disabledForegroundColor: c.line,
          minimumSize: const Size.square(InkGeometry.target),
          iconSize: InkGeometry.mediumIcon,
          shape: const CircleBorder(),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: c.action,
        foregroundColor: c.onAction,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        shape: control,
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll<Size>(
            Size(InkGeometry.target, InkGeometry.segmentHeight),
          ),
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(horizontal: 12),
          ),
          shape: const WidgetStatePropertyAll<OutlinedBorder>(control),
          side: WidgetStatePropertyAll<BorderSide>(strongSide),
          textStyle: WidgetStatePropertyAll<TextStyle>(button),
          backgroundColor: WidgetStateProperty.resolveWith(
            (Set<WidgetState> s) =>
                s.contains(WidgetState.selected) ? c.action : c.surface,
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (Set<WidgetState> s) => s.contains(WidgetState.disabled)
                ? c.fg2
                : s.contains(WidgetState.selected)
                ? c.onAction
                : c.fg,
          ),
          iconColor: WidgetStateProperty.resolveWith(
            (Set<WidgetState> s) =>
                s.contains(WidgetState.selected) ? c.onAction : c.fg,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: c.surface,
        selectedColor: c.pale,
        disabledColor: c.bg,
        checkmarkColor: c.action,
        showCheckmark: false,
        elevation: 0,
        pressElevation: 0,
        shadowColor: Colors.transparent,
        selectedShadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: control,
        side: WidgetStateBorderSide.resolveWith(
          (Set<WidgetState> s) => BorderSide(
            color: s.contains(WidgetState.selected) ? c.pale : c.line,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        labelPadding: const EdgeInsets.symmetric(horizontal: 4),
        labelStyle: WidgetStateTextStyle.resolveWith(
          (Set<WidgetState> s) => button.copyWith(
            color: s.contains(WidgetState.selected) ? c.action : c.fg,
          ),
        ),
        iconTheme: IconThemeData(color: c.fg, size: InkGeometry.smallIcon),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surface,
        isDense: false,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        hintStyle: AppTypography.body.copyWith(color: c.fg2),
        labelStyle: AppTypography.secondary.copyWith(color: c.fg2),
        floatingLabelStyle: AppTypography.secondary.copyWith(color: c.fg2),
        helperStyle: AppTypography.caption.copyWith(color: c.fg2),
        errorStyle: AppTypography.caption.copyWith(color: c.error),
        prefixIconColor: c.fg2,
        suffixIconColor: c.fg2,
        border: inputBorder(c.strong),
        enabledBorder: inputBorder(c.strong),
        disabledBorder: inputBorder(c.line),
        focusedBorder: inputBorder(c.action),
        errorBorder: inputBorder(c.error),
        focusedErrorBorder: inputBorder(c.error),
      ),
      switchTheme: SwitchThemeData(
        trackColor: WidgetStateProperty.resolveWith(
          (Set<WidgetState> s) =>
              s.contains(WidgetState.selected) ? c.action : c.bg,
        ),
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (Set<WidgetState> s) =>
              s.contains(WidgetState.selected) ? Colors.transparent : c.strong,
        ),
        trackOutlineWidth: const WidgetStatePropertyAll<double>(
          InkGeometry.switchBorder,
        ),
        thumbColor: WidgetStateProperty.resolveWith(
          (Set<WidgetState> s) =>
              s.contains(WidgetState.selected) ? c.onAction : c.strong,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (Set<WidgetState> s) =>
              s.contains(WidgetState.selected) ? c.action : Colors.transparent,
        ),
        checkColor: WidgetStatePropertyAll<Color>(c.onAction),
        side: BorderSide(color: c.strong, width: 1.5),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (Set<WidgetState> s) =>
              s.contains(WidgetState.selected) ? c.action : c.strong,
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: c.action,
        inactiveTrackColor: c.line,
        thumbColor: c.action,
        overlayColor: c.action.withValues(alpha: 0.12),
        valueIndicatorColor: c.action,
        valueIndicatorTextStyle: AppTypography.data.copyWith(color: c.onAction),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: c.action,
        linearTrackColor: c.line,
        circularTrackColor: Colors.transparent,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: c.fg2,
        textColor: c.fg,
        titleTextStyle: AppTypography.body.copyWith(color: c.fg),
        subtitleTextStyle: AppTypography.secondary.copyWith(color: c.fg2),
        leadingAndTrailingTextStyle: AppTypography.data.copyWith(color: c.fg2),
        minTileHeight: 48,
        selectedColor: c.action,
        selectedTileColor: c.pale,
      ),
      expansionTileTheme: ExpansionTileThemeData(
        iconColor: c.fg2,
        collapsedIconColor: c.fg2,
        textColor: c.fg,
        collapsedTextColor: c.fg,
        shape: const Border(),
        collapsedShape: const Border(),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: c.raised,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: InkRadii.inputRadius,
          side: lineSide,
        ),
        textStyle: AppTypography.secondary.copyWith(color: c.fg),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: c.fg,
        actionTextColor: c.pale,
        elevation: 0,
        contentTextStyle: AppTypography.secondary.copyWith(color: c.bg),
        shape: const RoundedRectangleBorder(borderRadius: InkRadii.inputRadius),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(color: c.fg, borderRadius: InkRadii.smRadius),
        textStyle: AppTypography.caption.copyWith(color: c.bg),
      ),
      badgeTheme: BadgeThemeData(
        backgroundColor: c.action,
        textColor: c.onAction,
        textStyle: AppTypography.data,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: c.action,
        unselectedLabelColor: c.fg2,
        indicatorColor: c.action,
        dividerColor: c.line,
        labelStyle: button,
        unselectedLabelStyle: button,
      ),
    );
  }
}
