import 'package:flutter/material.dart';

import '../../../core/color_vision.dart';
import '../../../core/value_view.dart';
import '../../../l10n/l10n.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_chip.dart';
import '../../widgets/page_header.dart';
import '../../widgets/value_view.dart';

/// [hex] as someone with [type] sees it; the colour itself when [type] is
/// `null` (normal vision). With [values] it is the grey of its value (see
/// [ValueView]) whatever [type] is.
///
/// Only for what is drawn on the page: a palette that is saved or shared
/// always keeps its true colours.
String seenHex(String hex, ColorVisionType? type, {bool values = false}) =>
    values
    ? ValueView.greyHex(hex)
    : type == null
    ? hex
    : ColorVision.simulate(hex, type);

/// The name of [type] in the app's language; `null` is normal vision.
String colorVisionLabel(BuildContext context, ColorVisionType? type) =>
    switch (type) {
      null => context.l10n.paletteVisionNormal,
      ColorVisionType.protanopia => context.l10n.paletteVisionProtanopia,
      ColorVisionType.deuteranopia => context.l10n.paletteVisionDeuteranopia,
      ColorVisionType.tritanopia => context.l10n.paletteVisionTritanopia,
      ColorVisionType.achromatopsia => context.l10n.paletteVisionAchromatopsia,
    };

/// "Colour vision": a compact control that previews the palette as seen with
/// protanopia, deuteranopia, tritanopia or achromatopsia, or in plain
/// greyscale ("Values", the [ValueViewToggle] of Match, for judging light and
/// dark), and says which of its colours become hard to tell apart.
///
/// The control only picks [selected] (`null` is normal vision) or [values];
/// the two exclude each other, and the page draws the simulated colours. [colors] and [labels] are the palette on
/// screen, to find the pairs; without them (the page has no palette, only
/// saved ones) the control just picks the preview.
class PaletteVisionControl extends StatelessWidget {
  const PaletteVisionControl({
    super.key,
    required this.selected,
    required this.onChanged,
    this.values = false,
    this.onValuesChanged,
    this.colors,
    this.labels,
  });

  final ColorVisionType? selected;
  final ValueChanged<ColorVisionType?> onChanged;

  /// Whether the value (greyscale) view is on. Only with [onValuesChanged]
  /// is its chip offered.
  final bool values;

  /// Turns the value view on or off.
  final ValueChanged<bool>? onValuesChanged;

  /// The hex colours of the palette on screen.
  final List<String>? colors;

  /// The marker codes of [colors], to name the pairs.
  final List<String>? labels;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final List<ColorVisionType?> options = <ColorVisionType?>[
      null,
      ...ColorVisionType.values,
    ];
    // Normal, Values and the deficiencies are one choice: Values (the check
    // artists make most) sits right after Normal, and is not a deficiency.
    final bool previewing = values || selected != null;
    // The value view is the grey of achromatopsia: same pairs.
    final ColorVisionType? effective = values
        ? ColorVisionType.achromatopsia
        : selected;
    return Column(
      // As tall as its content: in the sheet the page above must stay in
      // sight, since that is where the preview shows.
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        InkSectionHeading(context.l10n.paletteVisionTitle),
        const SizedBox(height: InkSpacing.headingGap),
        // Chips that wrap, not a scrolling segmented control: every option
        // stays in sight, and nothing scrolls the page to reveal one.
        Semantics(
          container: true,
          label: context.l10n.paletteVisionTitle,
          child: Wrap(
            spacing: InkSpacing.chipGap,
            children: <Widget>[
              for (final ColorVisionType? type in options) ...<Widget>[
                InkChip(
                  key: ValueKey<String>(
                    'palette-vision-${type?.name ?? 'normal'}',
                  ),
                  label: colorVisionLabel(context, type),
                  selected: type == selected && !values,
                  onSelected: (_) => onChanged(type),
                ),
                if (type == null && onValuesChanged != null)
                  KeyedSubtree(
                    key: const ValueKey<String>('palette-vision-values'),
                    child: ValueViewToggle(
                      selected: values,
                      onChanged: onValuesChanged,
                    ),
                  ),
              ],
            ],
          ),
        ),
        if (previewing) ...<Widget>[
          const SizedBox(height: InkSpacing.s8),
          Text(
            context.l10n.paletteVisionPreviewNote,
            key: const ValueKey<String>('palette-vision-note'),
            style: AppTypography.secondary.copyWith(color: ink.fg2),
          ),
          if (colors != null)
            PaletteVisionPairs(
              colors: colors!,
              labels: labels ?? const <String>[],
              type: effective!,
            ),
        ],
      ],
    );
  }
}

/// The pairs of colours of a palette that [type] makes hard to tell apart,
/// or a short line saying there are none.
class PaletteVisionPairs extends StatelessWidget {
  const PaletteVisionPairs({
    super.key,
    required this.colors,
    required this.labels,
    required this.type,
    this.top = InkSpacing.s4,
  });

  final List<String> colors;
  final List<String> labels;
  final ColorVisionType type;
  final double top;

  /// Pairs named before the rest is counted.
  static const int maxNamed = 3;

  String _name(int index) => index < labels.length && labels[index].isNotEmpty
      ? labels[index]
      : '${index + 1}';

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final List<ConfusablePair> pairs = ColorVision.confusablePairs(
      colors,
      type: type,
    );
    final String text;
    if (pairs.isEmpty) {
      text = context.l10n.paletteVisionNoPairs;
    } else {
      final List<String> named = <String>[
        for (final ConfusablePair pair in pairs.take(maxNamed))
          '${_name(pair.firstIndex)} / ${_name(pair.secondIndex)}',
      ];
      if (pairs.length > maxNamed) {
        named.add(context.l10n.paletteVisionPairsMore(pairs.length - maxNamed));
      }
      text = context.l10n.paletteVisionPairs(named.join(', '));
    }
    return Padding(
      padding: EdgeInsets.only(top: top),
      child: Text(
        text,
        key: ValueKey<String>(
          pairs.isEmpty ? 'palette-vision-clear' : 'palette-vision-pairs',
        ),
        style: AppTypography.secondary.copyWith(
          color: pairs.isEmpty ? ink.fg2 : ink.fg,
        ),
      ),
    );
  }
}
