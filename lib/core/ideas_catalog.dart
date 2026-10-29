part of 'ideas_engine.dart';

final _ideaPresets = [
  IdeaPreset(
    id: "sticker_effect",
    title: "Sticker Effect",
    category: IdeaCategory.signature,
    outputMode: IdeaOutputMode.guideOnly,
    summary: "Make subjects look like cut-out stickers using a white halo and black outer outline.",
  ),
  IdeaPreset(
    id: "polaroid_frame",
    title: "Polaroid Frame",
    category: IdeaCategory.signature,
    outputMode: IdeaOutputMode.guideOnly,
    summary: "Draw a Polaroid frame, color only inside it, and keep everything outside in grayscale.",
  ),
  IdeaPreset(
    id: "spotlight",
    title: "Spotlight",
    category: IdeaCategory.signature,
    outputMode: IdeaOutputMode.guideOnly,
    summary:
        "Create a strong focal light with dark edges and smooth value falloff.",
  ),
  IdeaPreset(
    id: "one_color",
    title: "One Color",
    category: IdeaCategory.challenge,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary: "Use a single hue family and control contrast only through value and saturation.",
  ),
  IdeaPreset(
    id: "two_colors",
    title: "Two Colors",
    category: IdeaCategory.challenge,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary: "Build the scene using only two dominant hue families plus subtle support tones.",
  ),
  IdeaPreset(
    id: "fifty_fifty",
    title: "50/50 Split",
    category: IdeaCategory.challenge,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary: "Split the composition in two moods. One side warm, the other cool, with a bridge color.",
  ),
  IdeaPreset(
    id: "warm_colors",
    title: "Warm Colors",
    category: IdeaCategory.challenge,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary: "Use only warm hues for an energetic, cozy, sunlit scene.",
  ),
  IdeaPreset(
    id: "cool_colors",
    title: "Cool Colors",
    category: IdeaCategory.challenge,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary: "Use cool hues for calm, depth, and atmospheric distance.",
  ),
  IdeaPreset(
    id: "pastel",
    title: "Pastel",
    category: IdeaCategory.challenge,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary: "Light value and low saturation for a soft, dreamy finish.",
  ),
  IdeaPreset(
    id: "neon",
    title: "Neon",
    category: IdeaCategory.challenge,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary: "High-energy, vivid colors that pop against dark support tones.",
  ),
  IdeaPreset(
    id: "rainbow",
    title: "Rainbow",
    category: IdeaCategory.challenge,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary: "Distribute hue families across the artwork while keeping values controlled.",
  ),
  IdeaPreset(
    id: "unlikely_colors",
    title: "Unlikely Colors",
    category: IdeaCategory.challenge,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary: "Try unexpected color pairings to make ordinary subjects feel stylized.",
  ),
  IdeaPreset(
    id: "random_colors",
    title: "Random Colors",
    category: IdeaCategory.challenge,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary:
        "Use a randomized palette and force cohesion through value planning.",
  ),
  IdeaPreset(
    id: "grayscale",
    title: "Grayscale",
    category: IdeaCategory.challenge,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary: "Work in values only to improve depth and contrast control.",
  ),
  IdeaPreset(
    id: "seasonal",
    title: "Seasonal",
    category: IdeaCategory.challenge,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary:
        "Blend spring, summer, autumn, or winter cues into a cohesive palette.",
  ),
  IdeaPreset(
    id: "christmas",
    title: "Christmas",
    category: IdeaCategory.challenge,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary: "Classic red-green-gold range for festive contrast and cozy highlights.",
  ),
  IdeaPreset(
    id: "valentines",
    title: "Valentine's Day",
    category: IdeaCategory.challenge,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary:
        "Romantic reds and pinks with soft highlights and warm transitions.",
  ),
  IdeaPreset(
    id: "white_effects",
    title: "White Effects",
    category: IdeaCategory.challenge,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary: "Plan the palette to leave room for white-pen sparkles and shine accents.",
  ),
  IdeaPreset(
    id: "black_effects",
    title: "Black Effects",
    category: IdeaCategory.challenge,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary: "Use black line details, dots, and pattern overlays to enhance contrast.",
  ),
  IdeaPreset(
    id: "crayons_only",
    title: "Crayons Only",
    category: IdeaCategory.challenge,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary:
        "Simple bold palette that mimics classic crayon behavior and texture.",
  ),
  IdeaPreset(
    id: "old_west",
    title: "Old West",
    category: IdeaCategory.atmosphere,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary: "Dusty sepia range with muted warmth, like an aged Western print.",
  ),
  IdeaPreset(
    id: "horror_halloween",
    title: "Horror/Halloween",
    category: IdeaCategory.atmosphere,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary: "Dark values and eerie accents to transform normal scenes into spooky mood.",
  ),
  IdeaPreset(
    id: "midnight",
    title: "Midnight",
    category: IdeaCategory.atmosphere,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary: "Turn daytime scenes into night by pushing cool shadows and selective highlights.",
  ),
  IdeaPreset(
    id: "underwater",
    title: "Underwater",
    category: IdeaCategory.atmosphere,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary:
        "Cool aquatic palette with depth haze, light rays, and bubble accents.",
  ),
  IdeaPreset(
    id: "spooky",
    title: "Spooky",
    category: IdeaCategory.atmosphere,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary:
        "Haunted-place vibe using desaturated darks and chilling accent tones.",
  ),
  IdeaPreset(
    id: "fantasy",
    title: "Fantasy",
    category: IdeaCategory.atmosphere,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary: "Magical tones with luminous accents and stylized contrast.",
  ),
  IdeaPreset(
    id: "in_the_mood",
    title: "In the Mood",
    category: IdeaCategory.atmosphere,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary: "Express one emotional tone through value rhythm and hue bias.",
  ),
  IdeaPreset(
    id: "sculpture",
    title: "Sculpture",
    category: IdeaCategory.atmosphere,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary: "Metallic or stone-like palette focused on material highlights and hard edges.",
  ),
  IdeaPreset(
    id: "galaxy",
    title: "Galaxy",
    category: IdeaCategory.atmosphere,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary:
        "Nebula-inspired range with deep space shadows and starlight accents.",
  ),
  IdeaPreset(
    id: "stained_glass",
    title: "Stained Glass",
    category: IdeaCategory.atmosphere,
    outputMode: IdeaOutputMode.guideAndPalette,
    summary:
        "Jewel-tone palette with dark separators to mimic leaded glass pieces.",
  ),
];

