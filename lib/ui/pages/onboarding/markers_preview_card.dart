import 'package:flutter/material.dart';

import '../../../core/collection_selection.dart';
import '../../../core/models.dart';
import '../../../data/brand_scoping.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';

/// The control of the markers step of the first-run setup (brands without
/// retail sets): the whole card is the button that opens the list to tick
/// markers.
///
/// Its title is the action ("Tick your markers"). Under it a status line says
/// "None ticked yet · 358 colours" or "12 ticked", and a strip shows a sample
/// of the brand's range before anything is ticked, or the ticked colours after
/// (the last slot reads "+K" when they do not all fit).
///
/// The card never changes height: the status line takes the room of its
/// longest form ("None ticked yet · 358 colours") whatever it says, and the
/// strip is always one row of equal slots, empty ones (and every slot while
/// the colours load) are outlined placeholders.
class MarkersPreviewCard extends StatelessWidget {
  const MarkersPreviewCard({
    super.key,
    required this.brand,
    required this.colors,
    required this.tickedIds,
    required this.onTap,
  });

  /// Key of the tappable area of the card (the control of the step).
  static const Key pickKey = ValueKey<String>('onboarding-pick-markers');

  /// Key of the status line: the ticked count, or none ticked and the size of
  /// the range.
  static const Key countKey = ValueKey<String>(
    'onboarding-markers-preview-count',
  );

  /// Key of the strip of slots.
  static const Key stripKey = ValueKey<String>(
    'onboarding-markers-preview-strip',
  );

  final MarkerBrand brand;

  /// The colours of [brand] (any brand's are fine, the range is picked out),
  /// or `null` while they load.
  final List<MarkerColor>? colors;

  /// The ticked markers (`brandId:CODE`), possibly of other brands too.
  final Set<String> tickedIds;

  final VoidCallback onTap;

  /// Narrowest a slot may be; more slots are added as the width allows.
  static const double _minSlot = 28;
  static const double _slotGap = InkSpacing.s4;
  static const double _stripHeight = 40;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final List<MarkerColor>? all = colors;
    final List<MarkerColor>? range = all == null
        ? null
        : brandRangeColors(colors: all, brand: brand);
    final List<MarkerColor> ticked = range == null
        ? const <MarkerColor>[]
        : range
              .where((MarkerColor c) => tickedIds.contains(c.colorId))
              .toList(growable: false);
    // Until the colours are there the count comes from the ids themselves.
    final int tickedCount = range == null
        ? tickedIds
              .where((String id) => colorIdBelongsToBrand(id, brand))
              .length
        : ticked.length;

    // The size of the range is only known once the colours are there: until
    // then a typical one stands in for the height.
    final String noneText = context.l10n.onboardingMarkersNoneTicked(
      context.l10n.commonColorCount(range?.length ?? 999),
    );
    final String? countText = tickedCount > 0
        ? context.l10n.onboardingMarkersTicked(tickedCount)
        : range == null
        ? null
        : noneText;
    final TextStyle statusStyle = AppTypography.secondary.copyWith(
      color: ink.fg2,
    );

    return Semantics(
      container: true,
      button: true,
      onTap: onTap,
      label: countText == null
          ? context.l10n.collectionDecoMarkersButton
          : '${context.l10n.collectionDecoMarkersButton}: $countText',
      excludeSemantics: true,
      child: Card(
        key: const ValueKey<String>('onboarding-markers-preview'),
        child: InkWell(
          key: pickKey,
          onTap: onTap,
          child: Padding(
            padding: InkSpacing.card,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        context.l10n.collectionDecoMarkersButton,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.section.copyWith(
                          color: ink.action,
                        ),
                      ),
                    ),
                    InkIcon(
                      InkIcons.chevronRight,
                      size: InkGeometry.smallIcon,
                      color: ink.action,
                    ),
                  ],
                ),
                const SizedBox(height: InkSpacing.s2),
                // The status can wrap (long languages, large text) and "None
                // ticked yet · 358 colours" is its longest form: an invisible
                // copy of it sets the height, so the card is as tall with 0
                // ticked as with 12.
                Stack(
                  children: <Widget>[
                    Visibility(
                      visible: false,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: Text(noneText, style: statusStyle),
                    ),
                    Text(
                      // A no-break space keeps the line's height while the
                      // colours load.
                      countText ?? ' ',
                      key: countKey,
                      style: statusStyle,
                    ),
                  ],
                ),
                const SizedBox(height: InkSpacing.group),
                SizedBox(
                  key: stripKey,
                  height: _stripHeight,
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints box) {
                      final int slots =
                          ((box.maxWidth + _slotGap) / (_minSlot + _slotGap))
                              .floor()
                              .clamp(1, 64);
                      return _strip(context, slots, range, ticked, tickedCount);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _strip(
    BuildContext context,
    int slots,
    List<MarkerColor>? range,
    List<MarkerColor> ticked,
    int tickedCount,
  ) {
    final List<Widget> cells = <Widget>[];
    if (range == null) {
      for (int i = 0; i < slots; i++) {
        cells.add(const _EmptySlot());
      }
    } else if (ticked.isNotEmpty) {
      final bool overflow = ticked.length > slots;
      final int shown = overflow ? slots - 1 : ticked.length;
      for (int i = 0; i < shown; i++) {
        cells.add(_ColourSlot(hex: ticked[i].hex));
      }
      if (overflow) {
        cells.add(_MoreSlot(count: ticked.length - shown));
      }
      while (cells.length < slots) {
        cells.add(const _EmptySlot());
      }
    } else {
      final int count = range.length < slots ? range.length : slots;
      for (int i = 0; i < count; i++) {
        // Evenly spaced over the range, first and last included.
        final int at = count == 1
            ? 0
            : (i * (range.length - 1) / (count - 1)).round();
        cells.add(_ColourSlot(hex: range[at].hex));
      }
      while (cells.length < slots) {
        cells.add(const _EmptySlot());
      }
    }
    // Stretch: the slots have no child to size them, so without it they
    // collapse to their borders (a row of hairlines).
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (int i = 0; i < cells.length; i++) ...<Widget>[
          if (i > 0) const SizedBox(width: _slotGap),
          Expanded(child: cells[i]),
        ],
      ],
    );
  }
}

class _ColourSlot extends StatelessWidget {
  const _ColourSlot({required this.hex});

  final String hex;

  @override
  Widget build(BuildContext context) {
    final Color colour = swatchColor(hex);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colour,
        borderRadius: InkRadii.xsRadius,
        border: Border.all(color: InkColors.of(context).swatchEdge(colour)),
      ),
    );
  }
}

class _EmptySlot extends StatelessWidget {
  const _EmptySlot();

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ink.bg,
        borderRadius: InkRadii.xsRadius,
        border: Border.all(color: ink.line),
      ),
    );
  }
}

class _MoreSlot extends StatelessWidget {
  const _MoreSlot({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ink.bg,
        borderRadius: InkRadii.xsRadius,
        border: Border.all(color: ink.line),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: InkSpacing.s2),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '+$count',
              maxLines: 1,
              style: AppTypography.data.copyWith(color: ink.fg),
            ),
          ),
        ),
      ),
    );
  }
}
