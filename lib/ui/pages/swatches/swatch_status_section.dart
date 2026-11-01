import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_button.dart';

/// The wishlist and dried-out controls of the swatch detail sheet.
///
/// Two toggles: "Add to wishlist" (any marker) and "Mark as dried out"
/// (a marker the user owns, or one already marked). While the marker is dried
/// out, a line says what that means for Match, Palette and Ideas.
class SwatchStatusSection extends StatelessWidget {
  const SwatchStatusSection({
    super.key,
    required this.wished,
    required this.dried,
    required this.owned,
    required this.onToggleWishlist,
    required this.onToggleDried,
  });

  /// Whether the marker is on the wishlist.
  final bool wished;

  /// Whether the marker is marked as dried out.
  final bool dried;

  /// Whether the marker is in the user's collection. Only an owned marker can
  /// be marked as dried out; one already marked can always be unmarked.
  final bool owned;

  final VoidCallback onToggleWishlist;
  final VoidCallback onToggleDried;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Wrap(
          spacing: InkSpacing.s8,
          runSpacing: InkSpacing.s8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            InkButton.secondary(
              key: const ValueKey<String>('swatch-wishlist'),
              label: wished
                  ? context.l10n.wishlistRemove
                  : context.l10n.wishlistAdd,
              icon: wished ? InkIcons.check : InkIcons.bookmark,
              onPressed: onToggleWishlist,
            ),
            if (owned || dried)
              InkButton.secondary(
                key: const ValueKey<String>('swatch-dried'),
                label: dried
                    ? context.l10n.driedUnmark
                    : context.l10n.driedMark,
                icon: dried ? InkIcons.rotateCcw : InkIcons.dropletOff,
                onPressed: onToggleDried,
              ),
          ],
        ),
        if (dried) ...<Widget>[
          const SizedBox(height: InkSpacing.group),
          Row(
            key: const ValueKey<String>('swatch-dried-note'),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: InkIcon(
                  InkIcons.dropletOff,
                  size: InkGeometry.smallIcon,
                  color: ink.fg2,
                ),
              ),
              const SizedBox(width: InkSpacing.group),
              Expanded(
                child: Text(
                  context.l10n.driedNote,
                  style: AppTypography.secondary.copyWith(color: ink.fg2),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