List<PaletteSuggestion> _buildPaletteForPreset(
  String presetId,
  List<MarkerColor> candidates,
  int size,
) {
  if (candidates.isEmpty) return [];
  return switch (presetId) {
    "one_color" => _roleSuggestions(
      colors: _pickMonochrome(candidates, size),
      roles: ["Main tone", "Midtone", "Shadow", "Highlight", "Blend"],
    ),
    "two_colors" => _roleSuggestions(
      colors: _pickTwoColor(candidates, size),
      roles: ["Tone A", "Tone A shadow", "Tone B", "Tone B shadow", "Bridge"],
    ),
    "warm_colors" => _roleSuggestions(
      colors: _pickProfile(
        candidates: candidates,
        size: size,
        hueTargets: [14, 26, 36, 350],
        satTarget: 0.58,
        valueTarget: 0.7,
        satMin: 0.22,
      ),
      roles: [
        "Warm base",
        "Warm shadow",
        "Sunlit accent",
        "Depth tone",
        "Blend",
      ],
    ),
    "cool_colors" => _roleSuggestions(
      colors: _pickProfile(
        candidates: candidates,
        size: size,
        hueTargets: [160, 188, 210, 235],
        satTarget: 0.5,
        valueTarget: 0.64,
        satMin: 0.18,
      ),
      roles: ["Cool base", "Cool shadow", "Atmosphere", "Deep cool", "Blend"],
    ),
    "pastel" => _roleSuggestions(
      colors: _pickProfile(
        candidates: candidates,
        size: size,
        hueTargets: [330, 20, 95, 175, 250],
        satTarget: 0.25,
        valueTarget: 0.9,
        satMax: 0.46,
        valueMin: 0.72,
      ),
      roles: [
        "Pastel base",
        "Soft shade",
        "Pastel highlight",
        "Accent",
        "Support",
      ],
    ),
    "neon" => _roleSuggestions(
      colors: _pickProfile(
        candidates: candidates,
        size: size,
        hueTargets: [325, 16, 80, 165, 255],
        satTarget: 0.86,
        valueTarget: 0.88,
        satMin: 0.62,
        valueMin: 0.6,
      ),
      roles: ["Neon lead", "Neon secondary", "Glow", "Pop accent", "Support"],
    ),
    "rainbow" => _roleSuggestions(
      colors: _pickRainbow(candidates, size),
      roles: ["Hue 1", "Hue 2", "Hue 3", "Hue 4", "Hue 5"],
    ),
    "unlikely_colors" => _roleSuggestions(
      colors: _pickUnlikely(candidates, size),
      roles: [
        "Unexpected lead",
        "Contrast pair",
        "Tension accent",
        "Offbeat support",
        "Bridge",
      ],
    ),
    "random_colors" => _roleSuggestions(
      colors: _pickDeterministicRandom(candidates, size, seed: presetId),
      roles: ["Random 1", "Random 2", "Random 3", "Random 4", "Random 5"],
    ),
    "grayscale" => _roleSuggestions(
      colors: _pickProfile(
        candidates: candidates,
        size: size,
        hueTargets: [0],
        satTarget: 0.06,
        valueTarget: 0.56,
        satMax: 0.22,
      ),
      roles: ["Light value", "Mid-light", "Mid", "Mid-dark", "Dark value"],
    ),
    "fifty_fifty" => _roleSuggestions(
      colors: _pickFiftyFifty(candidates, size),
      roles: [
        "Warm side A",
        "Warm side B",
        "Cool side A",
        "Cool side B",
        "Bridge tone",
      ],
    ),
    "seasonal" => _roleSuggestions(
      colors: _pickSeasonal(candidates, size),
      roles: ["Season lead", "Season support", "Shadow", "Highlight", "Accent"],
    ),
    "christmas" => _roleSuggestions(
      colors: _pickProfile(
        candidates: candidates,
        size: size,
        hueTargets: [0, 122, 45],
        satTarget: 0.58,
        valueTarget: 0.62,
        satMin: 0.2,
      ),
      roles: [
        "Festive red",
        "Evergreen",
        "Gold accent",
        "Pine shadow",
        "Snow support",
      ],
    ),
    "valentines" => _roleSuggestions(
      colors: _pickProfile(
        candidates: candidates,
        size: size,
        hueTargets: [352, 332, 18],
        satTarget: 0.54,
        valueTarget: 0.74,
        satMin: 0.18,
      ),
      roles: [
        "Romantic lead",
        "Rose shadow",
        "Soft blush",
        "Highlight",
        "Balance tone",
      ],
    ),
    "white_effects" => _roleSuggestions(
      colors: _pickProfile(
        candidates: candidates,
        size: size,
        hueTargets: [18, 205, 320, 92],
        satTarget: 0.42,
        valueTarget: 0.78,
        valueMin: 0.58,
      ),
      roles: ["Base", "Shadow", "Accent", "Glow zone", "Support"],
    ),
    "black_effects" => _roleSuggestions(
      colors: _pickProfile(
        candidates: candidates,
        size: size,
        hueTargets: [12, 210, 305, 118],
        satTarget: 0.6,
        valueTarget: 0.58,
        satMin: 0.22,
      ),
      roles: ["Base", "Shadow", "Pattern accent", "Contrast color", "Support"],
    ),
    "crayons_only" => _roleSuggestions(
      colors: _pickProfile(
        candidates: candidates,
        size: size,
        hueTargets: [0, 48, 120, 220],
        satTarget: 0.64,
        valueTarget: 0.72,
        satMin: 0.28,
      ),
      roles: ["Primary 1", "Primary 2", "Primary 3", "Secondary", "Support"],
    ),
    "old_west" => _roleSuggestions(
      colors: _pickProfile(
        candidates: candidates,
        size: size,
        hueTargets: [22, 30, 38],
        satTarget: 0.34,
        valueTarget: 0.58,
        satMax: 0.52,
      ),
      roles: [
        "Sepia light",
        "Dust midtone",
        "Leather shadow",
        "Aged accent",
        "Smoke neutral",
      ],
    ),
    "horror_halloween" => _roleSuggestions(
      colors: _pickProfile(
        candidates: candidates,
        size: size,
        hueTargets: [22, 280, 102, 240],
        satTarget: 0.56,
        valueTarget: 0.42,
        valueMax: 0.7,
      ),
      roles: [
        "Haunt base",
        "Pumpkin glow",
        "Night shadow",
        "Eerie accent",
        "Fog support",
      ],
    ),
    "midnight" => _roleSuggestions(
      colors: _pickProfile(
        candidates: candidates,
        size: size,
        hueTargets: [210, 236, 270],
        satTarget: 0.42,
        valueTarget: 0.36,
        valueMax: 0.62,
      ),
      roles: [
        "Night base",
        "Deep shadow",
        "Moonlit edge",
        "Cool accent",
        "Mist",
      ],
    ),
    "underwater" => _roleSuggestions(
      colors: _pickProfile(
        candidates: candidates,
        size: size,
        hueTargets: [168, 188, 204, 222],
        satTarget: 0.5,
        valueTarget: 0.62,
        satMin: 0.16,
      ),
      roles: [
        "Water base",
        "Depth",
        "Shadow water",
        "Light beam",
        "Bubble highlight",
      ],
    ),
    "spooky" => _roleSuggestions(
      colors: _pickProfile(
        candidates: candidates,
        size: size,
        hueTargets: [250, 115, 190],
        satTarget: 0.38,
        valueTarget: 0.44,
        valueMax: 0.72,
      ),
      roles: [
        "Spooky base",
        "Cold shadow",
        "Haunted accent",
        "Eerie highlight",
        "Fog tone",
      ],
    ),
    "fantasy" => _roleSuggestions(
      colors: _pickProfile(
        candidates: candidates,
        size: size,
        hueTargets: [286, 318, 182, 36],
        satTarget: 0.62,
        valueTarget: 0.68,
        satMin: 0.22,
      ),
      roles: [
        "Mystic base",
        "Spell shadow",
        "Magical accent",
        "Rune glow",
        "Balance tone",
      ],
    ),
    "in_the_mood" => _roleSuggestions(
      colors: _pickProfile(
        candidates: candidates,
        size: size,
        hueTargets: [302, 336, 208],
        satTarget: 0.46,
        valueTarget: 0.56,
      ),
      roles: [
        "Mood lead",
        "Mood shadow",
        "Emotion accent",
        "Atmosphere",
        "Support",
      ],
    ),
    "sculpture" => _roleSuggestions(
      colors: _pickProfile(
        candidates: candidates,
        size: size,
        hueTargets: [26, 42, 0, 210],
        satTarget: 0.16,
        valueTarget: 0.54,
        satMax: 0.34,
      ),
      roles: [
        "Material base",
        "Plane shift",
        "Hard shadow",
        "Specular edge",
        "Patina accent",
      ],
    ),
    "galaxy" => _roleSuggestions(
      colors: _pickProfile(
        candidates: candidates,
        size: size,
        hueTargets: [236, 282, 318, 190],
        satTarget: 0.62,
        valueTarget: 0.48,
        valueMax: 0.74,
      ),
      roles: [
        "Space base",
        "Nebula glow",
        "Deep void",
        "Star accent",
        "Dust cloud",
      ],
    ),
    "stained_glass" => _roleSuggestions(
      colors: _pickProfile(
        candidates: candidates,
        size: size,
        hueTargets: [8, 42, 122, 202, 292],
        satTarget: 0.72,
        valueTarget: 0.66,
        satMin: 0.3,
      ),
      roles: [
        "Glass pane A",
        "Glass pane B",
        "Glass pane C",
        "Glass pane D",
        "Light hit",
      ],
    ),
    _ => _roleSuggestions(
      colors: candidates.take(size).toList(),
      roles: ["Base", "Shade", "Accent", "Support", "Contrast"],
    ),
  };
}

