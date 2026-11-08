import 'package:flutter/material.dart';

import '../../core/value_view.dart';
import '../../l10n/l10n.dart';
import 'ink_chip.dart';

/// Draws [child] in greyscale (its luminance only) while [enabled].
///
/// The grey is [ValueView]'s: the filter works on linear light, between an
/// sRGB-to-linear and a linear-to-sRGB filter, so a photo shows the same grey
/// as the colours drawn with `ValueView.greyHex`. It changes nothing of the
/// layout, and draws [child] as it is when not [enabled].
class ValueViewFilter extends StatelessWidget {
  const ValueViewFilter({
    super.key,
    required this.enabled,
    required this.child,
  });

  final bool enabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;
    return ColorFiltered(
      colorFilter: const ColorFilter.linearToSrgbGamma(),
      child: ColorFiltered(
        colorFilter: const ColorFilter.matrix(ValueView.linearMatrix),
        child: ColorFiltered(
          colorFilter: const ColorFilter.srgbToLinearGamma(),
          child: child,
        ),
      ),
    );
  }
}

/// The "Values" chip that turns the value (greyscale) view on and off.
///
/// A toggle with a tooltip that says what it does. The state is the caller's
/// (a page keeps it for the session and never stores it), so the same chip
/// serves Match now and the palette later.
class ValueViewToggle extends StatelessWidget {
  const ValueViewToggle({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final bool selected;

  /// Called with the new state; `null` disables the chip.
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final String label = context.l10n.matchValuesButton;
    return Tooltip(
      message: context.l10n.matchValuesTooltip,
      child: InkChip(
        label: label,
        semanticLabel: label,
        selected: selected,
        onSelected: onChanged,
      ),
    );
  }
}
