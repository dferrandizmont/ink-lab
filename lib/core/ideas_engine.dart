import 'dart:math' as math;

import 'collection_utils.dart';
import 'color_utils.dart';
import 'models.dart';
import 'palette_advisor.dart';

part 'ideas_catalog.dart';

enum IdeaCategory {
  signature('Signature'),
  challenge('Challenges'),
  atmosphere('Atmosphere');

  const IdeaCategory(this.label);
  final String label;
}

enum IdeaOutputMode { guideOnly, guideAndPalette }

final class IdeaPreset {
  const IdeaPreset({
    required this.id,
    required this.title,
    required this.category,
    required this.outputMode,
    required this.summary,
  });
  final String id, title, summary;
  final IdeaCategory category;
  final IdeaOutputMode outputMode;
}

final class IdeaPlan {
  IdeaPlan({
    required this.preset,
    required this.overview,
    required List<String> steps,
    required List<String> embellishments,
    required List<PaletteSuggestion> palette,
  }) : steps = List.unmodifiable(steps),
       embellishments = List.unmodifiable(embellishments),
       palette = List.unmodifiable(palette);
  final IdeaPreset preset;
  final String overview;
  final List<String> steps, embellishments;
  final List<PaletteSuggestion> palette;
}

abstract final class IdeasEngine {
  static final List<IdeaPreset> presets = List.unmodifiable(_ideaPresets);
  static IdeaPlan generatePlan(
    IdeaPreset preset,
    List<MarkerColor> candidates,
    int paletteSize,
  ) => IdeaPlan(
    preset: preset,
    overview: _overviewFor(preset.id),
    steps: _stepsFor(preset.id),
    embellishments: _embellishmentsFor(preset.id),
    palette: preset.outputMode == IdeaOutputMode.guideOnly
        ? []
        : _buildPaletteForPreset(
            preset.id,
            candidates,
            paletteSize.clamp(3, 5),
          ),
  );
}

List<PaletteSuggestion> _roleSuggestions({
  required List<MarkerColor> colors,
  required List<String> roles,
}) => colors.indexed
    .map(
      (entry) => PaletteSuggestion(
        color: entry.$2,
        reason: entry.$1 < roles.length ? roles[entry.$1] : 'Companion',
      ),
    )
    .toList();

List<MarkerColor> _pickRainbow(List<MarkerColor> candidates, int size) =>
    _pickByHueTargets(
      candidates,
      switch (size) {
        3 => [0, 120, 240],
        4 => [0, 90, 190, 285],
        _ => [0, 48, 122, 206, 288],
      },
      satTarget: 0.64,
      valueTarget: 0.72,
    );

List<MarkerColor> _pickMonochrome(List<MarkerColor> candidates, int size) {
  final seed = minBy(candidates, (c) {
    final hsv = hexToHsv(c.hex);
    return -(hsv[1] * 0.68 + hsv[2] * 0.32);
  });
  return _pickProfile(
    candidates: candidates,
    size: size,
    hueTargets: [seed == null ? 28 : hexToHsv(seed.hex)[0]],
    satTarget: 0.52,
    valueTarget: 0.62,
    satMin: 0.14,
  );
}

List<MarkerColor> _pickTwoColor(List<MarkerColor> candidates, int size) {
  final seed = minBy(candidates, (c) => -hexToHsv(c.hex)[1]);
  final hueA = seed == null ? 20.0 : hexToHsv(seed.hex)[0];
  final second = minBy(candidates, (c) {
    final hsv = hexToHsv(c.hex);
    return -(hueDistance(hsv[0], hueA) * 0.72 + hsv[1] * 0.28);
  });
  final hueB = second == null ? (hueA + 180) % 360 : hexToHsv(second.hex)[0];
  final firstCount = math.max(1, size ~/ 2);
  final secondCount = math.max(1, size - firstCount - 1);
  final toneA = _pickProfile(
    candidates: candidates,
    size: firstCount,
    hueTargets: [hueA],
    satTarget: 0.56,
    valueTarget: 0.62,
    satMin: 0.16,
  );
  final used = toneA.map((c) => c.newCode.toUpperCase()).toSet();
  final toneB = _pickProfile(
    candidates: candidates
        .where((c) => !used.contains(c.newCode.toUpperCase()))
        .toList(),
    size: secondCount,
    hueTargets: [hueB],
    satTarget: 0.54,
    valueTarget: 0.6,
    satMin: 0.16,
  );
  used.addAll(toneB.map((c) => c.newCode.toUpperCase()));
  final bridge = _pickNeutralBridge(candidates, used);
  return distinctBy([
    ...toneA,
    ...toneB,
    if (bridge != null && size > 2) bridge,
  ], (c) => c.newCode.toUpperCase()).take(size).toList();
}

