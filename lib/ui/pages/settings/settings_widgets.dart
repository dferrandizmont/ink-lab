import 'package:flutter/material.dart';

import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_switch.dart';
import '../../widgets/section_card.dart';

/// A group of the settings page (design G "Settings list card").
///
/// A `caps` group head (optionally with a `caps` note on the right) above one
/// bordered card; the [children] are separated by hairlines.
class SettingsGroup extends StatelessWidget {
  const SettingsGroup({
    super.key,
    required this.title,
    required this.children,
    this.trailing,
  });

  final String title;

  /// Short note at the right of the head, for example "Off by default".
  final String? trailing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final Widget head = trailing == null
        ? InkGroupHead(title)
        : Padding(
            padding: const EdgeInsets.only(bottom: InkSpacing.group),
            child: Semantics(
              header: true,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      AppTypography.caps(title),
                      style: AppTypography.capsStyle.copyWith(color: ink.fg2),
                    ),
                  ),
                  Text(
                    AppTypography.caps(trailing!),
                    style: AppTypography.capsStyle.copyWith(color: ink.fg2),
                  ),
                ],
              ),
            ),
          );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        head,
        InkListCard(children: children),
      ],
    );
  }
}

/// A row with a label on the left and a control (segmented, buttons) on the
/// right. 56 high, 16 left padding, 4 right.
///
/// With [stacked] the control goes on its own line below the label, for
/// controls too wide to share the row.
class SettingsControlRow extends StatelessWidget {
  const SettingsControlRow({
    super.key,
    required this.label,
    required this.control,
    this.stacked = false,
    this.caption,
  });

  final String label;
  final Widget control;
  final bool stacked;

  /// One line of explanation below the control (stacked rows only).
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final Widget text = Text(
      label,
      style: AppTypography.body.copyWith(color: ink.fg),
    );
    if (stacked) {
      return Padding(
        padding: InkSpacing.card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            text,
            const SizedBox(height: InkSpacing.group),
            control,
            if (caption != null) ...<Widget>[
              const SizedBox(height: InkSpacing.group),
              Text(
                caption!,
                style: AppTypography.secondary.copyWith(color: ink.fg2),
              ),
            ],
          ],
        ),
      );
    }
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          InkSpacing.cardH,
          InkSpacing.s8,
          InkSpacing.s4,
          InkSpacing.s8,
        ),
        // The control sits at the trailing edge beside the label; when both
        // do not fit (a long translation on a narrow phone) it wraps onto its
        // own line below the label instead of overflowing.
        child: SizedBox(
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: InkSpacing.block,
            runSpacing: InkSpacing.group,
            children: <Widget>[text, control],
          ),
        ),
      ),
    );
  }
}

/// One option of a list of mutually exclusive choices (a radio list): the
/// radio, then the label on a single line. Use it instead of a segmented
/// control when the options are too long to sit side by side.
class SettingsRadioRow extends StatelessWidget {
  const SettingsRadioRow({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.semantic,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  /// Spoken label when [label] alone is unclear.
  final String? semantic;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: selected,
      button: true,
      enabled: onTap != null,
      label: semantic ?? label,
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap == null || selected ? null : onTap,
        borderRadius: InkRadii.cellRadius,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: InkGeometry.target),
          child: Row(
            children: <Widget>[
              Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected ? ink.action : ink.strong,
                    width: selected ? 2 : 1,
                  ),
                ),
                child: selected
                    ? Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ink.action,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: InkSpacing.s12),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  softWrap: false,
                  style: AppTypography.body.copyWith(color: ink.fg),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A row with a label (and an optional line below it) and a switch.
class SettingsSwitchRow extends StatelessWidget {
  const SettingsSwitchRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.subtitle,
  });

  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return InkWell(
      onTap: onChanged == null ? null : () => onChanged!(!value),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 56),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            InkSpacing.cardH,
            InkSpacing.cardV,
            InkSpacing.s8,
            InkSpacing.cardV,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
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
              const SizedBox(width: InkSpacing.block),
              InkSwitch(
                value: value,
                onChanged: onChanged,
                semanticLabel: label,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A small `caps` heading inside a card.
class SettingsSubhead extends StatelessWidget {
  const SettingsSubhead(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        InkSpacing.cardH,
        InkSpacing.block,
        InkSpacing.cardH,
        InkSpacing.group,
      ),
      child: Text(
        AppTypography.caps(text),
        style: AppTypography.capsStyle.copyWith(
          color: InkColors.of(context).fg2,
        ),
      ),
    );
  }
}

/// A line of `secondary` text in `fg2` inside a card.
class SettingsCaption extends StatelessWidget {
  const SettingsCaption(this.text, {super.key, this.color, this.textKey});

  final String text;

  /// Overrides the `fg2` colour, for example `error` on a failed action.
  final Color? color;

  /// Key of the text itself, for tests.
  final Key? textKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: InkSpacing.cardH,
        vertical: InkSpacing.s8,
      ),
      child: Text(
        text,
        key: textKey,
        style: AppTypography.secondary.copyWith(
          color: color ?? InkColors.of(context).fg2,
        ),
      ),
    );
  }
}
