import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import 'ai_report.dart';

/// Asks why an AI suggestion is reported. Pops the chosen [AiReportReason], or
/// `null` on cancel; Send stays disabled until one is chosen.
class PaletteAiReportDialog extends StatefulWidget {
  const PaletteAiReportDialog({super.key});

  @override
  State<PaletteAiReportDialog> createState() => _AiReportDialogState();
}

class _AiReportDialogState extends State<PaletteAiReportDialog> {
  AiReportReason? _reason;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final InkColors ink = InkColors.of(context);
    final Map<AiReportReason, String> labels = <AiReportReason, String>{
      AiReportReason.offensive: l10n.paletteAiReportOffensive,
      AiReportReason.wrong: l10n.paletteAiReportWrong,
      AiReportReason.other: l10n.paletteAiReportOther,
    };
    return AlertDialog(
      key: const ValueKey<String>('palette-ai-report-dialog'),
      title: Text(l10n.paletteAiReportTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              l10n.paletteAiReportBody,
              style: AppTypography.secondary.copyWith(color: ink.fg2),
            ),
            const SizedBox(height: InkSpacing.s8),
            RadioGroup<AiReportReason>(
              groupValue: _reason,
              onChanged: (AiReportReason? value) =>
                  setState(() => _reason = value),
              child: Column(
                children: <Widget>[
                  for (final MapEntry<AiReportReason, String> entry
                      in labels.entries)
                    RadioListTile<AiReportReason>(
                      key: ValueKey<String>(
                        'palette-ai-report-${entry.key.key}',
                      ),
                      value: entry.key,
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      // A FittedBox, not PaletteOneLine: the dialog measures its
                      // content with intrinsics, which a LayoutBuilder lacks.
                      title: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            entry.value,
                            maxLines: 1,
                            softWrap: false,
                            style: AppTypography.body.copyWith(color: ink.fg),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.paletteSaveDialogCancel),
        ),
        FilledButton(
          key: const ValueKey<String>('palette-ai-report-send'),
          onPressed: _reason == null
              ? null
              : () => Navigator.of(context).pop(_reason),
          child: Text(l10n.paletteAiReportSend),
        ),
      ],
    );
  }
}
