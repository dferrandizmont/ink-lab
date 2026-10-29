import 'dart:math' as math;

import 'collection_selection.dart';
import 'collection_utils.dart';
import 'color_utils.dart';
import 'models.dart';
import 'palette_advisor.dart';

export 'palette_advisor.dart' show PaletteSuggestion;

part 'palette_scenarios.dart';

enum QuickPaletteVariation {
  moreVibrant('More vibrant', 'Vibrant'),
  softer('Softer', 'Soft'),
  higherContrast('Higher contrast', 'Contrast'),
  warmer('Warmer', 'Warm'),
  cooler('Cooler', 'Cool');

  const QuickPaletteVariation(this.label, this.reasonPrefix);
  final String label, reasonPrefix;
}

final class _ScoredColor {
  const _ScoredColor(this.color, this.hsv, this.score, this.reason);
  final MarkerColor color;
  final List<double> hsv;
  final double score;
  final String reason;
}

/// A scenario role's HSV target and optional saturation bounds.
final class ScenarioTarget {
  const ScenarioTarget(
    this.role,
    this.hueOffsets, {
    required this.valueDelta,
    required this.saturationDelta,
    this.preferNeutral = false,
    this.minSaturation,
    this.maxSaturation,
  });
  final String role;
  final List<double> hueOffsets;
  final double valueDelta, saturationDelta;
  // All source scenario targets use these fixed default weights.
  final double weightHue = 0.58, weightValue = 0.27, weightSaturation = 0.15;
  final bool preferNeutral;
  final double? minSaturation, maxSaturation;
}

/// Default, entirely local implementation. Callers supply collection state;
/// every result is selected from the validated active collection.
final class PaletteGenerator implements PaletteAdvisor {
  const PaletteGenerator();
  @override
  PaletteAdvice advise(PaletteAdvisorRequest request) {
    final available = paletteCandidateColors(
      colors: request.availableColors,
      brand: request.brand,
      activeSetIds: request.activeSetIds,
      ownedMarkerCodes: request.ownedMarkerCodes,
    );
    if (available.isEmpty) {
      return const PaletteAdviceFailure(PaletteFailureReason.noAvailableColors);
    }
    MarkerColor? base;
    if (request.baseColor != null) {
      // Resolve to the catalog object; a fabricated base must not bypass brand
      // or ownership restrictions.
      base = available
          .where((c) => c.colorId == request.baseColor!.colorId)
          .firstOrNull;
      if (base == null) {
        return const PaletteAdviceFailure(
          PaletteFailureReason.invalidBaseColor,
        );
      }
    } else if (request.scenario != null) {
      base = findScenarioDefaultBase(available, request.scenario!);
    }
    if (base == null) {
      return const PaletteAdviceFailure(PaletteFailureReason.missingBaseColor);
    }
    final suggestions = request.scenario == null
        ? buildPalette(base, available, request.mode, size: request.paletteSize)
        : buildScenarioPalette(
            base,
            available,
            request.scenario!,
            size: request.paletteSize,
            variationToken: request.variationToken,
          );
    return suggestions.isEmpty && request.mode != PaletteMode.customPalette
        ? const PaletteAdviceFailure(PaletteFailureReason.noSuggestions)
        : PaletteAdviceSuccess(suggestions);
  }
}

/// Resolves the first catalog match using either current or legacy code.
MarkerColor? resolveBaseColor(String input, List<MarkerColor> colors) {
  final normalized = input.trim().toUpperCase();
  return colors
      .where(
        (color) =>
            color.newCode.toUpperCase() == normalized ||
            color.oldCode.toUpperCase() == normalized,
      )
      .firstOrNull;
}

