import 'dart:math' as math;

import 'color_utils.dart';
import 'models.dart';
import 'palette_advisor.dart';

part 'ideas_catalog.dart';

/// The tabs of the Ideas page.
enum IdeaCategory {
  technique('Techniques'),
  colorChallenge('Colour challenges'),
  mood('Moods'),
  season('Seasons');

  const IdeaCategory(this.label);

  /// English label; the UI shows the localised one.
  final String label;
}

/// How hard an exercise is for someone who already owns a few markers.
enum IdeaDifficulty { easy, medium, hard }

/// Things an exercise needs besides the markers.
enum IdeaMaterial { paper, blender, whiteGel, pigmentLiner, pencil, tape }

/// The roles a marker can play in an idea's palette.
///
/// They are English identifiers, like every role the core engines write; the
/// UI localises them for display. A ladder (light → dark) always lists its
/// roles from the lightest to the darkest marker.
abstract final class IdeaRoles {
  static const String light = 'Light';
  static const String lightMid = 'Light mid';
  static const String base = 'Base';
  static const String shadow = 'Shadow';
  static const String deepShadow = 'Deep shadow';
  static const String shadowGray = 'Shadow grey';
  static const String accent = 'Accent';
  static const String background = 'Background';
  static const String mainColor = 'Main colour';
  static const String mainShadow = 'Main shadow';
  static const String secondColor = 'Second colour';
  static const String secondShadow = 'Second shadow';
  static const String thirdColor = 'Third colour';
  static const String blush = 'Blush';
  static const String warmLight = 'Warm light';
  static const String warmShadow = 'Warm shadow';
  static const String coolLight = 'Cool light';
  static const String coolShadow = 'Cool shadow';
  static const String colorShadow = 'Colour shadow';

  /// Every role, in display order.
  static const List<String> all = <String>[
    light,
    lightMid,
    base,
    shadow,
    deepShadow,
    shadowGray,
    accent,
    background,
    mainColor,
    mainShadow,
    secondColor,
    secondShadow,
    thirdColor,
    blush,
    warmLight,
    warmShadow,
    coolLight,
    coolShadow,
    colorShadow,
  ];

  /// The ladder roles, from the lightest marker to the darkest.
  static const List<String> ladderOrder = <String>[
    light,
    lightMid,
    base,
    shadow,
    deepShadow,
  ];

  /// The roles of a light → dark ladder of [count] markers.
  static List<String> ladder(int count) => switch (count) {
    <= 0 => const <String>[],
    1 => const <String>[base],
    2 => const <String>[light, shadow],
    3 => const <String>[light, base, shadow],
    4 => const <String>[light, base, shadow, deepShadow],
    _ => const <String>[light, lightMid, base, shadow, deepShadow],
  };

  /// Why a marker plays [role]: the English reason shown next to it.
  static String reasonFor(String role) => switch (role) {
    light => 'First layer, over almost everything',
    lightMid => 'Second step, softens the jump to the base',
    base => 'Main colour of the shapes',
    shadow => 'Where the light does not reach',
    deepShadow => 'Only the darkest corners and contact lines',
    shadowGray => 'Neutral shadows and cast shadows',
    accent => 'Small touches that draw the eye',
    background => 'Around the subject, laid last',
    mainColor => 'First colour of the pair',
    mainShadow => 'Shadow of the first colour',
    secondColor => 'Second colour of the scheme',
    secondShadow => 'Shadow of the second colour',
    thirdColor => 'Third colour of the scheme',
    blush => 'Cheeks, nose and ears, blended while wet',
    warmLight => 'Lit areas of the warm half',
    warmShadow => 'Shadows of the warm half',
    coolLight => 'Lit areas of the cool half',
    coolShadow => 'Shadows of the cool half',
    colorShadow => 'A coloured shadow to compare with the grey one',
    _ => role,
  };
}

/// One drawing exercise.
///
/// The texts (title, summary, steps…) live in the localisations, keyed by
/// [id]; [title] and [summary] are the English fallbacks. [stepRoles] has one
/// entry per step: the palette role the step uses, or `null`.
final class IdeaPreset {
  const IdeaPreset({
    required this.id,
    required this.title,
    required this.summary,
    required this.category,
    required this.difficulty,
    required this.minutes,
    required this.materials,
    required this.stepRoles,
  });

