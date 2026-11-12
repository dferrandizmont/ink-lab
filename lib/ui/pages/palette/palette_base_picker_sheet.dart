import 'package:flutter/material.dart';

import '../../../core/collection_selection.dart';
import '../../../core/models.dart';
import '../../../l10n/l10n.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_search_field.dart';
import '../../widgets/section_card.dart';

/// A searchable list of markers to pick the base from: code, old code or
/// name, with the colour.
///
/// When [markers] are of several brands ("Mix my brands") the list is grouped
/// by brand, each group under its name (so a row shows the bare code, as in
/// a list of one brand), and any part of "DecoTime 91" finds the marker.
///
/// With one brand the search is by code and name, as it always was (a few
/// letters must not match the brand's own name and list everything); a
/// query that starts with the whole brand name ("ohuhu", "ohuhu bv04") is
/// read without it.
class PaletteBasePickerSheet extends StatefulWidget {
  const PaletteBasePickerSheet({super.key, required this.markers});

  final List<MarkerColor> markers;

  @override
  State<PaletteBasePickerSheet> createState() => _BasePickerSheetState();
}

class _BasePickerSheetState extends State<PaletteBasePickerSheet> {
  String _query = '';

  /// Whether the markers are of several brands, and the markers brand by
  /// brand (in the app's brand order, each brand in the order it came).
  late bool _mixed;
  late List<MarkerColor> _markers;

  @override
  void initState() {
    super.initState();
    _group();
  }

  @override
  void didUpdateWidget(PaletteBasePickerSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.markers, widget.markers)) _group();
  }

  void _group() {
    _mixed = hasMixedBrands(widget.markers);
    _markers = !_mixed
        ? widget.markers
        : <MarkerColor>[
            for (final MarkerBrand brand in MarkerBrand.values)
              for (final MarkerColor c in widget.markers)
                if (c.brandId == brand.id) c,
          ];
  }

  List<MarkerColor> get _filtered {
    final String q = _query.trim().toLowerCase();
    if (q.isEmpty) return _markers;
    return _markers.where((MarkerColor c) => _matches(c, q)).toList();
  }

  bool _matches(MarkerColor c, String q) {
    bool has(String text) =>
        c.newCode.toLowerCase().contains(text) ||
        c.oldCode.toLowerCase().contains(text) ||
        c.newName.toLowerCase().contains(text) ||
        c.oldName.toLowerCase().contains(text);
    if (has(q)) return true;
    if (_mixed) {
      return markerCodeLabel(c, mixed: true).toLowerCase().contains(q);
    }
    final String brand = MarkerBrand.fromId(c.brandId).label.toLowerCase();
    if (!q.startsWith(brand)) return false;
    final String rest = q.substring(brand.length).trim();
    return rest.isEmpty || has(rest);
  }

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final List<MarkerColor> markers = _filtered;
    final double height = MediaQuery.sizeOf(context).height * 0.55;
    return Column(
      key: const ValueKey<String>('palette-base-picker'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: InkGeometry.target),
          child: Semantics(
            header: true,
            child: Text(
              context.l10n.palettePickerTitle,
              style: AppTypography.section.copyWith(color: ink.fg),
            ),
          ),
        ),
        const SizedBox(height: InkSpacing.block),
        InkSearchField(
          key: const ValueKey<String>('palette-picker-search'),
          hintText: context.l10n.palettePickerSearchHint,
          semanticLabel: context.l10n.palettePickerSearchHint,
          onChanged: (String value) => setState(() => _query = value),
        ),
        const SizedBox(height: InkSpacing.s8),
        SizedBox(
          height: height,
          child: markers.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: InkSpacing.block),
                  child: Text(
                    context.l10n.palettePickerEmpty,
                    style: AppTypography.secondary.copyWith(color: ink.fg2),
                  ),
                )
              : ListView.builder(
                  itemCount: markers.length,
                  itemBuilder: (BuildContext context, int index) {
                    final MarkerColor marker = markers[index];
                    final Widget row = InkWell(
                      key: ValueKey<String>(
                        'palette-picker-'
                        '${_mixed ? marker.colorId : marker.newCode}',
                      ),
                      onTap: () => Navigator.of(context).pop(marker),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: InkGeometry.target + 8,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: InkSpacing.s6,
                          ),
                          child: Row(
                            children: <Widget>[
                              SwatchBlock(
                                hex: marker.hex,
                                size: InkGeometry.swatchMd,
                                radius: InkRadii.xs,
                                own: marker.hasOwnColor,
                              ),
                              const SizedBox(width: InkSpacing.s12),
                              // The bare code, also with brands mixed: the
                              // group head above already names the brand.
                              Text(
                                marker.newCode,
                                style: AppTypography.code.copyWith(
                                  color: ink.fg,
                                ),
                              ),
                              const SizedBox(width: InkSpacing.s10),
                              Expanded(
                                child: Text(
                                  marker.newName,
                                  style: AppTypography.secondary.copyWith(
                                    color: ink.fg2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                    // The first marker of a brand comes under the brand's
                    // name.
                    if (_mixed &&
                        (index == 0 ||
                            markers[index - 1].brandId != marker.brandId)) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: index == 0
                                ? InkSpacing.s4
                                : InkSpacing.block,
                          ),
                          InkGroupHead(
                            MarkerBrand.fromId(marker.brandId).label,
                            key: ValueKey<String>(
                              'palette-picker-brand-${marker.brandId}',
                            ),
                          ),
                          row,
                        ],
                      );
                    }
                    return row;
                  },
                ),
        ),
      ],
    );
  }
}
