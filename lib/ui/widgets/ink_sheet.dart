import 'package:flutter/gestures.dart' show Drag;
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
  return _showSheetRoute<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    builder: (BuildContext sheetContext) => InkSheet(
      showClose: showClose,
      closeTooltip: closeTooltip,
      child: Builder(builder: builder),
    ),
  );
}

/// The modal route shared by [showInkSheet] and [showInkDraggableSheet]:
/// transparent route background (the frame paints the sheet), the ink scrim
/// and the sheet slide, which is instant when animations are disabled.
Future<T?> _showSheetRoute<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isScrollControlled = true,
  bool enableDrag = true,
}) {
  final InkColors ink = InkColors.of(context);
  final bool still = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    enableDrag: enableDrag,
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
    builder: builder,
  );
}

/// Builds the content of a draggable sheet. Return a scrollable (a
/// [ListView], or a [SingleChildScrollView]) and give it [scrollController]
/// as its `controller`: that is what lets a drag on the content resize the
/// sheet before it scrolls.
typedef InkDraggableSheetBuilder = Widget Function(
  BuildContext context,
  ScrollController scrollController,
);

/// Shows a design G sheet that opens at [initial] of the available height and
/// can be dragged up to [max] (usually full screen) and down to [min], where
/// it closes. It settles on [snaps] (and on [min] and [max]) when released.
///
/// Use it for cards that show the essentials first and the detail one
/// gesture away (marker sheet, idea sheet, pickers of saved palettes).
/// The content scrolls only once the sheet is at [max]; dragging the content
/// or the grabber area at the top of the sheet resizes it.
///
/// [builder] must return a scrollable bound to the given controller:
///
/// ```dart
/// showInkDraggableSheet<void>(
///   context: context,
///   actions: <Widget>[InkOverflowMenu(items: items)],
///   builder: (BuildContext context, ScrollController scroll) => ListView(
///     controller: scroll,
///     padding: EdgeInsets.zero,
///     children: <Widget>[...],
///   ),
/// );
/// ```
///
/// [actions] are icon buttons painted left of the close button (see
/// [InkSheet.actions]); the content must leave room for them at the top
/// right (about 48 dp each, plus the close button). Pass a [controller] to
/// move the sheet from inside the content, for example to bring it back to
/// [initial] with [InkDraggableSheetController.moveTo]; the caller owns it
/// and disposes it once the returned future completes:
///
/// ```dart
/// final DraggableScrollableController sheet = DraggableScrollableController();
/// showInkDraggableSheet<void>(context: context, controller: sheet, ...)
///     .whenComplete(sheet.dispose);
/// ```
///
/// With animations disabled by the platform the sheet opens without
/// animating and settles on a snap size within a few frames (Flutter
/// requires a positive snap duration, so one microsecond is used).
Future<T?> showInkDraggableSheet<T>({
  required BuildContext context,
  required InkDraggableSheetBuilder builder,
  double initial = 0.5,
  List<double> snaps = const <double>[0.5],
  double max = 1.0,
  double min = 0.25,
  List<Widget> actions = const <Widget>[],
  bool showClose = true,
  String? closeTooltip,
  DraggableScrollableController? controller,
}) {
  assert(min <= initial && initial <= max, 'min <= initial <= max');
  assert(
    snaps.every((double s) => s >= min && s <= max),
    'every snap must be between min and max',
  );
  final bool still = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
  return _showSheetRoute<T>(
    context: context,
    // The sheet moves itself: the route's own drag would fight with it.
    enableDrag: false,
    builder: (BuildContext sheetContext) => DraggableScrollableSheet(
      controller: controller,
      initialChildSize: initial,
      minChildSize: min,
      maxChildSize: max,
      snap: true,
      snapSizes: snaps,
      snapAnimationDuration: still ? const Duration(microseconds: 1) : null,
      expand: false,
      shouldCloseOnMinExtent: true,
      builder: (BuildContext context, ScrollController scroll) => InkSheet(
        showClose: showClose,
        closeTooltip: closeTooltip,
        actions: actions,
        dragController: scroll,
        child: Builder(
          builder: (BuildContext context) => builder(context, scroll),
        ),
      ),
    ),
  );
}

/// Moving a [showInkDraggableSheet] from its content.
extension InkDraggableSheetController on DraggableScrollableController {
  /// Takes the sheet to [size] (a fraction of the available height): animated
  /// in 240 ms, or at once when the platform disables animations. Does
  /// nothing while the sheet is not attached (not built yet, or closed).
  Future<void> moveTo(BuildContext context, double size) async {
    if (!isAttached) return;
    if (InkMotion.accessible(context, InkMotion.sheetIn) == Duration.zero) {
      jumpTo(size);
      return;
    }
    await animateTo(
      size,
      duration: InkMotion.sheetIn,
      curve: InkMotion.sheetInCurve,
    );
  }
}