  final String id, title, summary;
  final IdeaCategory category;
  final IdeaDifficulty difficulty;
  final int minutes;
  final List<IdeaMaterial> materials;
  final List<String?> stepRoles;

  /// Whether the exercise comes with a palette picked from the collection.
  bool get hasPalette => _recipes.containsKey(id);
}

/// An exercise with the markers picked for it from the user's collection.
final class IdeaPlan {
  IdeaPlan({
    required this.preset,
    required List<PaletteSuggestion> palette,
    required this.wanted,
    required this.seed,
  }) : palette = List.unmodifiable(palette);

  final IdeaPreset preset;

  /// The markers, each with its role ([PaletteSuggestion.role]) and reason.
  final List<PaletteSuggestion> palette;

  /// How many markers the exercise asks for (0 when it has no palette).
  final int wanted;

  /// The seed the markers were picked with; another seed picks other markers.
  final int seed;

  /// Markers the collection could not provide.
  int get missing => math.max(0, wanted - palette.length);

  /// The marker that plays [role], if any.
  PaletteSuggestion? markerFor(String? role) {
    if (role == null) return null;
    for (final PaletteSuggestion s in palette) {
      if (s.role == role) return s;
    }
    return null;
  }
}

abstract final class IdeasEngine {
  static final List<IdeaPreset> presets = List.unmodifiable(_ideaPresets);

  /// The preset with [id], if any.
  static IdeaPreset? byId(String id) {
    for (final IdeaPreset p in presets) {
      if (p.id == id) return p;
    }
    return null;
  }

  /// The "idea of the day": a different preset every day, the same all day.
  static IdeaPreset featuredFor(DateTime day) {
    final int days = DateTime.utc(
      day.year,
      day.month,
      day.day,
    ).difference(DateTime.utc(2024)).inDays;
    return presets[days % presets.length];
  }

  /// Picks the markers of [preset] from [candidates].
  ///
  /// The same [seed] always gives the same markers; another seed gives other
  /// markers where the collection has alternatives ("Other markers").
  static IdeaPlan generatePlan(
    IdeaPreset preset,
    List<MarkerColor> candidates, {
    int seed = 0,
  }) {
    final _Recipe? recipe = _recipes[preset.id];
    if (recipe == null) {
      return IdeaPlan(preset: preset, palette: const [], wanted: 0, seed: seed);
    }
    final _Picker picker = _Picker(candidates, seed);
    final List<PaletteSuggestion> palette = _orderLadder(recipe.build(picker));
    return IdeaPlan(
      preset: preset,
      palette: palette,
      wanted: recipe.size,
      seed: seed,
    );
  }
}

/// Makes the ladder roles (light, light mid, base, shadow, deep shadow) follow
/// the real lightness of their markers: with a small collection a slot can
/// fall back to a marker darker than the next one, so the markers that play
/// ladder roles are sorted from light to dark and the roles dealt again in
/// order. Other roles (accent, background, second color…) stay as picked.
List<PaletteSuggestion> _orderLadder(List<PaletteSuggestion> palette) {
  final List<int> slots = <int>[
    for (var i = 0; i < palette.length; i++)
      if (IdeaRoles.ladderOrder.contains(palette[i].role)) i,
  ];
  if (slots.length < 2) return palette;
  final List<String> roles = <String>[for (final i in slots) palette[i].role!]
    ..sort(
      (a, b) =>
          IdeaRoles.ladderOrder.indexOf(a) - IdeaRoles.ladderOrder.indexOf(b),
    );
  final List<MarkerColor> colors = <MarkerColor>[
    for (final i in slots) palette[i].color,
  ]..sort((a, b) => ideaLightness(b.hex).compareTo(ideaLightness(a.hex)));
  final List<PaletteSuggestion> result = List<PaletteSuggestion>.of(palette);
  for (var k = 0; k < slots.length; k++) {
    result[slots[k]] = PaletteSuggestion(
      color: colors[k],
      reason: IdeaRoles.reasonFor(roles[k]),
      role: roles[k],
    );
  }
  return result;
}

/// CIELAB lightness (0 black … 100 white) of [hex].
double ideaLightness(String hex) => hexToLab(hex).l;

// ---------------------------------------------------------------------------
// Palette recipes
// ---------------------------------------------------------------------------

final class _Recipe {
  const _Recipe(this.size, this.build);

  /// Markers the recipe asks for.
  final int size;
  final List<PaletteSuggestion> Function(_Picker p) build;
}

