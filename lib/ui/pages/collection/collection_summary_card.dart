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
  const CollectionSummaryCard({
    super.key,
    required this.summary,
    this.embedded = false,
  });

  final CollectionSummary summary;

  /// Renders the summary as a row of a group card (My collection) instead of
  /// a card of its own (the first-run setup keeps the card).
  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
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
    );
    if (embedded) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(
          InkSpacing.cardH,
          InkSpacing.cardV,
          InkSpacing.cardH,
          InkSpacing.cardV,
        ),
        child: content,
      );
    }
    return Card(
      child: Padding(padding: InkSpacing.card, child: content),
    );
  }
}
