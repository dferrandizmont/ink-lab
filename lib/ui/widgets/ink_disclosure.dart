import 'package:flutter/material.dart';

import '../icons/ink_icons.dart';
import '../theme/app_typography.dart';
import '../theme/tokens.dart';

/// A collapsible block: a 48 high tappable header (title, optional one-line
/// summary and a chevron) above a [child] that is only built while open.
///
/// Used for long lists (the packs of a product line) so the page or sheet
/// stays short until the user asks for them.
class InkDisclosure extends StatelessWidget {
  const InkDisclosure({
    super.key,
    required this.title,
    required this.expanded,
    required this.onToggle,
    required this.child,
    this.subtitle,
    this.padding = const EdgeInsets.symmetric(horizontal: InkSpacing.cardH),
  });

  final String title;

  /// A short line under the title, for example "2 of 27 packs selected".
  final String? subtitle;
  final bool expanded;
  final VoidCallback onToggle;
  final Widget child;

  /// Padding around the header content.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Semantics(
          button: true,
          expanded: expanded,
          label: subtitle == null ? title : '$title, $subtitle',
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
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title,
                            style: AppTypography.body.copyWith(color: ink.fg),
                          ),
                          if (subtitle != null)
                            Text(
                              subtitle!,
                              style: AppTypography.secondary.copyWith(
                                color: ink.fg2,
                              ),
                            ),
                        ],
                      ),
                    ),
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
