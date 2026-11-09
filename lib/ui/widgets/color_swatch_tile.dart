import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../core/color_utils.dart';
import '../icons/ink_icons.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/tokens.dart';
import '../../l10n/l10n.dart';

/// Colour of a swatch built from a hex string.
///
/// Returns a neutral colour when the hex cannot be parsed, so a malformed
/// colour from the dataset never crashes the UI.
Color swatchColor(String hex) {
  try {
    return Color(hexToColorInt(hex));
  } on FormatException {
    return AppColors.daySurfaceStrong;
  }
}

/// Pure black or white, whichever has the higher WCAG contrast on the swatch
/// of the given hex (spec §1 text-on-swatch rule, via [inkOn]).
Color swatchContentColor(String hex) => inkOn(swatchColor(hex));

/// The 1 px border of a swatch in the current theme (swatch edge rule).
Color swatchEdgeColor(BuildContext context, String hex) =>
    InkColors.of(context).swatchEdge(swatchColor(hex));

/// `#RRGGBB` in upper case, whatever the input format.
String displayHex(String hex) {
  final String bare = hex.startsWith('#') ? hex.substring(1) : hex;
  return '#${bare.toUpperCase()}';
}

/// A plain block of marker colour with the swatch edge rule applied.
///
/// Marker colours are never animated or altered by the theme.
class SwatchBlock extends StatelessWidget {
  const SwatchBlock({
    super.key,
    required this.hex,
    this.size,
    this.width,
    this.height,
    this.radius = InkRadii.control,
    this.child,
    this.own = false,
  });

  final String hex;

  /// Square size; overrides [width] and [height].
  final double? size;
  final double? width;
  final double? height;
  final double radius;
  final Widget? child;

  /// Whether the colour is the user's own colour for the marker rather than
  /// the catalogue's: a small mark sits in the corner (see [OwnColorMark]).
  final bool own;

  @override
  Widget build(BuildContext context) {
    final Widget? content = own
        ? Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ?child,
              OwnColorMark(color: swatchContentColor(hex)),
            ],
          )
        : child;
    return Container(
      width: size ?? width,
      height: size ?? height,
      decoration: BoxDecoration(
        color: swatchColor(hex),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: swatchEdgeColor(context, hex)),
      ),
      child: content,
    );
  }
}

/// The discreet mark that says a swatch shows the user's own colour: a small
/// square in the bottom-right corner, drawn in [color] (pass `inkOn` of the
/// swatch so it reads on any colour).
class OwnColorMark extends StatelessWidget {
  const OwnColorMark({super.key, required this.color, this.size = 6});

  final Color color;

  /// Side of the square.
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: size / 2 + 1,
      bottom: size / 2 + 1,
      child: IgnorePointer(
        child: SizedBox.square(
          dimension: size,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ),
      ),
    );
  }
}

/// A swatch cell of the Swatches grid (spec §4 "Swatch cell").
///
/// `surface` card, radius 10, 1 px `line` (or `action` when [selected]):
/// a 72-high colour block with a favourite star in `inkOn(swatch)`, then the
/// code (`code`) with an owned check, the name (`secondary`, 2 lines) and the
/// hex (`data`, `fg2`). The grid does not show the hex ([showHex] false):
/// it stays in the list and in the detail sheet, and the cells are shorter
/// without it. When the parent constrains the height (a fixed grid extent or
/// [height]), the colour block shrinks and the name and hex drop out as needed
/// instead of overflowing.
class ColorSwatchTile extends StatelessWidget {
  const ColorSwatchTile({
    super.key,
    required this.hex,
    required this.code,
    this.name,
    this.selected = false,
    this.favorite = false,
    this.onTap,
    this.onFavoriteToggle,
    this.width,
    this.height,
    this.owned = false,
    this.showHex = true,
    this.favoriteTooltip,
    this.ownColor = false,
    this.dried = false,
  });

  /// Colour of the swatch, as a hex string such as `#F08C6D`.
  final String hex;

  /// Marker code, e.g. `B114`.
  final String code;

  /// Optional colour name shown under the code.
  final String? name;

  /// Whether the swatch is the selected one (1 px `action` outline).
  final bool selected;

  /// Whether the swatch is a favourite (filled star).
  final bool favorite;

  /// Whether the marker is owned (check after the code).
  final bool owned;

  /// Whether the colour is the user's own colour for the marker (a small
  /// mark in the corner of the colour block).
  final bool ownColor;

  /// Whether the marker is dried out: a struck-through drop replaces the owned
  /// check.
  final bool dried;

  /// Whether to show the hex line.
  ///
  /// The grid leaves it out (the list and the detail sheet keep it): the
  /// cells are lower and more colours fit on the screen.
  final bool showHex;

  /// Called when the swatch is tapped.
  final VoidCallback? onTap;

  /// When set, the star becomes a 44×44 toggle button.
  final VoidCallback? onFavoriteToggle;

  /// Tooltip of the favourite toggle.
  final String? favoriteTooltip;

  /// Optional fixed width; the swatch fills its parent otherwise.
  final double? width;

  /// Optional fixed height; the natural cell height otherwise.
  final double? height;

