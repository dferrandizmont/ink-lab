import 'dart:async';

import 'package:flutter/gestures.dart' show kDoubleTapTimeout;
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
  const PaletteBasePickerSheet({
    super.key,
    required this.markers,
    this.autofocusSearch = false,
    this.exampleCode,
  });

  final List<MarkerColor> markers;

  /// Opens with the search focused and the keyboard up, ready to type.
  final bool autofocusSearch;

  /// A code of one of the user's own markers, shown as the example in the
  /// search hint. Null (no marker of their own, or the list is the brand's
  /// whole range) leaves the hint without an example: the list never offers
  /// a code the user does not own as if it were theirs.
  final String? exampleCode;

  @override
  State<PaletteBasePickerSheet> createState() => _BasePickerSheetState();
}

class _BasePickerSheetState extends State<PaletteBasePickerSheet> {
  String _query = '';

  /// Whether the rows take taps: once the sheet has finished sliding in and
  /// a double tap's time has passed since it opened. Until then a second tap
  /// on the field that opened the sheet would land on the row under the
  /// finger and choose it (on a phone the sheet is in place before a quick
  /// second tap, so the animation alone is not enough).
  bool get _settled => _slidIn && _doubleTapOver;
  bool _slidIn = false;
  bool _doubleTapOver = false;
  Timer? _doubleTapTimer;
  Animation<double>? _routeAnimation;

  /// How long after opening a tap on a row still counts as the second tap of
  /// a double tap on the field.
  static final Duration _doubleTapGuard =
      const Duration(milliseconds: 200) + kDoubleTapTimeout;

  /// Whether the markers are of several brands, and the markers brand by
  /// brand (in the app's brand order, each brand in the order it came).
  late bool _mixed;
  late List<MarkerColor> _markers;

  @override
  void initState() {
    super.initState();
    _group();
    _doubleTapTimer = Timer(_doubleTapGuard, () {
      if (mounted) setState(() => _doubleTapOver = true);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Animation<double>? animation = ModalRoute.of(context)?.animation;
    if (!identical(animation, _routeAnimation)) {
      _routeAnimation?.removeStatusListener(_onRouteStatus);
      _routeAnimation = animation;
      animation?.addStatusListener(_onRouteStatus);
    }
    // No animation (none to wait for, or the platform disables them): the
    // rows work at once.
    if (animation == null ||
        animation.status == AnimationStatus.completed ||
        MediaQuery.maybeDisableAnimationsOf(context) == true) {
      _slidIn = true;
    }
  }

  void _onRouteStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed && !_slidIn && mounted) {
      setState(() => _slidIn = true);
    }
  }

  @override
  void dispose() {
    _doubleTapTimer?.cancel();
    _routeAnimation?.removeStatusListener(_onRouteStatus);
    super.dispose();
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
    final MediaQueryData media = MediaQuery.of(context);
    final double height = media.size.height * 0.55;
    // The sheet rises above the keyboard (the route does not do that for
    // itself); the list takes the room that is left, down to what the
    // keyboard leaves, and grows back to its height when the keyboard goes.
    return Padding(
      padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
      child: Column(
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
            hintText: widget.exampleCode == null
                ? context.l10n.palettePickerSearchHint
                : context.l10n.palettePickerSearchExample(widget.exampleCode!),
            semanticLabel: context.l10n.palettePickerSearchHint,
            autofocus: widget.autofocusSearch,
            onChanged: (String value) => setState(() => _query = value),
          ),
          const SizedBox(height: InkSpacing.s8),
          Flexible(
            child: SizedBox(
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
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: markers.length,
                      itemBuilder: (BuildContext context, int index) {
                        final MarkerColor marker = markers[index];
                        final Widget row = InkWell(
                          key: ValueKey<String>(
                            'palette-picker-'
                            '${_mixed ? marker.colorId : marker.newCode}',
                          ),
                          onTap: _settled
                              ? () => Navigator.of(context).pop(marker)
                              : null,
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
          ),
        ],
      ),
    );
  }
}