// LCh hue angles (CIELAB): red ~30, orange ~60, yellow ~95, green ~135,
// teal ~200, blue ~260, violet ~300, pink ~350.
const double _red = 32;
const double _orange = 58;
const double _yellow = 95;
const double _green = 138;
const double _teal = 205;
const double _blue = 262;
const double _violet = 305;
const double _pink = 352;

final Map<String, _Recipe> _recipes = <String, _Recipe>{
  'smooth_fill': _Recipe(
    2,
    (p) =>
        p.ladder(p.family(minL: 45), const [IdeaRoles.light, IdeaRoles.base]),
  ),
  'three_marker_blend': _Recipe(3, (p) => p.ladder(p.family(), null, 3)),
  'flicking': _Recipe(
    3,
    (p) => p.ladder(p.family(hue: _orange, width: 30, minC: 10), null, 3),
  ),
  'grayscale': _Recipe(5, (p) => p.ladder(p.grays(), null, 5)),
  'sticker_effect': _Recipe(5, (p) {
    final _Family subject = p.family();
    return <PaletteSuggestion>[
      ...p.ladder(subject, null, 3),
      ?p.one(
        IdeaRoles.background,
        hue: (subject.hue + 180) % 360,
        width: 70,
        minC: 15,
        minL: 45,
        maxL: 85,
      ),
      ?p.gray(IdeaRoles.shadowGray, minL: 55, maxL: 80),
    ];
  }),
  'glossy_cherries': _Recipe(5, (p) {
    return <PaletteSuggestion>[
      ...p.ladder(p.family(hue: _red, width: 20, minC: 25, want: 4), null, 4),
      ?p.gray(IdeaRoles.shadowGray, minL: 50, maxL: 78),
    ];
  }),
  'colored_shadows': _Recipe(
    3,
    (p) => <PaletteSuggestion>[
      ?p.one(IdeaRoles.base, hue: _yellow, width: 30, minC: 25, minL: 70),
      ?p.gray(IdeaRoles.shadowGray, minL: 50, maxL: 72),
      ?p.one(
        IdeaRoles.colorShadow,
        hue: _violet,
        width: 35,
        minC: 12,
        minL: 45,
        maxL: 75,
      ),
    ],
  ),
  'stained_glass': _Recipe(
    4,
    (p) => <PaletteSuggestion>[
      ?p.one(IdeaRoles.mainColor, hue: _blue, width: 35, minC: 30, minL: 35),
      ?p.one(IdeaRoles.secondColor, hue: _red, width: 30, minC: 35, minL: 35),
      ?p.one(IdeaRoles.thirdColor, hue: _yellow, width: 30, minC: 30, minL: 65),
      ?p.one(IdeaRoles.accent, hue: _green, width: 35, minC: 25, minL: 35),
    ],
  ),
  'one_color': _Recipe(4, (p) => p.ladder(p.family(want: 4), null, 4)),
  'two_markers': _Recipe(
    2,
    (p) => p.ladder(p.family(), const [IdeaRoles.light, IdeaRoles.shadow]),
  ),
  'two_colors': _Recipe(5, (p) {
    final _Family first = p.family(want: 2, minL: 30, maxL: 85);
    return <PaletteSuggestion>[
      ...p.ladder(first, const [IdeaRoles.mainColor, IdeaRoles.mainShadow]),
      ...p.ladder(
        p.family(
          hue: (first.hue + 180) % 360,
          width: 45,
          minL: 30,
          maxL: 85,
          want: 2,
        ),
        const [IdeaRoles.secondColor, IdeaRoles.secondShadow],
      ),
      ?p.gray(IdeaRoles.shadowGray, minL: 45, maxL: 72),
    ];
  }),
  'fifty_fifty': _Recipe(
    5,
    (p) => <PaletteSuggestion>[
      ...p.ladder(p.family(hue: 50, width: 35, minC: 20, want: 2), const [
        IdeaRoles.warmLight,
        IdeaRoles.warmShadow,
      ]),
      ...p.ladder(p.family(hue: 235, width: 40, minC: 15, want: 2), const [
        IdeaRoles.coolLight,
        IdeaRoles.coolShadow,
      ]),
      ?p.gray(IdeaRoles.shadowGray, minL: 40, maxL: 70),
    ],
  ),
  'random_colors': _Recipe(5, (p) => p.random(5)),
  'unlikely_colors': _Recipe(4, (p) {
    const List<double> unusual = <double>[_violet, _teal, _blue, _pink];
    final _Family family = p.family(
      hue: unusual[p.seed.abs() % unusual.length],
      width: 35,
    );
    return <PaletteSuggestion>[
      ...p.ladder(family, null, 3),
      ?p.one(
        IdeaRoles.accent,
        hue: (family.hue + 180) % 360,
        width: 50,
        minC: 30,
        minL: 40,
      ),
    ];
  }),
  'pastel': _Recipe(4, (p) {
    final PaletteSuggestion? light = p.one(
      IdeaRoles.light,
      minC: 8,
      maxC: 45,
      minL: 82,
      seeded: true,
    );
    final double hue = light == null ? _pink : _hueOf(light.color.hex);
    return <PaletteSuggestion>[
      ?light,
      ?p.one(
        IdeaRoles.shadow,
        hue: hue,
        width: 25,
        minC: 10,
        minL: 60,
        maxL: 81,
      ),
      ?p.one(
        IdeaRoles.secondColor,
        hue: (hue + 120) % 360,
        width: 50,
        minC: 6,
        maxC: 45,
        minL: 80,
      ),
      ?p.one(
        IdeaRoles.thirdColor,
        hue: (hue + 240) % 360,
        width: 50,
        minC: 6,
        maxC: 45,
        minL: 80,
      ),
    ];
  }),
  'skin_tones': _Recipe(
    4,
    (p) => <PaletteSuggestion>[
      ...p.ladder(
        p.family(hue: 62, width: 22, minC: 8, maxC: 40, minL: 45),
        null,
        3,
      ),
      ?p.one(
        IdeaRoles.blush,
        hue: 22,
        width: 25,
        minC: 15,
        maxC: 50,
        minL: 60,
        maxL: 88,
      ),
    ],
  ),
  'midnight': _Recipe(
    5,
    (p) => <PaletteSuggestion>[
      ...p.ladder(p.family(hue: _blue, width: 30, minC: 10, want: 4), null, 4),
      ?p.one(IdeaRoles.accent, hue: _yellow, width: 30, minC: 30, minL: 75),
    ],
  ),
  'underwater': _Recipe(
    5,
    (p) => <PaletteSuggestion>[
      ...p.ladder(p.family(hue: _teal, width: 35, minC: 10, want: 4), null, 4),
      ?p.one(IdeaRoles.accent, hue: 45, width: 25, minC: 30, minL: 50),
    ],
  ),
  'galaxy': _Recipe(
    5,
    (p) => <PaletteSuggestion>[
      ?p.one(IdeaRoles.light, hue: 345, width: 30, minC: 20, minL: 62),
      ?p.one(IdeaRoles.secondColor, hue: 225, width: 30, minC: 15, minL: 62),
      ?p.one(IdeaRoles.base, hue: _violet, width: 30, minC: 20, maxL: 60),
      ?p.one(IdeaRoles.shadow, hue: 280, width: 40, minC: 10, maxL: 42),
      ?p.one(IdeaRoles.deepShadow, maxL: 25),
    ],
  ),
  'neon': _Recipe(5, (p) {
    final PaletteSuggestion? vivid = p.one(
      IdeaRoles.base,
      minC: 50,
      minL: 50,
      maxL: 85,
      fluorescent: true,
      seeded: true,
    );
    final double hue = vivid == null ? _pink : _hueOf(vivid.color.hex);
    final double lightness = vivid == null
        ? 60
        : ideaLightness(vivid.color.hex);
    return <PaletteSuggestion>[
      ?p.one(
        IdeaRoles.light,
        hue: hue,
        width: 25,
        minC: 10,
        minL: math.min(95, lightness + 8),
      ),
      ?vivid,
      ?p.one(
        IdeaRoles.secondColor,
        minC: 45,
        minL: 45,
        awayFrom: hue,
        fluorescent: true,
        seeded: true,
      ),
      ?p.one(IdeaRoles.shadow, minL: 18, maxL: 40),
      ?p.one(IdeaRoles.deepShadow, maxL: 20),
    ];
  }),
  'sepia_photo': _Recipe(
    5,
    (p) => <PaletteSuggestion>[
      ...p.ladder(
        p.family(hue: 65, width: 25, minC: 10, maxC: 55, want: 4),
        null,
        4,
      ),
      ?p.gray(IdeaRoles.shadowGray, minL: 50, maxL: 78, tint: _GrayTint.warm),
    ],
  ),
  'sunset': _Recipe(
    5,
    (p) => <PaletteSuggestion>[
      ?p.one(IdeaRoles.light, hue: _yellow, width: 25, minC: 30, minL: 75),
      ?p.one(
        IdeaRoles.lightMid,
        hue: _orange,
        width: 20,
        minC: 30,
        minL: 58,
        maxL: 82,
      ),
      ?p.one(IdeaRoles.base, hue: 15, width: 25, minC: 25, minL: 45, maxL: 72),
      ?p.one(
        IdeaRoles.shadow,
        hue: _violet,
        width: 35,
        minC: 15,
        minL: 25,
        maxL: 55,
      ),
      ?p.one(IdeaRoles.deepShadow, hue: 285, width: 60, maxL: 28),
    ],
  ),
  'spring': _Recipe(
    5,
    (p) => <PaletteSuggestion>[
      ...p.ladder(p.family(hue: 0, width: 25, minC: 12), null, 3),
      ...p.ladder(p.family(hue: _green, width: 30, minC: 15, want: 2), const [
        IdeaRoles.secondColor,
        IdeaRoles.secondShadow,
      ]),
    ],
  ),
  'autumn': _Recipe(
    5,
    (p) => <PaletteSuggestion>[
      ...p.ladder(p.family(hue: _orange, width: 22, minC: 25), null, 3),
      ?p.one(
        IdeaRoles.secondColor,
        hue: _red,
        width: 20,
        minC: 35,
        minL: 30,
        maxL: 58,
      ),
      ?p.one(IdeaRoles.accent, hue: _yellow, width: 25, minC: 35, minL: 72),
    ],
  ),
  'winter': _Recipe(
    5,
    (p) => <PaletteSuggestion>[
      ...p.ladder(
        p.family(hue: 255, width: 40, minC: 3, maxC: 28, minL: 45),
        null,
        2,
      ),
      ?p.one(IdeaRoles.deepShadow, hue: 260, width: 60, maxL: 35),
      ?p.one(IdeaRoles.accent, hue: 88, width: 25, minC: 30, minL: 72),
      ?p.one(
        IdeaRoles.secondColor,
        hue: 60,
        width: 25,
        minC: 12,
        minL: 25,
        maxL: 55,
      ),
    ],
  ),
  'christmas': _Recipe(
    5,
    (p) => <PaletteSuggestion>[
      ...p.ladder(p.family(hue: _red, width: 20, minC: 30), null, 3),
      ...p.ladder(p.family(hue: 150, width: 30, minC: 15, want: 2), const [
        IdeaRoles.secondColor,
        IdeaRoles.secondShadow,
      ]),
    ],
  ),
  'halloween': _Recipe(
    5,
    (p) => <PaletteSuggestion>[
      ...p.ladder(p.family(hue: _orange, width: 20, minC: 35), null, 3),
      ?p.one(IdeaRoles.accent, hue: 128, width: 30, minC: 25, minL: 30),
      ?p.one(IdeaRoles.background, hue: _violet, width: 40, minC: 10, maxL: 40),
    ],
  ),
};