String _overviewFor(String presetId) {
  return switch (presetId) {
    "sticker_effect" => "Technique-first challenge. The illusion comes from edge treatment, not from a specific palette.",
    "polaroid_frame" => "Build a fake instant-photo composition. The interior gets full color while the rest stays in controlled grayscale.",
    "spotlight" => "Direct attention with value contrast: bright center, dark perimeter, and clear light falloff.",
    "one_color" => "One hue, many values. Depth comes from shifts in lightness and saturation, not hue variety.",
    "two_colors" => "Restrict the scene to two hue families and let contrast come from value, not palette breadth.",
    "fifty_fifty" => "Compose two distinct moods in one image. Keep each side coherent and blend with one bridge tone.",
    "warm_colors" => "Warm hues carry energy and intimacy. Keep shadows warm instead of neutral gray.",
    "cool_colors" => "Cool hues create depth and calm. Control value steps to avoid a flat finish.",
    "pastel" => "Pastel scenes rely on value control and subtle contrast more than hue intensity.",
    "neon" => "Neon needs contrast. Reserve at least one dark support area so bright accents can glow.",
    "rainbow" => "Use broad hue coverage but keep one dominant hue family so the piece still feels unified.",
    "unlikely_colors" => "Unexpected combinations can feel intentional when value hierarchy stays clear.",
    "random_colors" => "Random palettes look coherent if you keep one focal area and controlled contrast.",
    "grayscale" => "Limit color information and focus on depth, hierarchy, and material separation through value only.",
    "seasonal" => "Seasonal palettes work best when one season dominates and others support the mood.",
    "christmas" => "Classic holiday balance: warm highlights, rich reds/greens, and selective bright accents.",
    "valentines" => "Romantic harmony comes from warm transitions and gentle highlight placement.",
    "white_effects" => "Reserve whitespace and bright value zones so white-ink effects read clearly.",
    "black_effects" => "Plan midtone areas where black pen details can add texture and graphic punch.",
    "crayons_only" => "Crayon style favors simple blocks, bold primaries, and visible stroke texture.",
    "old_west" => "Aged-photo atmosphere with dusty mids, muted warms, and restrained highlights.",
    "horror_halloween" => "Push darkness and selective eerie accents to convert normal scenes into unsettling ones.",
    "midnight" => "Night conversion depends on cooler shadows, lower values, and sparse light accents.",
    "underwater" => "Water depth appears through cool shifts, softened distance, suspended particles, and bubbles.",
    "spooky" =>
      "A haunted look uses desaturated dark fields and isolated eerie accents.",
    "fantasy" => "Push stylized hue choices and luminous accents while keeping shadows readable.",
    "in_the_mood" => "Choose one emotional direction and keep every hue/value decision aligned with it.",
    "sculpture" => "Material realism comes from edge control, value planes, and restrained saturation.",
    "galaxy" => "Cosmic scenes need deep darks, vibrant nebula zones, and tiny high-contrast stars.",
    "stained_glass" => "Think in colored panels and dark separators rather than smooth painterly blending.",
    _ => "Creative challenge",
  };
}

