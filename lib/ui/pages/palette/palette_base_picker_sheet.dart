import 'package:flutter/material.dart';

import '../../../core/models.dart';
import '../../../l10n/l10n.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_search_field.dart';

/// A searchable list of markers to pick the base from: code, old code or
/// name, with the colour.
class PaletteBasePickerSheet extends StatefulWidget {
  const PaletteBasePickerSheet({super.key, required this.markers});

  final List<MarkerColor> markers;

  @override
  State<PaletteBasePickerSheet> createState() => _BasePickerSheetState();
}

class _BasePickerSheetState extends State<PaletteBasePickerSheet> {
  String _query = '';

  List<MarkerColor> get _filtered {
    final String q = _query.trim().toLowerCase();
    if (q.isEmpty) return widget.markers;
    return widget.markers
        .where(
          (MarkerColor c) =>
              c.newCode.toLowerCase().contains(q) ||
              c.oldCode.toLowerCase().contains(q) ||
              c.newName.toLowerCase().contains(q) ||
              c.oldName.toLowerCase().contains(q),
        )
        .toList();
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
                    return InkWell(
                      key: ValueKey<String>('palette-picker-${marker.newCode}'),
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
                  },
                ),
        ),
      ],
    );
  }
}
