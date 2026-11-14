import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/models.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_segmented.dart';
import 'palette_layout.dart';

/// The base marker field and the palette size control: they share a row while
/// both fit and stack when they do not (both widths are measured).
///
/// The base marker is not typed on the page: its field is a button that opens
/// the searchable list of markers ([onPickBase]), so the page never rebuilds
/// its palette at each letter.
class PaletteBaseAndSize extends StatefulWidget {
  const PaletteBaseAndSize({
    super.key,
    required this.customMode,
    required this.paletteSize,
    required this.onSizeChanged,
    required this.hasChoices,
    required this.baseInput,
    required this.resolvedBase,
    required this.exampleCode,
    required this.hint,
    required this.onPickBase,
  });

  /// A custom or photo palette has no base to choose: only the size shows.
  final bool customMode;

  /// Number of colours of the palette, base included (3, 4 or 5).
  final int paletteSize;
  final ValueChanged<int> onSizeChanged;

  /// Whether there is any marker the base may be chosen from (the ones the
  /// user owns, or the whole range of the brand when the blending chain is in
  /// whole-range mode); without one the field is disabled, the way Generate
  /// is, instead of opening an empty list.
  final bool hasChoices;

  /// The base as the page holds it, in the spelling the field shows ("BV04",
  /// or "DecoTime 91" with several brands); empty while there is none.
  final String baseInput;

  /// The marker the base resolves to, if any.
  final MarkerColor? resolvedBase;

  /// A real code of the collection, to size the field for.
  final String exampleCode;

  /// The hint of the empty base field.
  final String hint;

  /// Opens the searchable list of markers, ready to type in.
  final VoidCallback onPickBase;

  @override
  State<PaletteBaseAndSize> createState() => _PaletteBaseAndSizeState();
}

/// How many times the widths of the row were measured (for the test that the
/// cache is dropped when what they depend on changes).
@visibleForTesting
int paletteBaseMeasureCount = 0;

class _PaletteBaseAndSizeState extends State<PaletteBaseAndSize> {
  /// What the measured widths were measured for: the text as it is drawn
  /// (the two styles after the inherited text style and bold text are
  /// merged), the scale, the reading direction, the language, the two texts
  /// and the fonts installed. They only change with one of those, not with
  /// every build of the page.
  ({
    TextStyle code,
    TextStyle secondary,
    TextScaler scaler,
    TextDirection direction,
    Locale? locale,
    String example,
    String hint,
    int fonts,
  })?
  _measuredFor;
  double _sizeWidth = 0;
  double _baseWanted = 0;

  /// Bumped when the fonts of the system change: a measurement made with the
  /// old ones is no longer true.
  int _fontsEpoch = 0;

  @override
  void initState() {
    super.initState();
    PaintingBinding.instance.systemFonts.addListener(_onFontsChanged);
  }

  @override
  void dispose() {
    PaintingBinding.instance.systemFonts.removeListener(_onFontsChanged);
    super.dispose();
  }

  void _onFontsChanged() => setState(() => _fontsEpoch++);

  /// [style] as a [Text] draws it: on top of the inherited text style, bold
  /// when the system asks for bold text.
  static TextStyle _drawn(BuildContext context, TextStyle style) {
    TextStyle drawn = DefaultTextStyle.of(context).style.merge(style);
    if (MediaQuery.boldTextOf(context)) {
      drawn = drawn.merge(const TextStyle(fontWeight: FontWeight.bold));
    }
    return drawn;
  }

  void _measure(BuildContext context) {
    final TextScaler scaler = MediaQuery.textScalerOf(context);
    final TextDirection direction = Directionality.of(context);
    final Locale? locale = Localizations.maybeLocaleOf(context);
    final TextStyle code = _drawn(context, AppTypography.code);
    final TextStyle secondary = _drawn(context, AppTypography.secondary);
    final key = (
      code: code,
      secondary: secondary,
      scaler: scaler,
      direction: direction,
      locale: locale,
      example: widget.exampleCode,
      hint: widget.hint,
      fonts: _fontsEpoch,
    );
    if (_measuredFor == key) return;
    _measuredFor = key;
    paletteBaseMeasureCount++;
    double width(String text, TextStyle style) {
      final TextPainter painter = TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: direction,
        textScaler: scaler,
        locale: locale,
        maxLines: 1,
      )..layout();
      final double w = painter.width;
      painter.dispose();
      return w;
    }

