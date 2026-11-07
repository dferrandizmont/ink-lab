import 'dart:math' as math;

import 'color_utils.dart';
import 'models.dart';

/// Blending chains: three to five markers of one colour family that go from
/// light to dark in steps small enough to blend with alcohol ink.
///
/// Everything works in OKLab / OKLCh, where `L` (0 to 1) is perceived
/// lightness and `C` is chroma, so one threshold means the same thing for a
/// yellow and for a navy. The thresholds are in [BlendingRules]; they were
/// tuned on the Ohuhu, DecoTime, Copic and Finecolour catalogues (see the tests).

/// The thresholds behind the chain search. Lightness steps are OKLab `L`
/// differences.
abstract final class BlendingRules {
  /// A base or a candidate with a chroma under this is a neutral (grey,
  /// black, white-ish). Neutrals chain with neutrals, whatever their hue.
  static const double neutralChroma = 0.03;

  /// Hue window (degrees) around the base for a clearly coloured pair of
  /// markers (chroma at or above [richChroma]).
  static const double narrowHue = 24;

  /// Hue window for a pair whose less coloured marker sits at
  /// [neutralChroma]; between the two chromas the window widens in a line.
  static const double wideHue = 50;

  /// Chroma from which the hue window is [narrowHue].
  static const double richChroma = 0.10;

  /// Under this chroma a marker has no hue worth comparing (a true grey): the
  /// hue check is skipped.
  static const double hueNoiseChroma = 0.008;

  /// A coloured base only takes candidates with at least this share of its
  /// chroma (but never asks for more than [paleChroma]), so a pale tint can
  /// start the chain and a grey cannot.
  static const double chromaShare = 0.25;

  /// The most chroma a pale tint of a coloured base needs.
  static const double paleChroma = 0.02;

  /// Smallest lightness step between neighbours: under it two markers look
  /// the same and the chain wastes a marker.
  static const double minStep = 0.04;

  /// Largest lightness step between neighbours: over it the join shows even
  /// when blended.
  static const double maxStep = 0.16;

  /// The step the search aims for.
  static const double idealStep = 0.09;

  /// Largest chroma difference between neighbours.
  static const double maxChromaStep = 0.09;

  /// The longest step may be at most this many times the shortest one.
  static const double maxStepRatio = 2.6;

  /// Fewest markers (base included) that count as a chain.
  static const int minLength = 3;

  /// Most markers (base included) of a chain.
  static const int maxLength = 5;

  /// Above this lightness a base is not asked for a lighter marker.
  static const double lightestBase = 0.95;

  /// Under this lightness a base is not asked for a darker marker.
  static const double darkestBase = 0.12;

  /// How many alternatives are offered besides the best chain.
  static const int maxAlternatives = 2;

  /// A chain that costs more than this is a stretch (uneven steps, a drifting
  /// hue) and is not offered: a shorter chain, or none, is more honest.
  static const double maxCost = 1.4;

  /// An alternative may cost at most this much more than the best chain.
  static const double alternativeSlack = 0.4;
}

/// One blending chain: markers from the lightest to the darkest.
final class BlendingChain {
  /// Builds a chain from [colors], already ordered light to dark, that
  /// includes [base].
  BlendingChain({
    required List<MarkerColor> colors,
    required MarkerColor base,
    this.cost = 0,
  }) : colors = List.unmodifiable(colors),
       baseIndex = math.max(
         0,
         colors.indexWhere((MarkerColor c) => c.colorId == base.colorId),
       ),
       steps = List.unmodifiable(_lightnessSteps(colors));

  /// The markers, lightest first.
  final List<MarkerColor> colors;

  /// Where the base sits in [colors].
  final int baseIndex;

  /// Lightness difference between each marker and the next one darker
  /// (`colors.length - 1` positive numbers).
  final List<double> steps;

  /// The search cost: lower is better (0 for a chain not built by the search).
  final double cost;

  /// The base marker.
  MarkerColor get base => colors[baseIndex];

  /// Whether no marker in the chain is lighter than the base.
  bool get baseIsLightest => baseIndex == 0;

  /// Whether no marker in the chain is darker than the base.
  bool get baseIsDarkest => baseIndex == colors.length - 1;

  /// The largest lightness step.
  double get maxStep => steps.isEmpty ? 0 : steps.reduce(math.max);

  /// The markers other than the base, in chain order.
  List<MarkerColor> get companions => <MarkerColor>[
    for (int i = 0; i < colors.length; i++)
      if (i != baseIndex) colors[i],
  ];

