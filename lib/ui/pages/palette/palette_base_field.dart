import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/models.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_segmented.dart';
import 'palette_layout.dart';

/// The base marker field and the palette size control: they share a row while
/// both fit and stack when they do not (both widths are measured).
class PaletteBaseAndSize extends StatelessWidget {
  const PaletteBaseAndSize({
    super.key,
    required this.customMode,
    required this.paletteSize,
    required this.onSizeChanged,
    required this.catalog,
    required this.resolvedBase,
    required this.exampleCode,
    required this.hint,
    required this.baseController,
    required this.baseFocus,
    required this.onBaseChanged,
    required this.onPickBase,
  });

  /// A custom or photo palette has no base to type: only the size shows.
  final bool customMode;

  /// Number of colours of the palette, base included (3, 4 or 5).
  final int paletteSize;
  final ValueChanged<int> onSizeChanged;

  /// Every marker of the brand, to suggest codes from.
  final List<MarkerColor> catalog;

  /// The marker the typed code resolves to, if any.
  final MarkerColor? resolvedBase;

  /// A real code of the collection, to size the field for.
  final String exampleCode;

  /// The hint of the empty base field.
  final String hint;
  final TextEditingController baseController;
  final FocusNode baseFocus;
  final ValueChanged<String> onBaseChanged;

  /// Opens the searchable list of markers.
  final VoidCallback onPickBase;

