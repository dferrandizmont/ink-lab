import 'package:flutter/material.dart';

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
  });

  final String hex;

  /// Square size; overrides [width] and [height].
  final double? size;
  final double? width;
  final double? height;
  final double radius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? width,
      height: size ?? height,
      decoration: BoxDecoration(
        color: swatchColor(hex),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: swatchEdgeColor(context, hex)),
      ),
      child: child,
    );
  }
}

/// A swatch cell of the Swatches grid (spec §4 "Swatch cell").
///
/// `surface` card, radius 10, 1 px `line` (or `action` when [selected]):
/// a 72-high colour block with a favourite star in `inkOn(swatch)`, then the
/// code (`code`) with an owned check, the name (`secondary`, 2 lines) and the
/// hex (`data`, `fg2`). When the parent constrains the height (a fixed grid
/// extent or [height]), the colour block shrinks and the name and hex drop out
/// as needed instead of overflowing.
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

  /// Whether to show the hex line.
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

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final Color background = swatchColor(hex);
    final Color onSwatch = inkOn(background);

    return Semantics(
      button: onTap != null,
      selected: selected,
      label: name == null ? code : '$code, $name',
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
                    _codeLine +
                    (name == null ? 0 : 2 * _nameLine) +
                    (showHex ? _hexLine : 0) +
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
                      _codeLine -
                      _minBlock;
                  nameLines = 0;
                  hexVisible = false;
                  if (name != null && budget >= _nameLine) {
                    nameLines = 1;
                    budget -= _nameLine;
                  }
                  if (showHex && budget >= _hexLine) {
                    hexVisible = true;
                    budget -= _hexLine;
                  }
                  // A second name line only when the block keeps its 72.
                  const double secondLine =
                      _nameLine + InkGeometry.swatchBlockHeight - _minBlock;
                  if (nameLines == 1 && budget >= secondLine) {
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
                            height: _codeLine,
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
                                if (owned)
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
                              height: _nameLine * nameLines,
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

class _ColourBlock extends StatelessWidget {
  const _ColourBlock({
    required this.background,
    required this.edge,
    required this.onSwatch,
    required this.favorite,
    required this.onFavoriteToggle,
    required this.favoriteTooltip,
  });

  final Color background;
  final Color edge;
  final Color onSwatch;
  final bool favorite;
  final VoidCallback? onFavoriteToggle;
  final String? favoriteTooltip;

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
