import 'package:flutter/material.dart';

import '../../../core/models.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_search_field.dart';
import 'diary_widgets.dart';

/// A searchable list of markers to tick the ones an artwork used: code, old
/// code or name, with the colour and a check on the picked ones. Every tap
/// reports the new selection through [onChanged]; the sheet stays open.
class DiaryMarkerPickerSheet extends StatefulWidget {
  const DiaryMarkerPickerSheet({
    super.key,
    required this.markers,
    required this.selected,
    required this.onChanged,
    this.title,
    this.showBrand = false,
  });

  /// The heading of the sheet; the artwork diary's "Markers used" by default.
  final String? title;

  /// Writes the brand under each name, for a list that mixes brands.
  final bool showBrand;

  /// The markers that can be picked (the collection of the current brand).
  final List<MarkerColor> markers;

  /// The `brandId:CODE` ids picked so far.
  final Set<String> selected;
  final ValueChanged<Set<String>> onChanged;

  @override
  State<DiaryMarkerPickerSheet> createState() => _DiaryMarkerPickerSheetState();
}

class _DiaryMarkerPickerSheetState extends State<DiaryMarkerPickerSheet> {
  late final Set<String> _selected = <String>{...widget.selected};
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

  void _toggle(MarkerColor marker) {
    setState(() {
      if (!_selected.remove(marker.colorId)) _selected.add(marker.colorId);
    });
    widget.onChanged(<String>{..._selected});
  }

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final List<MarkerColor> markers = _filtered;
    final double height = MediaQuery.sizeOf(context).height * 0.55;
    return Column(
      key: const ValueKey<String>('diary-marker-picker'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: InkGeometry.target),
          child: Semantics(
            header: true,
            child: Text(
              widget.title ?? context.l10n.diaryMarkersTitle,
              style: AppTypography.section.copyWith(color: ink.fg),
            ),
          ),
        ),
        const SizedBox(height: InkSpacing.block),
        InkSearchField(
          key: const ValueKey<String>('diary-marker-search'),
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
                    final bool on = _selected.contains(marker.colorId);
                    return Semantics(
                      button: true,
                      selected: on,
                      excludeSemantics: true,
                      label: widget.showBrand
                          ? '${marker.newCode}, ${marker.newName}, '
                                '${MarkerBrand.fromId(marker.brandId).label}'
                          : '${marker.newCode}, ${marker.newName}',
                      child: InkWell(
                        key: ValueKey<String>('diary-marker-${marker.newCode}'),
                        onTap: () => _toggle(marker),
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
                                    widget.showBrand
                                        ? '${marker.newName} · '
                                              '${MarkerBrand.fromId(marker.brandId).label}'
                                        : marker.newName,
                                    style: AppTypography.secondary.copyWith(
                                      color: ink.fg2,
                                    ),
                                  ),
                                ),
                                if (on)
                                  InkIcon(
                                    InkIcons.check,
                                    size: InkGeometry.mediumIcon,
                                    color: ink.action,
                                  ),
                              ],
                            ),
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

/// What the palette picker answers: the palette chosen, or no palette.
class DiaryPaletteChoice {
  const DiaryPaletteChoice(this.paletteId);

  /// The chosen saved palette's id; `null` for "No palette".
  final String? paletteId;
}

/// The saved palettes to link an artwork to, each with its colour strip, and
/// a first row to link none. Pops with a [DiaryPaletteChoice].
class DiaryPalettePickerSheet extends StatelessWidget {
  const DiaryPalettePickerSheet({
    super.key,
    required this.palettes,
    required this.selectedId,
  });

  final List<SavedPalette> palettes;
  final String? selectedId;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final double height = MediaQuery.sizeOf(context).height * 0.55;

    Widget row({
      required Key key,
      required String title,
      String? subtitle,
      Widget? strip,
      required bool on,
      required String? id,
    }) => Semantics(
      button: true,
      selected: on,
      child: InkWell(
        key: key,
        onTap: () => Navigator.of(context).pop(DiaryPaletteChoice(id)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: InkGeometry.target + 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: InkSpacing.s8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: AppTypography.body.copyWith(color: ink.fg),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle,
                          style: AppTypography.secondary.copyWith(
                            color: ink.fg2,
                          ),
                        ),
                      if (strip != null) ...<Widget>[
                        const SizedBox(height: InkSpacing.s6),
                        strip,
                      ],
                    ],
                  ),
                ),
                if (on) ...<Widget>[
                  const SizedBox(width: InkSpacing.s8),
                  InkIcon(
                    InkIcons.check,
                    size: InkGeometry.mediumIcon,
                    color: ink.action,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );

    return Column(
      key: const ValueKey<String>('diary-palette-picker'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: InkGeometry.target),
          child: Semantics(
            header: true,
            child: Text(
              context.l10n.diaryPaletteChoose,
              style: AppTypography.section.copyWith(color: ink.fg),
            ),
          ),
        ),
        const SizedBox(height: InkSpacing.group),
        SizedBox(
          height: height,
          child: ListView(
            children: <Widget>[
              row(
                key: const ValueKey<String>('diary-palette-none'),
                title: context.l10n.diaryPaletteNone,
                on: selectedId == null,
                id: null,
              ),
              if (palettes.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: InkSpacing.group),
                  child: Text(
                    context.l10n.diaryPaletteEmpty,
                    style: AppTypography.secondary.copyWith(color: ink.fg2),
                  ),
                ),
              for (final SavedPalette palette in palettes) ...<Widget>[
                Divider(
                  height: InkGeometry.border,
                  thickness: InkGeometry.border,
                  color: ink.line,
                ),
                row(
                  key: ValueKey<String>('diary-palette-${palette.id}'),
                  title: palette.name,
                  subtitle:
                      '${MarkerBrand.fromId(palette.brandId).label} · '
                      '${context.l10n.commonColorCount(palette.colorCodes.length)}',
                  strip: DiaryPaletteStrip(palette: palette),
                  on: selectedId == palette.id,
                  id: palette.id,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
