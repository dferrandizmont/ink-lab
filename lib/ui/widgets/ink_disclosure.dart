import 'package:flutter/material.dart';

import '../icons/ink_icons.dart';
import '../theme/app_typography.dart';
import '../theme/tokens.dart';

/// A collapsible block: a tappable header (optional [leading], title, an
/// optional one-line summary, optional [trailing] and a chevron) above a
/// [child] that is only built while open. The header is at least 44 dp high
/// and never changes height when it opens or closes, so only what sits below
/// it moves.
///
/// Used for long lists (the packs of a product line, the other brands of a
/// marker) so the page or sheet stays short until the user asks for them.
///
/// ```dart
/// InkDisclosure(
///   title: 'OHUHU',
///   leading: SwatchBlock(
///     hex: best.hex,
///     size: InkGeometry.swatchInline,
///     radius: InkRadii.xs,
///   ),
///   subtitle: 'FY02 · ΔE 10,8',
///   expanded: _open,
///   onToggle: () => setState(() => _open = !_open),
///   padding: EdgeInsets.zero, // inside a sheet, which has its own margin
///   child: Column(children: <Widget>[...]),
/// )
/// ```
class InkDisclosure extends StatelessWidget {
  const InkDisclosure({
    super.key,
    required this.title,
    required this.expanded,
    required this.onToggle,
    required this.child,
    this.subtitle,
    this.subtitleWidget,
    this.leading,
    this.trailing,
    this.semanticLabel,
    this.padding = const EdgeInsets.symmetric(horizontal: InkSpacing.cardH),
  });

  final String title;

  /// A short line under the title, for example "2 of 27 packs selected".
  final String? subtitle;

  /// Rich summary; replaces [subtitle] (for example a code and an
  /// `InkQualityText`). Pass [semanticLabel] with it so screen readers hear
  /// the summary too.
  final Widget? subtitleWidget;

  /// Before the text, for example a 20 dp swatch.
  final Widget? leading;

  /// Between the summary and the chevron, for example a count.
  final Widget? trailing;

  /// What a screen reader reads for the header; defaults to the title and
  /// [subtitle]. Set it when [subtitleWidget], [leading] or [trailing] carry
  /// information.
  final String? semanticLabel;

  final bool expanded;
  final VoidCallback onToggle;
  final Widget child;

  /// Padding around the header content. Use [EdgeInsets.zero] inside a sheet,
  /// whose frame already has the side margin.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final Widget? summary =
        subtitleWidget ??
        (subtitle == null
            ? null
            : Text(
                subtitle!,
                style: AppTypography.secondary.copyWith(color: ink.fg2),
              ));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Semantics(
          button: true,
          expanded: expanded,
          label:
              semanticLabel ?? (subtitle == null ? title : '$title, $subtitle'),
          excludeSemantics: true,
          onTap: onToggle,
          child: InkWell(
            onTap: onToggle,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: InkGeometry.target),
              child: Padding(
                padding: padding.add(
                  const EdgeInsets.symmetric(vertical: InkSpacing.s8),
                ),
                child: Row(
                  children: <Widget>[
                    if (leading != null) ...<Widget>[
                      leading!,
                      const SizedBox(width: InkSpacing.s12),
                    ],
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title,
                            style: AppTypography.body.copyWith(color: ink.fg),
                          ),
                          ?summary,
                        ],
                      ),
                    ),
                    if (trailing != null) ...<Widget>[
                      const SizedBox(width: InkSpacing.group),
                      trailing!,
                    ],
                    const SizedBox(width: InkSpacing.group),
                    InkIcon(
                      expanded ? InkIcons.chevronDown : InkIcons.chevronRight,
                      size: InkGeometry.smallIcon,
                      color: ink.fg2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (expanded) child,
      ],
    );
  }
}
