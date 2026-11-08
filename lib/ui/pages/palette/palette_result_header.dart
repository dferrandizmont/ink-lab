import 'package:flutter/material.dart';

import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_overflow_menu.dart';

/// The row that titles a result ("Combinations (5)") with the AI badge (when
/// the result came from the AI) and the "⋯" of its secondary actions.
class PaletteResultHeader extends StatelessWidget {
  const PaletteResultHeader({
    super.key,
    required this.title,
    required this.menuItems,
    this.aiLabel,
  });

  final String title;

  /// The badge text of an AI result ("Model · 3 of 4 colours"), or `null`.
  final String? aiLabel;

  /// The secondary actions behind the "⋯".
  final List<InkMenuItem> menuItems;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final String? label = aiLabel;
    return Row(
      children: <Widget>[
        Expanded(
          child: Semantics(
            header: true,
            child: Text(
              title,
              style: AppTypography.section.copyWith(color: ink.fg),
            ),
          ),
        ),
        if (label != null)
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: InkSpacing.s8),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: ink.pale,
                  borderRadius: BorderRadius.circular(InkRadii.xs),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: InkSpacing.s8,
                    vertical: InkSpacing.s2,
                  ),
                  child: Tooltip(
                    message: label,
                    excludeFromSemantics: true,
                    child: Text(
                      label,
                      key: const ValueKey<String>('palette-ai-badge'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.secondary.copyWith(
                        color: ink.action,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        InkOverflowMenu(
          key: const ValueKey<String>('palette-overflow'),
          items: menuItems,
        ),
      ],
    );
  }
}
