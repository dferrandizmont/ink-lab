import 'package:ink_lab/core/models.dart' show PaletteMode;
import 'package:ink_lab/core/palette_advisor.dart'
    as core
    show
        PaletteAdvisor,
        PaletteAdvisorRequest,
        PaletteAdviceFailure,
        PaletteAdviceSuccess,
        PaletteFailureReason,
        PaletteSuggestion;

import 'palette_advisor.dart';

/// Runs an AI [primary] advisor and never leaves the caller without an answer.
///
/// If the primary advisor fails, is disabled or throws, the local [local]
/// engine's result is returned instead, tagged with a short note. The local
/// engine is pure and synchronous, so this always completes.
final class FallbackPaletteAdvisor implements PaletteAdvisor {
  FallbackPaletteAdvisor({required this.primary, required this.local});

  final PaletteAdvisor primary;
  final core.PaletteAdvisor local;

  @override
  Future<PaletteAdvice> advise(core.PaletteAdvisorRequest request) async {
    PaletteAdvice? primaryFailure;
    try {
      final advice = await primary.advise(request);
      if (advice is PaletteAdviceSuccess) return _completed(request, advice);
      primaryFailure = advice;
    } catch (_) {
      primaryFailure = null;
    }
    return _localAdvice(request, primaryFailure);
  }

  /// Fills the missing slots of a short (but valid) AI answer from the local
  /// colour-theory engine. Colours already chosen are never repeated, and the
  /// AI's own picks stay first. Without room to fill, or when the local engine
  /// has nothing, the AI answer is returned as it came.
  PaletteAdviceSuccess _completed(
    core.PaletteAdvisorRequest request,
    PaletteAdviceSuccess advice,
  ) {
    final wanted = request.paletteSize <= 0 ? 1 : request.paletteSize;
    if (advice.modelUsed.isEmpty ||
        advice.suggestions.length >= wanted ||
        request.mode == PaletteMode.customPalette) {
      return advice;
    }
    final local = this.local.advise(request);
    if (local is! core.PaletteAdviceSuccess) return advice;

    final used = <String>{
      if (request.baseColor != null) request.baseColor!.colorId,
      for (final suggestion in advice.suggestions) suggestion.color.colorId,
    };
    final merged = <core.PaletteSuggestion>[...advice.suggestions];
    for (final suggestion in local.suggestions) {
      if (merged.length >= wanted) break;
      if (used.add(suggestion.color.colorId)) merged.add(suggestion);
    }
    if (merged.length == advice.suggestions.length) return advice;
    return PaletteAdviceSuccess(
      merged,
      tips: advice.tips,
      modelUsed: advice.modelUsed,
      usedFallback: advice.usedFallback,
      aiCount: advice.aiCount,
    );
  }

  PaletteAdvice _localAdvice(
    core.PaletteAdvisorRequest request,
    PaletteAdvice? primaryFailure,
  ) {
    final note = primaryFailure is PaletteAdviceFailure
        ? 'AI unavailable (${primaryFailure.message}) Showing local suggestions.'
        : 'AI unavailable. Showing local suggestions.';

    final advice = local.advise(request);
    switch (advice) {
      case core.PaletteAdviceSuccess(:final suggestions):
        return PaletteAdviceSuccess(
          [
            for (final suggestion in suggestions)
              core.PaletteSuggestion(
                color: suggestion.color,
                reason: suggestion.reason,
                role: suggestion.role,
              ),
          ],
          tips: [note],
          usedFallback: true,
        );
      case core.PaletteAdviceFailure(:final reason):
        return PaletteAdviceFailure(_mapCoreReason(reason), message: note);
    }
  }
}

PaletteFailureReason _mapCoreReason(core.PaletteFailureReason reason) =>
    switch (reason) {
      core.PaletteFailureReason.noAvailableColors =>
        PaletteFailureReason.noAvailableColors,
      core.PaletteFailureReason.noSuggestions =>
        PaletteFailureReason.noSuggestions,
      core.PaletteFailureReason.missingBaseColor ||
      core.PaletteFailureReason.invalidBaseColor =>
        PaletteFailureReason.noSuggestions,
    };