// ---------------------------------------------------------------------------
// Picker
// ---------------------------------------------------------------------------

double _hueOf(String hex) {
  final LabColor lab = hexToLab(hex);
  final double h = math.atan2(lab.b, lab.a) * 180 / math.pi;
  return h < 0 ? h + 360 : h;
}

enum _GrayTint { warm, cool, neutral }

final RegExp _letters = RegExp(r'^[A-Za-z]+');
final RegExp _fluorescent = RegExp(r'fluor|neon', caseSensitive: false);

/// A marker with its CIELAB lightness, chroma and hue.
final class _Swatch {
  _Swatch(this.color)
    : prefix = _letters.stringMatch(color.newCode)?.toUpperCase() ?? '',
      fluo = _fluorescent.hasMatch(color.newName) {
    final LabColor lab = hexToLab(color.hex);
    l = lab.l;
    c = math.sqrt(lab.a * lab.a + lab.b * lab.b);
    final double angle = math.atan2(lab.b, lab.a) * 180 / math.pi;
    h = angle < 0 ? angle + 360 : angle;
  }

  final MarkerColor color;

  /// Letters of the code (`YR` of YR57, `CG` of CG4): the brand's family.
  final String prefix;

  /// Fluorescent markers sit apart: they are see-through and only fit ideas
  /// that ask for them (neon).
  final bool fluo;
  late final double l, c, h;
  String get key => color.colorId;