MarkerColor? findScenarioDefaultBase(
  List<MarkerColor> candidates,
  DrawingScenario scenario,
) {
  final seed = _scenarioSeed(scenario);
  return minBy(candidates, (color) {
    final hsv = hexToHsv(color.hex);
    return hueDistance(hsv[0], seed.$1) / 180 * 0.55 +
        (hsv[1] - seed.$2).abs() * 0.2 +
        (hsv[2] - seed.$3).abs() * 0.25;
  });
}

/// Like Kotlin, size is the number of companions, excluding the base.
/// Candidates here are already available markers; use [PaletteGenerator] to
/// apply pack/ownership validation to a whole catalog.
List<PaletteSuggestion> buildPalette(
  MarkerColor baseColor,
  List<MarkerColor> candidates,
  PaletteMode mode, {
  int size = 5,
}) {
  if (mode == PaletteMode.customPalette) return [];
  final wanted = size.clamp(3, 5);
  final base = hexToHsv(baseColor.hex);
  final options = candidates
      .where((c) => c.newCode != baseColor.newCode)
      .toList();
  if (options.isEmpty) return [];
  if (mode == PaletteMode.recommended) {
    return _buildRecommended(base, options, wanted);
  }
  final scored = options.map((c) {
    final hsv = hexToHsv(c.hex);
    return _ScoredColor(
      c,
      hsv,
      _scoreForMode(base, hsv, mode),
      _reasonForMode(mode, base, hsv),
    );
  });
  return _diversify(
    stableSortedBy(scored, (c) => c.score),
    mode,
    wanted,
  ).map((c) => PaletteSuggestion(color: c.color, reason: c.reason)).toList();
}

List<PaletteSuggestion> buildScenarioPalette(
  MarkerColor baseColor,
  List<MarkerColor> candidates,
  DrawingScenario scenario, {
  int size = 5,
  int variationToken = 0,
}) {
  final wanted = size.clamp(3, 5);
  final base = hexToHsv(baseColor.hex);
  final options = candidates
      .where((c) => c.newCode != baseColor.newCode)
      .toList();
  if (options.isEmpty) return [];
  final selected = <String>{};
  final result = <PaletteSuggestion>[];
  final targets = _scenarioTargets(scenario).take(wanted).toList();
  for (var i = 0; i < targets.length; i++) {
    final target = targets[i];
    final best = stableSortedBy(
      options.where((c) => !selected.contains(c.newCode)),
      (c) => scoreScenarioTarget(base, hexToHsv(c.hex), target),
    ).take(5).toList();
    if (best.isEmpty) continue;
    final offset = (variationToken + i).abs() % math.min(4, best.length);
    final color = best[offset.toInt()];
    selected.add(color.newCode);
    result.add(PaletteSuggestion(color: color, reason: target.role));
  }
  if (result.length < wanted) {
    final fallback = stableSortedBy(
      options.where((c) => !selected.contains(c.newCode)),
      (c) => _recommendedScore(base, hexToHsv(c.hex)),
    );
    for (final c in fallback) {
      if (result.length >= wanted) break;
      if (selected.add(c.newCode)) {
        result.add(PaletteSuggestion(color: c, reason: 'Scenario support'));
      }
    }
  }
  return result.take(wanted).toList();
}

/// Kotlin scenario score for HSV triples, including optional bound penalties.
double scoreScenarioTarget(
  List<double> base,
  List<double> candidate,
  ScenarioTarget target,
) {
  final hue = target.hueOffsets
      .map(
        (offset) => hueDistance(candidate[0], (base[0] + offset) % 360) / 180,
      )
      .reduce(math.min);
  final value = (base[2] + target.valueDelta).clamp(0.0, 1.0);
  final saturation = (base[1] + target.saturationDelta).clamp(0.0, 1.0);
  var score =
      hue * target.weightHue +
      (candidate[2] - value).abs() * target.weightValue +
      (candidate[1] - saturation).abs() * target.weightSaturation;
  if (target.preferNeutral && candidate[1] > 0.38) {
    score += (candidate[1] - 0.38) * 0.5;
  }
  if (target.minSaturation != null && candidate[1] < target.minSaturation!) {
    score += (target.minSaturation! - candidate[1]) * 0.5;
  }
  if (target.maxSaturation != null && candidate[1] > target.maxSaturation!) {
    score += (candidate[1] - target.maxSaturation!) * 0.5;
  }
  return score;
}

