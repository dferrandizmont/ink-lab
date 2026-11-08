import 'package:flutter/material.dart';

import '../../../core/models.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_sheet.dart';

/// Opens the brand list in a sheet and returns the brand the user taps, or
/// `null` when the sheet is closed. Unlike the collection's brand picker it
/// changes nothing by itself: the tools pages ask for a brand for one job.
Future<MarkerBrand?> showBrandChoice(
  BuildContext context, {
  required MarkerBrand current,
  required String title,
}) => showInkSheet<MarkerBrand>(
  context: context,
  builder: (BuildContext context) =>
      BrandChoiceSheet(current: current, title: title),
);

/// Every [MarkerBrand] as a row, the current one ticked. The brand list can
/// keep growing, so it lives behind a picker, never inline. Pops with the
/// brand tapped.
class BrandChoiceSheet extends StatelessWidget {
  const BrandChoiceSheet({
    super.key,
    required this.current,
    required this.title,
  });

  final MarkerBrand current;
  final String title;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final double maxListHeight = MediaQuery.sizeOf(context).height * 0.6;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: InkSpacing.sheetCloseClearance),
          child: Semantics(
            header: true,
            child: Text(
              title,
              style: AppTypography.section.copyWith(color: ink.fg),
            ),
          ),
        ),
        const SizedBox(height: InkSpacing.block),
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxListHeight),
            child: ListView(
              key: const ValueKey<String>('tools-brand-list'),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: <Widget>[
                for (final MarkerBrand brand in MarkerBrand.values)
                  _BrandChoiceRow(
                    key: ValueKey<String>('tools-brand-${brand.id}'),
                    label: brand.label,
                    selected: brand == current,
                    onTap: () => Navigator.of(context).pop(brand),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BrandChoiceRow extends StatelessWidget {
  const _BrandChoiceRow({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: selected,
      button: true,
      excludeSemantics: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: InkGeometry.target),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: InkSpacing.s8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    label,
                    style: AppTypography.body.copyWith(color: ink.fg),
                  ),
                ),
                SizedBox(
                  width: InkGeometry.checkSlot,
                  child: selected
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: InkIcon(
                            InkIcons.check,
                            size: InkGeometry.mediumIcon,
                            color: ink.action,
                          ),
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// One marker as a row: its colour, code and name, and its brand when
/// [showBrand] (a list that mixes brands).
class ToolsMarkerRow extends StatelessWidget {
  const ToolsMarkerRow({
    super.key,
    required this.marker,
    this.showBrand = false,
    this.onTap,
    this.trailing,
  });

  final MarkerColor marker;
  final bool showBrand;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final String brand = MarkerBrand.fromId(marker.brandId).label;
    final String label = showBrand
        ? '${marker.newCode}, ${marker.newName}, $brand'
        : '${marker.newCode}, ${marker.newName}';
    return Semantics(
      button: onTap != null,
      excludeSemantics: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: InkGeometry.target + 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: InkSpacing.s6),
            child: Row(
              children: <Widget>[
                SwatchBlock(
                  hex: marker.hex,
                  size: InkGeometry.swatchMd,
                  radius: InkRadii.xs,
                  own: marker.hasOwnColor,
                ),
                const SizedBox(width: InkSpacing.s12),
                Text(
                  marker.newCode,
                  style: AppTypography.code.copyWith(color: ink.fg),
                ),
                const SizedBox(width: InkSpacing.s10),
                Expanded(
                  child: Tooltip(
                    message: showBrand
                        ? '${marker.newName} · $brand'
                        : marker.newName,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          marker.newName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.secondary.copyWith(
                            color: ink.fg2,
                          ),
                        ),
                        if (showBrand)
                          Text(
                            brand,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.caption.copyWith(
                              color: ink.fg2,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                ?trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A sheet with a title and a scrolling list of markers. The lists of the
/// tools can be long (a hue band of a big collection, the codes an import
/// found), so they live in a sheet rather than inline.
class ToolsMarkerListSheet extends StatelessWidget {
  const ToolsMarkerListSheet({
    super.key,
    required this.title,
    required this.markers,
    this.showBrand = false,
    this.onSelect,
  });

  final String title;
  final List<MarkerColor> markers;
  final bool showBrand;
  final ValueChanged<MarkerColor>? onSelect;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final double maxListHeight = MediaQuery.sizeOf(context).height * 0.6;
    return Column(
      key: const ValueKey<String>('tools-marker-list'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: InkSpacing.sheetCloseClearance),
          child: Semantics(
            header: true,
            child: Text(
              title,
              style: AppTypography.section.copyWith(color: ink.fg),
            ),
          ),
        ),
        const SizedBox(height: InkSpacing.group),
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxListHeight),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: markers.length,
              itemBuilder: (BuildContext context, int index) {
                final MarkerColor marker = markers[index];
                return ToolsMarkerRow(
                  key: ValueKey<String>('tools-list-${marker.colorId}'),
                  marker: marker,
                  showBrand: showBrand,
                  onTap: onSelect == null ? null : () => onSelect!(marker),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

/// The sheet that describes one marker of the colour map: its colour, code,
/// name, brand, hex and whether the user owns it.
class ToolsMarkerInfoSheet extends StatelessWidget {
  const ToolsMarkerInfoSheet({
    super.key,
    required this.marker,
    required this.owned,
    required this.nameDisplay,
  });

  final MarkerColor marker;
  final bool owned;
  final NameDisplayMode nameDisplay;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    final String brand = MarkerBrand.fromId(marker.brandId).label;
    return Semantics(
      container: true,
      child: Row(
        key: const ValueKey<String>('tools-marker-info'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SwatchBlock(
            hex: marker.hex,
            size: InkGeometry.heroSwatch,
            own: marker.hasOwnColor,
          ),
          const SizedBox(width: InkSpacing.block),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                right: InkSpacing.sheetCloseClearance,
              ),
              // Hugs its lines: a Column in a Row would otherwise take the
              // whole height the sheet may have and leave it empty below.
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    marker.displayCode(nameDisplay),
                    style: AppTypography.code.copyWith(color: ink.fg),
                  ),
                  Text(
                    marker.displayName(nameDisplay),
                    style: AppTypography.body.copyWith(color: ink.fg),
                  ),
                  const SizedBox(height: InkSpacing.s4),
                  Text(
                    '$brand · ${displayHex(marker.hex)}',
                    style: AppTypography.secondary.copyWith(color: ink.fg2),
                  ),
                  Text(
                    owned ? l10n.toolsMarkerOwned : l10n.toolsMarkerNotOwned,
                    style: AppTypography.secondary.copyWith(color: ink.fg2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