  _GrayTint get tint {
    if (c < 2) return _GrayTint.neutral;
    if (h >= 20 && h <= 130) return _GrayTint.warm;
    if (h >= 170 && h <= 300) return _GrayTint.cool;
    return _GrayTint.neutral;
  }
}

/// The members of one color family, and its centre hue.
final class _Family {
  const _Family(this.hue, this.members, {this.hasHue = true});
  final double hue;
  final List<_Swatch> members;

  /// Grays have no meaningful hue to stay close to.
  final bool hasHue;
}

/// Gray markers have almost no chroma.
const double _grayChroma = 9;

/// Target lightness of each step of a ladder of [count] markers: steps of
/// about 15 L*, close enough to blend, far enough to see.
List<double> _ladderTargets(int count) => switch (count) {
  <= 1 => const <double>[62],
  2 => const <double>[80, 42],
  3 => const <double>[82, 64, 45],
  4 => const <double>[86, 70, 54, 36],
  _ => const <double>[90, 76, 62, 47, 32],
};

/// Picks markers for one plan: never the same marker twice.
final class _Picker {
  _Picker(List<MarkerColor> candidates, this.seed)
    : _random = math.Random(seed),
      _pool = <_Swatch>[
        for (final MarkerColor color in candidates)
          if (!_isBlender(color)) _Swatch(color),
      ];

