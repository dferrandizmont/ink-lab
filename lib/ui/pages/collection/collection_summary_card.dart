import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import 'collection_summary.dart';

/// The card that says what the user owns: brand and series on the first
/// line, sets and markers (or what the app does while nothing is chosen) on
/// the second. Shown at the top of My collection and in the last step of the
/// first-run setup.
class CollectionSummaryCard extends StatelessWidget {
  const CollectionSummaryCard({super.key, required this.summary});

  final CollectionSummary summary;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Card(
      child: Padding(
        padding: InkSpacing.card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              summary.headline(),
              key: const ValueKey<String>('collection-summary-headline'),
              style: AppTypography.section.copyWith(color: ink.fg),
            ),
            const SizedBox(height: InkSpacing.s4),
            Text(
              summary.counts(context.l10n),
              key: const ValueKey<String>('collection-summary-counts'),
              style: AppTypography.body.copyWith(color: ink.fg2),
            ),
          ],
        ),
      ),
    );
  }
}
