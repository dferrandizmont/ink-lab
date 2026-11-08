import 'color_utils.dart';
import 'match_quality.dart';
import 'model/marker_color.dart';

// Marker codes typed or pasted by a person ("E00, E21, R20", a bulleted list
// from a tutorial, one code per line...) and what the app does with them:
// look them up in a brand's catalogue and, for a recipe written for another
// brand, find the closest markers of the user's own.
//
// Nothing here knows about the screen: the parsing is plain text work and the
// translation is the same CIELAB76 distance (and the same `MatchQuality`
// bands) the rest of the app uses.

/// How a code is compared: upper case, without spaces or hyphens, so `c-3`,
/// `C 3` and `C3` are the same code.
String recipeCodeKey(String code) =>
    code.trim().toUpperCase().replaceAll(RegExp(r'[\s\-]'), '');

/// The markers of one brand by code, for looking up what a person typed.
///
/// A marker answers to its code and to its old code (Ohuhu's historical
/// ones); the current code wins when both spell the same.
final class CodeIndex {
  CodeIndex(Iterable<MarkerColor> markers) {
    final List<MarkerColor> list = markers.toList();
    for (final MarkerColor marker in list) {
      _byKey.putIfAbsent(recipeCodeKey(marker.newCode), () => marker);
    }
    for (final MarkerColor marker in list) {
      _byKey.putIfAbsent(recipeCodeKey(marker.oldCode), () => marker);
    }
  }

  final Map<String, MarkerColor> _byKey = <String, MarkerColor>{};

  /// The marker that [code] names, or `null`.
  MarkerColor? find(String code) => _byKey[recipeCodeKey(code)];

  /// Whether [code] names a marker.
  bool knows(String code) => find(code) != null;
}

/// The codes listed in [text], in the order written and without repeats.
///
/// Tolerant on purpose: codes can be separated by commas, semicolons, slashes,
/// plus signs, arrows, bullets, line breaks or just spaces; list markers
/// ("1.", "-", "•") and notes in brackets ("E00 (skin base)") are dropped.
/// A word that looks like a code but is not in the catalogue is kept, so it
/// can be reported as unknown; words without a digit ("then", "edges") are
/// ignored as prose. Junk that is clearly not prose and not a code either (a
/// very long token, a token with a digit and symbols such as `1'='1`, markup
/// such as `<script>`) is reported as unknown too, cut to [_clippedLength]
/// characters, instead of vanishing without a trace.
///
/// [knows] tells the parser which words are real codes. It matters for the
/// codes that hold a hyphen or a space (Copic's `C-3`): a word the catalogue
/// knows is never split.
List<String> parseCodeList(String text, {bool Function(String)? knows}) {
  bool known(String word) => knows != null && knows(word);
  final String cleaned = text
      .replaceAll(RegExp(r'\([^)]*\)|\[[^\]]*\]|\{[^}]*\}'), ' ')
      .replaceAll(RegExp(r'[–—−]'), '-')
      .replaceAll(RegExp(r'->|=>|-->|[→⇒➔➜➡]'), ',');
  final List<String> found = <String>[];
  final Set<String> seen = <String>{};
  void add(String word) {
    if (seen.add(recipeCodeKey(word))) found.add(word);
  }

  for (final String line in cleaned.split(RegExp(r'[\r\n]+'))) {
    final String body = line.replaceFirst(
      RegExp(r'^\s*(?:[-*•·▪●◦‣]|\d+[.)])\s+'),
      '',
    );
    for (final String segment in body.split(
      RegExp(r'[,;|\t•·▪●◦‣+&/]|\s-\s|\s\*\s|\s>\s'),
    )) {
      final String trimmed = segment.trim();
      if (trimmed.isEmpty) continue;
      if (known(trimmed)) {
        add(trimmed);
        continue;
      }
      for (final String raw in trimmed.split(RegExp(r'\s+'))) {
        final String word = raw.replaceAll(
          RegExp(r'^[^A-Za-z0-9]+|[^A-Za-z0-9]+$'),
          '',
        );
        if (word.isEmpty) continue;
        if (known(word)) {
          add(word);
          continue;
        }
        // "E00-E21-R20": a list written with hyphens.
        final List<String> parts = word.contains('-')
            ? word.split('-').where((String p) => p.isNotEmpty).toList()
            : const <String>[];
        if (parts.length > 1 &&
            parts.every((String p) => known(p) || _looksLikeCode(p))) {
          parts.forEach(add);
        } else if (_looksLikeCode(word)) {
          add(word);
        } else if (_looksLikeJunk(word)) {
          add(_clipped(word));
        }
      }
    }
  }
  return found;
}

/// A short word with a digit, made of letters, digits, dots and hyphens.
bool _looksLikeCode(String word) =>
    word.length <= _maxCodeLength &&
    RegExp(r'\d').hasMatch(word) &&
    RegExp(r'^[A-Za-z0-9.\-]+$').hasMatch(word);

/// The longest a code can be.
const int _maxCodeLength = 12;

/// A word longer than this is never prose.
const int _maxWordLength = 40;

/// How much of a junk word is kept to be shown.
const int _clippedLength = 24;