List<PaletteSuggestion> _buildRecommended(
  List<double> base,
  List<MarkerColor> options,
  int size,
) {
  final scored = options.map((c) {
    final hsv = hexToHsv(c.hex);
    return _ScoredColor(
      c,
      hsv,
      _recommendedScore(base, hsv),
      'Balanced pairing',
    );
  }).toList();
  final byCode = <String, PaletteSuggestion>{};
  void pick(
    bool Function(_ScoredColor) filter,
    double Function(_ScoredColor) score,
    String reason,
  ) {
    final best = minBy(scored.where(filter), score);
    if (best != null) {
      byCode[best.color.newCode] = PaletteSuggestion(
        color: best.color,
        reason: reason,
      );
    }
  }

  pick(
    (c) => c.hsv[2] < base[2] - 0.08,
    (c) => _scoreForMode(base, c.hsv, PaletteMode.shadow),
    'Shadow depth',
  );
  pick(
    (c) => true,
    (c) => _scoreForMode(base, c.hsv, PaletteMode.analogous),
    'Soft nearby hue',
  );
  pick(
    (c) => true,
    (c) => _scoreForMode(base, c.hsv, PaletteMode.splitComplementary),
    'Controlled contrast',
  );
  pick(
    (c) => c.hsv[1] < 0.28,
    (c) => ((base[2] - c.hsv[2]).abs() - 0.16).abs(),
    'Neutral balance',
  );
  pick(
    (c) => c.hsv[2] > base[2] + 0.1,
    (c) => _scoreForMode(base, c.hsv, PaletteMode.monochrome),
    'Highlight lift',
  );
  if (byCode.length < size) {
    for (final c in stableSortedBy(scored, (c) => c.score)) {
      if (byCode.length >= size) break;
      byCode.putIfAbsent(
        c.color.newCode,
        () => PaletteSuggestion(color: c.color, reason: 'Balanced pairing'),
      );
    }
  }
  return byCode.values.take(size).toList();
}

double _recommendedScore(List<double> base, List<double> candidate) {
  final scores = [
    _scoreForMode(base, candidate, PaletteMode.analogous) + 0.08,
    _scoreForMode(base, candidate, PaletteMode.splitComplementary) + 0.1,
    _scoreForMode(base, candidate, PaletteMode.monochrome) + 0.12,
    _scoreForMode(base, candidate, PaletteMode.shadow) + 0.22,
  ];
  return scores.reduce(math.min) + (candidate[1] < 0.28 ? 0 : 0.15);
}

