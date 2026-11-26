import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import 'ink_chip.dart';

/// The "Values" chip that turns the Palette's greyscale view on and off.
///
/// The caller keeps the selected state for the session.
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
