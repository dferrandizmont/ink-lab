import 'package:flutter/material.dart';

import '../icons/ink_icons.dart';
import '../theme/app_typography.dart';
import '../theme/tokens.dart';
import 'ink_button.dart';

/// Empty and error states (spec §4): centred, max width 300, icon 24 `fg2`,
/// gap 8, `section` headline, gap 4, `secondary` line in `fg2`, gap 16, one
/// secondary button. Errors share the layout; no red fills, no illustrations.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    this.message,
    this.icon = InkIcons.search,
    this.actionLabel,
    this.onAction,
    this.primaryAction = false,
  });

  /// Error variant (alert icon).
  const EmptyState.error({
    super.key,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
    this.primaryAction = false,
  }) : icon = InkIcons.alertCircle;

  final String title;
  final String? message;
  final InkIcons icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  /// Draws the action as the primary (filled) button.
  final bool primaryAction;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkIcon(icon, size: InkGeometry.iconSize, color: ink.fg2),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTypography.section.copyWith(color: ink.fg),
              ),
              if (message != null) ...<Widget>[
                const SizedBox(height: 4),
                Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: AppTypography.secondary.copyWith(color: ink.fg2),
                ),
              ],
              if (actionLabel != null && onAction != null) ...<Widget>[
                const SizedBox(height: 16),
                if (primaryAction)
                  InkButton(label: actionLabel!, onPressed: onAction)
                else
                  InkButton.secondary(label: actionLabel!, onPressed: onAction),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