List<MarkerColor> _pickUnlikely(List<MarkerColor> candidates, int size) =>
    _pickProfile(
      candidates: candidates,
      size: size,
      hueTargets: [96, 312, 190, 42, 252],
      satTarget: 0.66,
      valueTarget: 0.64,
      satMin: 0.22,
    );

List<MarkerColor> _pickDeterministicRandom(
  List<MarkerColor> candidates,
  int size, {
  required String seed,
}) => stableSortedBy(
  candidates,
  (c) => _stableOrderKey('$seed|${c.colorId}'),
).take(size).toList();

/// Reproduce JVM signed-Int overflow and UTF-16 code-unit iteration.
int _stableOrderKey(String value) {
  var hash = 17;
  for (final unit in value.codeUnits) {
    hash = ((hash * 31) ^ unit) & 0xffffffff;
  }
  return hash & 0x7fffffff;
}

List<MarkerColor> _pickSeasonal(List<MarkerColor> candidates, int size) =>
    _pickByHueTargets(
      candidates,
      switch (size) {
        3 => [102, 26, 210],
        4 => [102, 34, 208, 332],
        _ => [102, 34, 210, 332, 50],
      },
      satTarget: 0.52,
      valueTarget: 0.68,
    );

List<MarkerColor> _pickFiftyFifty(List<MarkerColor> candidates, int size) {
  final warmCount = math.max(size - 1, 2) ~/ 2;
  final coolCount = math.max(size - 1, 2) - warmCount;
  final warm = _pickProfile(
    candidates: candidates,
    size: warmCount,
    hueTargets: [14, 28, 352],
    satTarget: 0.56,
    valueTarget: 0.66,
    satMin: 0.2,
  );
  final used = warm.map((c) => c.newCode.toUpperCase()).toSet();
  final cool = _pickProfile(
    candidates: candidates
        .where((c) => !used.contains(c.newCode.toUpperCase()))
        .toList(),
    size: coolCount,
    hueTargets: [170, 198, 224],
    satTarget: 0.52,
    valueTarget: 0.62,
    satMin: 0.16,
  );
  used.addAll(cool.map((c) => c.newCode.toUpperCase()));
  final bridge = _pickNeutralBridge(candidates, used);
  return [
    ...warm,
    ...cool,
    if (bridge != null && size > 2) bridge,
  ].take(size).toList();
}

MarkerColor? _pickNeutralBridge(
  List<MarkerColor> candidates,
  Set<String> usedCodes,
) => minBy(
  candidates.where((c) => !usedCodes.contains(c.newCode.toUpperCase())),
  (c) {
    final hsv = hexToHsv(c.hex);
    return (hsv[1] - 0.22).abs() * 0.6 + (hsv[2] - 0.56).abs() * 0.4;
  },
);

List<MarkerColor> _pickByHueTargets(
  List<MarkerColor> candidates,
  List<double> targets, {
  required double satTarget,
  required double valueTarget,
}) {
  final selected = <String>{};
  final result = <MarkerColor>[];
  for (final hue in targets) {
    final best = minBy(
      candidates.where((c) => !selected.contains(c.newCode.toUpperCase())),
      (c) {
        final hsv = hexToHsv(c.hex);
        return hueDistance(hsv[0], hue) / 180 * 0.68 +
            (hsv[1] - satTarget).abs() * 0.18 +
            (hsv[2] - valueTarget).abs() * 0.14;
      },
    );
    if (best != null && selected.add(best.newCode.toUpperCase())) {
      result.add(best);
    }
  }
  return result;
}

List<MarkerColor> _pickProfile({
  required List<MarkerColor> candidates,
  required int size,
  required List<double> hueTargets,
  required double satTarget,
  required double valueTarget,
  double? satMin,
  double? satMax,
  double? valueMin,
  double? valueMax,
}) {
  final sorted = stableSortedBy(candidates, (c) {
    final hsv = hexToHsv(c.hex);
    final hueScore = hueTargets
        .map((target) => hueDistance(hsv[0], target) / 180)
        .reduce(math.min);
    var score =
        hueScore * 0.62 +
        (hsv[1] - satTarget).abs() * 0.23 +
        (hsv[2] - valueTarget).abs() * 0.15;
    if (satMin != null && hsv[1] < satMin) score += (satMin - hsv[1]) * 0.42;
    if (satMax != null && hsv[1] > satMax) score += (hsv[1] - satMax) * 0.42;
    if (valueMin != null && hsv[2] < valueMin) {
      score += (valueMin - hsv[2]) * 0.32;
    }
    if (valueMax != null && hsv[2] > valueMax) {
      score += (hsv[2] - valueMax) * 0.32;
    }
    return score;
  });
  return distinctBy(sorted, (c) => c.newCode.toUpperCase()).take(size).toList();
}
