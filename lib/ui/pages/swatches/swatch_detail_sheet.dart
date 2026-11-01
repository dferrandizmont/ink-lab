import 'package:flutter/material.dart';

import '../../../core/color_utils.dart';
import '../../../core/models.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_sheet.dart';
import '../../widgets/page_header.dart';
import 'swatch_status_section.dart';
import '../../../l10n/l10n.dart';

/// A colour close to the one a [SwatchDetailSheet] describes.
@immutable
class SwatchAlternative {
  const SwatchAlternative({required this.color, required this.deltaE});

  final MarkerColor color;

  /// Colour distance to the described colour (CIE76, from `core`).
  final double deltaE;
}

/// The [SwatchAlternative]s closest to [color] among [pool], nearest first.
///
/// Distances come from the colour utilities of `core` (CIE76); colours whose
/// hex cannot be parsed are skipped.
List<SwatchAlternative> closestAlternatives(
  MarkerColor color,
  Iterable<MarkerColor> pool, {
  int limit = 3,
}) {
  final LabColor origin;
  try {
    origin = hexToLab(color.hex);
  } on FormatException {
    return const <SwatchAlternative>[];
  }
  final List<SwatchAlternative> found = <SwatchAlternative>[];
  for (final MarkerColor other in pool) {
    if (other.colorId == color.colorId) continue;
    try {
      found.add(
        SwatchAlternative(
          color: other,
          deltaE: deltaE76(origin, hexToLab(other.hex)),
        ),
      );
    } on FormatException {
      // A malformed catalogue entry is simply not offered.
    }
  }
  found.sort(
    (SwatchAlternative a, SwatchAlternative b) => a.deltaE.compareTo(b.deltaE),
  );
  return found.take(limit).toList();
}

/// Detail sheet content of a single swatch (spec §4 "Swatch detail sheet").
///
/// Meant to live inside an [InkSheet] (see `showInkSheet`): a hero swatch with
/// the new and old code, the name, the hex and RGB values, the packs and the
/// card location, the favourite / copy / add-to-palette actions and the
/// closest alternatives.
class SwatchDetailSheet extends StatelessWidget {
  const SwatchDetailSheet({
    super.key,
    required this.color,
    required this.favorite,
    required this.onToggleFavorite,
    this.onCopyHex,
    this.onAddToPalette,
    this.onBlendingChain,
    this.alternatives = const <SwatchAlternative>[],
    this.onSelectAlternative,
    this.lineLabels = const <String>[],
    this.packLabels = const <String>[],
    this.cardLocation,
    this.onSetOwnColor,
    this.onResetOwnColor,
    this.onToggleWishlist,
    this.onToggleDried,
    this.wished = false,
    this.dried = false,
    this.owned = false,
    this.brandEquivalents,
    this.brandLabel,
    this.showPaletteActions = true,
  });

  /// The colour the sheet describes.
  final MarkerColor color;

  /// Whether the colour is one of the user's favourites.
  final bool favorite;

  /// Called when the favourite button is pressed.
  final VoidCallback onToggleFavorite;

  /// Called when the user asks for the hexadecimal value to be copied.
  final VoidCallback? onCopyHex;

  /// Called when the user adds the colour to a palette.
  final VoidCallback? onAddToPalette;

  /// Called when the user asks for a blending chain around the colour. Without
  /// it the action is not shown.
  final VoidCallback? onBlendingChain;

  /// The closest colours, nearest first.
  final List<SwatchAlternative> alternatives;

  /// Called when an alternative is tapped.
  final ValueChanged<MarkerColor>? onSelectAlternative;

  /// Names of the product lines the colour is sold in ("Oahu", "Honolulu").
  final List<String> lineLabels;

  /// Names of the packs that contain the colour.
  final List<String> packLabels;

  /// Where the colour sits on the swatch card, when known.
  final String? cardLocation;