  static List<double> _lightnessSteps(List<MarkerColor> colors) {
    final List<double> lightness = <double>[
      for (final MarkerColor c in colors) hexToOklab(c.hex).l,
    ];
    return <double>[
      for (int i = 0; i + 1 < lightness.length; i++)
        lightness[i] - lightness[i + 1],
    ];
  }
}

/// The role of each marker of [chain], lightest first, as English
/// identifiers (localised when drawn): `Lightest`, `Lighter`, `Base`,
/// `Darker`, `Darkest`.
List<String> blendingChainRoles(BlendingChain chain) {
  final int last = chain.colors.length - 1;
  return <String>[
    for (int i = 0; i <= last; i++)
      if (i == chain.baseIndex)
        BlendingRoles.base
      else if (i == 0)
        BlendingRoles.lightest
      else if (i == last)
        BlendingRoles.darkest
      else if (i < chain.baseIndex)
        BlendingRoles.lighter
      else
        BlendingRoles.darker,
  ];
}

/// The English role identifiers of [blendingChainRoles].
abstract final class BlendingRoles {
  static const String lightest = 'Lightest';
  static const String lighter = 'Lighter';
  static const String base = 'Base';
  static const String darker = 'Darker';
  static const String darkest = 'Darkest';
}

/// What is missing around a base when no chain can be built.
enum BlendingGap {
  /// Nothing is missing: there is a chain.
  none,

  /// A lighter marker of the family is needed.
  lighter,

  /// A darker marker of the family is needed.
  darker,

  /// Both a lighter and a darker marker are needed.
  both,
}

/// The answer of [buildBlendingChains].
final class BlendingChainResult {
  BlendingChainResult({
    required this.base,
    required this.requested,
    required List<BlendingChain> chains,
    required this.gap,
    required this.lighterAvailable,
    required this.darkerAvailable,
  }) : chains = List.unmodifiable(chains);

  /// The base marker the chains were built around.
  final MarkerColor base;

  /// The length asked for (base included).
  final int requested;

  /// The best chain first, then the alternatives. Empty when there is none.
  final List<BlendingChain> chains;

  /// What the family lacks when [chains] is empty.
  final BlendingGap gap;

  /// Whether the family has a marker that can sit right before the base
  /// (lighter) or right after it (darker) in a chain.
  final bool lighterAvailable, darkerAvailable;

  /// The best chain, or `null`.
  BlendingChain? get best => chains.isEmpty ? null : chains.first;

  /// Whether there is a chain, but shorter than the one asked for.
  bool get isShort => best != null && best!.colors.length < requested;
}

/// Builds the blending chains around [base] from [candidates].
///
/// [length] is the number of markers wanted, base included (3 to 5). The best
/// chain has exactly that many markers when the family allows it, otherwise
/// the longest one that does (never fewer than [BlendingRules.minLength]); if
/// there is none the result has no chains and says what is missing.
///
/// The rules, in OKLab / OKLCh:
///  * Family. A candidate is in the base's family when its hue is within a
///    window of the base's hue that widens as chroma falls (from
///    [BlendingRules.narrowHue] to [BlendingRules.wideHue]); pale tints whose
///    hue is noise skip the check. A neutral base (chroma under
///    [BlendingRules.neutralChroma]) only takes neutrals.
///  * Steps. Neighbours differ in lightness by [BlendingRules.minStep] to
///    [BlendingRules.maxStep], in chroma by at most
///    [BlendingRules.maxChromaStep], and in hue within the window.
///  * Choice. Among the chains that follow the rules, the one with the most
///    even steps close to [BlendingRules.idealStep] wins; a base in the
///    middle (light, base, dark) is preferred, not forced. The longest step
///    may be at most [BlendingRules.maxStepRatio] times the shortest.
///
/// The colourless blender is never part of a chain.
BlendingChainResult buildBlendingChains(
  MarkerColor base,
  List<MarkerColor> candidates, {
  int length = 4,
}) {
  final int wanted = length.clamp(
    BlendingRules.minLength,
    BlendingRules.maxLength,
  );
  final _Node baseNode = _Node(base);
  final List<_Node> pool = <_Node>[
    for (final MarkerColor c in candidates)
      if (c.colorId != base.colorId &&
          !isColourlessBlender(c) &&
          _inFamily(baseNode, _Node(c)))
        _Node(c),
  ];
  // Direct neighbours of the base on each side, to say what is missing.
  final bool lighterAvailable = pool.any(
    (_Node n) => n.l > baseNode.l && _canFollow(n, baseNode),
  );
  final bool darkerAvailable = pool.any(
    (_Node n) => n.l < baseNode.l && _canFollow(baseNode, n),
  );
  // Paths outward from the base, each a list of nodes going away from it.
  final List<List<_Node>> lighterPaths = _paths(baseNode, pool, lighter: true);
  final List<List<_Node>> darkerPaths = _paths(baseNode, pool, lighter: false);

  List<BlendingChain> chains = const <BlendingChain>[];
  for (int n = wanted; n >= BlendingRules.minLength; n--) {
    chains = _chainsOfLength(baseNode, n, lighterPaths, darkerPaths);
    if (chains.isNotEmpty) break;
  }
  // A marker at the very end of the lightness scale (black) cannot be asked
  // for a darker one, nor a near-white one for a lighter one.
  final bool needLighter =
      !lighterAvailable && baseNode.l < BlendingRules.lightestBase;
  final bool needDarker =
      !darkerAvailable && baseNode.l > BlendingRules.darkestBase;
  final BlendingGap gap = chains.isNotEmpty
      ? BlendingGap.none
      : needLighter && needDarker
      ? BlendingGap.both
      : needLighter
      ? BlendingGap.lighter
      : needDarker
      ? BlendingGap.darker
      // One neighbour each side always makes a chain of three, so only a
      // base at an end of the scale gets here: it lacks the other side.
      : baseNode.l <= BlendingRules.darkestBase
      ? BlendingGap.lighter
      : BlendingGap.darker;
  return BlendingChainResult(
    base: base,
    requested: wanted,
    chains: chains,
    gap: gap,
    lighterAvailable: lighterAvailable,
    darkerAvailable: darkerAvailable,
  );
}

