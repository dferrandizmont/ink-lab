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
  });

  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final String? semanticLabel;

  /// Lays the chips out in as many lines as the width needs (the same 6 gap
  /// between them) instead of scrolling. For a wide page, where a chip cut
  /// by the edge would look like a mistake; a phone keeps the scrolling row.
  final bool wrap;

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
    return Semantics(
      container: true,
      label: semanticLabel,
      child: SingleChildScrollView(
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