  /// Called when the user wants to set (or change) their own colour for the
  /// marker. Without it the "My colour" section is not shown.
  final VoidCallback? onSetOwnColor;

  /// Called when the user drops their own colour and goes back to the
  /// catalogue's. Only offered while the marker has an own colour.
  final VoidCallback? onResetOwnColor;

  /// Called when the user adds the marker to, or takes it off, the wishlist.
  /// Without it the wishlist and dried-out controls are not shown.
  final VoidCallback? onToggleWishlist;

  /// Called when the user marks the marker as dried out, or as usable again.
  final VoidCallback? onToggleDried;

  /// Whether the marker is on the wishlist.
  final bool wished;

  /// Whether the marker is marked as dried out.
  final bool dried;

  /// Whether the marker is in the user's collection.
  final bool owned;

  /// The "In other brands" section (see `BrandEquivalentsSection`), shown
  /// after the closest alternatives. Without it the section is not shown.
  final Widget? brandEquivalents;

  /// The brand of the marker, shown as a row of its own. Only given when the
  /// sheet describes a marker of a brand other than the one the app works
  /// with, where a code alone would be ambiguous.
  final String? brandLabel;

  /// Whether "Add to palette" and the blending chain are offered. A marker of
  /// a brand other than the active one cannot go into a palette, which only
  /// holds the markers of the brand chosen in Settings.
  final bool showPaletteActions;

  /// The hexadecimal value, as shown to the user.
  String get displayHex => displayHexOf(color.hex);

  /// `#RRGGBB` in upper case.
  static String displayHexOf(String hex) =>
      hex.startsWith('#') ? hex.toUpperCase() : '#${hex.toUpperCase()}';

  /// Most packs a colour is listed in before the rest is summarised: a
  /// colour sold in every line sits in two dozen packs.
  static const int maxPackLabels = 6;

  String _packsText(BuildContext context) {
    if (packLabels.length <= maxPackLabels) return packLabels.join(', ');
    final String more = context.l10n.swatchesMorePacks(
      packLabels.length - maxPackLabels,
    );
    return '${packLabels.take(maxPackLabels).join(', ')}, $more';
  }

  String? _rgbLine(BuildContext context) {
    try {
      final RgbColor rgb = hexToRgb(color.hex);
      return context.l10n.commonRgb(rgb.r, rgb.g, rgb.b);
    } on FormatException {
      return null;
    }
  }

