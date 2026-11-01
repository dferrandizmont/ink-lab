import 'package:flutter/material.dart';

import '../icons/ink_icons.dart';
import '../theme/app_typography.dart';
import '../theme/tokens.dart';
import 'color_swatch_tile.dart';
import '../../l10n/l10n.dart';

/// A swatch row for list mode (spec §4 "Swatch list row"): 64 high, 44×44
/// radius 10 swatch with the edge rule, gap 12, `code` + `secondary` name,
/// trailing `data` hex in `fg2` and an owned check. Put a `Divider` between
/// rows for the hairline.
class SwatchListTile extends StatelessWidget {
  const SwatchListTile({
    super.key,
    required this.hex,
    required this.code,
    this.name,
    this.owned = false,
    this.favorite = false,
    this.selected = false,
    this.onTap,
    this.trailing,
    this.ownColor = false,
    this.dried = false,
  });

  final String hex;
  final String code;
  final String? name;
  final bool owned;
  final bool favorite;
  final bool selected;
  final VoidCallback? onTap;

  /// Whether the colour is the user's own colour for the marker (a small
  /// mark on the swatch).
  final bool ownColor;

  /// Whether the marker is dried out: a struck-through drop replaces the owned
  /// check.
  final bool dried;

  /// Replaces the hex + owned trailing.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Semantics(
      button: onTap != null,
      selected: selected,
      label:
          (name == null ? code : '$code, $name') +
          (ownColor ? ', ${context.l10n.commonOwnColour}' : '') +
          (dried ? ', ${context.l10n.commonDried}' : ''),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 64,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: InkSpacing.gutter),
            child: Row(
              children: <Widget>[
                SwatchBlock(
                  hex: hex,
                  size: InkGeometry.target,
                  own: ownColor,
                  child: favorite
                      ? Center(
                          child: InkIcon(
                            InkIcons.star,
                            size: InkGeometry.smallIcon,
                            filled: true,
                            color: swatchContentColor(hex),
                            semanticLabel: context.l10n.commonFavourite,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        code,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.code.copyWith(color: ink.fg),
                      ),
                      if (name != null)
                        Text(
                          name!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.secondary.copyWith(
                            color: ink.fg,
                          ),
                        ),
                    ],
                  ),
                ),
                if (trailing != null)
                  trailing!
                else ...<Widget>[
                  Text(
                    displayHex(hex),
                    style: AppTypography.data.copyWith(color: ink.fg2),
                  ),
                  if (dried || owned) ...<Widget>[
                    const SizedBox(width: 8),
                    InkIcon(
                      dried ? InkIcons.dropletOff : InkIcons.check,
                      size: InkGeometry.smallIcon,
                      color: ink.fg2,
                      semanticLabel: dried
                          ? context.l10n.commonDried
                          : context.l10n.commonOwned,
                    ),
                  ],
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
