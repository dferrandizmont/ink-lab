import 'package:flutter/material.dart';

import '../../../core/gradient_preview.dart';
import '../../../core/models.dart';
import '../../../core/natural_sort.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_search_field.dart';
import '../../widgets/ink_sheet.dart';
import '../../widgets/skeleton_block.dart';
import 'swatch_marker_row.dart';

/// "Blend with…": a button that opens a searchable list of the user's
/// markers and, once one is picked, the gradient from this marker to that one
/// with the markers the user owns that make the steps in between.
///
/// What is picked is forgotten when the sheet moves to another marker.
class BlendSection extends StatefulWidget {
  const BlendSection({
    super.key,
    required this.marker,
    required this.owned,
    required this.catalogue,
    required this.onSelect,
  });

  final MarkerColor marker;

  /// The markers the user owns and can use, of every brand.
  final Future<List<MarkerColor>> owned;

  /// The markers the user could buy to fill a gap (the range of the brand of
  /// [marker]).
  final List<MarkerColor> catalogue;

  /// Called when a marker of the result is tapped.
  final ValueChanged<MarkerColor> onSelect;

  @override
  State<BlendSection> createState() => _BlendSectionState();
}

class _BlendSectionState extends State<BlendSection> {
  MarkerColor? _other;
  Future<GradientPreview?>? _preview;

  Future<GradientPreview?> _build(MarkerColor other) =>
      widget.owned.then<GradientPreview?>((List<MarkerColor> owned) {
        try {
          return buildGradientPreview(
            widget.marker,
            other,
            owned: owned,
            catalogue: widget.catalogue,
          );
        } on FormatException {
          return null;
        }
      }, onError: (Object _) => null);

  @override
  void didUpdateWidget(BlendSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.marker.colorId != widget.marker.colorId) {
      _other = null;
      _preview = null;
    } else if (_other != null &&
        (!identical(oldWidget.owned, widget.owned) ||
            oldWidget.marker.hex != widget.marker.hex)) {
      _preview = _build(_other!);
    }
  }

  Future<void> _pick() async {
    List<MarkerColor> owned;
    try {
      owned = await widget.owned;
    } catch (_) {
      owned = const <MarkerColor>[];
    }
    if (!mounted) return;
    final MarkerColor? picked = await showBlendPicker(
      context,
      marker: widget.marker,
      owned: owned,
    );
    if (picked == null || !mounted) return;
    setState(() {
      _other = picked;
      _preview = _build(picked);
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Column(
      key: const ValueKey<String>('swatch-blend'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        InkButton.secondary(
          key: const ValueKey<String>('swatch-blend-button'),
          label: l10n.swatchBlendWith,
          icon: InkIcons.droplet,
          expand: true,
          onPressed: _pick,
        ),
        if (_preview != null) ...<Widget>[
          const SizedBox(height: InkSpacing.block),
          FutureBuilder<GradientPreview?>(
            future: _preview,
            builder:
                (
                  BuildContext context,
                  AsyncSnapshot<GradientPreview?> snapshot,
                ) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const SkeletonBlock(
                      height: InkGeometry.skeletonList,
                    );
                  }
                  final GradientPreview? preview = snapshot.data;
                  if (preview == null) return const SizedBox.shrink();
                  return _Result(preview: preview, onSelect: widget.onSelect);
                },
          ),
        ],
      ],
    );
  }
}

/// The gradient strip and what is in between.
class _Result extends StatelessWidget {
  const _Result({required this.preview, required this.onSelect});