  /// The "My colour" section: both colours side by side once the user has
  /// their own, and the way to set, change or drop it.
  Widget _buildOwnColor(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final bool stacked = MediaQuery.textScalerOf(context).scale(1) > 1.15;
    final Widget catalogue = _OwnColorSide(
      label: context.l10n.swatchesCatalogueLabel,
      hex: color.originalHex,
    );
    final Widget mine = _OwnColorSide(
      label: context.l10n.swatchesMineLabel,
      hex: color.hex,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        InkSectionHeading(context.l10n.swatchesMyColourTitle),
        const SizedBox(height: InkSpacing.group),
        if (color.hasOwnColor)
          // Side by side; with large text each colour needs a full row.
          KeyedSubtree(
            key: const ValueKey<String>('swatch-own-compare'),
            child: stacked
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      catalogue,
                      const SizedBox(height: InkSpacing.group),
                      mine,
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(child: catalogue),
                      const SizedBox(width: InkSpacing.block),
                      Expanded(child: mine),
                    ],
                  ),
          )
        else
          Text(
            context.l10n.swatchesMyColourHelp,
            style: AppTypography.secondary.copyWith(color: ink.fg2),
          ),
        const SizedBox(height: InkSpacing.group),
        Wrap(
          spacing: InkSpacing.s8,
          runSpacing: InkSpacing.s4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            InkButton.secondary(
              key: const ValueKey<String>('swatch-own-set'),
              label: color.hasOwnColor
                  ? context.l10n.swatchesMyColourChange
                  : context.l10n.swatchesMyColourSet,
              icon: InkIcons.edit3,
              onPressed: onSetOwnColor,
            ),
            if (color.hasOwnColor && onResetOwnColor != null)
              InkButton.text(
                key: const ValueKey<String>('swatch-own-reset'),
                label: context.l10n.swatchesMyColourReset,
                icon: InkIcons.rotateCcw,
                onPressed: onResetOwnColor,
              ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final bool hasOldCode = color.oldCode != color.newCode;
    final bool hasOldName = color.oldName != color.newName;
    final String? rgbLine = _rgbLine(context);
    final List<(String, String)> definitions = <(String, String)>[
      if (brandLabel != null) (context.l10n.settingsBrandTitle, brandLabel!),
      if (lineLabels.isNotEmpty)
        (context.l10n.swatchesLines, lineLabels.join(', ')),
      if (packLabels.isNotEmpty)
        (context.l10n.swatchesInPacks, _packsText(context)),
      if (cardLocation != null) (context.l10n.swatchesLocation, cardLocation!),
      if (hasOldName) (context.l10n.swatchesOldName, color.oldName),
    ];

    // One label column for all rows, as wide as the widest label.
    final double definitionLabelWidth = InkDefinitionRow.labelWidthFor(
      context,
      <String>[for (final (String, String) row in definitions) row.$1],
    );

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Semantics(
            container: true,
            label: context.l10n.swatchesSwatchSemantics(
              color.newCode,
              color.newName,
              favorite.toString(),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SwatchBlock(
                  hex: color.hex,
                  size: InkGeometry.heroSwatch,
                  radius: InkRadii.control,
                  own: color.hasOwnColor,
                ),
                const SizedBox(width: InkSpacing.block),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: InkSpacing.sheetCloseClearance,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Wrap(
                          spacing: InkSpacing.s8,
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: <Widget>[
                            Text(
                              color.newCode,
                              style: AppTypography.code.copyWith(color: ink.fg),
                            ),
                            if (hasOldCode)
                              Text(
                                context.l10n.commonOldCode(color.oldCode),
                                style: AppTypography.data.copyWith(
                                  color: ink.fg2,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: InkSpacing.s4),
                        Text(
                          color.newName,
                          style: AppTypography.sheetTitle.copyWith(
                            color: ink.fg,
                          ),
                        ),
                        const SizedBox(height: InkSpacing.group),
                        Text(
                          displayHex,
                          style: AppTypography.data.copyWith(color: ink.fg2),
                        ),
                        if (rgbLine != null)
                          Text(
                            rgbLine,
                            style: AppTypography.data.copyWith(color: ink.fg2),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (definitions.isNotEmpty) ...<Widget>[
            const SizedBox(height: InkSpacing.block),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: ink.line)),
              ),
              child: Column(
                children: <Widget>[
                  for (final (String, String) row in definitions)
                    InkDefinitionRow(
                      label: row.$1,
                      value: row.$2,
                      labelWidth: definitionLabelWidth,
                    ),
                ],
              ),
            ),
          ],
          if (onSetOwnColor != null) ...<Widget>[
            const SizedBox(height: InkSpacing.block),
            _buildOwnColor(context),
          ],
          const SizedBox(height: InkSpacing.block),
          Wrap(
            spacing: InkSpacing.s8,
            runSpacing: InkSpacing.s8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              InkIconButton(
                icon: InkIcons.star,
                outlined: true,
                selected: favorite,
                tooltip: favorite
                    ? context.l10n.swatchesRemoveFavorite
                    : context.l10n.swatchesAddFavorite,
                onPressed: onToggleFavorite,
              ),
              InkButton.secondary(
                label: context.l10n.swatchesCopyHex,
                icon: InkIcons.copy,
                onPressed: onCopyHex,
              ),
              if (showPaletteActions)
                InkButton(
                  label: context.l10n.swatchesAddToPalette,
                  icon: InkIcons.plus,
                  onPressed: onAddToPalette,
                ),
              if (showPaletteActions && onBlendingChain != null)
                InkButton.secondary(
                  key: const ValueKey<String>('swatch-blending-chain'),
                  label: context.l10n.swatchesBlendingChain,
                  icon: InkIcons.arrowRight,
                  onPressed: onBlendingChain,
                ),
            ],
          ),
          if (!showPaletteActions) ...<Widget>[
            const SizedBox(height: InkSpacing.group),
            Text(
              context.l10n.swatchesOtherBrandsPaletteNote,
              key: const ValueKey<String>('swatch-other-brand-note'),
              style: AppTypography.secondary.copyWith(color: ink.fg2),
            ),
          ],
          if (onToggleWishlist != null && onToggleDried != null) ...<Widget>[
            const SizedBox(height: InkSpacing.block),
            SwatchStatusSection(
              wished: wished,
              dried: dried,
              owned: owned,
              onToggleWishlist: onToggleWishlist!,
              onToggleDried: onToggleDried!,
            ),
          ],
          if (alternatives.isNotEmpty) ...<Widget>[
            const SizedBox(height: InkSpacing.s24),
            InkSectionHeading(
              context.l10n.swatchesClosestAlternatives,
              trailing: context.l10n.swatchesDeltaEUnit,
            ),
            const SizedBox(height: InkSpacing.group),
            // Three across; with large text the codes need a full row each.
            if (MediaQuery.textScalerOf(context).scale(1) > 1.15)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  for (int i = 0; i < alternatives.length && i < 3; i++)
                    _AlternativeTile(
                      alternative: alternatives[i],
                      onTap: onSelectAlternative == null
                          ? null
                          : () => onSelectAlternative!(alternatives[i].color),
                    ),
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (int i = 0; i < 3; i++) ...<Widget>[
                    if (i > 0) const SizedBox(width: InkSpacing.s8),
                    Expanded(
                      child: i < alternatives.length
                          ? _AlternativeTile(
                              alternative: alternatives[i],
                              onTap: onSelectAlternative == null
                                  ? null
                                  : () => onSelectAlternative!(
                                      alternatives[i].color,
                                    ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ],
              ),
          ],
          if (brandEquivalents != null) ...<Widget>[
            const SizedBox(height: InkSpacing.s24),
            brandEquivalents!,
          ],
        ],
      ),
    );
  }
}

/// One closest alternative: 36×36 swatch, `code` and `data` ΔE, at least 44
/// high and tappable.
class _AlternativeTile extends StatelessWidget {
  const _AlternativeTile({required this.alternative, required this.onTap});