/// Whether [color] is the colourless blender (it has no colour of its own and
/// never belongs in a chain).
bool isColourlessBlender(MarkerColor color) =>
    color.newCode == '0' ||
    color.newName.toLowerCase().contains('blender') ||
    color.oldName.toLowerCase().contains('blender');

/// A marker with its OKLCh coordinates.
final class _Node {
  _Node(this.color) : _lab = hexToOklab(color.hex);

  final MarkerColor color;
  final OklabColor _lab;

  double get l => _lab.l;
  double get c => math.sqrt(_lab.a * _lab.a + _lab.b * _lab.b);
  double get h => (math.atan2(_lab.b, _lab.a) * 180 / math.pi + 360) % 360;
  bool get neutral => c < BlendingRules.neutralChroma;
}

/// The hue window (degrees) for a pair whose less coloured member has chroma
/// [chroma]; 360 (any hue) under the neutral line.
double _hueWindow(double chroma) {
  if (chroma >= BlendingRules.richChroma) return BlendingRules.narrowHue;
  if (chroma <= BlendingRules.neutralChroma) return BlendingRules.wideHue;
  final double t =
      (BlendingRules.richChroma - chroma) /
      (BlendingRules.richChroma - BlendingRules.neutralChroma);
  return BlendingRules.narrowHue +
      t * (BlendingRules.wideHue - BlendingRules.narrowHue);
}

/// Whether [other] is in the family of [base] (not yet a valid step).
bool _inFamily(_Node base, _Node other) {
  if (base.neutral) return other.neutral && _hueOk(base, other);
  final double floor = math.min(
    base.c * BlendingRules.chromaShare,
    BlendingRules.paleChroma,
  );
  return other.c >= floor && _hueOk(base, other);
}

bool _hueOk(_Node a, _Node b) {
  final double chroma = math.min(a.c, b.c);
  if (chroma < BlendingRules.hueNoiseChroma) return true;
  return hueDistance(a.h, b.h) <= _hueWindow(chroma);
}

/// Whether [other] is in the colour family of [base]: the same hue, within
/// the window the blending chains use (see [BlendingRules]), or a neutral
/// next to a neutral.
///
/// The question is asked from [base], so it is not symmetric: a pale tint is
/// in the family of a saturated colour of its hue, but a grey is not.
bool inSameHueFamily(MarkerColor base, MarkerColor other) =>
    _inFamily(_Node(base), _Node(other));

/// Whether [dark] can sit right after [light] (the lighter one) in a chain.
bool _canFollow(_Node light, _Node dark) {
  final double step = light.l - dark.l;
  if (step < BlendingRules.minStep || step > BlendingRules.maxStep) {
    return false;
  }
  if ((light.c - dark.c).abs() > BlendingRules.maxChromaStep) return false;
  return _hueOk(light, dark);
}

/// How many options each step of a path may branch into; the ones whose step
/// is closest to the ideal go first.
const int _branching = 6;

