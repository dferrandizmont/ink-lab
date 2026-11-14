import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/match_quality.dart';
import '../../l10n/l10n.dart';
import '../icons/ink_icons.dart';
import '../theme/app_typography.dart';
import '../theme/tokens.dart';

/// A filter / harmony / category chip (spec §4 "Chips").
///
/// 36 visual inside a 44 hit area, pill, padding 0 12, `button` type.
/// Off: `surface` fill, `line` border, `fg` text. On: `pale` fill and border,
/// `action` text. Optional leading 16 icon. Tokens cross-fade in 150 ms.
class InkChip extends StatelessWidget {
  const InkChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    this.icon,
    this.expand = false,
    this.lines = 1,
    this.semanticLabel,
  });

  final String label;
  final bool selected;

  /// Called with the new state; `null` disables the chip.
  final ValueChanged<bool>? onSelected;
  final InkIcons? icon;

  /// Fills its parent's width (equal-width variation chips).
  final bool expand;

  /// How many lines of label the chip makes room for. 1 (the default) is the
  /// 36 high chip with a single line; more lines make it as tall as that many
  /// lines of `button` text need at the current text scale, always the same
  /// height whatever the label, so a grid of chips can share one height.
  final int lines;
  final String? semanticLabel;

  /// The width a chip takes when nothing squeezes it: its label, the icon
  /// and the padding around them, never less than the touch target.
  ///
  /// A row of chips uses it to know whether it fits before it lays it out,
  /// so a chip is never cut by the edge of the screen (see
  /// `InkChipRow`, which scrolls or wraps according to it).
  static double naturalWidth(
    BuildContext context,
    String label, {
    InkIcons? icon,
  }) {
    final TextPainter painter = TextPainter(
      text: TextSpan(text: label, style: AppTypography.button),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
      maxLines: 1,
    )..layout();
    // The padding of the chip, the border around it and the icon in front of
    // the label.
    double width = painter.width + 2 * InkSpacing.s10 + 2 * InkGeometry.border;
    if (icon != null) width += InkGeometry.smallIcon + InkSpacing.chipGap;
    return math.max(InkGeometry.target, width);
  }

  /// The visual height of a chip that makes room for [lines] lines.
  static double visualHeight(BuildContext context, int lines) {
    if (lines <= 1) return InkGeometry.chipHeight;
    final double line = MediaQuery.textScalerOf(context)
        .scale(AppTypography.button.fontSize! * AppTypography.button.height!);
    return math.max(InkGeometry.chipHeight, line * lines + 2 * InkSpacing.s8);
  }

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final Color fill = selected ? ink.pale : ink.surface;
    final Color border = selected ? ink.pale : ink.line;
    final Color fg = onSelected == null
        ? ink.fg2
        : selected
        ? ink.action
        : ink.fg;
    final Duration duration = InkMotion.accessible(
      context,
      InkMotion.crossFade,
    );

    final double visual = visualHeight(context, lines);
    return Semantics(
      button: true,
      toggled: selected,
      enabled: onSelected != null,
      label: semanticLabel,
      excludeSemantics: semanticLabel != null,
      child: InkWell(
        onTap: onSelected == null ? null : () => onSelected!(!selected),
        customBorder: const RoundedRectangleBorder(
          borderRadius: InkRadii.controlRadius,
        ),
        // The hit area is at least 44 x 44 even for a short label, and
        // reaches 4 beyond the visible chip on every side.
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(
            height: visual + (InkGeometry.target - InkGeometry.chipHeight),
            width: expand ? double.infinity : null,
          ).copyWith(minWidth: expand ? null : InkGeometry.target),
          child: Center(
            widthFactor: 1,
            child: AnimatedContainer(
              duration: duration,
              curve: InkMotion.crossFadeCurve,
              height: visual,
              width: expand ? double.infinity : null,
              padding: const EdgeInsets.symmetric(horizontal: InkSpacing.s10),
              decoration: ShapeDecoration(
                color: fill,
                shape: RoundedRectangleBorder(
                  borderRadius: InkRadii.controlRadius,
                  side: BorderSide(color: border),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (icon != null) ...<Widget>[
                    InkIcon(icon!, size: InkGeometry.smallIcon, color: fg),
                    const SizedBox(width: 6),
                  ],
                  Flexible(
                    child: Text(
                      label,
                      maxLines: lines,
                      softWrap: lines > 1,
                      overflow: lines > 1 ? TextOverflow.ellipsis : null,
                      textAlign: lines > 1 ? TextAlign.center : null,
                      style: AppTypography.button.copyWith(color: fg),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A horizontally scrolling row of chips with a 6 gap; the first chip is
/// aligned to the 16 gutter. It does not wrap, unless [wrap] is set.
class InkChipRow extends StatelessWidget {
  const InkChipRow({
    super.key,
    required this.children,
    this.padding = const EdgeInsets.symmetric(horizontal: InkSpacing.gutter),
    this.semanticLabel,
    this.wrap = false,
    this.fadeEnds = false,
  });

  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final String? semanticLabel;

  /// Lays the chips out in as many lines as the width needs (the same 6 gap
  /// between them) instead of scrolling. For a wide page, where a chip cut
  /// by the edge would look like a mistake; a phone keeps the scrolling row.
  final bool wrap;

  /// Fades the chips out at an edge that has more to scroll to, so a chip cut
  /// by the edge reads as "there is more" and not as a mistake. Only for the
  /// scrolling row.
  final bool fadeEnds;

  @override
  Widget build(BuildContext context) {
    if (wrap) {
      return Semantics(
        container: true,
        label: semanticLabel,
        child: Padding(
          padding: padding,
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Wrap(
              spacing: InkSpacing.chipGap,
              // Each chip has a 44 dp hit area around its 36 dp body, so the
              // lines need no gap of their own.
              runSpacing: 0,
              children: children,
            ),
          ),
        ),
      );
    }
    final Widget row = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: padding,
      child: Row(
        children: <Widget>[
          for (int i = 0; i < children.length; i++) ...<Widget>[
            if (i > 0) const SizedBox(width: InkSpacing.chipGap),
            children[i],
          ],
        ],
      ),
    );
    return Semantics(
      container: true,
      label: semanticLabel,
      child: fadeEnds ? _EdgeFade(child: row) : row,
    );
  }
}

/// Size of the chevron painted over a faded edge.
const double _chipHintSize = 20;

/// Gap between the chevron and the edge of the row.
const double _chipHintInset = 6;

/// Width of the fully clear zone at a faded edge: the chips are gone under the
/// chevron, so it never lands on top of a label.
const double _chipClearWidth = _chipHintInset + _chipHintSize + 4;

/// Width of the ramp from clear to opaque after the clear zone. Wide enough
/// that a cut chip clearly dissolves, also in dark mode.
const double _chipFadeWidth = 44;

/// The clear zone and ramp never take more than this share of each side of
/// the row (a very narrow row).
const double _chipFadeMaxShare = 1 / 3;

/// The least ramp that must follow the clear zone for the chevron to show: a
/// narrower side would leave labels cut hard right next to the chevron.
const double _chipMinRamp = 12;

/// The clear zone and ramp of a faded edge on a row [width] wide, and whether
/// the chevron still fits inside the clear zone. On a very narrow row the
/// fade shrinks with the share cap and the chevron is dropped: it would land
/// on visible label text.
({double clear, double ramp, bool hintFits}) _fadeGeometry(double width) {
  final double side = width * _chipFadeMaxShare;
  if (side >= _chipClearWidth + _chipMinRamp) {
    return (
      clear: _chipClearWidth,
      ramp: math.min(_chipClearWidth + _chipFadeWidth, side),
      hintFits: true,
    );
  }
  const double total = _chipClearWidth + _chipFadeWidth;
  return (clear: _chipClearWidth * side / total, ramp: side, hintFits: false);
}

/// Keys of the two edge chevrons, for tests.
const ValueKey<String> chipRowHintStartKey = ValueKey<String>(
  'chip-row-hint-start',
);
const ValueKey<String> chipRowHintEndKey = ValueKey<String>(
  'chip-row-hint-end',
);

/// Fades the sides of a horizontally scrolling child that still have content
/// beyond them, and paints a small chevron over each faded edge so the fade
/// reads as "scroll for more". The layout does not change: only the paint
/// does, and the chevrons take no touches and are hidden from screen readers.
class _EdgeFade extends StatefulWidget {
  const _EdgeFade({required this.child});

  final Widget child;

  @override
  State<_EdgeFade> createState() => _EdgeFadeState();
}

class _EdgeFadeState extends State<_EdgeFade> {
  bool _fadeStart = false;
  bool _fadeEnd = false;

  void _update(ScrollMetrics metrics) {
    final bool start = metrics.pixels > metrics.minScrollExtent + 1;
    final bool end = metrics.pixels < metrics.maxScrollExtent - 1;
    if (start == _fadeStart && end == _fadeEnd) return;
    setState(() {
      _fadeStart = start;
      _fadeEnd = end;
    });
  }

  Widget _hint({
    required Key key,
    required bool shown,
    required bool atEnd,
    required TextDirection direction,
    required Duration duration,
    required Color color,
  }) {
    // The end chevron points towards the end of the row, the start one back.
    final bool pointsRight = atEnd == (direction == TextDirection.ltr);
    final Widget glyph = InkIcon(
      InkIcons.chevronRight,
      size: _chipHintSize,
      color: color,
    );
    return Align(
      alignment: atEnd
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: atEnd ? 0 : _chipHintInset,
          end: atEnd ? _chipHintInset : 0,
        ),
        child: AnimatedOpacity(
          key: key,
          opacity: shown ? 1 : 0,
          duration: duration,
          curve: Curves.easeOut,
          child: pointsRight
              ? glyph
              : Transform.flip(flipX: true, child: glyph),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextDirection direction = Directionality.of(context);
    final Color hint = InkColors.of(context).fg2;
    final Duration duration = MediaQuery.of(context).disableAnimations
        ? Duration.zero
        : const Duration(milliseconds: 150);
    return NotificationListener<ScrollMetricsNotification>(
      onNotification: (ScrollMetricsNotification n) {
        _update(n.metrics);
        return false;
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification n) {
          if (n.metrics.axis == Axis.horizontal) _update(n.metrics);
          return false;
        },
        child: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            ShaderMask(
              blendMode: BlendMode.dstIn,
              shaderCallback: (Rect bounds) {
                // Clear zone under the chevron, then a ramp to opaque.
                if (bounds.width <= 0) {
                  return const LinearGradient(
                    colors: <Color>[Colors.black, Colors.black],
                  ).createShader(bounds);
                }
                final geometry = _fadeGeometry(bounds.width);
                final double clear = geometry.clear / bounds.width;
                final double ramp = geometry.ramp / bounds.width;
                const Color gone = Colors.transparent;
                const Color kept = Colors.black;
                return LinearGradient(
                  begin: AlignmentDirectional.centerStart,
                  end: AlignmentDirectional.centerEnd,
                  colors: <Color>[
                    _fadeStart ? gone : kept,
                    _fadeStart ? gone : kept,
                    kept,
                    kept,
                    _fadeEnd ? gone : kept,
                    _fadeEnd ? gone : kept,
                  ],
                  stops: <double>[0, clear, ramp, 1 - ramp, 1 - clear, 1],
                ).createShader(bounds, textDirection: direction);
              },
              child: widget.child,
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: ExcludeSemantics(
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints box) {
                      final bool fits = _fadeGeometry(box.maxWidth).hintFits;
                      return Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: _hint(
                              key: chipRowHintStartKey,
                              shown: _fadeStart && fits,
                              atEnd: false,
                              direction: direction,
                              // When the row turns too narrow, the chevron
                              // goes at once: fading out it would cross the
                              // label text in the shrunken clear zone.
                              duration: fits ? duration : Duration.zero,
                              color: hint,
                            ),
                          ),
                          Positioned.fill(
                            child: _hint(
                              key: chipRowHintEndKey,
                              shown: _fadeEnd && fits,
                              atEnd: true,
                              direction: direction,
                              // When the row turns too narrow, the chevron
                              // goes at once: fading out it would cross the
                              // label text in the shrunken clear zone.
                              duration: fits ? duration : Duration.zero,
                              color: hint,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A quality badge (spec §4): 24 high pill, `pale`, padding 0 10, `caps` in
/// `action`.
///
/// It always hugs its label: inside a `Column(crossAxisAlignment: stretch)`
/// or any other tight box the badge keeps its own width and sits at the
/// start edge. For a quality that repeats on every row prefer
/// [InkQualityText].
class QualityBadge extends StatelessWidget {
  const QualityBadge(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Align(
      alignment: AlignmentDirectional.centerStart,
      widthFactor: 1,
      heightFactor: 1,
      child: Container(
        height: InkGeometry.badgeHeight,
        padding: const EdgeInsets.symmetric(horizontal: InkSpacing.s10),
        decoration: ShapeDecoration(
          color: ink.pale,
          shape: const RoundedRectangleBorder(borderRadius: InkRadii.xsRadius),
        ),
        child: Center(
          widthFactor: 1,
          child: Text(
            AppTypography.caps(label),
            style: AppTypography.capsStyle.copyWith(color: ink.action),
          ),
        ),
      ),
    );
  }
}

/// How many of the four dots of [InkQualityText] are filled for a match at
/// [deltaE]: nearly exact 4, very close 3, close 2, rough 1, far 0.
int qualityDotsFor(double deltaE) => switch (MatchQuality.of(deltaE)) {
  MatchQuality.nearlyExact => 4,
  MatchQuality.veryClose => 3,
  MatchQuality.close => 2,
  MatchQuality.rough => 1,
  MatchQuality.far => 0,
};

/// A quiet match quality for rows that repeat it: `ΔE 10,8 · Rough` in
/// `data` / `fg2` and four 6 dp dots (filled `fg`, empty `line`; the design
/// is monochrome, so no colour carries the meaning). Screen readers hear
/// "Rough, ΔE 10,8".
///
/// ```dart
/// InkQualityText(match.deltaE) // ΔE 10,8 · Rough ●○○○
/// InkQualityText(match.deltaE, showDots: false) // only the text
/// ```
///
/// The text and the dots share a line while they fit and the dots drop below
/// otherwise (never cut), so give it the row's whole width.
class InkQualityText extends StatelessWidget {
  const InkQualityText(this.deltaE, {super.key, this.showDots = true});

  /// The CIELAB distance of the match.
  final double deltaE;

  /// Draws the four dots after the text.
  final bool showDots;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    final String quality = l10n.matchQualityLabel(deltaE);
    final int filled = qualityDotsFor(deltaE);
    return Semantics(
      label: '$quality, ${l10n.commonDeltaE(deltaE)}',
      excludeSemantics: true,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: InkSpacing.s6,
        runSpacing: InkSpacing.s2,
        children: <Widget>[
          Text(
            l10n.commonQualityLine(deltaE, quality),
            style: AppTypography.data.copyWith(color: ink.fg2),
          ),
          if (showDots)
            Row(
              key: const ValueKey<String>('quality-dots'),
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                for (int i = 0; i < 4; i++) ...<Widget>[
                  if (i > 0) const SizedBox(width: InkGeometry.qualityDotGap),
                  Container(
                    width: InkGeometry.qualityDot,
                    height: InkGeometry.qualityDot,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i < filled ? ink.fg : ink.line,
                    ),
                  ),
                ],
              ],
            ),
        ],
      ),
    );
  }
}