/// The frame of a design G sheet; usable on its own inside custom routes.
class InkSheet extends StatelessWidget {
  const InkSheet({
    super.key,
    required this.child,
    this.showClose = true,
    this.closeTooltip,
    this.onClose,
    this.actions = const <Widget>[],
    this.dragController,
  });

  final Widget child;
  final bool showClose;

  /// Icon buttons (for example an [InkOverflowMenu]) painted to the left of
  /// the close button, in the same top-right corner, 4 dp apart. Give the
  /// sheet's own header room for them: each takes 44 dp plus the gap.
  final List<Widget> actions;

  /// A scroll controller of the content that the grabber area (the top 32 dp
  /// of the sheet) forwards vertical drags to. [showInkDraggableSheet] sets
  /// it so the grabber resizes the sheet like the content does.
  final ScrollController? dragController;

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
          if (dragController != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: _grabberZone,
              child: _GrabberDrag(controller: dragController!),
            ),
          if (showClose || actions.isNotEmpty)
            Positioned(
              top: InkSpacing.s10,
              right: InkSpacing.s8,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  for (final Widget action in actions) ...<Widget>[
                    action,
                    const SizedBox(width: InkSpacing.s4),
                  ],
                  if (showClose)
                    InkIconButton(
                      icon: InkIcons.x,
                      tooltip: closeTooltip ?? context.l10n.commonClose,
                      onPressed:
                          onClose ?? () => Navigator.of(context).maybePop(),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// Height of the strip at the top of a draggable sheet that drags it (the
/// padding above the grabber, the grabber and the gap below it).
const double _grabberZone = 32;

/// Forwards vertical drags on its area to the scroll position of the
/// content, so the sheet resizes (and snaps, and closes) exactly as when the
/// content itself is dragged.
class _GrabberDrag extends StatefulWidget {
  const _GrabberDrag({required this.controller});

  final ScrollController controller;

  @override
  State<_GrabberDrag> createState() => _GrabberDragState();
}

class _GrabberDragState extends State<_GrabberDrag> {
  Drag? _drag;

  void _start(DragStartDetails details) {
    if (!widget.controller.hasClients) return;
    _drag = widget.controller.position.drag(details, () => _drag = null);
  }

  void _end(DragEndDetails details) {
    _drag?.end(details);
    _drag = null;
  }

  @override
  void dispose() {
    _drag?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragStart: _start,
      onVerticalDragUpdate: (DragUpdateDetails d) => _drag?.update(d),
      onVerticalDragEnd: _end,
      onVerticalDragCancel: () => _drag?.cancel(),
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

  /// The label column width that fits the widest of [labels] (never below
  /// [minWidth]), so the rows of one list align in every language and at
  /// every text scale. Capped at [maxWidth]: a wider label stacks above its
  /// value instead.
  static double labelWidthFor(
    BuildContext context,
    Iterable<String> labels, {
    double minWidth = 96,
    double maxWidth = 136,
  }) {
    final InkColors ink = InkColors.of(context);
    final TextStyle? style = Theme.of(context).textTheme.labelSmall
        ?.copyWith(color: ink.fg2);
    final TextDirection direction = Directionality.of(context);
    final TextScaler scaler = MediaQuery.textScalerOf(context);
    double widest = minWidth;
    for (final String label in labels) {
      final TextPainter painter = TextPainter(
        text: TextSpan(text: label.toUpperCase(), style: style),
        textDirection: direction,
        textScaler: scaler,
        maxLines: 1,
      )..layout();
      if (painter.width + 1 > widest) widest = painter.width + 1;
      painter.dispose();
    }
    return widest > maxWidth ? maxWidth : widest;
  }

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final TextTheme text = Theme.of(context).textTheme;
    final TextStyle? labelStyle = text.labelSmall?.copyWith(color: ink.fg2);
    final Text labelText = Text(
      label.toUpperCase(),
      maxLines: 1,
      softWrap: false,
      style: labelStyle,
    );
    final Text valueText = Text(
      value,
      style: text.bodyMedium?.copyWith(color: ink.fg),
    );
    // The label column is fixed; a label that is wider than it (a long
    // translation, or large text) goes on its own line above the value
    // instead of being cut or wrapped.
    final TextPainter painter = TextPainter(
      text: TextSpan(text: label.toUpperCase(), style: labelStyle),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
      maxLines: 1,
    )..layout();
    final bool stacked = painter.width > labelWidth;
    painter.dispose();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: InkSpacing.s12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: ink.line)),
      ),
      child: stacked
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                labelText,
                const SizedBox(height: InkSpacing.s4),
                valueText,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                SizedBox(width: labelWidth, child: labelText),
                const SizedBox(width: InkSpacing.block),
                Expanded(child: valueText),
              ],
            ),
    );
  }
}
