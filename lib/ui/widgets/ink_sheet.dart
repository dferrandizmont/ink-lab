import 'package:flutter/material.dart';

import '../icons/ink_icons.dart';
import '../theme/tokens.dart';
import 'ink_button.dart';
import '../../l10n/l10n.dart';

/// Shows a design G bottom sheet (spec §4 "Swatch detail sheet", §5):
/// `raised`, 1 px `line` without a bottom border, top radius 16, padding
/// 8/16/16, grabber 36×4 `strong`, close button top-right, scrim behind.
/// Slides up in 240 ms ease-out-cubic and down in 200 ms ease-in-cubic
/// (no animation when the platform disables animations).
Future<T?> showInkSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool showClose = true,
  String? closeTooltip,
  bool isScrollControlled = true,
}) {
  final InkColors ink = InkColors.of(context);
  final bool still = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    showDragHandle: false,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    barrierColor: ink.scrim,
    sheetAnimationStyle: AnimationStyle(
      duration: still ? Duration.zero : InkMotion.sheetIn,
      reverseDuration: still ? Duration.zero : InkMotion.sheetOut,
      curve: InkMotion.sheetInCurve,
      reverseCurve: InkMotion.sheetOutCurve,
    ),
    builder: (BuildContext sheetContext) => InkSheet(
      showClose: showClose,
      closeTooltip: closeTooltip,
      child: Builder(builder: builder),
    ),
  );
}

/// The frame of a design G sheet; usable on its own inside custom routes.
class InkSheet extends StatelessWidget {
  const InkSheet({
    super.key,
    required this.child,
    this.showClose = true,
    this.closeTooltip,
    this.onClose,
  });

  final Widget child;
  final bool showClose;

  /// Tooltip of the close button; defaults to the localised "Close".
  final String? closeTooltip;

  /// Defaults to popping the route.
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final BorderSide side = BorderSide(color: ink.line);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ink.raised,
        borderRadius: InkRadii.sheetRadius,
        border: Border(top: side, left: side, right: side),
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(
              InkSpacing.sheet,
              InkSpacing.s12,
              InkSpacing.sheet,
              InkSpacing.sheet,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Container(
                    width: InkGeometry.grabberWidth,
                    height: InkGeometry.grabberHeight,
                    decoration: ShapeDecoration(
                      color: ink.strong,
                      shape: const StadiumBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: InkSpacing.block),
                Flexible(child: child),
              ],
            ),
          ),
          if (showClose)
            Positioned(
              top: 10,
              right: 8,
              child: InkIconButton(
                icon: InkIcons.x,
                tooltip: closeTooltip ?? context.l10n.commonClose,
                onPressed: onClose ?? () => Navigator.of(context).maybePop(),
              ),
            ),
        ],
      ),
    );
  }
}

/// A definition row of a sheet (spec §4): `caps` label column 96 wide in
/// `fg2`, `secondary` value, padding 12 0, hairline below.
class InkDefinitionRow extends StatelessWidget {
  const InkDefinitionRow({
    super.key,
    required this.label,
    required this.value,
    this.labelWidth = 96,
  });

  final String label;
  final String value;
  final double labelWidth;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final TextTheme text = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: InkSpacing.s12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: ink.line)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          SizedBox(
            width: labelWidth,
            child: Text(
              label.toUpperCase(),
              style: text.labelSmall?.copyWith(color: ink.fg2),
            ),
          ),
          const SizedBox(width: InkSpacing.block),
          Expanded(
            child: Text(value, style: text.bodyMedium?.copyWith(color: ink.fg)),
          ),
        ],
      ),
    );
  }
}
