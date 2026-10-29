import 'package:flutter/material.dart';

import '../icons/ink_icons.dart';
import '../theme/app_typography.dart';
import '../theme/tokens.dart';

/// A `surface` card with a 1 px `line` outline and radius 16, grouping
/// related content under an optional `section` title.
class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    this.title,
    this.subtitle,
    this.trailing,
    this.child,
    this.padding = const EdgeInsets.all(InkSpacing.block),
  });

  /// Title of the section (`section` type).
  final String? title;

  /// Optional description shown under the title (`secondary`, `fg2`).
  final String? subtitle;

  /// Optional widget shown at the end of the title row.
  final Widget? trailing;

  /// Content of the card.
  final Widget? child;

  /// Padding between the border of the card and its content.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);

    return Card(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (title != null) ...<Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Semantics(
                      header: true,
                      child: Text(
                        title!,
                        style: AppTypography.section.copyWith(color: ink.fg),
                      ),
                    ),
                  ),
                  ?trailing,
                ],
              ),
              if (subtitle != null) ...<Widget>[
                const SizedBox(height: InkSpacing.group),
                Text(
                  subtitle!,
                  style: AppTypography.secondary.copyWith(color: ink.fg2),
                ),
              ],
              const SizedBox(height: InkSpacing.block),
            ],
            ?child,
          ],
        ),
      ),
    );
  }
}

/// A caps group head above a card (spec §4 "Settings list card"): `caps`
/// in `fg2`, 8 bottom (label -> control), with an optional trailing note.
class InkGroupHead extends StatelessWidget {
  const InkGroupHead(this.text, {super.key, this.trailing});

  final String text;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final TextStyle style = AppTypography.capsStyle.copyWith(color: ink.fg2);
    return Padding(
      padding: const EdgeInsets.only(bottom: InkSpacing.group),
      child: Semantics(
        header: true,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(AppTypography.caps(text), style: style)),
            if (trailing != null)
              Text(
                trailing!,
                style: AppTypography.secondary.copyWith(color: ink.fg2),
              ),
          ],
        ),
      ),
    );
  }
}

/// A `surface` card of rows separated by `line` hairlines (settings lists,
/// role/reason card).
class InkListCard extends StatelessWidget {
  const InkListCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < children.length; i++) ...<Widget>[
            if (i > 0) const Divider(),
            children[i],
          ],
        ],
      ),
    );
  }
}

/// A settings row (spec §4): 48 high (56 when [tall]), padding 16 / 12,
/// `body` label, optional `secondary` subtitle and trailing value or control,
/// optional chevron for navigable rows.
class InkListRow extends StatelessWidget {
  const InkListRow({
    super.key,
    required this.label,
    this.subtitle,
    this.value,
    this.valueIsData = false,
    this.trailing,
    this.onTap,
    this.chevron = false,
    this.tall = false,
  });

  final String label;
  final String? subtitle;
  final String? value;

  /// Renders [value] in `data` (mono) instead of `secondary`.
  final bool valueIsData;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool chevron;
  final bool tall;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: tall || subtitle != null ? 56 : 48,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: InkSpacing.cardH,
            right: trailing == null ? InkSpacing.cardH : 4,
            top: InkSpacing.cardV,
            bottom: InkSpacing.cardV,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      label,
                      style: AppTypography.body.copyWith(color: ink.fg),
                    ),
                    if (subtitle != null) ...<Widget>[
                      const SizedBox(height: InkSpacing.s4),
                      Text(
                        subtitle!,
                        style: AppTypography.secondary.copyWith(color: ink.fg2),
                      ),
                    ],
                  ],
                ),
              ),
              if (value != null)
                Padding(
                  padding: const EdgeInsets.only(left: InkSpacing.group),
                  child: ConstrainedBox(
                    // A long value (a model id, say) must not push the row
                    // past the screen edge.
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.sizeOf(context).width * 0.5,
                    ),
                    child: Text(
                      value!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          (valueIsData
                                  ? AppTypography.data
                                  : AppTypography.secondary)
                              .copyWith(color: ink.fg2),
                    ),
                  ),
                ),
              ?trailing,
              if (chevron)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: InkIcon(
                    InkIcons.chevronRight,
                    size: InkGeometry.smallIcon,
                    color: ink.fg2,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