  static const double _bodyTop = InkSpacing.cardV,
      _bodyBottom = InkSpacing.cardV,
      _codeLine = 22;
  static const double _nameLine = 20, _hexLine = 16, _minBlock = 32;

  // The font sizes behind those line heights (the code is 16/22, the name
  // 14/20, the hex 12/16): the system scales the font size, not the line.
  static const double _codeSize = 16, _nameSize = 14, _hexSize = 12;

  /// The height of a grid cell that holds the colour block, the code, two name
  /// lines and the hex line (spec §4 "Swatch cell").
  ///
  /// The text lines grow with the system font scale, so the cell does too:
  /// with fixed lines a second name line would be cut at the card's bottom edge
  /// at large text sizes. A cell without the hex (the grid) is one line
  /// shorter.
  static double gridCellHeight(BuildContext context, {bool showHex = true}) =>
      InkGeometry.swatchBlockHeight +
      _bodyTop +
      _bodyBottom +
      _line(context, _codeLine, _codeSize) +
      2 * _line(context, _nameLine, _nameSize) +
      (showHex ? _line(context, _hexLine, _hexSize) : 0);

  /// [height], a line height at scale 1 of a text of [fontSize], as the system
  /// text scale makes it.
  ///
  /// The scaler is asked for the font size, as the text does: Android scales
  /// text non-linearly (a 14 sp name grows more than a 20 sp line would), so
  /// scaling the line itself came out too short at large text sizes and cut
  /// the second line of a name at the card's bottom edge.
  static double _line(BuildContext context, double height, double fontSize) =>
      MediaQuery.textScalerOf(context).scale(fontSize) * height / fontSize;

  /// The grid delegate for a grid of [ColorSwatchTile]s, from the system text
  /// scale and whether the cells show the hex (the grid leaves it out).
  ///
  /// See [SwatchGridDelegate] for how the column count is chosen.
  static SliverGridDelegate gridDelegate(
    BuildContext context, {
    bool showHex = false,
  }) => SwatchGridDelegate(
    textScale: MediaQuery.textScalerOf(context).scale(1.0),
    showHex: showHex,
    cellHeight: gridCellHeight(context, showHex: showHex),
  );

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final Color background = swatchColor(hex);
    final Color onSwatch = inkOn(background);
    final double codeLine = _line(context, _codeLine, _codeSize);
    final double nameLine = _line(context, _nameLine, _nameSize);
    final double hexLine = _line(context, _hexLine, _hexSize);

