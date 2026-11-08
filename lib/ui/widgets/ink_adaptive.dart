import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../icons/ink_icons.dart';
import '../theme/tokens.dart';
import 'ink_button.dart';

/// The tablet layout system: breakpoints, widths and column counts.
///
/// Every value is measured on the width the page actually gets (a
/// [LayoutBuilder] inside the shell, so the navigation rail is already taken
/// away), never on the screen: an iPad in Split View or Slide Over gets the
/// phone layout of its narrow window.
///
/// * Below [readableWidth] a page uses the whole width, as on a phone.
/// * Reading and form pages stop at [readableWidth], centred.
/// * Pages that lay content in columns (Ideas, the diary) stop at
///   [wideWidth] and pick their column count with [columns].
/// * From [splitBreakpoint], in landscape, Match and Palette put their two
///   halves side by side.
/// * From [twoPaneBreakpoint] Swatches shows the grid and the detail of the
///   marker side by side; below it the detail is a sheet.
/// * Sheets never grow wider than [sheetWidth]; wider screens centre them.
abstract final class InkLayout {
  /// Widest column of a reading or form page, page margins included: lines of
  /// body text stay well under 90 characters.
  static const double readableWidth = 720;

  /// Widest column of a page that lays its content in columns.
  static const double wideWidth = 1040;

  /// Widest a bottom sheet gets.
  static const double sheetWidth = 640;

  /// Page width from which Swatches shows the detail next to the grid.
  static const double twoPaneBreakpoint = 1000;

  /// Width of the detail pane of a two-pane page.
  static const double detailPaneWidth = 400;

  /// Page width from which a landscape page splits in two columns.
  static const double splitBreakpoint = 840;

  /// Height of a page below which it is a short screen (a phone in
  /// landscape): a page that pins a tall footer folds it into less height,
  /// so the content keeps room to be read.
  static const double shortPageHeight = 480;

  /// The gap between the two halves of a split page.
  static const double splitGap = InkSpacing.section;

  /// Constraints of every bottom sheet: as wide as the screen on a phone,
  /// [sheetWidth] at most (centred) on a tablet.
  static const BoxConstraints sheetConstraints = BoxConstraints(
    maxWidth: sheetWidth,
  );

  /// Whether a page [width] wide shows a list and its detail side by side.
  static bool isTwoPane(double width) => width >= twoPaneBreakpoint;

  /// Whether a page of [size] splits its content in two columns: wide
  /// enough, and wider than tall (landscape).
  static bool isSplit(Size size) =>
      size.width >= splitBreakpoint && size.width > size.height;

  /// How many columns of at least [minExtent] fit in [width], [spacing]
  /// apart, between [min] and [max].
  static int columns(
    double width, {
    required double minExtent,
    double spacing = InkSpacing.block,
    int min = 1,
    int max = 4,
  }) {
    final int fit = ((width + spacing) / (minExtent + spacing)).floor();
    return math.max(min, math.min(max, fit));
  }

  /// Minimum width of one column of cards or rows (Ideas, diary entries).
  static const double cardColumnMinWidth = 360;
}

/// Centres [child] in a column at most [maxWidth] wide (by default
/// [InkLayout.readableWidth]); narrower parents give it their whole width.
///
/// The widget tree is the same at every width, so crossing the breakpoint
/// (rotating, resizing a Split View window) keeps scroll positions, text
/// fields and focus. Wrap a scrollable in it: the scroll area is the column.
class InkReadableWidth extends StatelessWidget {
  const InkReadableWidth({
    super.key,
    required this.child,
    this.maxWidth = InkLayout.readableWidth,
  });

  final Widget child;

  /// Widest the column gets.
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.hasBoundedWidth
            ? math.min(maxWidth, constraints.maxWidth)
            : maxWidth;
        return Align(
          alignment: Alignment.topCenter,
          // In an unbounded height (inside a scroll view) the column is as
          // tall as its child.
          heightFactor: constraints.hasBoundedHeight ? null : 1,
          child: SizedBox(width: width, child: child),
        );
      },
    );
  }
}

