import 'package:flutter/material.dart';

import '../../../core/color_utils.dart';
import '../../../core/models.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_chip.dart';
import '../../../l10n/l10n.dart';

String _semanticsOf(BuildContext context, ColorDistanceMatch match) {
  final MarkerColor color = match.color;
  return '${color.newCode}, ${color.newName}, '
      '${context.l10n.matchQualityLabel(match.deltaE)}, '
      '${context.l10n.commonDeltaE(match.deltaE)}. ${context.l10n.matchSaveButton}.';
}

/// The closest marker of a match, shown large and tappable to save it.
///
/// Design G "Best match": an 88 hero swatch beside the code, the old code, the
/// name in the sheet-title style, the distance and the quality badge.
class BestMatchTile extends StatelessWidget {
  const BestMatchTile({super.key, required this.match, required this.onRecord});

  /// The winning match, with its marker and CIELAB76 distance.
  final ColorDistanceMatch match;

  /// Called when the tile is tapped.
  final VoidCallback onRecord;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final MarkerColor color = match.color;
    final bool hasOldCode =
        color.oldCode.isNotEmpty &&
        color.oldCode.toUpperCase() != color.newCode.toUpperCase();
    return Semantics(
      button: true,
      label: _semanticsOf(context, match),
      excludeSemantics: true,
      child: InkWell(
        onTap: onRecord,
        borderRadius: InkRadii.cardRadius,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SwatchBlock(
              hex: color.hex,
              size: InkGeometry.heroSwatch,
              radius: InkRadii.card,
            ),
            const SizedBox(width: InkSpacing.s16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        color.newCode,
                        style: AppTypography.code.copyWith(color: ink.fg),
                      ),
                      if (hasOldCode) ...<Widget>[
                        const SizedBox(width: InkSpacing.s8),
                        Flexible(
                          child: Text(
                            context.l10n.commonOldCode(color.oldCode),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.data.copyWith(color: ink.fg2),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: InkSpacing.s4),
                  Text(
                    color.newName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.sheetTitle.copyWith(color: ink.fg),
                  ),
                  const SizedBox(height: InkSpacing.group),
                  Row(
                    children: <Widget>[
                      Text(
                        context.l10n.commonDeltaE(match.deltaE),
                        style: AppTypography.data.copyWith(color: ink.fg),
                      ),
                      const SizedBox(width: InkSpacing.s8),
                      Flexible(
                        child: QualityBadge(
                          context.l10n.matchQualityLabel(match.deltaE),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// One alternate match, tappable to save it.
///
/// Design G "Alternatives": a 32 high swatch above the code and the distance,
/// at least 44 high so it stays an easy target.
class MatchResultTile extends StatelessWidget {
  const MatchResultTile({
    super.key,
    required this.match,
    required this.onRecord,
  });

  /// The match, with its marker and CIELAB76 distance.
  final ColorDistanceMatch match;

  /// Called when the tile is tapped.
  final VoidCallback onRecord;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final MarkerColor color = match.color;
    return Semantics(
      button: true,
      label: _semanticsOf(context, match),
      excludeSemantics: true,
      child: InkWell(
        onTap: onRecord,
        borderRadius: InkRadii.cellRadius,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: InkGeometry.target),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SwatchBlock(hex: color.hex, height: 32),
              const SizedBox(height: InkSpacing.group),
              Text(
                color.newCode,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.code.copyWith(color: ink.fg),
              ),
              Text(
                context.l10n.commonDeltaE(match.deltaE),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.data.copyWith(color: ink.fg2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
