import 'package:flutter/material.dart';

/// Design G colour roles, one instance per theme.
///
/// Registered as a [ThemeExtension], so widgets read it with
/// `InkColors.of(context)` and it lerps with the rest of the theme.
@immutable
class InkColors extends ThemeExtension<InkColors> {
  const InkColors({
    required this.bg,
    required this.surface,
    required this.raised,
    required this.fg,
    required this.fg2,
    required this.line,
    required this.strong,
    required this.action,
    required this.onAction,
    required this.pale,
    required this.edge,
    required this.edgeAt,
    required this.scrim,
    required this.error,
  });

  /// Scaffold background, switch-off track fill.
  final Color bg;

  /// Cards, swatch cells, search field, chips (off), nav bar.
  final Color surface;

  /// Bottom sheets (dark gets one more step; no shadows).
  final Color raised;

  /// Primary text and icons.
  final Color fg;

  /// Secondary text, captions, inactive nav, data.
  final Color fg2;

  /// Hairlines, card borders, off-chip borders.
  final Color line;

  /// Input / segmented / secondary-button borders, grabber, switch-off.
  final Color strong;

  /// Primary button fill, active segment, active nav icon and label.
  final Color action;

  /// Text and icons on [action].
  final Color onAction;

  /// Active chip fill and border, nav pill, quality badge.
  final Color pale;

  /// Hairline drawn around light marker colours.
  final Color edge;

  /// Relative-luminance threshold above which a swatch gets [edge].
  final double edgeAt;

  /// Behind bottom sheets.
  final Color scrim;

  /// Error text and icons (never used as a fill).
  final Color error;

  static const InkColors light = InkColors(
    bg: Color(0xFFF5F5F3),
    surface: Color(0xFFFFFFFF),
    raised: Color(0xFFFFFFFF),
    fg: Color(0xFF20211F),
    fg2: Color(0xFF5C5F59),
    line: Color(0xFFD5D7D1),
    strong: Color(0xFF7A7E76),
    action: Color(0xFF30382F),
    onAction: Color(0xFFFFFFFF),
    pale: Color(0xFFE3E8DD),
    edge: Color(0xFFD5D7D1),
    edgeAt: 0.75,
    scrim: Color(0x66181A18),
    error: Color(0xFFA12424),
  );

  static const InkColors dark = InkColors(
    bg: Color(0xFF181A18),
    surface: Color(0xFF202320),
    raised: Color(0xFF2B2F2B),
    fg: Color(0xFFF2F3EF),
    fg2: Color(0xFFB7BDB3),
    line: Color(0xFF363B36),
    strong: Color(0xFF6E746C),
    action: Color(0xFFD7DFCF),
    onAction: Color(0xFF181A18),
    pale: Color(0xFF3A4238),
    edge: Color(0xFF4A504A),
    edgeAt: 0.35,
    scrim: Color(0x8F000000),
    error: Color(0xFFFFB4AA),
  );

  /// The tokens of the current theme (falls back on brightness).
  static InkColors of(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.extension<InkColors>() ??
        (theme.brightness == Brightness.dark ? dark : light);
  }

  /// Fixed Match reticle colours (theme independent).
  static const Color reticleRing = Color(0xFFFFFFFF);
  static const Color reticleOuter = Color(0xFF20211F);

  /// 1 px border for a marker colour: [edge] when it is lighter than
  /// [edgeAt], the colour itself otherwise (swatch edge rule, spec §1).
  Color swatchEdge(Color swatch) =>
      swatch.computeLuminance() > edgeAt ? edge : swatch;

  @override
  InkColors copyWith({
    Color? bg,
    Color? surface,
    Color? raised,
    Color? fg,
    Color? fg2,
    Color? line,
    Color? strong,
    Color? action,
    Color? onAction,
    Color? pale,
    Color? edge,
    double? edgeAt,
    Color? scrim,
    Color? error,
  }) => InkColors(
    bg: bg ?? this.bg,
    surface: surface ?? this.surface,
    raised: raised ?? this.raised,
    fg: fg ?? this.fg,
    fg2: fg2 ?? this.fg2,
    line: line ?? this.line,
    strong: strong ?? this.strong,
    action: action ?? this.action,
    onAction: onAction ?? this.onAction,
    pale: pale ?? this.pale,
    edge: edge ?? this.edge,
    edgeAt: edgeAt ?? this.edgeAt,
    scrim: scrim ?? this.scrim,
    error: error ?? this.error,
  );

  @override
  InkColors lerp(InkColors? other, double t) {
    if (other == null) {
      return this;
    }
    Color c(Color a, Color b) => Color.lerp(a, b, t)!;
    return InkColors(
      bg: c(bg, other.bg),
      surface: c(surface, other.surface),
      raised: c(raised, other.raised),
      fg: c(fg, other.fg),
      fg2: c(fg2, other.fg2),
      line: c(line, other.line),
      strong: c(strong, other.strong),
      action: c(action, other.action),
      onAction: c(onAction, other.onAction),
      pale: c(pale, other.pale),
      edge: c(edge, other.edge),
      edgeAt: t < 0.5 ? edgeAt : other.edgeAt,
      scrim: c(scrim, other.scrim),
      error: c(error, other.error),
    );
  }
}