  final int seed;
  final math.Random _random;
  final List<_Swatch> _pool;
  final Set<String> _used = <String>{};

  static bool _isBlender(MarkerColor color) =>
      color.newCode == '0' ||
      color.newName.toLowerCase().contains('blender') ||
      color.oldName.toLowerCase().contains('blender');

  Iterable<_Swatch> get _free => _pool.where((s) => !_used.contains(s.key));

  /// Index into a ranked list of [length] alternatives: the best one for seed
  /// 0, one of the next best for other seeds.
  int _variant(int length, {int spread = 3}) {
    if (seed == 0 || length <= 1) return 0;
    return _random.nextInt(math.min(spread, length));
  }

  bool _fits(_Swatch s, double minC, double? maxC, double minL, double maxL) =>
      s.c >= minC &&
      (maxC == null || s.c <= maxC) &&
      s.l >= minL &&
      s.l <= maxL;

  /// How good [members] are as a ladder: enough markers, spread in lightness.
  static double _ladderScore(List<_Swatch> members, int want) {
    if (members.isEmpty) return 0;
    final List<double> ls = members.map((s) => s.l).toList();
    final double spread = ls.reduce(math.max) - ls.reduce(math.min);
    return math.min(members.length, want) * 40 + math.min(spread, 60);
  }

  /// [_ladderScore] minus how far the group strays from [center] on average.
  static double _groupScore(List<_Swatch> group, int want, double? center) {
    if (center == null) return _ladderScore(group, want);
    final double drift =
        group.map((s) => hueDistance(s.h, center)).reduce((a, b) => a + b) /
        group.length;
    return _ladderScore(group, want) - drift * 2;
  }

  /// The members of one code family (same letters, such as every `YR`) when
  /// one has enough markers; brands with plain numeric codes keep them all.
  List<_Swatch> _sameCodeFamily(
    List<_Swatch> members,
    int want, {
    double? center,
  }) {
    final Map<String, List<_Swatch>> byPrefix = <String, List<_Swatch>>{};
    for (final _Swatch s in members) {
      if (s.prefix.isEmpty) continue;
      byPrefix.putIfAbsent(s.prefix, () => <_Swatch>[]).add(s);
    }
    final List<List<_Swatch>> groups =
        byPrefix.values.where((g) => g.length >= want).toList()..sort(
          (a, b) => _groupScore(
            b,
            want,
            center,
          ).compareTo(_groupScore(a, want, center)),
        );
    if (groups.isEmpty) return members;
    return groups[_variant(groups.length, spread: 2)];
  }