/// Every path of up to four markers going away from [from] ([lighter] or
/// darker), including the empty one.
List<List<_Node>> _paths(
  _Node from,
  List<_Node> pool, {
  required bool lighter,
}) {
  final List<List<_Node>> out = <List<_Node>>[<_Node>[]];
  void walk(List<_Node> path, _Node last) {
    if (path.length >= BlendingRules.maxLength - 1) return;
    final List<_Node> next = <_Node>[
      for (final _Node n in pool)
        if (!path.contains(n) &&
            (lighter ? _canFollow(n, last) : _canFollow(last, n)))
          n,
    ];
    next.sort((_Node a, _Node b) {
      final double da = ((a.l - last.l).abs() - BlendingRules.idealStep).abs();
      final double db = ((b.l - last.l).abs() - BlendingRules.idealStep).abs();
      final int byStep = da.compareTo(db);
      return byStep != 0 ? byStep : a.color.colorId.compareTo(b.color.colorId);
    });
    for (final _Node n in next.take(_branching)) {
      final List<_Node> extended = <_Node>[...path, n];
      out.add(extended);
      walk(extended, n);
    }
  }

  walk(<_Node>[], from);
  return out;
}

/// The valid chains of exactly [n] markers, best first, then the alternatives.
List<BlendingChain> _chainsOfLength(
  _Node base,
  int n,
  List<List<_Node>> lighterPaths,
  List<List<_Node>> darkerPaths,
) {
  final List<({List<_Node> nodes, double cost})> found =
      <({List<_Node> nodes, double cost})>[];
  for (final List<_Node> up in lighterPaths) {
    final int need = n - 1 - up.length;
    if (need < 0) continue;
    for (final List<_Node> down in darkerPaths) {
      if (down.length != need) continue;
      // Lightest first: the far end of the lighter path down to the darkest.
      final List<_Node> nodes = <_Node>[...up.reversed, base, ...down];
      final double? cost = _chainCost(nodes, up.length, base);
      if (cost != null && cost <= BlendingRules.maxCost) {
        found.add((nodes: nodes, cost: cost));
      }
    }
  }
  if (found.isEmpty) return const <BlendingChain>[];
  String signature(List<_Node> nodes) =>
      nodes.map((_Node x) => x.color.colorId).join(' ');
  found.sort((a, b) {
    final int byCost = a.cost.compareTo(b.cost);
    return byCost != 0
        ? byCost
        : signature(a.nodes).compareTo(signature(b.nodes));
  });
  final List<({List<_Node> nodes, double cost})> picked =
      <({List<_Node> nodes, double cost})>[found.first];
  // Alternatives must differ from every chain already offered by at least
  // two markers (one when the chain has only two companions).
  final int differ = n >= 4 ? 2 : 1;
  for (final item in found.skip(1)) {
    if (picked.length > BlendingRules.maxAlternatives) break;
    if (item.cost > found.first.cost + BlendingRules.alternativeSlack) break;
    final bool distinct = picked.every((p) {
      final Set<String> mine = <String>{
        for (final _Node x in p.nodes) x.color.colorId,
      };
      final int fresh = item.nodes
          .where((_Node x) => !mine.contains(x.color.colorId))
          .length;
      return fresh >= differ;
    });
    if (distinct) picked.add(item);
  }
  return <BlendingChain>[
    for (final item in picked)
      BlendingChain(
        colors: <MarkerColor>[for (final _Node x in item.nodes) x.color],
        base: base.color,
        cost: item.cost,
      ),
  ];
}

/// The cost of a chain (lower is better), or `null` when it breaks a rule.
double? _chainCost(List<_Node> nodes, int baseIndex, _Node base) {
  final List<double> steps = <double>[
    for (int i = 0; i + 1 < nodes.length; i++) nodes[i].l - nodes[i + 1].l,
  ];
  final double shortest = steps.reduce(math.min);
  final double longest = steps.reduce(math.max);
  if (longest > shortest * BlendingRules.maxStepRatio) return null;
  final double mean = steps.reduce((a, b) => a + b) / steps.length;
  var variance = 0.0;
  var distance = 0.0;
  for (final double s in steps) {
    variance += (s - mean) * (s - mean);
    final double off = (s - BlendingRules.idealStep) / BlendingRules.idealStep;
    distance += off * off;
  }
  final double evenness = math.sqrt(variance / steps.length) / mean;
  final double middle = (nodes.length - 1) / 2;
  var drift = 0.0;
  for (final _Node x in nodes) {
    if (base.neutral) break;
    final double chroma = math.min(base.c, x.c);
    if (chroma < BlendingRules.hueNoiseChroma) continue;
    drift += hueDistance(base.h, x.h) / _hueWindow(chroma);
  }
  return evenness * 2 +
      distance / steps.length +
      drift / nodes.length * 0.6 +
      (baseIndex - middle).abs() * 0.12;
}
