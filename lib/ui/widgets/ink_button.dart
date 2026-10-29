import 'package:flutter/material.dart';

import '../icons/ink_icons.dart';
import '../theme/app_typography.dart';
import '../theme/tokens.dart';

/// Button variants of design G (spec §4 "Buttons"). All are pills, 44 high.
enum InkButtonVariant {
  /// `action` fill, `onAction` text.
  primary,

  /// Transparent with a 1 px `strong` border, `fg` text.
  secondary,

  /// Secondary drawn 36 high inside a 44 hit area, padding 0 14.
  smallSecondary,

  /// No fill or border, `action` text, padding 0 12.
  text,
}

/// A design G button: label in `button` type with an optional 16 icon
/// (leading, gap 8) and an optional trailing `caps` tag in `fg2` (used by
/// "Suggest with AI · OFF").
class InkButton extends StatelessWidget {
  const InkButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = InkButtonVariant.primary,
    this.icon,
    this.trailingIcon,
    this.tag,
    this.expand = false,
    this.loading = false,
  });

  const InkButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.trailingIcon,
    this.tag,
    this.expand = false,
    this.loading = false,
  }) : variant = InkButtonVariant.secondary;

  const InkButton.text({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.trailingIcon,
    this.tag,
    this.expand = false,
    this.loading = false,
  }) : variant = InkButtonVariant.text;

  final String label;
  final VoidCallback? onPressed;
  final InkButtonVariant variant;
  final InkIcons? icon;
  final InkIcons? trailingIcon;

  /// Trailing `caps` tag in `fg2`, e.g. "OFF".
  final String? tag;

  /// Stretches to the available width.
  final bool expand;

  /// Shows a spinner in place of the icon and disables the button.
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final bool small = variant == InkButtonVariant.smallSecondary;
    final double hPad = switch (variant) {
      InkButtonVariant.primary || InkButtonVariant.secondary => 16,
      InkButtonVariant.smallSecondary => 14,
      InkButtonVariant.text => 12,
    };
    final VoidCallback? effectiveOnPressed = loading ? null : onPressed;
    final List<Widget> children = <Widget>[
      if (loading) ...<Widget>[
        const SizedBox.square(
          dimension: InkGeometry.smallIcon,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        const SizedBox(width: 8),
      ] else if (icon != null) ...<Widget>[
        InkIcon(icon!, size: InkGeometry.smallIcon),
        const SizedBox(width: 8),
      ],
      Flexible(
        child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      if (tag != null) ...<Widget>[
        const SizedBox(width: 8),
        Text(
          AppTypography.caps(tag!),
          style: AppTypography.capsStyle.copyWith(color: ink.fg2),
        ),
      ],
      if (trailingIcon != null) ...<Widget>[
        const SizedBox(width: 8),
        InkIcon(trailingIcon!, size: InkGeometry.smallIcon),
      ],
    ];
    final Widget content = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
    final ButtonStyle sizing = ButtonStyle(
      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(horizontal: hPad),
      ),
      minimumSize: WidgetStatePropertyAll<Size>(
        Size(InkGeometry.target, small ? InkGeometry.chipHeight : 44),
      ),
      tapTargetSize: MaterialTapTargetSize.padded,
    );

    final Widget button = switch (variant) {
      InkButtonVariant.primary => FilledButton(
        onPressed: effectiveOnPressed,
        style: sizing,
        child: content,
      ),
      InkButtonVariant.secondary ||
      InkButtonVariant.smallSecondary => OutlinedButton(
        onPressed: effectiveOnPressed,
        style: sizing,
        child: content,
      ),
      InkButtonVariant.text => TextButton(
        onPressed: effectiveOnPressed,
        style: sizing,
        child: content,
      ),
    };
    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}

/// A 44×44 circular icon button: 1 px `strong` border when [outlined]
/// (favourite), borderless otherwise (sheet close, icon 20).
class InkIconButton extends StatelessWidget {
  const InkIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.outlined = false,
    this.selected = false,
    this.filledWhenSelected = true,
    this.iconSize,
    this.color,
  });

  final InkIcons icon;
  final VoidCallback? onPressed;
  final String tooltip;
  final bool outlined;

  /// Toggle state (e.g. favourite); fills the glyph when
  /// [filledWhenSelected].
  final bool selected;
  final bool filledWhenSelected;
  final double? iconSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final Color fg = color ?? ink.fg;
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      isSelected: selected,
      style: IconButton.styleFrom(
        foregroundColor: fg,
        fixedSize: const Size.square(InkGeometry.target),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: CircleBorder(
          side: outlined ? BorderSide(color: ink.strong) : BorderSide.none,
        ),
      ),
      icon: InkIcon(
        icon,
        size: iconSize ?? (outlined ? 18 : InkGeometry.mediumIcon),
        color: fg,
        filled: selected && filledWhenSelected,
      ),
    );
  }
}