List<String> _stepsFor(String presetId) {
  return switch (presetId) {
    "sticker_effect" => [
      "Color the main subject normally first.",
      "Add a clean white halo around the full silhouette.",
      "Trace the outside edge of that white halo with a black line.",
      "Optional: add a tiny drop shadow under one side to make it pop.",
    ],
    "polaroid_frame" => [
      "Sketch a Polaroid frame with a wider bottom border.",
      "Block everything outside the frame using 2-3 grayscale values.",
      "Color only the interior photo window with your subject colors.",
      "Add a subtle frame shadow so the photo appears on top of the page.",
    ],
    "spotlight" => [
      "Mark the spotlight center before laying color.",
      "Keep the focal zone bright and high-contrast.",
      "Darken values gradually as you move away from the center.",
      "Finish with a soft vignette around page edges.",
    ],
    "one_color" => [
      "Choose one dominant hue family for the full piece.",
      "Separate planes with value shifts, not hue shifts.",
      "Reserve highest contrast for your focal element.",
      "Use saturation variation to avoid flat areas.",
    ],
    "two_colors" => [
      "Assign each major area to one of the two hue families.",
      "Keep transitions clean to preserve the two-tone concept.",
      "Use one neutral bridge only where needed.",
      "Keep one hue dominant and one supporting.",
    ],
    "fifty_fifty" => [
      "Split the page vertically or horizontally.",
      "Assign warm hues to one side and cool hues to the other.",
      "Use one bridge tone at the boundary so the split feels intentional.",
      "Keep each half internally consistent in value and saturation.",
    ],
    "old_west" => [
      "Lay a sepia-like base across major areas.",
      "Use dusty midtones and avoid highly saturated accents.",
      "Push shadows with muted browns instead of pure black.",
      "Reserve highlights for worn edges and sun hit points.",
    ],
    "horror_halloween" => [
      "Drop overall value to establish darkness first.",
      "Place eerie accent hues only near focal shapes.",
      "Use harder edge shadows for tension.",
      "Keep bright highlights sparse and directional.",
    ],
    "midnight" => [
      "Convert warm daytime areas into cooler night tones.",
      "Push sky/background values darker than midground.",
      "Add moonlight accents on top-facing edges.",
      "Soften distant elements to increase nocturnal depth.",
    ],
    "underwater" => [
      "Start with cool blue-green base layers.",
      "Fade distant elements by lowering contrast.",
      "Add directional light rays to suggest water depth.",
      "Use pale highlights sparingly on bubbles and reflective edges.",
    ],
    "spooky" => [
      "Start from a dim neutral base with low saturation.",
      "Introduce one eerie accent hue in key focal areas.",
      "Use uneven shadow edges for haunted atmosphere.",
      "Keep backgrounds subdued so the subject feels isolated.",
    ],
    "stained_glass" => [
      "Block separate color panels before any blending.",
      "Leave dark separators between major shapes.",
      "Increase saturation in center panels for luminosity.",
      "Use highlights as reflected light, not smooth gradients.",
    ],
    _ => [
      "Block large shapes with your dominant tones.",
      "Build depth using one lighter and one darker support color.",
      "Use your accent color only on focal areas.",
      "Finish with line cleanup and controlled highlights.",
    ],
  };
}

