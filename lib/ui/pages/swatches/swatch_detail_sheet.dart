import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../core/color_utils.dart';
import '../../../core/match_quality.dart';
import '../../../core/models.dart';
import '../../../data/marker_extras_repository.dart' show InkLevel;
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_chip.dart';
import '../../widgets/ink_disclosure.dart';
import '../../widgets/ink_overflow_menu.dart';
import '../../widgets/ink_sheet.dart';
import 'blend_section.dart';
import 'ink_level_section.dart';
import 'swatch_neighbours_section.dart';
import 'swatch_photo_row.dart';

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
/// hex cannot be parsed are skipped. Colours farther than [maxDeltaE] (the
/// "No close match" distance by default) are not alternatives at all, so the
/// list can be shorter than [limit] or empty.
List<SwatchAlternative> closestAlternatives(
  MarkerColor color,
  Iterable<MarkerColor> pool, {
  int limit = 3,
  double maxDeltaE = MatchQuality.noCloseMatchThreshold,
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
  return found
      .where((SwatchAlternative a) => a.deltaE <= maxDeltaE)
      .take(limit)
      .toList();
}

/// Detail sheet content of a single swatch (spec §4 "Swatch detail sheet").
///
/// It lives inside a draggable sheet that opens at half height (see
/// `showInkDraggableSheet`): the header, the primary action, "My colour" and
/// the closest alternatives are on screen at once; the other brands and the
/// details are one gesture away.
///
/// The sheet has one primary action (the `InkButton`) and one row ("My
/// colour"). Below the closest alternatives come, in this order: the ink level
/// and refill note of an owned marker (or, for one the user does not own, the
/// near-duplicates they already have), the photo of the real swatch, "Shadow
/// and light", "Blend with…", "In other brands" and the details. Everything
/// else is a disclosure or an entry of the "⋯" menu, which lives in the frame
/// of the sheet, next to the close button: the sheet publishes its entries in
/// [menuItems] and the page shows them there.
///
/// No section changes the size of the ones above it: the chips and the rows
/// of a section are there in every state, and the texts that depend on a
/// state share the room of the longest one.
class SwatchDetailSheet extends StatefulWidget {
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
    this.inkLevel = InkLevel.full,
    this.onInkLevelChanged,
    this.refillNote,
    this.onEditRefillNote,
    this.photo,
    this.hasPhoto = false,
    this.onSwatchPhoto,
    this.ownedMarkers,
    this.blendCatalogue = const <MarkerColor>[],
    this.onSelectNeighbour,
    this.wished = false,
    this.dried = false,
    this.owned = false,
    this.brandEquivalents,
    this.brandLabel,
    this.showPaletteActions = true,
    this.scrollController,
    this.sheetController,
    this.menuItems,
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
  /// marker. Without it the "My colour" row is not shown.
  final VoidCallback? onSetOwnColor;

  /// Called when the user drops their own colour and goes back to the
  /// catalogue's. Only offered while the marker has an own colour.
  final VoidCallback? onResetOwnColor;

  /// Called when the user adds the marker to, or takes it off, the wishlist.
  /// Without it the wishlist is not offered.
  final VoidCallback? onToggleWishlist;

  /// Called when the user marks the marker as dried out, or as usable again.
  final VoidCallback? onToggleDried;

  /// How much ink the marker has left. Only offered for a marker the user
  /// owns, and only with [onInkLevelChanged].
  final InkLevel inkLevel;

  /// Called when the user picks another ink level.
  final ValueChanged<InkLevel>? onInkLevelChanged;

  /// The refill note of the marker, or `null`.
  final String? refillNote;

  /// Called when the user wants to write or change the refill note.
  final VoidCallback? onEditRefillNote;

  /// The photo of the real paper swatch, once loaded.
  final Uint8List? photo;

  /// Whether the marker has a photo of its real swatch.
  final bool hasPhoto;

  /// Called when the user taps the "Real swatch" row. Without it the row is
  /// not shown.
  final VoidCallback? onSwatchPhoto;

  /// The markers the user owns and can use, of every brand. They feed
  /// "Shadow and light", "Blend with…" and the near-duplicates of a marker
  /// the user does not own; without them those sections are not shown. Give
  /// the sheet the same future until the collection changes: the sections
  /// measure again when it is another one.
  final Future<List<MarkerColor>>? ownedMarkers;

  /// The range the user could buy from, to fill a gap in "Blend with…".
  final List<MarkerColor> blendCatalogue;

  /// Called when a marker in "Shadow and light", the near-duplicates or the
  /// blend is tapped: the page opens its detail.
  final ValueChanged<MarkerColor>? onSelectNeighbour;

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

  /// The scroll controller of the sheet's content. The sheet uses it to go
  /// back to the top when the user picks another marker.
  final ScrollController? scrollController;

  /// The controller of the draggable sheet that holds this content. The sheet
  /// uses it to go back to half height when the user picks another marker.
  final DraggableScrollableController? sheetController;

  /// Where the sheet publishes the entries of its "⋯" menu, built from the
  /// callbacks above. The page shows them in the frame of the sheet, next to
  /// the close button.
  final InkMenuItemsNotifier? menuItems;

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

  @override
  State<SwatchDetailSheet> createState() => _SwatchDetailSheetState();
}

class _SwatchDetailSheetState extends State<SwatchDetailSheet> {
  /// Room the header leaves at its right for the "⋯" menu and the close
  /// button of the frame, which float over the top right corner.
  static const double _headerClearance =
      InkSpacing.sheetCloseClearance + InkGeometry.target + InkSpacing.s4;

  /// The closest alternatives start closed: only the best one is on screen.
  bool _alternativesOpen = false;

  /// The details (brand, lines, sets, place) start closed too.
  bool _detailsOpen = false;

  /// Whether the entries of the "⋯" menu have already been published.
  bool _menuPublished = false;

  @override
  void didUpdateWidget(SwatchDetailSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color.colorId == widget.color.colorId) return;
    // Another marker: the sheet starts again at the top and at half height.
    WidgetsBinding.instance.addPostFrameCallback((_) => _backToTop());
  }

  /// Takes the content back to its top and the sheet back to half height.
  ///
  /// The content jumps to its top at once; it is another marker's content, so
  /// there is nothing to scroll back through. Animating it while the sheet
  /// is resized does not work: the resize cancels the scroll half way and the
  /// content stays scrolled (a few hundred pixels down) in a sheet at half
  /// height. That is a state the sheet never has when the user drives it, and
  /// the next drag down first scrolls the content up and then keeps going,
  /// shrinking the sheet until it closes.
  Future<void> _backToTop() async {
    if (!mounted) return;
    final ScrollController? scroll = widget.scrollController;
    if (scroll != null && scroll.hasClients && scroll.position.pixels > 0) {
      scroll.jumpTo(0);
    }
    final DraggableScrollableController? sheet = widget.sheetController;
    if (sheet != null && sheet.isAttached && sheet.size > 0.5) {
      await sheet.moveTo(context, 0.5);
    }
    if (!mounted) return;
    // The resize can leave the content off its top: put it back for certain.
    if (scroll != null && scroll.hasClients && scroll.position.pixels > 0) {
      scroll.jumpTo(0);
    }
  }

  /// The entries of the "⋯" menu, in the order of the spec: copy the hex,
  /// the blending chain, the wishlist, the dried-out mark and the way back
  /// to the catalogue colour. Only what applies to this marker is offered.
  List<InkMenuItem> _menuItems(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return <InkMenuItem>[
      if (widget.onCopyHex != null)
        InkMenuItem(
          key: const ValueKey<String>('swatch-menu-copy'),
          label: l10n.swatchesCopyHex,
          icon: InkIcons.copy,
          onSelected: widget.onCopyHex!,
        ),
      if (widget.showPaletteActions && widget.onBlendingChain != null)
        InkMenuItem(
          key: const ValueKey<String>('swatch-blending-chain'),
          label: l10n.swatchesBlendingChain,
          icon: InkIcons.arrowRight,
          onSelected: widget.onBlendingChain!,
        ),
      if (widget.showPaletteActions && widget.onToggleWishlist != null)
        InkMenuItem(
          key: const ValueKey<String>('swatch-menu-wishlist'),
          label: widget.wished ? l10n.wishlistRemove : l10n.wishlistAdd,
          icon: widget.wished ? InkIcons.check : InkIcons.bookmark,
          onSelected: widget.onToggleWishlist!,
        ),
      if ((widget.owned || widget.dried) && widget.onToggleDried != null)
        InkMenuItem(
          key: const ValueKey<String>('swatch-menu-dried'),
          label: widget.dried ? l10n.driedUnmark : l10n.driedMark,
          icon: widget.dried ? InkIcons.rotateCcw : InkIcons.dropletOff,
          onSelected: widget.onToggleDried!,
        ),
      if (widget.color.hasOwnColor && widget.onResetOwnColor != null)
        InkMenuItem(
          key: const ValueKey<String>('swatch-own-reset'),
          label: l10n.swatchesMyColourReset,
          icon: InkIcons.rotateCcw,
          onSelected: widget.onResetOwnColor!,
        ),
    ];
  }

  /// Publishes the menu entries. The first time the menu is not on screen
  /// yet (it is painted after the content), so the value goes in directly;
  /// later on the menu is on screen and is told outside the build.
  ///
  /// The entries are only published when they really change, so the menu is
  /// not rebuilt on every frame, and nothing is written once the notifier
  /// is gone.
  void _publishMenuItems(List<InkMenuItem> items) {
    final InkMenuItemsNotifier? notifier = widget.menuItems;
    if (notifier == null || notifier.isDisposed) return;
    // From now on the menu is on screen, so a change has to be told outside
    // the build.
    final bool first = !_menuPublished;
    _menuPublished = true;
    if (notifier.hasSameItems(items)) return;
    if (first) {
      notifier.publish(items);
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      notifier.publish(items);
    });
  }

  /// The header: the swatch, the code, the name with the favourite beside it
  /// and the hex, which is copied when it is tapped.
  Widget _buildHeader(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    final MarkerColor color = widget.color;
    final bool hasOldCode = color.oldCode != color.newCode;
    final List<String> status = <String>[
      if (widget.owned) l10n.commonOwned,
      if (widget.dried) l10n.commonDried,
      if (widget.wished) l10n.swatchesStatusWished,
    ];
    return Semantics(
      container: true,
      label: l10n.swatchesSwatchSemantics(
        color.newCode,
        color.newName,
        widget.favorite.toString(),
      ),
      child: Row(
        key: const ValueKey<String>('swatch-header'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SwatchBlock(
            hex: color.hex,
            size: InkGeometry.swatchBlockHeight,
            radius: InkRadii.control,
            own: color.hasOwnColor,
          ),
          const SizedBox(width: InkSpacing.block),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  // Room for the "⋯" menu and the close button of the frame.
                  padding: const EdgeInsets.only(right: _headerClearance),
                  child: Wrap(
                    spacing: InkSpacing.s8,
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: <Widget>[
                      Text(
                        color.newCode,
                        style: AppTypography.code.copyWith(color: ink.fg),
                      ),
                      if (hasOldCode)
                        Text(
                          l10n.commonOldCode(color.oldCode),
                          style: AppTypography.data.copyWith(color: ink.fg2),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: InkSpacing.s4),
                // No clearance here: the star sits below the "⋯" menu and the
                // ✕ of the frame (the code line is in between), so only that
                // first line needs the room. The name takes the full width and
                // the star stays at the end of its own row.
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Tooltip(
                        message: color.newName,
                        excludeFromSemantics: true,
                        child: Text(
                          color.newName,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.sheetTitle.copyWith(
                            color: ink.fg,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: InkSpacing.group),
                    InkIconButton(
                      icon: InkIcons.star,
                      outlined: true,
                      selected: widget.favorite,
                      tooltip: widget.favorite
                          ? l10n.swatchesRemoveFavorite
                          : l10n.swatchesAddFavorite,
                      onPressed: widget.onToggleFavorite,
                    ),
                  ],
                ),
                // The hex line: one text high, with the tap target around
                // it, so it is a full row high without a forced height.
                _buildHexLine(context, status.join(' · ')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// The hex, which is copied when it is tapped, followed by the state of the
  /// marker ("Owned", "Dried out", "On your wishlist") on the same line.
  Widget _buildHexLine(BuildContext context, String status) {
    final InkColors ink = InkColors.of(context);
    final TextStyle style = AppTypography.data.copyWith(color: ink.fg2);
    final Widget hex = Text(widget.displayHex, style: style);
    final Widget tappable = widget.onCopyHex == null
        ? hex
        : Semantics(
            button: true,
            label: '${context.l10n.swatchesHex} ${widget.displayHex}',
            child: InkWell(
              onTap: widget.onCopyHex,
              borderRadius: InkRadii.controlRadius,
              // The hex is a line of text: the padding around it is the tap
              // target, so it is a full row high without a forced height.
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: InkSpacing.s14),
                child: hex,
              ),
            ),
          );
    if (status.isEmpty) return tappable;
    return Row(
      key: const ValueKey<String>('swatch-hex-line'),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        tappable,
        Text(' · ', style: style),
        Expanded(child: Text(status, style: style)),
      ],
    );
  }

  /// The one primary action of the sheet: "Add to palette" for a marker of
  /// the active brand, the wishlist for a marker of another one.
  Widget _buildPrimaryAction(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    if (!widget.showPaletteActions) {
      return InkButton(
        key: const ValueKey<String>('swatch-primary'),
        label: widget.wished ? l10n.wishlistRemove : l10n.wishlistAdd,
        icon: widget.wished ? InkIcons.check : InkIcons.bookmark,
        expand: true,
        onPressed: widget.onToggleWishlist,
      );
    }
    return InkButton(
      key: const ValueKey<String>('swatch-primary'),
      label: l10n.swatchesAddToPalette,
      icon: InkIcons.plus,
      expand: true,
      onPressed: widget.onAddToPalette,
    );
  }

  /// "My colour": a row that opens the editor of the user's own colour. On
  /// the left, the catalogue colour beside the user's own one; in the
  /// middle, the title and what the marker is now.
  Widget _buildMyColourRow(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    final MarkerColor color = widget.color;
    return InkWell(
      key: const ValueKey<String>('swatch-my-colour-row'),
      onTap: widget.onSetOwnColor,
      borderRadius: InkRadii.controlRadius,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: InkGeometry.rowTall),
        child: Row(
          children: <Widget>[
            if (color.hasOwnColor)
              _splitSwatch(context)
            else
              SizedBox.square(
                dimension: InkGeometry.swatchRow,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: InkRadii.controlRadius,
                    border: Border.all(color: ink.line),
                  ),
                  child: Center(
                    child: InkIcon(
                      InkIcons.edit3,
                      size: InkGeometry.smallIcon,
                      color: ink.fg2,
                    ),
                  ),
                ),
              ),
            const SizedBox(width: InkSpacing.s12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    l10n.swatchesMyColourTitle,
                    style: AppTypography.body.copyWith(color: ink.fg),
                  ),
                  Text(
                    color.hasOwnColor
                        ? l10n.swatchesMyColourValue(
                            SwatchDetailSheet.displayHexOf(color.hex),
                          )
                        : l10n.swatchesMyColourSame,
                    style: AppTypography.secondary.copyWith(color: ink.fg2),
                  ),
                ],
              ),
            ),
            const SizedBox(width: InkSpacing.group),
            InkIcon(
              InkIcons.chevronRight,
              size: InkGeometry.smallIcon,
              color: ink.fg2,
            ),
          ],
        ),
      ),
    );
  }

  /// The catalogue colour and the user's own one, side by side.
  Widget _splitSwatch(BuildContext context) {
    final MarkerColor color = widget.color;
    return SizedBox.square(
      dimension: InkGeometry.swatchRow,
      child: ClipRRect(
        borderRadius: InkRadii.controlRadius,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: SwatchBlock(hex: color.originalHex, radius: 0)),
            Expanded(child: SwatchBlock(hex: color.hex, radius: 0)),
          ],
        ),
      ),
    );
  }

  /// The closest alternatives, closed by default: the summary shows the best
  /// one and opening it shows the three of them.
  Widget _buildAlternatives(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    final List<SwatchAlternative> alternatives = widget.alternatives;
    if (alternatives.isEmpty) return _buildNoAlternatives(context);
    final SwatchAlternative best = alternatives.first;
    return InkDisclosure(
      key: const ValueKey<String>('swatch-alternatives'),
      title: l10n.swatchesClosestAlternatives,
      leading: SwatchBlock(
        hex: best.color.hex,
        size: InkGeometry.swatchInline,
        radius: InkRadii.xs,
      ),
      subtitleWidget: Row(
        children: <Widget>[
          Text(
            best.color.newCode,
            style: AppTypography.code.copyWith(color: ink.fg),
          ),
          const SizedBox(width: InkSpacing.s8),
          Expanded(child: InkQualityText(best.deltaE)),
        ],
      ),
      semanticLabel:
          '${l10n.swatchesClosestAlternatives}, ${best.color.newCode}, '
          '${l10n.commonDeltaE(best.deltaE)}',
      expanded: _alternativesOpen,
      onToggle: () => setState(() => _alternativesOpen = !_alternativesOpen),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Three across; with large text the codes need a full row each.
          if (MediaQuery.textScalerOf(context).scale(1) > 1.15)
            for (int i = 0; i < alternatives.length && i < 3; i++)
              _AlternativeTile(
                alternative: alternatives[i],
                onTap: widget.onSelectAlternative == null
                    ? null
                    : () => widget.onSelectAlternative!(alternatives[i].color),
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
                            onTap: widget.onSelectAlternative == null
                                ? null
                                : () => widget.onSelectAlternative!(
                                    alternatives[i].color,
                                  ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ],
            ),
        ],
      ),
    );
  }

  /// Nothing is close enough to stand in for the marker: the row of the
  /// alternatives says so, as high as its closed header, so the sheet does
  /// not change height with the marker.
  Widget _buildNoAlternatives(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    return Semantics(
      container: true,
      label:
          '${l10n.swatchesClosestAlternatives}, '
          '${l10n.swatchesNoCloseAlternatives}',
      excludeSemantics: true,
      child: ConstrainedBox(
        key: const ValueKey<String>('swatch-alternatives-none'),
        constraints: const BoxConstraints(minHeight: InkGeometry.target),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: InkSpacing.s8),
          child: Row(
            children: <Widget>[
              SizedBox.square(
                dimension: InkGeometry.swatchInline,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: InkRadii.xsRadius,
                    border: Border.all(color: ink.line),
                  ),
                ),
              ),
              const SizedBox(width: InkSpacing.s12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      l10n.swatchesClosestAlternatives,
                      style: AppTypography.body.copyWith(color: ink.fg),
                    ),
                    Text(
                      l10n.swatchesNoCloseAlternatives,
                      style: AppTypography.secondary.copyWith(color: ink.fg2),
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

  void _selectNeighbour(MarkerColor other) {
    final ValueChanged<MarkerColor>? select =
        widget.onSelectNeighbour ?? widget.onSelectAlternative;
    select?.call(other);
  }

  /// The details of the marker: brand, lines, sets, place and old name.
  Widget _buildDetails(
    BuildContext context,
    List<(String, String)> definitions,
    double labelWidth,
  ) {
    final AppLocalizations l10n = context.l10n;
    return InkDisclosure(
      key: const ValueKey<String>('swatch-details'),
      title: l10n.swatchesDetailsTitle,
      // The first set is the summary of the block.
      subtitle: widget.packLabels.isEmpty ? null : widget.packLabels.first,
      expanded: _detailsOpen,
      onToggle: () => setState(() => _detailsOpen = !_detailsOpen),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (final (String, String) row in definitions)
            InkDefinitionRow(
              label: row.$1,
              value: row.$2,
              labelWidth: labelWidth,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    final MarkerColor color = widget.color;
    final bool hasOldName = color.oldName != color.newName;
    final List<(String, String)> definitions = <(String, String)>[
      if (widget.brandLabel != null)
        (l10n.settingsBrandTitle, widget.brandLabel!),
      if (widget.lineLabels.isNotEmpty)
        (l10n.swatchesLines, widget.lineLabels.join(', ')),
      if (widget.packLabels.isNotEmpty)
        (l10n.swatchesInPacks, widget._packsText(context)),
      if (widget.cardLocation != null)
        (l10n.swatchesLocation, widget.cardLocation!),
      if (hasOldName) (l10n.swatchesOldName, color.oldName),
    ];
    // One label column for all rows, as wide as the widest label.
    final double definitionLabelWidth = InkDefinitionRow.labelWidthFor(
      context,
      <String>[for (final (String, String) row in definitions) row.$1],
    );

    _publishMenuItems(_menuItems(context));

    return ListView(
      controller: widget.scrollController,
      padding: EdgeInsets.zero,
      children: <Widget>[
        _buildHeader(context),
        // With the ink level on the sheet the note lives under its chips,
        // where it does not move anything when the level changes.
        if (widget.dried && widget.onInkLevelChanged == null) ...<Widget>[
          const SizedBox(height: InkSpacing.group),
          Text(
            l10n.driedNote,
            key: const ValueKey<String>('swatch-dried-note'),
            style: AppTypography.secondary.copyWith(color: ink.fg2),
          ),
        ],
        const SizedBox(height: InkSpacing.s12),
        _buildPrimaryAction(context),
        if (!widget.showPaletteActions) ...<Widget>[
          const SizedBox(height: InkSpacing.group),
          Text(
            l10n.swatchesOtherBrandsPaletteNote,
            key: const ValueKey<String>('swatch-other-brand-note'),
            style: AppTypography.secondary.copyWith(color: ink.fg2),
          ),
        ],
        if (widget.onSetOwnColor != null) ...<Widget>[
          const SizedBox(height: InkSpacing.group),
          _buildMyColourRow(context),
        ],
        const SizedBox(height: InkSpacing.group),
        _buildAlternatives(context),
        // The ink of a marker the user has; for one they do not have, how
        // many near-duplicates they own already.
        if (widget.onInkLevelChanged != null &&
            (widget.owned || widget.dried)) ...<Widget>[
          const SizedBox(height: InkSpacing.block),
          InkLevelSection(
            level: widget.inkLevel,
            onChanged: widget.onInkLevelChanged,
            note: widget.refillNote,
            onEditNote: widget.onEditRefillNote,
          ),
        ] else if (!widget.owned && widget.ownedMarkers != null) ...<Widget>[
          const SizedBox(height: InkSpacing.block),
          NearDuplicatesSection(
            marker: color,
            owned: widget.ownedMarkers!,
            onSelect: _selectNeighbour,
          ),
        ],
        if (widget.onSwatchPhoto != null) ...<Widget>[
          const SizedBox(height: InkSpacing.group),
          SwatchPhotoRow(
            hex: color.hex,
            own: color.hasOwnColor,
            hasPhoto: widget.hasPhoto,
            photo: widget.photo,
            onTap: widget.onSwatchPhoto,
          ),
        ],
        if (widget.ownedMarkers != null) ...<Widget>[
          const SizedBox(height: InkSpacing.s24),
          ShadowLightSection(
            marker: color,
            owned: widget.ownedMarkers!,
            onSelect: _selectNeighbour,
          ),
          const SizedBox(height: InkSpacing.block),
          BlendSection(
            marker: color,
            owned: widget.ownedMarkers!,
            catalogue: widget.blendCatalogue,
            onSelect: _selectNeighbour,
          ),
        ],
        if (widget.brandEquivalents != null) ...<Widget>[
          const SizedBox(height: InkSpacing.s24),
          widget.brandEquivalents!,
        ],
        if (definitions.isNotEmpty) ...<Widget>[
          const SizedBox(height: InkSpacing.s24),
          _buildDetails(context, definitions, definitionLabelWidth),
        ],
      ],
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
              SwatchBlock(
                hex: color.hex,
                size: InkGeometry.swatchRow,
                own: color.hasOwnColor,
              ),
              const SizedBox(width: InkSpacing.s10),
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
