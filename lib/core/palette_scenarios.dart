part of 'palette_generator.dart';

List<ScenarioTarget> _scenarioTargets(
  DrawingScenario scenario,
) => switch (scenario) {
  DrawingScenario.ghostCharacter => [
    ScenarioTarget(
      "Soft shadow",
      [0],
      valueDelta: -0.2,
      saturationDelta: -0.05,
    ),
    ScenarioTarget(
      "Deep shadow",
      [8, 352],
      valueDelta: -0.32,
      saturationDelta: -0.1,
    ),
    ScenarioTarget(
      "Highlight",
      [0],
      valueDelta: 0.22,
      saturationDelta: -0.12,
      preferNeutral: true,
    ),
    ScenarioTarget(
      "Accent",
      [170, 190],
      valueDelta: -0.06,
      saturationDelta: 0.05,
    ),
    ScenarioTarget(
      "Background",
      [145, 215],
      valueDelta: 0.1,
      saturationDelta: -0.09,
    ),
  ],
  DrawingScenario.cuteCharacter ||
  DrawingScenario.pastelDream ||
  DrawingScenario.springGarden => [
    ScenarioTarget(
      "Soft shadow",
      [0],
      valueDelta: -0.15,
      saturationDelta: -0.03,
    ),
    ScenarioTarget(
      "Highlight",
      [0],
      valueDelta: 0.2,
      saturationDelta: -0.08,
      preferNeutral: true,
    ),
    ScenarioTarget(
      "Companion hue",
      [20, 340],
      valueDelta: 0.02,
      saturationDelta: -0.02,
    ),
    ScenarioTarget(
      "Accent",
      [150, 210],
      valueDelta: -0.04,
      saturationDelta: 0.08,
    ),
    ScenarioTarget(
      "Background",
      [165],
      valueDelta: 0.12,
      saturationDelta: -0.1,
    ),
  ],
  DrawingScenario.fantasyCreature || DrawingScenario.neonNight => [
    ScenarioTarget(
      "Primary shadow",
      [0],
      valueDelta: -0.24,
      saturationDelta: 0,
    ),
    ScenarioTarget(
      "Mystic accent",
      [120, 240],
      valueDelta: -0.08,
      saturationDelta: 0.12,
    ),
    ScenarioTarget(
      "Secondary accent",
      [180],
      valueDelta: 0,
      saturationDelta: 0.09,
    ),
    ScenarioTarget(
      "Highlight",
      [20, 340],
      valueDelta: 0.16,
      saturationDelta: -0.06,
    ),
    ScenarioTarget(
      "Background",
      [210],
      valueDelta: -0.14,
      saturationDelta: -0.02,
    ),
  ],
  DrawingScenario.halloweenMood => [
    ScenarioTarget(
      "Pumpkin shadow",
      [0],
      valueDelta: -0.24,
      saturationDelta: 0.02,
    ),
    ScenarioTarget(
      "Pumpkin glow",
      [14, 348],
      valueDelta: 0.16,
      saturationDelta: 0.08,
    ),
    ScenarioTarget(
      "Witchy purple",
      [248, 266],
      valueDelta: -0.02,
      saturationDelta: 0.1,
    ),
    ScenarioTarget(
      "Toxic accent",
      [92, 108],
      valueDelta: -0.06,
      saturationDelta: 0.1,
    ),
    ScenarioTarget(
      "Night background",
      [205],
      valueDelta: -0.18,
      saturationDelta: -0.04,
    ),
  ],
  DrawingScenario.christmasMood => [
    ScenarioTarget("Ribbon red", [0], valueDelta: -0.08, saturationDelta: 0.04),
    ScenarioTarget(
      "Evergreen",
      [120],
      valueDelta: -0.12,
      saturationDelta: 0.06,
    ),
    ScenarioTarget(
      "Gold accent",
      [48],
      valueDelta: 0.14,
      saturationDelta: 0.06,
    ),
    ScenarioTarget(
      "Pine depth",
      [140],
      valueDelta: -0.22,
      saturationDelta: -0.02,
    ),
    ScenarioTarget(
      "Snow highlight",
      [0],
      valueDelta: 0.24,
      saturationDelta: -0.24,
      preferNeutral: true,
      maxSaturation: 0.32,
    ),
  ],
  DrawingScenario.springMood => [
    ScenarioTarget(
      "Bud shadow",
      [0],
      valueDelta: -0.14,
      saturationDelta: -0.02,
    ),
    ScenarioTarget(
      "Blossom tint",
      [228],
      valueDelta: 0.06,
      saturationDelta: 0.03,
    ),
    ScenarioTarget("Fresh leaf", [0], valueDelta: 0.04, saturationDelta: 0.08),
    ScenarioTarget(
      "Daffodil light",
      [305],
      valueDelta: 0.22,
      saturationDelta: 0.02,
    ),
    ScenarioTarget("Rainy sky", [130], valueDelta: 0.1, saturationDelta: -0.1),
  ],
  DrawingScenario.warmPortrait ||
  DrawingScenario.cozyInterior ||
  DrawingScenario.vintageRoom ||
  DrawingScenario.autumnScene => [
    ScenarioTarget(
      "Skin/subject shadow",
      [0],
      valueDelta: -0.17,
      saturationDelta: -0.02,
    ),
    ScenarioTarget(
      "Warm companion",
      [20, 340],
      valueDelta: 0,
      saturationDelta: 0.02,
    ),
    ScenarioTarget(
      "Neutral balance",
      [0],
      valueDelta: 0.06,
      saturationDelta: -0.18,
      preferNeutral: true,
      maxSaturation: 0.35,
    ),
    ScenarioTarget(
      "Accent",
      [155, 205],
      valueDelta: -0.05,
      saturationDelta: 0.05,
    ),
    ScenarioTarget(
      "Background",
      [30],
      valueDelta: 0.14,
      saturationDelta: -0.12,
    ),
  ],
  DrawingScenario.autumnMood => [
    ScenarioTarget(
      "Bark shadow",
      [0],
      valueDelta: -0.26,
      saturationDelta: -0.04,
    ),
    ScenarioTarget(
      "Maple red",
      [334],
      valueDelta: -0.02,
      saturationDelta: 0.12,
    ),
    ScenarioTarget(
      "Pumpkin glow",
      [10],
      valueDelta: 0.12,
      saturationDelta: 0.08,
    ),
    ScenarioTarget(
      "Olive accent",
      [92],
      valueDelta: -0.06,
      saturationDelta: -0.02,
    ),
    ScenarioTarget(
      "Morning mist",
      [0],
      valueDelta: 0.18,
      saturationDelta: -0.24,
      preferNeutral: true,
      maxSaturation: 0.32,
    ),
  ],
  DrawingScenario.coolPortrait ||
  DrawingScenario.oceanScene ||
  DrawingScenario.winterSnow ||
  DrawingScenario.moodyNight => [
    ScenarioTarget(
      "Subject shadow",
      [0],
      valueDelta: -0.2,
      saturationDelta: -0.03,
    ),
    ScenarioTarget(
      "Cool companion",
      [25, 335],
      valueDelta: -0.02,
      saturationDelta: 0,
    ),
    ScenarioTarget(
      "Airy highlight",
      [0],
      valueDelta: 0.22,
      saturationDelta: -0.12,
      preferNeutral: true,
    ),
    ScenarioTarget(
      "Accent",
      [170, 190],
      valueDelta: -0.06,
      saturationDelta: 0.07,
    ),
    ScenarioTarget(
      "Background",
      [205, 230],
      valueDelta: 0.1,
      saturationDelta: -0.08,
    ),
  ],
  DrawingScenario.winterMood => [
    ScenarioTarget(
      "Snow shadow",
      [0],
      valueDelta: -0.24,
      saturationDelta: -0.04,
    ),
    ScenarioTarget(
      "Frost highlight",
      [0],
      valueDelta: 0.24,
      saturationDelta: -0.16,
      preferNeutral: true,
      maxSaturation: 0.3,
    ),
    ScenarioTarget(
      "Evergreen depth",
      [265],
      valueDelta: -0.08,
      saturationDelta: 0.06,
    ),
    ScenarioTarget(
      "Berry accent",
      [128],
      valueDelta: -0.02,
      saturationDelta: 0.12,
    ),
    ScenarioTarget(
      "Twilight sky",
      [30],
      valueDelta: -0.04,
      saturationDelta: 0.03,
    ),
  ],
  DrawingScenario.sunsetLandscape => [
    ScenarioTarget(
      "Ground shadow",
      [0],
      valueDelta: -0.24,
      saturationDelta: -0.02,
    ),
    ScenarioTarget("Sky blend", [30], valueDelta: 0.08, saturationDelta: 0.03),
    ScenarioTarget(
      "Sun highlight",
      [45],
      valueDelta: 0.24,
      saturationDelta: 0.06,
    ),
    ScenarioTarget(
      "Contrast accent",
      [190],
      valueDelta: -0.05,
      saturationDelta: 0.08,
    ),
    ScenarioTarget(
      "Neutral buffer",
      [0],
      valueDelta: 0.02,
      saturationDelta: -0.2,
      preferNeutral: true,
      maxSaturation: 0.35,
    ),
  ],
  DrawingScenario.summerMood => [
    ScenarioTarget(
      "Palm shadow",
      [0],
      valueDelta: -0.22,
      saturationDelta: -0.02,
    ),
    ScenarioTarget(
      "Coral accent",
      [320],
      valueDelta: 0.02,
      saturationDelta: 0.1,
    ),
    ScenarioTarget(
      "Ocean splash",
      [170],
      valueDelta: -0.04,
      saturationDelta: 0.09,
    ),
    ScenarioTarget(
      "Sunbeam highlight",
      [18],
      valueDelta: 0.24,
      saturationDelta: 0.04,
    ),
    ScenarioTarget(
      "Warm sand",
      [0],
      valueDelta: 0.1,
      saturationDelta: -0.22,
      preferNeutral: true,
      maxSaturation: 0.34,
    ),
  ],
  DrawingScenario.forestScene => [
    ScenarioTarget(
      "Leaf shadow",
      [0],
      valueDelta: -0.22,
      saturationDelta: -0.01,
    ),
    ScenarioTarget(
      "Moss midtone",
      [20, 340],
      valueDelta: -0.04,
      saturationDelta: -0.02,
    ),
    ScenarioTarget(
      "Sunlit leaf",
      [12],
      valueDelta: 0.18,
      saturationDelta: 0.03,
    ),
    ScenarioTarget(
      "Trunk accent",
      [150, 210],
      valueDelta: -0.1,
      saturationDelta: -0.06,
    ),
    ScenarioTarget("Sky/fog", [180], valueDelta: 0.12, saturationDelta: -0.08),
  ],
  DrawingScenario.floralPattern => [
    ScenarioTarget("Petal shadow", [0], valueDelta: -0.16, saturationDelta: 0),
    ScenarioTarget(
      "Petal highlight",
      [0],
      valueDelta: 0.18,
      saturationDelta: -0.08,
    ),
    ScenarioTarget(
      "Secondary petal",
      [30, 330],
      valueDelta: 0.04,
      saturationDelta: 0.04,
    ),
    ScenarioTarget(
      "Leaf accent",
      [140, 220],
      valueDelta: -0.02,
      saturationDelta: 0.04,
    ),
    ScenarioTarget(
      "Pattern background",
      [180],
      valueDelta: 0.1,
      saturationDelta: -0.1,
    ),
  ],
  DrawingScenario.geometricPattern ||
  DrawingScenario.plaidPattern ||
  DrawingScenario.polkaDotPattern ||
  DrawingScenario.candyStripes => [
    ScenarioTarget("Tone A", [0], valueDelta: 0, saturationDelta: 0),
    ScenarioTarget("Tone B", [90], valueDelta: 0, saturationDelta: 0.05),
    ScenarioTarget("Tone C", [180], valueDelta: -0.04, saturationDelta: 0.03),
    ScenarioTarget("Tone D", [270], valueDelta: 0.08, saturationDelta: -0.02),
    ScenarioTarget(
      "Neutral linework",
      [0],
      valueDelta: -0.1,
      saturationDelta: -0.22,
      preferNeutral: true,
      maxSaturation: 0.33,
    ),
  ],
};