double _scoreForMode(
  List<double> base,
  List<double> candidate,
  PaletteMode mode,
) {
  final hue = candidate[0];
  final satDelta = (base[1] - candidate[1]).abs();
  final valueDelta = (base[2] - candidate[2]).abs();
  double targets(List<double> offsets) =>
      offsets
          .map((offset) => hueDistance(hue, (base[0] + offset) % 360))
          .reduce(math.min) /
      180;
  switch (mode) {
    case PaletteMode.recommended:
      return _recommendedScore(base, candidate);
    case PaletteMode.complementary:
      return targets([180]) +
          satDelta * 0.28 +
          (0.22 - valueDelta).abs() * 0.25;
    case PaletteMode.analogous:
      return targets([28, 332]) +
          satDelta * 0.28 +
          (0.18 - valueDelta).abs() * 0.2;
    case PaletteMode.splitComplementary:
      return targets([150, 210]) +
          satDelta * 0.3 +
          (0.2 - valueDelta).abs() * 0.2;
    case PaletteMode.triad:
      return targets([120, 240]) +
          satDelta * 0.3 +
          (0.2 - valueDelta).abs() * 0.2;
    case PaletteMode.square:
      return targets([90, 180, 270]) +
          satDelta * 0.3 +
          (0.18 - valueDelta).abs() * 0.2;
    case PaletteMode.rectangle:
      return targets([60, 180, 240]) +
          satDelta * 0.3 +
          (0.2 - valueDelta).abs() * 0.2;
    case PaletteMode.monochrome:
      final distance = hueDistance(hue, base[0]);
      final penalty = distance > 20 ? 1.1 + (distance - 20) / 40 : 0;
      return distance / 180 * 2.2 +
          satDelta * 0.55 +
          (0.18 - valueDelta).abs() * 0.45 +
          penalty;
    case PaletteMode.customPalette:
      return 10;
    case PaletteMode.shadow:
      if (candidate[2] >= base[2]) return 2 + candidate[2] - base[2];
      final satTarget = (base[1] * 0.95).clamp(0.0, 1.0);
      return hueDistance(hue, base[0]) / 180 * 0.7 +
          (candidate[1] - satTarget).abs() * 0.45 +
          (0.24 - (base[2] - candidate[2])).abs() * 0.9;
  }
}

String _reasonForMode(
  PaletteMode mode,
  List<double> base,
  List<double> candidate,
) {
  final distance = hueDistance(base[0], candidate[0]).toInt();
  final valueDiff = base[2] - candidate[2];
  return switch (mode) {
    PaletteMode.recommended => 'Balanced pairing',
    PaletteMode.complementary => 'Opposite hue contrast',
    PaletteMode.analogous => 'Nearby hue harmony (${distance}deg)',
    PaletteMode.splitComplementary => 'Split complement contrast',
    PaletteMode.triad => 'Triad balance',
    PaletteMode.square => 'Square harmony',
    PaletteMode.rectangle => 'Rectangle harmony',
    PaletteMode.monochrome =>
      valueDiff > 0 ? 'Same family, deeper tone' : 'Same family, lighter tone',
    PaletteMode.customPalette => 'Manual palette',
    PaletteMode.shadow =>
      valueDiff > 0
          ? 'Shadow tone (${(valueDiff * 100).toInt()}% darker)'
          : 'Support tone',
  };
}

List<_ScoredColor> _diversify(
  List<_ScoredColor> scored,
  PaletteMode mode,
  int size,
) {
  if ([
    PaletteMode.monochrome,
    PaletteMode.shadow,
    PaletteMode.customPalette,
  ].contains(mode)) {
    return scored.take(size).toList();
  }
  final gap = mode == PaletteMode.analogous
      ? 8
      : mode == PaletteMode.splitComplementary
      ? 12
      : 14;
  final selected = <_ScoredColor>[];
  for (final c in scored) {
    if (selected.length >= size) break;
    if (!selected.any(
      (current) =>
          hueDistance(current.hsv[0], c.hsv[0]) < gap &&
          (current.hsv[2] - c.hsv[2]).abs() < 0.07,
    )) {
      selected.add(c);
    }
  }
  for (final c in scored) {
    if (selected.length >= size) break;
    if (!selected.any((current) => current.color.newCode == c.color.newCode)) {
      selected.add(c);
    }
  }
  return selected.take(size).toList();
}