  @override
  Widget build(BuildContext context) {
    final Widget size = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _caps(context, context.l10n.paletteSizeTitle),
        const SizedBox(height: InkSpacing.group),
        InkSegmented<int>(
          semanticLabel: context.l10n.paletteSizeSemantic,
          numeric: true,
          segments: <InkSegment<int>>[
            for (final value in const <int>[3, 4, 5])
              InkSegment<int>(
                value: value,
                label: '$value',
                semantic: context.l10n.paletteSizeChip(value),
              ),
          ],
          selected: paletteSize,
          onChanged: onSizeChanged,
        ),
      ],
    );
    return paletteInset(
      LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (customMode) return size;
          // Base marker and Size share a row while both fit; past that (a
          // narrow phone at a large text scale) Size drops below the field.
          // Both widths are measured, so the switch is exact in every
          // language and at every text scale (like InkDefinitionRow).
          const double gap = InkSpacing.buttonGap;
          final double sizeWidth = _sizeControlWidth(context);
          final double scale = MediaQuery.textScalerOf(context).scale(1);
          final double baseWanted = math.max(
            _baseFieldMinWidth(context),
            _baseFieldFloor * scale,
          );
          if (constraints.maxWidth < baseWanted + gap + sizeWidth) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildBaseInput(context),
                const SizedBox(height: InkSpacing.block),
                size,
              ],
            );
          }
          // Aligned by the top: the two captions and the two controls start
          // on the same lines whatever the base's name is.
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: _buildBaseInput(context)),
              const SizedBox(width: gap),
              size,
            ],
          );
        },
      ),
      top: InkSpacing.block,
    );
  }

  /// The narrowest a base field may be before the size control moves below it
  /// (scaled by the text scale at build time).
  static const double _baseFieldFloor = 150;

  /// Width of the three-segment size control: each 3 / 4 / 5 segment is at
  /// least `InkGeometry.target` wide plus its 10 dp padding, in a 48-high
  /// container (3 dp side padding, 2 dp between segments).
  double _sizeControlWidth(BuildContext context) {
    final TextScaler scaler = MediaQuery.textScalerOf(context);
    final TextDirection direction = Directionality.of(context);
    double widest = 0;
    for (final String label in const <String>['3', '4', '5']) {
      final TextPainter painter = TextPainter(
        text: TextSpan(text: label, style: AppTypography.code),
        textDirection: direction,
        textScaler: scaler,
        maxLines: 1,
      )..layout();
      final double width = painter.width + 20;
      painter.dispose();
      if (width > widest) widest = width;
    }
    final double segment = math.max(widest, InkGeometry.target);
    return segment * 3 + 2 * 2 + 2 * 3;
  }

  /// What the base field needs to hold its swatch, the text it shows (its
  /// code, or its hint while it is empty) and the pick button, measured like
  /// the size control: the row only keeps the base and the size together when
  /// neither text is cut.
  double _baseFieldMinWidth(BuildContext context) {
    final TextDirection direction = Directionality.of(context);
    final TextScaler scaler = MediaQuery.textScalerOf(context);
    double text = 0;
    for (final (String value, TextStyle style) in <(String, TextStyle)>[
      (exampleCode, AppTypography.code),
      (hint, AppTypography.secondary),
    ]) {
      final TextPainter painter = TextPainter(
        text: TextSpan(text: value, style: style),
        textDirection: direction,
        textScaler: scaler,
        maxLines: 1,
      )..layout();
      if (painter.width > text) text = painter.width;
      painter.dispose();
    }
    // Left padding 12, swatch 24, gap 10, pick button 44, right padding 2.
    const double chrome = 12 + 24 + 10 + InkGeometry.target + 2;
    // A little slack so the row/stack boundary never lands exactly on the
    // measured width: rounding the Expanded down by a fraction of a pixel
    // would otherwise ellipsise the last glyph of the hint.
    return chrome + text + InkSpacing.buttonGap;
  }

  Widget _buildBaseInput(BuildContext context) {
    return RawAutocomplete<MarkerColor>(
      textEditingController: baseController,
      focusNode: baseFocus,
      displayStringForOption: (MarkerColor option) => option.newCode,
      optionsBuilder: (TextEditingValue value) {
        final query = value.text.trim().toUpperCase();
        if (query.isEmpty) return const Iterable<MarkerColor>.empty();
        final List<MarkerColor> matches = catalog
            .where(
              (color) =>
                  color.newCode.toUpperCase().contains(query) ||
                  color.oldCode.toUpperCase().contains(query),
            )
            .take(8)
            .toList();
        // A complete code that already produced its result has nothing left
        // to suggest: the list would only hover over the strip.
        if (matches.length == 1 &&
            (matches.first.newCode.toUpperCase() == query ||
                matches.first.oldCode.toUpperCase() == query)) {
          return const Iterable<MarkerColor>.empty();
        }
        return matches;
      },
      onSelected: (MarkerColor option) {
        onBaseChanged(option.newCode);
        // Close the suggestions: losing focus hides the overlay.
        baseFocus.unfocus();
      },
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController controller,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) => _buildBaseField(context, controller, focusNode, onFieldSubmitted),
      optionsViewBuilder: (
        BuildContext context,
        AutocompleteOnSelected<MarkerColor> onSelected,
        Iterable<MarkerColor> options,
      ) => _buildOptions(context, onSelected, options),
    );
  }

  /// The base-marker field: caps label, then a 48-high rounded box with the
  /// marker colour chip, the code input and the marker name.
  Widget _buildBaseField(
    BuildContext context,
    TextEditingController controller,
    FocusNode focusNode,
    VoidCallback onFieldSubmitted,
  ) {
    final InkColors ink = InkColors.of(context);
    final MarkerColor? base = resolvedBase;
    const InputBorder none = InputBorder.none;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _caps(context, context.l10n.paletteBaseMarkerTitle),
        const SizedBox(height: InkSpacing.group),
        ListenableBuilder(
          listenable: focusNode,
          builder: (BuildContext context, Widget? child) => Container(
            constraints: const BoxConstraints(
              minHeight: InkGeometry.fieldHeight,
            ),
            padding: const EdgeInsets.only(
              left: InkSpacing.s12,
              right: InkSpacing.s2,
              top: InkSpacing.s4,
              bottom: InkSpacing.s4,
            ),
            decoration: BoxDecoration(
              color: ink.surface,
              borderRadius: InkRadii.inputRadius,
              border: Border.all(
                color: focusNode.hasFocus ? ink.action : ink.strong,
              ),
            ),
            child: child,
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: InkGeometry.swatchSm,
                height: InkGeometry.swatchSm,
                decoration: BoxDecoration(
                  color: base == null ? null : swatchColor(base.hex),
                  borderRadius: InkRadii.xsRadius,
                  border: Border.all(
                    color: base == null
                        ? ink.line
                        : ink.swatchEdge(swatchColor(base.hex)),
                  ),
                ),
              ),
              const SizedBox(width: InkSpacing.s10),
              Expanded(
                // The code on top and, once a marker is resolved, its name on
                // a second line, one line at most (an ellipsis; the whole name
                // is in the tooltip and read by screen readers), so the card
                // is the height of the size control beside it with any name.
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Semantics(
                      label: context.l10n.paletteBaseCodeLabel,
                      child: TextField(
                        key: const ValueKey<String>('palette-base-input'),
                        controller: controller,
                        focusNode: focusNode,
                        textCapitalization: TextCapitalization.characters,
                        onChanged: onBaseChanged,
                        onSubmitted: (_) => onFieldSubmitted(),
                        onTapOutside: (_) => focusNode.unfocus(),
                        style: AppTypography.code.copyWith(color: ink.fg),
                        cursorColor: ink.action,
                        decoration: InputDecoration(
                          hintText: hint,
                          hintStyle: AppTypography.secondary.copyWith(
                            color: ink.fg2,
                          ),
                          filled: false,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: none,
                          enabledBorder: none,
                          focusedBorder: none,
                          disabledBorder: none,
                          errorBorder: none,
                          focusedErrorBorder: none,
                        ),
                      ),
                    ),
                    if (base != null)
                      Tooltip(
                        message: base.newName,
                        excludeFromSemantics: true,
                        child: Text(
                          base.newName,
                          key: const ValueKey<String>('palette-base-name'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.caption.copyWith(color: ink.fg2),
                        ),
                      ),
                  ],
                ),
              ),
              InkIconButton(
                key: const ValueKey<String>('palette-pick-base'),
                icon: InkIcons.search,
                iconSize: InkGeometry.smallIcon + 2,
                tooltip: context.l10n.palettePickBaseTooltip,
                onPressed: onPickBase,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOptions(
    BuildContext context,
    AutocompleteOnSelected<MarkerColor> onSelected,
    Iterable<MarkerColor> options,
  ) {
    final InkColors ink = InkColors.of(context);
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: InkSpacing.group),
        child: Material(
          key: const ValueKey<String>('palette-base-options'),
          color: ink.surface,
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: InkRadii.inputRadius,
            side: BorderSide(color: ink.line),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 280,
              maxWidth: math.min(
                MediaQuery.sizeOf(context).width - 2 * InkSpacing.pageMargin,
                420,
              ),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) {
                final MarkerColor option = options.elementAt(index);
                final bool hasOld =
                    option.oldCode.toUpperCase() !=
                    option.newCode.toUpperCase();
                return InkWell(
                  onTap: () => onSelected(option),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: InkGeometry.target,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: InkSpacing.cardH,
                        vertical: InkSpacing.s6,
                      ),
                      child: Row(
                        children: <Widget>[
                          SwatchBlock(
                            hex: option.hex,
                            size: InkGeometry.swatchSm,
                            radius: InkRadii.xs,
                            own: option.hasOwnColor,
                          ),
                          const SizedBox(width: InkSpacing.s10),
                          Expanded(
                            // Code (and former code) on the first line, the
                            // whole name below it.
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: <Widget>[
                                    Text(
                                      option.newCode,
                                      style: AppTypography.code.copyWith(
                                        color: ink.fg,
                                      ),
                                    ),
                                    if (hasOld) ...<Widget>[
                                      const SizedBox(width: InkSpacing.s8),
                                      Text(
                                        option.oldCode,
                                        style: AppTypography.data.copyWith(
                                          color: ink.fg2,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                Text(
                                  option.newName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.secondary.copyWith(
                                    color: ink.fg2,
                                  ),
                                ),
                              ],
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
        ),
      ),
    );
  }

  Widget _caps(BuildContext context, String text) {
    final InkColors ink = InkColors.of(context);
    return Text(
      AppTypography.caps(text),
      style: AppTypography.capsStyle.copyWith(color: ink.fg2),
    );
  }
}