(double, double, double) _scenarioSeed(DrawingScenario scenario) =>
    switch (scenario) {
      DrawingScenario.ghostCharacter ||
      DrawingScenario.winterSnow => (210.0, 0.18, 0.88),
      DrawingScenario.cuteCharacter ||
      DrawingScenario.pastelDream ||
      DrawingScenario.springGarden => (330.0, 0.28, 0.9),
      DrawingScenario.springMood => (104.0, 0.38, 0.86),
      DrawingScenario.fantasyCreature ||
      DrawingScenario.neonNight => (285.0, 0.62, 0.68),
      DrawingScenario.halloweenMood => (28.0, 0.72, 0.78),
      DrawingScenario.christmasMood => (4.0, 0.64, 0.72),
      DrawingScenario.warmPortrait ||
      DrawingScenario.cozyInterior ||
      DrawingScenario.vintageRoom ||
      DrawingScenario.autumnScene => (22.0, 0.46, 0.74),
      DrawingScenario.autumnMood => (26.0, 0.58, 0.66),
      DrawingScenario.coolPortrait ||
      DrawingScenario.oceanScene ||
      DrawingScenario.moodyNight => (205.0, 0.38, 0.7),
      DrawingScenario.winterMood => (212.0, 0.24, 0.84),
      DrawingScenario.sunsetLandscape => (28.0, 0.58, 0.82),
      DrawingScenario.summerMood => (34.0, 0.62, 0.84),
      DrawingScenario.forestScene => (118.0, 0.5, 0.62),
      DrawingScenario.floralPattern => (340.0, 0.42, 0.84),
      DrawingScenario.geometricPattern ||
      DrawingScenario.plaidPattern ||
      DrawingScenario.polkaDotPattern ||
      DrawingScenario.candyStripes => (28.0, 0.5, 0.74),
    };
