import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_button.dart';
import 'palette_layout.dart';
import 'palette_notes.dart';

/// The actions under the result (spec §2.2): "Suggest with AI" when the AI is
/// on, a secondary "Regenerate" (or "Generate" before there is a result) and
/// the primary "Save palette".
class PaletteActions extends StatelessWidget {
  const PaletteActions({
    super.key,
    required this.customMode,
    required this.photoMode,
    required this.chainMode,
    required this.aiAvailable,
    required this.aiLoading,
    required this.aiError,
    required this.hasResult,
    this.saved = false,
    required this.canRegenerate,
    required this.canGenerate,
    required this.canSuggestAi,
    required this.onSuggestAi,
    required this.onRegenerate,
    required this.onGenerate,
    required this.onSave,
  });

  final bool customMode;
  final bool photoMode;
  final bool chainMode;

  /// The AI is on and configured: the "Suggest with AI" button is offered.
  final bool aiAvailable;
  final bool aiLoading;

  /// Typed message of the last failed AI call, shown under the buttons.
  final String? aiError;
  final bool hasResult;

  /// The palette on screen is already saved: the Save button reads "Saved"
  /// (checked, disabled), in the same place and size.
  final bool saved;

  /// Whether Regenerate has anything else to show.
  final bool canRegenerate;

  /// Whether there is a base (or a scene) to generate from.
  final bool canGenerate;

  /// Whether "Suggest with AI" may run: there is a base (or a scene) to
  /// suggest from and the collection has a marker to suggest. Without
  /// markers there is nothing to suggest, so the button stays off.
  final bool canSuggestAi;
  final VoidCallback onSuggestAi;
  final VoidCallback onRegenerate;
  final VoidCallback onGenerate;
  final VoidCallback onSave;

  /// Whether the two secondary buttons fit side by side in [width]: each
  /// half has to hold the widest label they can show (with its icon) uncut,
  /// at the current text scale.
  bool _actionsFitInRow(BuildContext context, double width) {
    final TextDirection direction = Directionality.of(context);
    final TextScaler scaler = MediaQuery.textScalerOf(context);
    final AppLocalizations t = context.l10n;
    double widest = 0;
    // (label, has an icon or spinner); the AI button shows a spinner while it
    // loads, so both of its labels carry one.
    for (final (String label, bool icon) in <(String, bool)>[
      (t.paletteSuggestAiButton, false),
      (t.paletteSuggestAiLoading, true),
      (t.paletteRegenerateButton, true),
      (t.paletteGenerateButton, true),
    ]) {
      final TextPainter painter = TextPainter(
        text: TextSpan(text: label, style: AppTypography.button),
        textDirection: direction,
        textScaler: scaler,
        maxLines: 1,
      )..layout();
      // Padding 14 + 14, icon 16 and its gap 8.
      final double needed =
          painter.width + 28 + (icon ? InkGeometry.smallIcon + 8 : 0);
      painter.dispose();
      if (needed > widest) widest = needed;
    }
    // A little slack so rounding never cuts the last glyph.
    return widest + 2 <= (width - InkSpacing.buttonGap) / 2;
  }

  /// The actions under the result (spec §2.2): "Suggest with AI" when the AI
  /// is on, a secondary "Regenerate" (or "Generate" before there is a result)
  /// and the primary "Save palette". Share, the colour vision preview and
  /// Clear live in the result's "⋯".
  ///
  /// The secondaries share a row and are all the same size; the primary is
  /// on its own full-width row below, in a slot that is always there, so the
  /// result appearing never moves anything.
  @override
  Widget build(BuildContext context) {
    final bool showAi = aiAvailable && !customMode && !photoMode && !chainMode;
    // A photo palette has nothing to regenerate: same photo, same markers.
    final bool showSecondary = !photoMode && !customMode;
    final List<Widget> secondaries = <Widget>[
      if (showAi)
        InkButton(
          key: const ValueKey<String>('palette-suggest-ai'),
          variant: InkButtonVariant.smallSecondary,
          label: aiLoading
              ? context.l10n.paletteSuggestAiLoading
              : context.l10n.paletteSuggestAiButton,
          loading: aiLoading,
          expand: true,
          onPressed: canSuggestAi ? onSuggestAi : null,
        ),
      if (showSecondary)
        hasResult
            ? InkButton(
                key: const ValueKey<String>('palette-regenerate'),
                variant: InkButtonVariant.smallSecondary,
                label: context.l10n.paletteRegenerateButton,
                icon: InkIcons.rotateCcw,
                expand: true,
                onPressed: canRegenerate ? onRegenerate : null,
              )
            : InkButton(
                key: const ValueKey<String>('palette-generate'),
                variant: InkButtonVariant.smallSecondary,
                label: context.l10n.paletteGenerateButton,
                icon: InkIcons.shuffle,
                expand: true,
                onPressed: canGenerate ? onGenerate : null,
              ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        paletteInset(
          secondaries.length == 2
              ? LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    // Side by side, equal, when every label fits its half;
                    // otherwise one under the other, each the full width. The
                    // labels measured are all the ones the buttons can show,
                    // so the choice never changes with the state.
                    if (_actionsFitInRow(context, constraints.maxWidth)) {
                      return Row(
                        children: <Widget>[
                          Expanded(child: secondaries[0]),
                          const SizedBox(width: InkSpacing.buttonGap),
                          Expanded(child: secondaries[1]),
                        ],
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        secondaries[0],
                        const SizedBox(height: InkSpacing.buttonGap),
                        secondaries[1],
                      ],
                    );
                  },
                )
              : secondaries.isEmpty
              ? const SizedBox.shrink()
              : secondaries.single,
          top: InkSpacing.block,
        ),
        // The slot of the primary is always there: before there is a result it
        // is empty, but it keeps its height, so nothing moves below it.
        paletteInset(
          SizedBox(
            key: const ValueKey<String>('palette-save-slot'),
            height: InkGeometry.buttonHeight,
            child: hasResult
                ? InkButton(
                    key: const ValueKey<String>('palette-save'),
                    label: saved
                        ? context.l10n.paletteSavedButton
                        : context.l10n.paletteSaveButton,
                    icon: saved ? InkIcons.check : null,
                    expand: true,
                    onPressed: saved ? null : onSave,
                  )
                : null,
          ),
          top: InkSpacing.buttonGap,
        ),
        if (aiError != null)
          paletteInset(
            KeyedSubtree(
              key: const ValueKey<String>('palette-ai-error'),
              child: PaletteErrorNote(message: context.l10n.aiNote(aiError!)),
            ),
            top: InkSpacing.buttonGap,
          ),
      ],
    );
  }
}