/// Pure black or pure white, whichever has the higher WCAG contrast on [c]
/// (spec §1 text-on-swatch rule). Always at least 4.58:1 on opaque colours.
Color inkOn(Color c) {
  final double l = c.computeLuminance();
  return (l + 0.05) / 0.05 > 1.05 / (l + 0.05) ? Colors.black : Colors.white;
}

/// WCAG 2 contrast ratio between two opaque colours.
double contrastRatio(Color a, Color b) {
  final double la = a.computeLuminance();
  final double lb = b.computeLuminance();
  final double hi = la > lb ? la : lb;
  final double lo = la > lb ? lb : la;
  return (hi + 0.05) / (lo + 0.05);
}

/// Spacing scale (spec §3).
abstract final class InkSpacing {
  static const double s2 = 2,
      s4 = 4,
      s6 = 6,
      s8 = 8,
      s10 = 10,
      s12 = 12,
      s14 = 14,
      s16 = 16,
      s24 = 24;

  /// Screen gutter.
  static const double gutter = 16;

  /// Page header padding: 24 top, 16 sides, 16 bottom.
  static const EdgeInsets header = EdgeInsets.fromLTRB(16, 24, 16, 16);

  /// Gap between chips and segments.
  static const double chipGap = 6;

  // Semantic rhythm (owner rule: nothing may touch anything else).

  /// Page side margin.
  static const double pageMargin = 16;

  /// Between page sections (a section heading and what precedes it).
  static const double section = 32;

  /// Between related blocks: field -> strip, strip -> roles card, chips row ->
  /// content, card -> buttons, buttons -> next section content.
  static const double block = 16;

  /// Inside a group: label -> control, title -> subtitle.
  static const double group = 8;

  /// Section heading -> the first block of its content.
  static const double headingGap = 12;

  /// Between sibling buttons (8-12).
  static const double buttonGap = 12;

  /// Sheet side / bottom padding.
  static const double sheet = 24;

  /// Minimum bottom padding of a scrollable page, above the nav.
  static const double pageBottom = 24;

  /// Inner padding of cards and list rows: at least 16 x 12.
  static const double cardH = 16, cardV = 12;
  static const EdgeInsets card = EdgeInsets.symmetric(
    horizontal: cardH,
    vertical: cardV,
  );

  /// Clearance reserved at the end of a sheet's first row for the 44 px
  /// close button that floats at the sheet's top right.
  static const double sheetCloseClearance = 36;

  // Legacy names.
  static const double xs = s4, sm = s8, md = s12, lg = s16, xl = s24;
  static const double page = gutter;
}

/// Corner radii (spec §3).
abstract final class InkRadii {
  /// Sampled chip, mini palette strip.
  static const double xs = 4;

  /// Base-marker colour chip.
  static const double sm = 6;

  /// Swatch cell, small swatches, recent picks, Ideas strip.
  static const double cell = 10;

  /// Base-marker field, other text inputs.
  static const double input = 12;

  /// Cards, sheet top corners, photo, palette strip, hero swatch.
  static const double card = 16;

  /// Pills: search, chips, buttons, segmented, nav pill, switch.
  static const double pill = 999;

  static const BorderRadius xsRadius = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius smRadius = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius cellRadius = BorderRadius.all(
    Radius.circular(cell),
  );
  static const BorderRadius inputRadius = BorderRadius.all(
    Radius.circular(input),
  );
  static const BorderRadius cardRadius = BorderRadius.all(
    Radius.circular(card),
  );
  static const BorderRadius pillRadius = BorderRadius.all(
    Radius.circular(pill),
  );
  static const BorderRadius sheetRadius = BorderRadius.vertical(
    top: Radius.circular(card),
  );
}

/// Fixed sizes (spec §3–4).
abstract final class InkGeometry {
  /// Every border is 1 px; the switch-off track is 2 px.
  static const double border = 1, switchBorder = 2;

  /// Minimum touch target.
  static const double target = 44;

  /// Visual height of chips and small buttons (inside a 44 hit area).
  static const double chipHeight = 36;

  static const double buttonHeight = 44;
  static const double fieldHeight = 48;
  static const double segmentedHeight = 48, segmentHeight = 40;

  static const double navHeight = 72;
  static const double navPillWidth = 56, navPillHeight = 32;
  static const double railWidth = 88;

  static const double swatchBlockHeight = 72;
  static const double paletteStripHeight = 56;
  static const double heroSwatch = 88;
  static const double grabberWidth = 36, grabberHeight = 4;

  static const double iconSize = 24, smallIcon = 16, mediumIcon = 20;
}

/// Motion tokens (spec §5).
abstract final class InkMotion {
  static const Duration sheetIn = Duration(milliseconds: 240);
  static const Duration sheetOut = Duration(milliseconds: 200);
  static const Duration crossFade = Duration(milliseconds: 150);
  static const Duration swatchFade = Duration(milliseconds: 120);

  static const Curve sheetInCurve = Curves.easeOutCubic;
  static const Curve sheetOutCurve = Curves.easeInCubic;
  static const Curve crossFadeCurve = Curves.easeOut;

  /// [duration], or zero when the platform asks to disable animations.
  static Duration accessible(BuildContext context, Duration duration) =>
      MediaQuery.maybeDisableAnimationsOf(context) ?? false
      ? Duration.zero
      : duration;
}
