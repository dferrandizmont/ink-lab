import 'package:flutter/material.dart';

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
    this.semanticLabel,
  });

  final String label;
  final bool selected;

  /// Called with the new state; `null` disables the chip.
  final ValueChanged<bool>? onSelected;
  final InkIcons? icon;

  /// Fills its parent's width (equal-width variation chips).
  final bool expand;
  final String? semanticLabel;

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

    return Semantics(
      button: true,
      toggled: selected,
      enabled: onSelected != null,
      label: semanticLabel,
      excludeSemantics: semanticLabel != null,
      child: InkWell(
        onTap: onSelected == null ? null : () => onSelected!(!selected),
        customBorder: const StadiumBorder(),
        child: SizedBox(
          height: InkGeometry.target,
          width: expand ? double.infinity : null,
          child: Center(
            widthFactor: 1,
            child: AnimatedContainer(
              duration: duration,
              curve: InkMotion.crossFadeCurve,
              height: InkGeometry.chipHeight,
              width: expand ? double.infinity : null,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: ShapeDecoration(
                color: fill,
                shape: StadiumBorder(side: BorderSide(color: border)),
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
/// aligned to the 16 gutter. Never wraps.
class InkChipRow extends StatelessWidget {
  const InkChipRow({
    super.key,
    required this.children,
    this.padding = const EdgeInsets.symmetric(horizontal: InkSpacing.gutter),
    this.semanticLabel,
  });

  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
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
class QualityBadge extends StatelessWidget {
  const QualityBadge(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: ink.pale,
        shape: const StadiumBorder(),
      ),
      child: Text(
        AppTypography.caps(label),
        style: AppTypography.capsStyle.copyWith(color: ink.action),
      ),
    );
  }
}
