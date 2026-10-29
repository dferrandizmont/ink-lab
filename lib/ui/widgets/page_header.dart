import 'package:flutter/material.dart';

import '../theme/app_typography.dart';
import '../theme/tokens.dart';

/// The header of every screen (spec §3, §6): padding 24 top / 16 sides /
/// 16 bottom, `title` (Archivo 800 40/40), optional trailing `data` on the
/// title baseline (e.g. "160 of 321"), gap 8, `secondary` subtitle in `fg2`.
class InkPageHeader extends StatelessWidget {
  const InkPageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.subtitleWidget,
    this.padding = InkSpacing.header,
  });

  final String title;
  final String? subtitle;

  /// Short `data` text right-aligned on the title baseline.
  final String? trailing;

  /// Rich subtitle; replaces [subtitle].
  final Widget? subtitleWidget;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final Widget? sub =
        subtitleWidget ??
        (subtitle == null
            ? null
            : Text(
                subtitle!,
                style: AppTypography.secondary.copyWith(color: ink.fg2),
              ));
    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Expanded(
                child: Semantics(
                  header: true,
                  // The 40 px display title is already large text: it keeps its
                  // size at any system scale so it stays on one line.
                  child: MediaQuery.withClampedTextScaling(
                    maxScaleFactor: 1,
                    child: Text(
                      title,
                      maxLines: 1,
                      softWrap: false,
                      style: AppTypography.title.copyWith(color: ink.fg),
                    ),
                  ),
                ),
              ),
              if (trailing != null)
                Text(
                  trailing!,
                  style: AppTypography.data.copyWith(color: ink.fg2),
                ),
            ],
          ),
          if (sub != null) ...<Widget>[
            const SizedBox(height: InkSpacing.group),
            sub,
          ],
        ],
      ),
    );
  }
}

/// A `section` heading with an optional `data` note on the right (e.g.
/// "Closest alternatives" + "ΔE 2000").
class InkSectionHeading extends StatelessWidget {
  const InkSectionHeading(this.title, {super.key, this.trailing});

  final String title;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    // The note shares the line while both fit, else it drops below.
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.end,
        spacing: InkSpacing.group,
        children: <Widget>[
          Semantics(
            header: true,
            child: Text(
              title,
              style: AppTypography.section.copyWith(color: ink.fg),
            ),
          ),
          if (trailing != null)
            Text(trailing!, style: AppTypography.data.copyWith(color: ink.fg2)),
        ],
      ),
    );
  }
}