/// A word that is not a code and not plain prose either: far too long, or
/// with a digit but not shaped like a code, or with symbols no sentence or
/// code has (`<`, `>`, `=`, `$`, `{`, `}`, backslash, backtick, `%`, `@`).
bool _looksLikeJunk(String word) =>
    word.length > _maxWordLength ||
    // A digit plus something a code never holds; apostrophes, colons and quotes
    // are prose ("l'E00", "E00's", "2:1"), not junk.
    (RegExp(r'\d').hasMatch(word) &&
        !_looksLikeCode(word) &&
        RegExp(r'''[^A-Za-z0-9.\-'’‘:"“”]''').hasMatch(word)) ||
    RegExp(r'[<>=${}\\`%@^~]').hasMatch(word);

/// [word] cut to [_clippedLength] characters, with an ellipsis when cut.
String _clipped(String word) => word.length <= _clippedLength
    ? word
    : '${word.substring(0, _clippedLength)}…';

/// A marker offered for one code of a recipe.
final class TranslationCandidate {
  const TranslationCandidate({
    required this.color,
    required this.deltaE,
    required this.owned,
  });

  final MarkerColor color;

  /// The distance to the recipe's marker (ΔE76).
  final double deltaE;

  /// Whether the user owns it.
  final bool owned;

  MatchQuality get quality => MatchQuality.of(deltaE);
}

/// What one code of a recipe turns into.
final class RecipeLine {
  const RecipeLine({
    required this.code,
    required this.source,
    this.mine,
    this.range,
  });

  /// The code as the person wrote it.
  final String code;

  /// The marker of the recipe's brand that the code names, or `null` when the
  /// brand has no such code.
  final MarkerColor? source;

  /// The closest marker the user owns, when it is close enough to stand in.
  final TranslationCandidate? mine;

  /// A marker the user does not own that would do clearly better than [mine]
  /// (or the only one close enough when [mine] is `null`).
  final TranslationCandidate? range;

  /// The code is real but nothing the user owns is close to it.
  bool get missing => source != null && mine == null;

  /// The code does not exist in the brand the recipe was written for.
  bool get unknown => source == null;
}

/// Turns the markers of a recipe into the closest ones the user owns.
///
/// Built once for a collection ([owned], every brand, dried-out markers
/// already left out) and the brand range to suggest from ([range], the whole
/// range of the user's brand); asking is one distance per candidate.
final class RecipeTranslator {
  RecipeTranslator({
    required Iterable<MarkerColor> owned,
    required Iterable<MarkerColor> range,
  }) : _owned = _withLab(owned),
       _ownedIds = <String>{for (final MarkerColor c in owned) c.colorId},
       _range = _withLab(range);

  /// How much better (in ΔE) a marker that is not owned has to be before it
  /// is offered next to one that is.
  static const double worthBuyingMargin = 2;

  final List<_Candidate> _owned;
  final Set<String> _ownedIds;
  final List<_Candidate> _range;

  /// What [code] of the recipe becomes. [source] is the marker the code
  /// names in the recipe's brand, `null` when there is none.
  RecipeLine translate(String code, MarkerColor? source) {
    if (source == null) return RecipeLine(code: code, source: null);
    final LabColor? lab = _labOf(source.hex);
    if (lab == null) return RecipeLine(code: code, source: source);
    final TranslationCandidate? mine = _best(_owned, lab, owned: true);
    final TranslationCandidate? usableMine =
        mine != null && MatchQuality.isUsable(mine.deltaE) ? mine : null;
    final TranslationCandidate? rangeBest = _best(
      _range.where((_Candidate c) => !_ownedIds.contains(c.color.colorId)),
      lab,
      owned: false,
    );
    final bool offerRange =
        rangeBest != null &&
        MatchQuality.isUsable(rangeBest.deltaE) &&
        (usableMine == null ||
            rangeBest.deltaE < usableMine.deltaE - worthBuyingMargin);
    return RecipeLine(
      code: code,
      source: source,
      mine: usableMine,
      range: offerRange ? rangeBest : null,
    );
  }

  static TranslationCandidate? _best(
    Iterable<_Candidate> candidates,
    LabColor lab, {
    required bool owned,
  }) {
    _Candidate? best;
    double bestDistance = double.infinity;
    for (final _Candidate candidate in candidates) {
      final double distance = deltaE76(lab, candidate.lab);
      if (distance < bestDistance) {
        best = candidate;
        bestDistance = distance;
      }
    }
    return best == null
        ? null
        : TranslationCandidate(
            color: best.color,
            deltaE: bestDistance,
            owned: owned,
          );
  }

  static List<_Candidate> _withLab(Iterable<MarkerColor> colors) =>
      <_Candidate>[
        for (final MarkerColor color in colors)
          if (_labOf(color.hex) case final LabColor lab) _Candidate(color, lab),
      ];
}

final class _Candidate {
  const _Candidate(this.color, this.lab);

  final MarkerColor color;
  final LabColor lab;
}

LabColor? _labOf(String hex) {
  try {
    return hexToLab(hex);
  } on FormatException {
    // A malformed catalogue entry is simply not considered.
    return null;
  }
}
