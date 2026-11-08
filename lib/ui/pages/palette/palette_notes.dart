import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_button.dart';

/// A short note under the field it belongs to (spec §2.2): one `secondary`
/// line in `fg2`, no card, so it does not compete with the result.
class PaletteInfoCard extends StatelessWidget {
  const PaletteInfoCard({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Text(
      message,
      style: AppTypography.secondary.copyWith(color: ink.fg2),
    );
  }
}

/// An error: same card as [PaletteInfoCard], with an `error` icon (no red fill).
class PaletteErrorNote extends StatelessWidget {
  const PaletteErrorNote({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Card(
      child: Padding(
        padding: InkSpacing.card,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: InkSpacing.s2),
              child: InkIcon(
                InkIcons.alertCircle,
                size: InkGeometry.mediumIcon,
                color: ink.error,
              ),
            ),
            const SizedBox(width: InkSpacing.buttonGap),
            Expanded(
              child: Text(
                message,
                style: AppTypography.secondary.copyWith(color: ink.fg),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A one-line notice with an OK button (saved, loaded, applied...).
class PaletteNoticeCard extends StatelessWidget {
  const PaletteNoticeCard({
    super.key,
    required this.message,
    required this.onDismiss,
  });

  final String message;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          InkSpacing.cardH,
          InkSpacing.s8,
          InkSpacing.s8,
          InkSpacing.s8,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                message,
                style: AppTypography.secondary.copyWith(color: ink.fg),
              ),
            ),
            InkButton.text(
              label: context.l10n.paletteOkButton,
              onPressed: onDismiss,
            ),
          ],
        ),
      ),
    );
  }
}