  final GradientPreview preview;
  final ValueChanged<MarkerColor> onSelect;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    final MarkerColor? missing = preview.missing;
    return Column(
      key: const ValueKey<String>('swatch-blend-result'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Semantics(
          image: true,
          label: l10n.swatchBlendStripSemantics(
            preview.from.newCode,
            preview.to.newCode,
          ),
          excludeSemantics: true,
          child: Container(
            key: const ValueKey<String>('swatch-blend-strip'),
            height: InkGeometry.paletteStripHeight - InkSpacing.s16,
            decoration: BoxDecoration(
              borderRadius: InkRadii.controlRadius,
              border: Border.all(color: ink.line),
              gradient: LinearGradient(
                colors: <Color>[
                  for (final String hex in preview.stops) swatchColor(hex),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: InkSpacing.s4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              preview.from.newCode,
              style: AppTypography.code.copyWith(color: ink.fg),
            ),
            Text(
              preview.to.newCode,
              style: AppTypography.code.copyWith(color: ink.fg),
            ),
          ],
        ),
        const SizedBox(height: InkSpacing.group),
        if (preview.picks.isNotEmpty) ...<Widget>[
          SwatchNote(l10n.swatchBlendSteps),
          for (final GradientPick pick in preview.picks)
            SwatchMarkerRow(
              key: ValueKey<String>('swatch-blend-step-${pick.color.colorId}'),
              color: pick.color,
              relativeTo: preview.from,
              onTap: () => onSelect(pick.color),
            ),
        ] else
          SwatchNote(
            preview.isDirect
                ? l10n.swatchBlendNothingBetween
                : l10n.swatchBlendNoneBetween,
          ),
        if (missing != null) ...<Widget>[
          const SizedBox(height: InkSpacing.group),
          SwatchNote(l10n.swatchBlendBuy(missing.newCode)),
          SwatchMarkerRow(
            key: ValueKey<String>('swatch-blend-buy-${missing.colorId}'),
            color: missing,
            relativeTo: preview.from,
            onTap: () => onSelect(missing),
          ),
        ],
      ],
    );
  }
}

/// Opens the list of [owned] markers (without [marker]) to pick the one to
/// blend [marker] with. `null` when the sheet is dismissed.
Future<MarkerColor?> showBlendPicker(
  BuildContext context, {
  required MarkerColor marker,
  required List<MarkerColor> owned,
}) {
  final List<MarkerColor> choices = <MarkerColor>[
    for (final MarkerColor c in owned)
      if (c.colorId != marker.colorId) c,
  ]..sort(_byBrandThenCode);
  return showInkSheet<MarkerColor>(
    context: context,
    builder: (BuildContext context) =>
        _BlendPicker(marker: marker, choices: choices),
  );
}

int _byBrandThenCode(MarkerColor a, MarkerColor b) {
  final int brand = MarkerBrand.values
      .indexOf(MarkerBrand.fromId(a.brandId))
      .compareTo(MarkerBrand.values.indexOf(MarkerBrand.fromId(b.brandId)));
  return brand != 0 ? brand : naturalCodeComparator(a.newCode, b.newCode);
}

class _BlendPicker extends StatefulWidget {
  const _BlendPicker({required this.marker, required this.choices});

  final MarkerColor marker;
  final List<MarkerColor> choices;

  @override
  State<_BlendPicker> createState() => _BlendPickerState();
}

class _BlendPickerState extends State<_BlendPicker> {
  String _query = '';

  List<MarkerColor> get _shown {
    final String q = _query.trim().toLowerCase();
    if (q.isEmpty) return widget.choices;
    return <MarkerColor>[
      for (final MarkerColor c in widget.choices)
        if (c.newCode.toLowerCase().contains(q) ||
            c.oldCode.toLowerCase().contains(q) ||
            c.newName.toLowerCase().contains(q) ||
            c.oldName.toLowerCase().contains(q) ||
            c.hex.toLowerCase().contains(q.replaceFirst('#', '')) ||
            MarkerBrand.fromId(c.brandId).label.toLowerCase().contains(q))
          c,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final MediaQueryData media = MediaQuery.of(context);
    final List<MarkerColor> shown = _shown;
    // The list keeps one height whatever the search finds, and leaves room
    // for the keyboard.
    final double listHeight =
        ((media.size.height - media.viewInsets.bottom) * 0.4).clamp(
          InkGeometry.rowTall * 2,
          double.infinity,
        );
    return Padding(
      padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
      child: Column(
        key: const ValueKey<String>('swatch-blend-picker'),
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              right: InkSpacing.sheetCloseClearance + InkGeometry.target,
            ),
            child: SwatchSectionHeading(l10n.swatchBlendTitle),
          ),
          const SizedBox(height: InkSpacing.block),
          InkSearchField(
            hintText: l10n.swatchBlendSearchHint,
            semanticLabel: l10n.swatchBlendSearchHint,
            onChanged: (String value) => setState(() => _query = value),
          ),
          const SizedBox(height: InkSpacing.group),
          SizedBox(
            height: listHeight,
            child: widget.choices.isEmpty
                ? SwatchNote(l10n.swatchBlendNoMarkers)
                : shown.isEmpty
                ? SwatchNote(l10n.swatchBlendNoResults)
                : ListView.builder(
                    itemCount: shown.length,
                    itemBuilder: (BuildContext context, int index) {
                      final MarkerColor color = shown[index];
                      return SwatchMarkerRow(
                        key: ValueKey<String>(
                          'swatch-blend-choice-${color.colorId}',
                        ),
                        color: color,
                        relativeTo: widget.marker,
                        onTap: () => Navigator.of(context).pop(color),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