/// Lays [children] in rows of [columns], [spacing] apart; the cells of a row
/// share its height (so hairlines and card edges line up). One column is a
/// plain column of [children].
class InkColumns extends StatelessWidget {
  const InkColumns({
    super.key,
    required this.columns,
    required this.children,
    this.spacing = InkSpacing.block,
    this.runSpacing = 0,
  });

  final int columns;
  final List<Widget> children;

  /// Gap between the cells of a row.
  final double spacing;

  /// Gap between the rows.
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    if (columns <= 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < children.length; i++) ...<Widget>[
            if (i > 0 && runSpacing > 0) SizedBox(height: runSpacing),
            children[i],
          ],
        ],
      );
    }
    final List<Widget> rows = <Widget>[];
    for (int start = 0; start < children.length; start += columns) {
      if (start > 0 && runSpacing > 0) rows.add(SizedBox(height: runSpacing));
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (int c = 0; c < columns; c++) ...<Widget>[
                if (c > 0) SizedBox(width: spacing),
                Expanded(
                  child: start + c < children.length
                      ? children[start + c]
                      : const SizedBox.shrink(),
                ),
              ],
            ],
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }
}

/// The detail pane of a two-pane page: the frame of a sheet standing next to
/// the list (`raised`, a hairline on its leading edge, the sheet's padding),
/// with [actions] and a close button in its top-right corner.
class InkDetailPane extends StatelessWidget {
  const InkDetailPane({
    super.key,
    required this.child,
    this.onClose,
    this.actions = const <Widget>[],
    this.closeTooltip,
  });

  /// The content; a scrollable fills the pane.
  final Widget child;

  /// Closes the pane (clears the selection of the list); `null` hides the
  /// close button (nothing to close).
  final VoidCallback? onClose;

  /// Icon buttons painted to the left of the close button.
  final List<Widget> actions;

  /// Tooltip of the close button; defaults to the localised "Close".
  final String? closeTooltip;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ink.raised,
        border: BorderDirectional(start: BorderSide(color: ink.line)),
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            // The top padding matches the sheet's: grabber zone included, so
            // the content starts at the same height as in the sheet.
            // The pane reaches the bottom edge of the screen, so its content
            // keeps clear of the system navigation bar (like [InkSheet]).
            padding: EdgeInsets.fromLTRB(
              InkSpacing.sheet,
              InkSpacing.s12 + InkGeometry.grabberHeight + InkSpacing.block,
              InkSpacing.sheet,
              InkSpacing.sheet + MediaQuery.paddingOf(context).bottom,
            ),
            child: child,
          ),
          PositionedDirectional(
            top: InkSpacing.s10,
            end: InkSpacing.s8,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                for (final Widget action in actions) ...<Widget>[
                  action,
                  const SizedBox(width: InkSpacing.s4),
                ],
                if (onClose != null)
                  InkIconButton(
                    key: const ValueKey<String>('detail-pane-close'),
                    icon: InkIcons.x,
                    tooltip: closeTooltip ?? context.l10n.commonClose,
                    onPressed: onClose,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Cards or rows in as many columns of at least
/// [InkLayout.cardColumnMinWidth] as the width allows (one on a phone, two
/// on a tablet), [spacing] apart. See [InkColumns].
class InkCardColumns extends StatelessWidget {
  const InkCardColumns({
    super.key,
    required this.children,
    this.spacing = InkSpacing.block,
    this.runSpacing = 0,
    this.maxColumns = 3,
  });

  final List<Widget> children;
  final double spacing;
  final double runSpacing;

  /// The most columns, however wide the page.
  final int maxColumns;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => InkColumns(
        columns: InkLayout.columns(
          constraints.maxWidth,
          minExtent: InkLayout.cardColumnMinWidth,
          spacing: spacing,
          max: maxColumns,
        ),
        spacing: spacing,
        runSpacing: runSpacing,
        children: children,
      ),
    );
  }
}