  /// A family of markers around [hue] (or the richest family of the collection
  /// when [hue] is null), with chroma and lightness limits.
  _Family family({
    double? hue,
    double width = 22,
    double minC = 14,
    double? maxC,
    double minL = 0,
    double maxL = 100,
    int want = 3,
    bool fluorescent = false,
  }) {
    List<_Swatch> around(double center, double w) => <_Swatch>[
      for (final _Swatch s in _free)
        if ((fluorescent || !s.fluo) &&
            _fits(s, minC, maxC, minL, maxL) &&
            hueDistance(s.h, center) <= w)
          s,
    ];

    if (hue != null) {
      var members = around(hue, width);
      // Too few markers in the family: widen the search once.
      if (members.length < want) members = around(hue, width * 1.4);
      return _Family(hue, _sameCodeFamily(members, want, center: hue));
    }

    // No hue given: rank every 15° family by how many markers it has and how
    // far apart their lightness is, so the ladder is a real ladder.
    final List<(double, List<_Swatch>, double)> ranked =
        <(double, List<_Swatch>, double)>[];
    for (var center = 0.0; center < 360; center += 15) {
      final List<_Swatch> members = _sameCodeFamily(
        around(center, width),
        want,
        center: center,
      );
      if (members.isEmpty) continue;
      ranked.add((center, members, _ladderScore(members, want)));
    }
    if (ranked.isEmpty) return const _Family(0, <_Swatch>[]);
    ranked.sort((a, b) => b.$3.compareTo(a.$3));
    // Skip neighbouring bins of the same family so "other markers" really
    // changes the family.
    final List<(double, List<_Swatch>, double)> distinct =
        <(double, List<_Swatch>, double)>[];
    for (final entry in ranked) {
      if (distinct.every((d) => hueDistance(d.$1, entry.$1) > 40)) {
        distinct.add(entry);
      }
    }
    final pick = distinct[_variant(distinct.length, spread: 4)];
    return _Family(pick.$1, pick.$2);
  }

  /// Gray markers of one family (warm, cool or green grays never mix).
  _Family grays({double minL = 0, double maxL = 100, int want = 5}) {
    final List<_Swatch> all = <_Swatch>[
      for (final _Swatch s in _free)
        if (s.c <= _grayChroma && s.l >= minL && s.l <= maxL) s,
    ];
    if (all.isEmpty) return const _Family(0, <_Swatch>[], hasHue: false);
    final List<_Swatch> byCode = _sameCodeFamily(all, math.min(want, 4));
    if (!identical(byCode, all)) return _Family(0, byCode, hasHue: false);
    final Map<_GrayTint, List<_Swatch>> byTint = <_GrayTint, List<_Swatch>>{};
    for (final _Swatch s in all) {
      byTint.putIfAbsent(s.tint, () => <_Swatch>[]).add(s);
    }
    final List<List<_Swatch>> families = byTint.values.toList()
      ..sort((a, b) => _ladderScore(b, want).compareTo(_ladderScore(a, want)));
    return _Family(0, families[_variant(families.length)], hasHue: false);
  }

  /// Up to [count] members of [family] stepping from light to dark, labelled
  /// with [roles] (or the ladder roles of the count). The result is ordered
  /// by lightness, so the roles always follow the real light → dark order.
  List<PaletteSuggestion> ladder(
    _Family family,
    List<String>? roles, [
    int? count,
  ]) {
    final int wanted = roles?.length ?? count ?? 3;
    final List<_Swatch> sorted =
        family.members.where((s) => !_used.contains(s.key)).toList()
          ..sort((a, b) => b.l.compareTo(a.l));
    // Drop markers too close in lightness to tell apart.
    final List<_Swatch> distinct = <_Swatch>[];
    for (final _Swatch s in sorted) {
      if (distinct.isEmpty || (distinct.last.l - s.l).abs() >= 4) {
        distinct.add(s);
      }
    }
    final List<_Swatch> chosen = <_Swatch>[];
    if (distinct.length <= wanted) {
      chosen.addAll(distinct);
    } else {
      // Walk the targets from light to dark, each time taking the remaining
      // marker closest to the target (another seed nudges the targets).
      final List<double> targets = _ladderTargets(wanted);
      var from = 0;
      for (var i = 0; i < wanted; i++) {
        final double target =
            targets[i] + (seed == 0 ? 0 : _random.nextDouble() * 12 - 6);
        // Leave enough markers for the steps still to come.
        final int last = distinct.length - (wanted - i);
        // Lightness first, then staying close to the family hue.
        double cost(_Swatch s) =>
            (s.l - target).abs() +
            (family.hasHue ? hueDistance(s.h, family.hue) * 0.35 : 0);
        var best = from;
        for (var j = from; j <= last; j++) {
          if (cost(distinct[j]) < cost(distinct[best])) best = j;
        }
        chosen.add(distinct[best]);
        from = best + 1;
      }
    }
    final List<String> labels = roles == null
        ? IdeaRoles.ladder(chosen.length)
        : _rolesFor(roles, chosen.length);
    return <PaletteSuggestion>[
      for (var i = 0; i < chosen.length; i++) _take(chosen[i], labels[i]),
    ];
  }