  final SwatchAlternative alternative;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final MarkerColor color = alternative.color;
    return Semantics(
      button: onTap != null,
      excludeSemantics: true,
      label: context.l10n.swatchesAlternativeSemantics(
        color.newCode,
        color.newName,
        alternative.deltaE,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: InkRadii.cellRadius,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: InkGeometry.target),
          child: Row(
            children: <Widget>[
              SwatchBlock(hex: color.hex, size: 36, own: color.hasOwnColor),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      color.newCode,
                      maxLines: 1,
                      softWrap: false,
                      style: AppTypography.code.copyWith(color: ink.fg),
                    ),
                    Text(
                      context.l10n.commonDeltaE(alternative.deltaE),
                      maxLines: 1,
                      style: AppTypography.data.copyWith(color: ink.fg2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One side of the catalogue / mine comparison: a 36 swatch, a `caps` label
/// and the hex.
class _OwnColorSide extends StatelessWidget {
  const _OwnColorSide({required this.label, required this.hex});

  final String label;
  final String hex;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Row(
      children: <Widget>[
        SwatchBlock(hex: hex, size: 36),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppTypography.caps(label),
                style: AppTypography.capsStyle.copyWith(color: ink.fg2),
              ),
              Text(
                SwatchDetailSheet.displayHexOf(hex),
                maxLines: 1,
                style: AppTypography.data.copyWith(color: ink.fg),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