    _sizeWidth = _sizeControlWidth(<double>[
      for (final String d in const <String>['3', '4', '5']) width(d, code),
    ]);
    _baseWanted = math.max(
      _baseFieldMinWidth(
        math.max(
          width(widget.exampleCode, code),
          width(widget.hint, secondary),
        ),
      ),
      _baseFieldFloor * scaler.scale(1),
    );
  }

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
          selected: widget.paletteSize,
          onChanged: widget.onSizeChanged,
        ),
      ],
    );
    return paletteInset(
      LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (widget.customMode) return size;
          // Base marker and Size share a row while both fit; past that (a
          // narrow phone at a large text scale) Size drops below the field.
          // Both widths are measured, so the switch is exact in every
          // language and at every text scale (like InkDefinitionRow).
          const double gap = InkSpacing.buttonGap;
          _measure(context);
          if (constraints.maxWidth < _baseWanted + gap + _sizeWidth) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildBaseField(context),
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
              Expanded(child: _buildBaseField(context)),
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

  /// Width of the three-segment size control, from the width of its digits:
  /// each 3 / 4 / 5 segment is at least `InkGeometry.target` wide plus its
  /// 10 dp padding, in a 48-high container (3 dp side padding, 2 dp between
  /// segments).
  static double _sizeControlWidth(List<double> digitWidths) {
    final double widest = digitWidths.fold(
      0,
      (double a, double w) => math.max(a, w + 20),
    );
    final double segment = math.max(widest, InkGeometry.target);
    return segment * 3 + 2 * 2 + 2 * 3;
  }

  /// What the base field needs to hold its swatch, the text it shows (its
  /// code, or its hint while it is empty, [text] wide) and the search glyph,
  /// measured like the size control: the row only keeps the base and the size
  /// together when neither text is cut.
  static double _baseFieldMinWidth(double text) {
    // Side padding 12 + 12, swatch 24, gap 10, gap 8, search glyph 20.
    const double chrome =
        InkSpacing.s12 +
        InkGeometry.swatchSm +
        InkSpacing.s10 +
        InkSpacing.s8 +
        InkGeometry.mediumIcon +
        InkSpacing.s12;
    // A little slack so the row/stack boundary never lands exactly on the
    // measured width: rounding the Expanded down by a fraction of a pixel
    // would otherwise ellipsise the last glyph of the hint.
    return chrome + text + InkSpacing.buttonGap;
  }

  /// The base-marker field: caps label, then a 48-high rounded box with the
  /// marker colour chip, the code and the marker name. The whole box is one
  /// button that opens the list of markers.
  Widget _buildBaseField(BuildContext context) {
    final MarkerColor? base = widget.resolvedBase;
    final String input = widget.baseInput.trim();
    final String spoken = base == null
        ? (input.isEmpty ? widget.hint : input)
        : '${input.isEmpty ? base.newCode : input}, ${base.newName}';
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _caps(context, l10n.paletteBaseMarkerTitle),
        const SizedBox(height: InkSpacing.group),
        _BaseFieldButton(
          key: const ValueKey<String>('palette-base-field'),
          semanticLabel: l10n.paletteBaseMarkerTitle,
          semanticValue: spoken,
          semanticHint: l10n.palettePickBaseTooltip,
          onTap: widget.hasChoices ? widget.onPickBase : null,
          base: base,
          code: input.isEmpty ? null : input,
          hint: widget.hint,
        ),
      ],
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

/// The box of the base marker field: swatch, code (or hint) on top and the
/// marker's name below, a search glyph at the end. One tap target; Enter and
/// Space open the list; a focus ring (the `action` border, like the old
/// focused input) shows while it has the keyboard focus. Disabled (no tap,
/// muted border and glyph) when [onTap] is null.
class _BaseFieldButton extends StatefulWidget {
  const _BaseFieldButton({
    super.key,
    required this.semanticLabel,
    required this.semanticValue,
    required this.semanticHint,
    required this.onTap,
    required this.base,
    required this.code,
    required this.hint,
  });

  final String semanticLabel;
  final String semanticValue;
  final String semanticHint;
  final VoidCallback? onTap;
  final MarkerColor? base;

  /// The base as written, or `null` while there is none (the hint shows).
  final String? code;
  final String hint;

  @override
  State<_BaseFieldButton> createState() => _BaseFieldButtonState();
}

class _BaseFieldButtonState extends State<_BaseFieldButton> {
  bool _focused = false;

  /// One line of [style] at the text scale in use (a line is as tall as the
  /// whole pixels it is drawn in).
  static double _lineHeight(BuildContext context, TextStyle style) =>
      (MediaQuery.textScalerOf(context).scale(style.fontSize!) * style.height!)
          .ceilToDouble();

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final MarkerColor? base = widget.base;
    final bool enabled = widget.onTap != null;
    // Nothing chosen: the hint shows alone, centred.
    final bool empty = base == null && widget.code == null;
    final Color border = !enabled
        ? ink.line
        : _focused
        ? ink.action
        : ink.strong;
    return Semantics(
      container: true,
      button: true,
      enabled: enabled,
      label: widget.semanticLabel,
      value: widget.semanticValue,
      hint: widget.semanticHint,
      excludeSemantics: true,
      onTap: widget.onTap,
      child: Material(
        color: ink.surface,
        shape: RoundedRectangleBorder(
          borderRadius: InkRadii.inputRadius,
          side: BorderSide(color: border),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: widget.onTap,
          onFocusChange: (bool value) => setState(() => _focused = value),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: InkGeometry.fieldHeight,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: InkSpacing.s12,
                vertical: InkSpacing.s4,
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
                    // The code on top and, once a marker is resolved, its name
                    // on a second line, one line at most (an ellipsis; the
                    // whole name is in the tooltip and read by screen
                    // readers), so the card is the height of the size control
                    // beside it with any name.
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Both lines keep their height whatever the box shows
                        // (the hint is a line shorter than the code, the name
                        // is not there until a marker is resolved): the box,
                        // and the row it is in, never change height. With
                        // nothing chosen the hint is centred in the two lines,
                        // level with the swatch and the glyph.
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight:
                                _lineHeight(context, AppTypography.code) +
                                (empty
                                    ? _lineHeight(
                                        context,
                                        AppTypography.caption,
                                      )
                                    : 0),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              widget.code ?? widget.hint,
                              key: const ValueKey<String>('palette-base-value'),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: widget.code == null
                                  ? AppTypography.secondary.copyWith(
                                      color: ink.fg2,
                                    )
                                  : AppTypography.code.copyWith(color: ink.fg),
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
                              style: AppTypography.caption.copyWith(
                                color: ink.fg2,
                              ),
                            ),
                          )
                        else if (!empty)
                          // No name yet: the line is kept, empty and unspoken.
                          SizedBox(
                            height: _lineHeight(context, AppTypography.caption),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: InkSpacing.s8),
                  InkIcon(
                    InkIcons.search,
                    size: InkGeometry.mediumIcon,
                    color: enabled ? ink.fg2 : ink.line,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