  /// [roles] trimmed to [count]: keep the lightest and the darkest roles.
  List<String> _rolesFor(List<String> roles, int count) {
    if (count >= roles.length) return roles;
    if (count <= 1) return roles.take(count).toList();
    return <String>[...roles.take(count - 1), roles.last];
  }

  /// The best free marker for [role] within the limits, or null.
  PaletteSuggestion? one(
    String role, {
    double? hue,
    double width = 30,
    double minC = 0,
    double? maxC,
    double minL = 0,
    double maxL = 100,
    double? awayFrom,
    bool fluorescent = false,
    bool seeded = false,
  }) {
    double score(_Swatch s) {
      var value = 0.0;
      if (hue != null) {
        final double d = hueDistance(s.h, hue);
        value += d <= width ? d / width : 1 + (d - width) / 20;
      }
      if (s.c < minC) value += (minC - s.c) / 8;
      if (maxC != null && s.c > maxC) value += (s.c - maxC) / 8;
      if (s.l < minL) value += (minL - s.l) / 6;
      if (s.l > maxL) value += (s.l - maxL) / 6;
      if (awayFrom != null && hueDistance(s.h, awayFrom) < 60) value += 3;
      // Fluorescents only where the idea asks for them, and first there.
      if (s.fluo) value += fluorescent ? -0.6 : 1.5;
      // Without a hue, prefer stronger colors for colored roles.
      if (hue == null && minC > 0) value -= s.c / 400;
      return value;
    }

    final List<_Swatch> ranked = _free.toList()
      ..sort((a, b) => score(a).compareTo(score(b)));
    if (ranked.isEmpty) return null;
    // Only markers that really fit compete; else the closest one.
    final double best = score(ranked.first);
    final List<_Swatch> fitting = ranked
        .where((s) => score(s) <= math.max(best, 0) + (hue == null ? 0.05 : 1))
        .toList();
    final int index = _variant(fitting.length, spread: seeded ? 6 : 3);
    return _take(fitting[index], role);
  }

  /// A gray marker for [role] (of one [tint] when given).
  PaletteSuggestion? gray(
    String role, {
    double minL = 0,
    double maxL = 100,
    _GrayTint? tint,
  }) {
    final List<_Swatch> grays = _free
        .where((s) => s.c <= _grayChroma && (tint == null || s.tint == tint))
        .toList();
    if (grays.isEmpty) {
      return tint == null ? null : gray(role, minL: minL, maxL: maxL);
    }
    final double middle = (minL + maxL) / 2;
    double score(_Swatch s) =>
        (s.l < minL ? minL - s.l : 0) +
        (s.l > maxL ? s.l - maxL : 0) +
        (s.l - middle).abs() / 50;
    grays.sort((a, b) => score(a).compareTo(score(b)));
    final List<_Swatch> fitting = grays
        .where((s) => s.l >= minL && s.l <= maxL)
        .toList();
    final List<_Swatch> pool = fitting.isEmpty
        ? grays.take(1).toList()
        : fitting;
    return _take(pool[_variant(pool.length)], role);
  }

  /// [count] markers at random (a new draw for every seed), ordered and
  /// labelled from light to dark.
  List<PaletteSuggestion> random(int count) {
    final List<_Swatch> free = _free.toList()..shuffle(_random);
    final List<_Swatch> chosen = free.take(count).toList()
      ..sort((a, b) => b.l.compareTo(a.l));
    final List<String> roles = IdeaRoles.ladder(chosen.length);
    return <PaletteSuggestion>[
      for (var i = 0; i < chosen.length; i++) _take(chosen[i], roles[i]),
    ];
  }

  PaletteSuggestion _take(_Swatch swatch, String role) {
    _used.add(swatch.key);
    return PaletteSuggestion(
      color: swatch.color,
      reason: IdeaRoles.reasonFor(role),
      role: role,
    );
  }
}