    return Semantics(
      button: onTap != null,
      selected: selected,
      label:
          (name == null ? code : '$code, $name') +
          (ownColor ? ', ${context.l10n.commonOwnColour}' : '') +
          (dried ? ', ${context.l10n.commonDried}' : ''),
      child: SizedBox(
        width: width,
        height: height,
        child: Material(
          color: ink.surface,
          shape: RoundedRectangleBorder(
            borderRadius: InkRadii.cellRadius,
            side: BorderSide(color: selected ? ink.action : ink.line),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double natural =
                    InkGeometry.swatchBlockHeight +
                    _bodyTop +
                    codeLine +
                    (name == null ? 0 : 2 * nameLine) +
                    (showHex ? hexLine : 0) +
                    _bodyBottom;
                // Fill the height only when it is imposed (a grid extent or
                // [height]) or too short for the natural cell.
                final bool bounded =
                    constraints.hasBoundedHeight &&
                    (constraints.hasTightHeight ||
                        constraints.maxHeight < natural);
                int nameLines = name == null ? 0 : 2;
                bool hexVisible = showHex;
                if (bounded) {
                  double budget =
                      constraints.maxHeight -
                      _bodyTop -
                      _bodyBottom -
                      codeLine -
                      _minBlock;
                  nameLines = 0;
                  hexVisible = false;
                  if (name != null && budget >= nameLine) {
                    nameLines = 1;
                    budget -= nameLine;
                  }
                  if (showHex && budget >= hexLine) {
                    hexVisible = true;
                    budget -= hexLine;
                  }
                  // A second name line only when the block keeps its 72.
                  final double secondLine =
                      nameLine + InkGeometry.swatchBlockHeight - _minBlock;
                  // (a hair of tolerance for the rounding of scaled lines)
                  if (nameLines == 1 && budget + 0.01 >= secondLine) {
                    nameLines = 2;
                  }
                }
                final Widget block = _ColourBlock(
                  background: background,
                  edge: ink.swatchEdge(background),
                  onSwatch: onSwatch,
                  favorite: favorite,
                  onFavoriteToggle: onFavoriteToggle,
                  favoriteTooltip: favoriteTooltip,
                  ownColor: ownColor,
                );
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if (bounded)
                      Expanded(child: block)
                    else
                      SizedBox(
                        height: InkGeometry.swatchBlockHeight,
                        child: block,
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        InkSpacing.cardV,
                        _bodyTop,
                        InkSpacing.cardV,
                        _bodyBottom,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: codeLine,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    code,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.code.copyWith(
                                      color: ink.fg,
                                    ),
                                  ),
                                ),
                                if (dried)
                                  InkIcon(
                                    InkIcons.dropletOff,
                                    size: InkGeometry.smallIcon,
                                    color: ink.fg2,
                                    semanticLabel: context.l10n.commonDried,
                                  )
                                else if (owned)
                                  InkIcon(
                                    InkIcons.check,
                                    size: InkGeometry.smallIcon,
                                    color: ink.fg2,
                                    semanticLabel: context.l10n.commonOwned,
                                  ),
                              ],
                            ),
                          ),
                          if (nameLines > 0)
                            SizedBox(
                              height: nameLine * nameLines,
                              // A name can be longer than the cell: the tile opens
                              // the full detail on tap, and a long press shows
                              // the whole name.
                              child: Tooltip(
                                message: name!,
                                excludeFromSemantics: true,
                                child: Text(
                                  name!,
                                  maxLines: nameLines,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.secondary.copyWith(
                                    color: ink.fg,
                                  ),
                                ),
                              ),
                            ),
                          if (hexVisible)
                            Text(
                              displayHex(hex),
                              maxLines: 1,
                              style: AppTypography.data.copyWith(
                                color: ink.fg2,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// The grid delegate of the Swatches grid.
///
/// A [SliverGridDelegateWithMaxCrossAxisExtent] fits as many 130 dp cells as
/// the width allows: three columns on any phone. At large system text those
/// cells become too narrow and the colour names break inside words
/// ("Turquoi / se"). This delegate keeps the same count as before when the
/// text is normal (so a 1.0 layout is identical, tablets included) and drops
/// columns as the text grows, so every name still has a cell as wide as the
/// narrowest cell of the old grid (98 dp on a 360 dp phone) for the current
/// text scale.
class SwatchGridDelegate extends SliverGridDelegate {
  const SwatchGridDelegate({
    required this.textScale,
    required this.showHex,
    required this.cellHeight,
  });

  /// The system text scale ([MediaQuery.textScalerOf]).
  final double textScale;

  /// Whether the cells show the hex line (the grid leaves it out).
  final bool showHex;

  /// The height of a cell, from [ColorSwatchTile.gridCellHeight].
  final double cellHeight;

  /// The cell extent the grid used before (its three-column maximum).
  static const double _maxCellExtent = 130;

  /// The narrowest cell of the old grid (a 360 dp phone): below this, long
  /// names break inside words.
  static const double _narrowestCell = 98;

  /// The gap between cells.
  static const double _spacing = InkSpacing.block;

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final double extent = constraints.crossAxisExtent;
    // Exactly today's count: what the max-extent delegate would pick.
    final int byExtent = (extent / (_maxCellExtent + _spacing)).ceil();
    // The most columns that still leaves every cell as wide as the narrowest
    // cell of the old grid, at the current text scale.
    final int byText =
        ((extent + _spacing) / (_narrowestCell * textScale + _spacing)).floor();
    final int count = math.max(2, math.min(byExtent, byText));
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: count,
      mainAxisExtent: cellHeight,
      crossAxisSpacing: _spacing,
      mainAxisSpacing: _spacing,
    ).getLayout(constraints);
  }

  @override
  bool shouldRelayout(covariant SwatchGridDelegate oldDelegate) =>
      oldDelegate.textScale != textScale ||
      oldDelegate.showHex != showHex ||
      oldDelegate.cellHeight != cellHeight;
}

class _ColourBlock extends StatelessWidget {
  const _ColourBlock({
    required this.background,
    required this.edge,
    required this.onSwatch,
    required this.favorite,
    required this.onFavoriteToggle,
    required this.favoriteTooltip,
    required this.ownColor,
  });

  final Color background;
  final Color edge;
  final Color onSwatch;
  final bool favorite;
  final VoidCallback? onFavoriteToggle;
  final String? favoriteTooltip;
  final bool ownColor;

  @override
  Widget build(BuildContext context) {
    final Widget star = InkIcon(
      InkIcons.star,
      size: InkGeometry.smallIcon,
      color: onSwatch,
      filled: favorite,
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        border: Border(bottom: BorderSide(color: edge)),
      ),
      child: Stack(
        children: <Widget>[
          if (ownColor) OwnColorMark(color: onSwatch, size: 8),
          if (onFavoriteToggle != null)
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: onFavoriteToggle,
                isSelected: favorite,
                tooltip:
                    favoriteTooltip ??
                    (favorite
                        ? context.l10n.commonRemoveFromFavourites
                        : context.l10n.commonAddToFavourites),
                alignment: Alignment.topRight,
                padding: const EdgeInsets.all(8),
                constraints: const BoxConstraints.tightFor(
                  width: InkGeometry.target,
                  height: InkGeometry.target,
                ),
                style: IconButton.styleFrom(
                  shape: const CircleBorder(),
                  foregroundColor: onSwatch,
                ),
                icon: star,
              ),
            )
          else if (favorite)
            Positioned(
              top: 8,
              right: 8,
              child: InkIcon(
                InkIcons.star,
                size: InkGeometry.smallIcon,
                color: onSwatch,
                filled: true,
                semanticLabel: context.l10n.commonFavourite,
              ),
            ),
        ],
      ),
    );
  }
}
