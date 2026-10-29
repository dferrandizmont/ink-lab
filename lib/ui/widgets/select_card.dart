import 'package:flutter/material.dart';

import '../icons/ink_icons.dart';
import '../theme/app_typography.dart';
import '../theme/tokens.dart';

/// A full-width selectable card: a one-line [title], an optional [line]
/// under it and a check mark when [selected] (first-run brand and series).
///
/// Off: `surface` fill and `line` border. On: `pale` fill, 2 px `action`
/// border and a check. The whole card is the tap target.
class SelectCard extends StatelessWidget {
  const SelectCard({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
    this.line,
  });

  /// One line, never wraps.
  final String title;

  /// Short description under the title.
  final String? line;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Semantics(
      button: true,
      selected: selected,
      child: InkWell(
        onTap: onTap,
        borderRadius: InkRadii.cardRadius,
        child: Container(
          constraints: const BoxConstraints(minHeight: InkGeometry.target),
          padding: InkSpacing.card,
          decoration: BoxDecoration(
            color: selected ? ink.pale : ink.surface,
            borderRadius: InkRadii.cardRadius,
            border: Border.all(
              color: selected ? ink.action : ink.line,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      maxLines: 1,
                      softWrap: false,
                      style: AppTypography.section.copyWith(color: ink.fg),
                    ),
                    if (line != null) ...<Widget>[
                      const SizedBox(height: InkSpacing.s4),
                      Text(
                        line!,
                        style: AppTypography.secondary.copyWith(color: ink.fg2),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: InkSpacing.s12),
              SizedBox.square(
                dimension: InkGeometry.mediumIcon,
                child: selected
                    ? InkIcon(
                        InkIcons.check,
                        size: InkGeometry.mediumIcon,
                        color: ink.action,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
