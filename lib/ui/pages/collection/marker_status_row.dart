import 'package:flutter/material.dart';

import '../../../core/models.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';

/// One marker in a list of My collection (wishlist, dried out, what to buy
/// next): its swatch, the code, the name, optional notes and a trailing
/// control. At least 56 high; the texts wrap rather than being cut.
class MarkerStatusRow extends StatelessWidget {
  const MarkerStatusRow({
    super.key,
    required this.colorId,
    required this.color,
    required this.nameDisplayMode,
    this.notes = const <String>[],
    this.trailing,
  });

  /// The brand-scoped id of the marker.
  final String colorId;

  /// The catalogue colour, or `null` when the id is no longer in the
  /// catalogue (only the code is shown then).
  final MarkerColor? color;

  final NameDisplayMode nameDisplayMode;

  /// Lines of explanation under the name (`secondary`, `fg2`).
  final List<String> notes;

  /// The control at the end of the row (a 44 × 44 button).
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final MarkerColor? known = color;
    final String code = known == null
        ? colorId.substring(colorId.indexOf(':') + 1)
        : known.displayCode(nameDisplayMode);
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 56),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: InkSpacing.s8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (known == null)
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: ink.bg,
                  borderRadius: InkRadii.cellRadius,
                  border: Border.all(color: ink.line),
                ),
              )
            else
              SwatchBlock(hex: known.hex, size: 36, own: known.hasOwnColor),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(code, style: AppTypography.code.copyWith(color: ink.fg)),
                  if (known != null)
                    Text(
                      known.displayName(nameDisplayMode),
                      style: AppTypography.secondary.copyWith(color: ink.fg),
                    ),
                  for (final String note in notes)
                    Text(
                      note,
                      style: AppTypography.secondary.copyWith(color: ink.fg2),
                    ),
                ],
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }
}

/// The marker of [colorId] in [colors], or `null`.
MarkerColor? findMarker(List<MarkerColor> colors, String colorId) {
  for (final MarkerColor color in colors) {
    if (color.colorId == colorId) return color;
  }
  return null;
}