List<PaletteSuggestion> remixPaletteWithVariation(
  List<PaletteSuggestion> currentPalette,
  List<MarkerColor> candidates,
  Set<String> lockedCodes,
  String? baseCode,
  QuickPaletteVariation variation, {
  required int size,
}) {
  if (currentPalette.isEmpty || candidates.isEmpty) return currentPalette;
  final wanted = size.clamp(3, 5);
  final pool = candidates
      .where(
        (c) =>
            baseCode == null ||
            c.newCode.toUpperCase() != baseCode.toUpperCase(),
      )
      .toList();
  if (pool.isEmpty) return currentPalette.take(wanted).toList();
  final selected = <String>{};
  final result = <PaletteSuggestion>[];
  for (final locked in currentPalette.where(
    (s) => lockedCodes.contains(s.color.newCode),
  )) {
    if (result.length >= wanted) break;
    if (selected.add(locked.color.newCode.toUpperCase())) {
      result.add(PaletteSuggestion(color: locked.color, reason: 'Locked'));
    }
  }
  for (final s in currentPalette.where(
    (s) => !lockedCodes.contains(s.color.newCode),
  )) {
    if (result.length >= wanted) break;
    final target = _shiftedHsv(hexToHsv(s.color.hex), variation);
    final best = minBy(
      pool.where((c) => !selected.contains(c.newCode.toUpperCase())),
      (c) => _scoreVariationTarget(target, hexToHsv(c.hex), variation),
    );
    if (best != null) {
      selected.add(best.newCode.toUpperCase());
      result.add(
        PaletteSuggestion(
          color: best,
          reason:
              '${variation.reasonPrefix}: ${_stripVariationPrefixes(s.reason)}',
        ),
      );
    }
  }
  for (final s in currentPalette) {
    if (result.length >= wanted) break;
    if (selected.add(s.color.newCode.toUpperCase())) {
      result.add(
        PaletteSuggestion(
          color: s.color,
          reason: _stripVariationPrefixes(s.reason),
        ),
      );
    }
  }
  for (final c in pool) {
    if (result.length >= wanted) break;
    if (selected.add(c.newCode.toUpperCase())) {
      result.add(PaletteSuggestion(color: c, reason: 'Variation support'));
    }
  }
  return result.take(wanted).toList();
}

List<double> _shiftedHsv(List<double> hsv, QuickPaletteVariation variation) {
  final h = hsv[0], s = hsv[1], v = hsv[2];
  return switch (variation) {
    QuickPaletteVariation.moreVibrant => [
      h,
      (s + 0.18).clamp(0, 1),
      (v + 0.02).clamp(0, 1),
    ],
    QuickPaletteVariation.softer => [
      h,
      (s - 0.2).clamp(0, 1),
      (v + 0.08).clamp(0, 1),
    ],
    QuickPaletteVariation.higherContrast => [
      h,
      (s + 0.08).clamp(0, 1),
      (v >= 0.5 ? v + 0.16 : v - 0.16).clamp(0, 1),
    ],
    QuickPaletteVariation.warmer => [(h - 18) % 360, (s + 0.04).clamp(0, 1), v],
    QuickPaletteVariation.cooler => [(h + 18) % 360, (s + 0.02).clamp(0, 1), v],
  };
}

double _scoreVariationTarget(
  List<double> target,
  List<double> c,
  QuickPaletteVariation variation,
) {
  final score =
      hueDistance(target[0], c[0]) / 180 * 0.55 +
      (target[1] - c[1]).abs() * 0.25 +
      (target[2] - c[2]).abs() * 0.2;
  return switch (variation) {
    QuickPaletteVariation.moreVibrant => score + (0.82 - c[1]).abs() * 0.08,
    QuickPaletteVariation.softer => score + c[1] * 0.08,
    QuickPaletteVariation.higherContrast => score - (c[2] - 0.5).abs() * 0.06,
    QuickPaletteVariation.warmer || QuickPaletteVariation.cooler => score,
  };
}

String _stripVariationPrefixes(String reason) {
  var value = reason.trim();
  var changed = true;
  while (changed) {
    changed = false;
    for (final variation in QuickPaletteVariation.values) {
      final prefix = '${variation.reasonPrefix}:';
      if (value.toLowerCase().startsWith(prefix.toLowerCase())) {
        value = value.substring(prefix.length).trimLeft();
        changed = true;
      }
    }
  }
  return value.isEmpty ? 'AI suggestion' : value;
}