List<String> _embellishmentsFor(String presetId) {
  return switch (presetId) {
    "sticker_effect" => [
      "Keep halo width consistent for a cleaner cut-out look.",
      "If edges feel noisy, smooth with white pen before black contour.",
    ],
    "polaroid_frame" => [
      "Write a tiny date caption on the bottom frame for realism.",
      "Make outside grayscale slightly cooler to boost interior warmth.",
    ],
    "spotlight" => [
      "Use harder edges near the focal point, softer edges far away.",
      "Avoid bright accents in corners so focus stays centered.",
    ],
    "one_color" => [
      "Use texture shifts to separate materials when hue variety is limited.",
      "Keep one micro-accent at the brightest value for focal clarity.",
    ],
    "two_colors" => [
      "Let one hue occupy larger shapes and the second hue act as accent.",
      "If harmony breaks, add a low-saturation bridge tone in transitions.",
    ],
    "underwater" => [
      "Add bubble clusters of different sizes, denser near the light path.",
      "Paint tiny suspended particles for volume in the water.",
      "Curve light rays slightly for a natural underwater feel.",
    ],
    "midnight" => [
      "Keep highlights cool and sparse to avoid reintroducing daytime feel.",
      "Darken corners more than center to create natural nighttime framing.",
    ],
    "horror_halloween" => [
      "Add subtle color noise in shadows for unsettling texture.",
      "Use one sharp high-contrast edge to create visual tension.",
    ],
    "stained_glass" => [
      "Use thin black separators to mimic lead came lines.",
      "Keep each panel hue clean and avoid muddy mixes.",
    ],
    "white_effects" => [
      "Use white pen for sparkles on metal, eyes, and water reflections.",
      "Dot highlights in clusters, not evenly, for natural shine.",
    ],
    "black_effects" => [
      "Use black dots/stripes to add texture after color layers dry.",
      "Concentrate black details near focal areas for stronger emphasis.",
    ],
    "old_west" => [
      "Add subtle grain dots in empty regions for aged texture.",
      "Use broken edges on highlights to mimic worn print paper.",
    ],
    "fifty_fifty" => [
      "Mirror one small motif on both halves to tie the concept together.",
      "Keep one side slightly darker to avoid visual symmetry fatigue.",
    ],
    _ => [
      "Run a final pass to simplify accents and keep one clear focal area.",
      "Reserve your brightest highlight for the subject you want first attention on.",
    ],
  };
}
