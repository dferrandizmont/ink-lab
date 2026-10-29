import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/collection_utils.dart';
import 'package:ink_lab/core/color_utils.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/palette_advisor.dart'
    show PaletteAdvisorRequest, PaletteSuggestion;
import 'package:ink_lab/data/ai_settings.dart';

import 'open_router_client.dart';
import 'palette_advisor.dart';

/// Bring-your-own-key advisor.
///
/// It never stores, caches or logs the API key: the key is fetched per call
/// from the injected [apiKey] provider and only placed in the `Authorization`
/// header of an HTTPS request. Prompts and responses are never logged.
///
/// Every code the model returns is validated against the active collection
/// (brand, active sets and owned markers). Invalid codes are dropped; if a
/// model yields no valid code the next configured model is tried. When
/// `autoFallback` is on, the configured fallback models are tried in order.
final class OpenRouterPaletteAdvisor implements PaletteAdvisor {
  OpenRouterPaletteAdvisor({
    required OpenRouterClient client,
    required AiSettings Function() settings,
    required FutureOr<String?> Function() apiKey,
    this.maxTextCandidates = 48,
  }) {
    _client = client;
    _settings = settings;
    _apiKey = apiKey;
  }

  late final OpenRouterClient _client;
  late final AiSettings Function() _settings;
  late final FutureOr<String?> Function() _apiKey;

  /// Upper bound on how many candidate colours are sent to the model, keeping
  /// the prompt (and therefore the token cost) small.
  final int maxTextCandidates;

  @override
  Future<PaletteAdvice> advise(PaletteAdvisorRequest request) async {
    final settings = _settings();
    if (!settings.enabled) {
      return PaletteAdviceFailure(PaletteFailureReason.disabled);
    }

    final key = (await _apiKey())?.trim() ?? '';
    if (key.isEmpty) {
      return PaletteAdviceFailure(PaletteFailureReason.missingKey);
    }

    final candidates = paletteCandidateColors(
      colors: request.availableColors,
      brand: request.brand,
      activeSetIds: request.activeSetIds,
      ownedMarkerCodes: request.ownedMarkerCodes,
    );
    if (candidates.isEmpty) {
      return PaletteAdviceFailure(PaletteFailureReason.noAvailableColors);
    }

    final models = _attemptedModels(settings);
    if (models.isEmpty) {
      return PaletteAdviceFailure(PaletteFailureReason.noModelSelected);
    }

    final prepared = preparePaletteWire(request, candidates, maxTextCandidates);
    final baseCode = prepared.baseCode;
    final byCode = prepared.byCode;
    final systemPrompt = buildPaletteSystemPrompt(prepared.wire);
    final userPrompt = buildPaletteUserPrompt(prepared.wire);

    var lastReason = PaletteFailureReason.unknown;
    for (var index = 0; index < models.length; index++) {
      final model = models[index];
      try {
        final content = await _client.completeJson(
          apiKey: key,
          model: model,
          temperature: settings.temperature,
          maxTokens: settings.maxTokens,
          systemPrompt: systemPrompt,
          userPrompt: userPrompt,
        );
        final parsed = parsePaletteContent(content);
        final suggestions = validatePaletteItems(
          parsed.items,
          byCode,
          baseCode,
          request.paletteSize,
          baseColor: request.baseColor,
        );
        if (!hasEnoughPaletteSuggestions(suggestions)) {
          lastReason = PaletteFailureReason.noValidSuggestions;
          continue;
        }
        return PaletteAdviceSuccess(
          suggestions,
          tips: sanitizeTips(parsed.tips),
          modelUsed: model,
          usedFallback: index > 0,
        );
      } catch (error) {
        lastReason = _mapError(error);
      }
    }

    return PaletteAdviceFailure(lastReason);
  }

  List<String> _attemptedModels(AiSettings settings) =>
      <String>[
            settings.effectiveTextModel,
            if (settings.autoFallback) ...settings.effectiveTextFallbacks,
          ]
          .map((model) => model.trim())
          .where((model) => model.isNotEmpty)
          .toSet()
          .toList();

  PaletteFailureReason _mapError(Object error) {
    if (error is OpenRouterHttpException) {
      return switch (error.statusCode) {
        401 => PaletteFailureReason.unauthorized,
        402 => PaletteFailureReason.paymentRequired,
        429 => PaletteFailureReason.rateLimited,
        >= 500 && < 600 => PaletteFailureReason.serverError,
        _ => PaletteFailureReason.httpError,
      };
    }
    if (error is OpenRouterNetworkException) {
      return PaletteFailureReason.networkError;
    }
    if (error is OpenRouterFormatException) {
      return PaletteFailureReason.invalidJson;
    }
    return PaletteFailureReason.unknown;
  }
}

/// What every advisor needs after the candidates are known: the wire request
/// (capped candidate list), the lookup used to validate the model's codes and
/// the normalised base code.
typedef PreparedPaletteRequest = ({
  AiPaletteRequest wire,
  Map<String, MarkerColor> byCode,
  String? baseCode,
});

/// Builds the capped wire request shared by the cloud and the on-device
/// advisors. [candidates] must already be filtered to the active collection.
PreparedPaletteRequest preparePaletteWire(
  PaletteAdvisorRequest request,
  List<MarkerColor> candidates,
  int maxCandidates, {
  List<MarkerColor> Function(List<MarkerColor>, MarkerColor?, int)? capper,
}) {
  final baseColor = resolvePaletteBase(request.baseColor, candidates);
  final baseCode = baseColor == null
      ? null
      : normalizeCodeForMatch(baseColor.newCode);
  final byCode = <String, MarkerColor>{
    for (final color in candidates) normalizeCodeForMatch(color.newCode): color,
  };
  final sendable = candidates
      .where(
        (color) =>
            baseCode == null ||
            normalizeCodeForMatch(color.newCode) != baseCode,
      )
      .toList();
  final wire = AiPaletteRequest(
    brandId: request.brand.id,
    brandLabel: request.brand.label,
    baseColor: baseColor,
    candidates: (capper ?? capPaletteCandidates)(
      sendable,
      baseColor,
      maxCandidates,
    ),
    scenario: request.scenario,
    mode: request.mode,
    paletteSize: request.paletteSize,
  );
  return (wire: wire, byCode: byCode, baseCode: baseCode);
}

/// The candidate that is the request's base colour, or the base itself.
MarkerColor? resolvePaletteBase(
  MarkerColor? base,
  List<MarkerColor> candidates,
) {
  if (base == null) return null;
  for (final candidate in candidates) {
    if (candidate.colorId == base.colorId) return candidate;
  }
  return base;
}

/// Whether [suggestions] are enough to keep an AI answer: at least two valid
/// markers, where the base counts (the one given, or the one the scene picks
/// when none is), so one valid companion is enough. With none, the caller
/// falls back entirely.
bool hasEnoughPaletteSuggestions(List<PaletteSuggestion> suggestions) =>
    suggestions.length + 1 >= 2;

/// Largest colour distance (CIE76 deltaE) at which a model-supplied hex is
/// mapped onto the nearest marker of the active collection.
const double paletteHexMatchMaxDeltaE = 10;

/// Turns parsed model items into validated suggestions: only colours of the
/// active collection ([byCode]), never the base, unique, at most
/// [paletteSize], with the role and reason normalised from the same item.
///
/// Matching is lenient before an item is rejected, in this order: the code as
/// written (brand prefix stripped, case, spaces, leading zeros: `1` is `01`),
/// the colour name (case-insensitive), the code extracted from loose text, a
/// hex value mapped to the nearest marker within [paletteHexMatchMaxDeltaE],
/// and a name found inside the text. Nothing outside [byCode] is invented.
List<PaletteSuggestion> validatePaletteItems(
  List<AiPaletteItem> items,
  Map<String, MarkerColor> byCode,
  String? baseCode,
  int paletteSize, {
  MarkerColor? baseColor,
}) {
  final wanted = paletteSize <= 0 ? 1 : paletteSize;
  final lookup = _PaletteLookup(byCode);
  final seen = <String>{};
  final result = <PaletteSuggestion>[];
  for (final item in items) {
    if (result.length >= wanted) break;
    final color = lookup.resolve(item);
    if (color == null) continue;
    final code = normalizeCodeForMatch(color.newCode);
    if (code.isEmpty) continue;
    if (baseCode != null && code == baseCode) continue;
    if (!seen.add(code)) continue;
    // Role and reason come from this one item, so the row can never show a
    // role that belongs to another colour or contradicts its own text.
    final split = splitRoleAndReason(item.role, item.reason);
    result.add(
      PaletteSuggestion(color: color, reason: split.reason, role: split.role),
    );
  }
  return diversifyPaletteRoles(result, baseColor: baseColor);
}

/// Lightness gap (CIE L*) from the reference beyond which a colour counts as
/// darker or lighter than it.
const double _roleLightnessGap = 6;

/// Lab chroma under which a colour reads as neutral, and over which it reads
/// as vivid enough to be an accent.
const double _roleNeutralChroma = 12;
const double _roleAccentChroma = 30;

/// Replaces repeated roles with distinct ones that fit each colour.
///
/// Models (small on-device ones especially) often label two colours of a
/// palette "Midtone". The first colour keeps a role; every later duplicate
/// (any role but `Base`) is reassigned to the best-fitting role not yet used,
/// judged against [baseColor] (or, without a base, the palette's average
/// lightness and its first colour's hue): `Neutral` when nearly grey,
/// `Accent` when vivid and more than 60 degrees away in hue, `Shadow` when
/// darker, `Highlight` when lighter, `Companion` when under 30 degrees away
/// (tried in that order, skipping roles already used). When no
/// unused role fits, the model's own role is kept. Reasons are never changed
/// and colours without a role are left alone.
List<PaletteSuggestion> diversifyPaletteRoles(
  List<PaletteSuggestion> suggestions, {
  MarkerColor? baseColor,
}) {
  final used = <String>{};
  final duplicates = <int>[];
  for (var i = 0; i < suggestions.length; i++) {
    final role = suggestions[i].role;
    if (role == null || role == 'Base') continue;
    if (!used.add(role)) duplicates.add(i);
  }
  if (duplicates.isEmpty) return suggestions;

  final labs = [for (final s in suggestions) _safeLab(s.color.hex)];
  final reference = baseColor == null ? null : _safeLab(baseColor.hex);
  final referenceLightness =
      reference?.l ??
      () {
        final known = labs.whereType<LabColor>().toList();
        if (known.isEmpty) return null;
        return known.fold<double>(0, (sum, lab) => sum + lab.l) / known.length;
      }();
  final referenceHue = _safeHue((baseColor ?? suggestions.first.color).hex);

  final result = List<PaletteSuggestion>.of(suggestions);
  for (final index in duplicates) {
    final lab = labs[index];
    if (lab == null || referenceLightness == null) continue;
    final chroma = math.sqrt(lab.a * lab.a + lab.b * lab.b);
    final hueGap = hueDistance(
      _safeHue(suggestions[index].color.hex),
      referenceHue,
    );
    // Most specific first; a role already taken falls through to the next.
    final fitting = <String>[
      if (chroma < _roleNeutralChroma) 'Neutral',
      if (chroma >= _roleAccentChroma && hueGap > 60) 'Accent',
      if (lab.l < referenceLightness - _roleLightnessGap) 'Shadow',
      if (lab.l > referenceLightness + _roleLightnessGap) 'Highlight',
      if (chroma >= _roleNeutralChroma && hueGap < 30) 'Companion',
    ];
    for (final role in fitting) {
      if (used.add(role)) {
        final original = suggestions[index];
        result[index] = PaletteSuggestion(
          color: original.color,
          reason: original.reason,
          role: role,
        );
        break;
      }
    }
  }
  return result;
}

final RegExp _brandPrefix = RegExp(
  r'^(?:DECO\s*TIME|OHUHU(?:[\s_-]*OAHU)?|OAHU)\s*[:#/_\s-]\s*',
  caseSensitive: false,
);
final RegExp _hashHex = RegExp(r'#([0-9A-Fa-f]{6})(?![0-9A-Za-z])');
final RegExp _bareHex = RegExp(r'^[0-9A-Fa-f]{6}$');

String _stripBrandPrefix(String raw) {
  var value = raw.trim();
  for (var i = 0; i < 2; i++) {
    final stripped = value.replaceFirst(_brandPrefix, '');
    if (stripped == value) break;
    value = stripped.trim();
  }
  return value;
}

String _compactCode(String raw) =>
    raw.toUpperCase().replaceAll(RegExp(r'[\s_-]+'), '');

String _normalizeName(String raw) =>
    raw.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), ' ').trim();

/// Resolves a model item to a colour of the active collection, or `null`.
final class _PaletteLookup {
  _PaletteLookup(this.byCode) {
    for (final color in byCode.values) {
      for (final name in {color.newName, color.oldName}) {
        final key = _normalizeName(name);
        if (key.isEmpty) continue;
        (_byName[key] ??= <MarkerColor>[]).add(color);
      }
    }
  }

  final Map<String, MarkerColor> byCode;
  final Map<String, List<MarkerColor>> _byName = {};
  final Map<String, LabColor?> _labs = {};

  MarkerColor? resolve(AiPaletteItem item) {
    final raw = item.rawCode.isEmpty ? item.code : item.rawCode;
    final stripped = _stripBrandPrefix(raw);

    // 1. The code as written.
    final exact = _byCodeText(stripped);
    if (exact != null) return exact;

    // 2. The name, in the name field or in the code field.
    final named = _byExactName(item.name) ?? _byExactName(stripped);
    if (named != null) return named;

    // 3. A code extracted from loose text ("Wine Red (01)").
    final extracted =
        _byCodeText(normalizeMarkerCode(stripped)) ?? _byCodeText(item.code);
    if (extracted != null) return extracted;

    // 4. A hex value, mapped to the nearest marker within the limit.
    final hex = _hexOf(item, raw);
    if (hex != null) {
      final nearest = _nearest(hex);
      if (nearest != null) return nearest;
    }

    // 5. A known name inside longer text.
    return _byContainedName(item.name) ?? _byContainedName(stripped);
  }

  MarkerColor? _byCodeText(String text) {
    if (text.trim().isEmpty) return null;
    return byCode[normalizeCodeForMatch(text)] ??
        byCode[normalizeCodeForMatch(_compactCode(text))];
  }

  MarkerColor? _byExactName(String text) {
    final key = _normalizeName(text);
    if (key.isEmpty) return null;
    return _byName[key]?.first;
  }

  MarkerColor? _byContainedName(String text) {
    final haystack = ' ${_normalizeName(text)} ';
    if (haystack.trim().isEmpty) return null;
    MarkerColor? best;
    var bestLength = 0;
    for (final entry in _byName.entries) {
      if (entry.key.length < 4 || entry.key.length <= bestLength) continue;
      if (haystack.contains(' ${entry.key} ')) {
        best = entry.value.first;
        bestLength = entry.key.length;
      }
    }
    return best;
  }

  LabColor? _hexOf(AiPaletteItem item, String raw) {
    final field = item.hex.trim();
    final candidates = <String>[
      if (field.isNotEmpty) field,
      for (final text in [raw, item.name])
        if (_hashHex.firstMatch(text) case final match?) match.group(1)!,
      if (_bareHex.hasMatch(raw.trim())) raw.trim(),
    ];
    for (final candidate in candidates) {
      final lab = _safeLab(candidate);
      if (lab != null) return lab;
    }
    return null;
  }

  MarkerColor? _nearest(LabColor target) {
    MarkerColor? best;
    var bestDistance = double.infinity;
    for (final color in byCode.values) {
      final lab = _labs.putIfAbsent(color.colorId, () => _safeLab(color.hex));
      if (lab == null) continue;
      final distance = deltaE76(target, lab);
      if (distance < bestDistance) {
        bestDistance = distance;
        best = color;
      }
    }
    return bestDistance <= paletteHexMatchMaxDeltaE ? best : null;
  }
}

/// Caps the candidate list to [limit] colours: the closest ones by deltaE to
/// the base, then a hue spread across the rest, so the model still sees the
/// whole gamut.
List<MarkerColor> capPaletteCandidates(
  List<MarkerColor> colors,
  MarkerColor? base,
  int limit,
) {
  if (colors.length <= limit) return colors;
  final picked = <MarkerColor>[];
  final pickedCodes = <String>{};
  void add(MarkerColor color) {
    if (picked.length >= limit) return;
    if (pickedCodes.add(color.newCode.toUpperCase())) picked.add(color);
  }

  final baseLab = base == null ? null : _safeLab(base.hex);
  final byDistance = baseLab == null
      ? colors.toList()
      : stableSortedBy(colors, (color) {
          final lab = _safeLab(color.hex);
          return lab == null ? double.infinity : deltaE76(baseLab, lab);
        });

  final closestTarget = (limit * 3) ~/ 5;
  for (final color in byDistance) {
    if (picked.length >= closestTarget) break;
    add(color);
  }

  final rest = stableSortedBy(
    colors.where((color) => !pickedCodes.contains(color.newCode.toUpperCase())),
    (color) => _safeHue(color.hex),
  );
  final remaining = limit - picked.length;
  if (rest.isNotEmpty && remaining > 0) {
    final step = rest.length / remaining;
    for (var i = 0; i < remaining; i++) {
      final index = (i * step).floor().clamp(0, rest.length - 1);
      add(rest[index]);
    }
  }
  for (final color in rest) {
    if (picked.length >= limit) break;
    add(color);
  }
  return picked;
}

/// Normalizes a marker code so that different spellings ("05", "5", "B315")
/// compare equal. Ported from the Kotlin `normalizeCodeForMatch`.
String normalizeCodeForMatch(String raw) {
  final value = _stripTrailingDots(raw.trim().toUpperCase());
  if (value.isEmpty) return '';
  if (value == '0.5') return value;
  if (RegExp(r'^\d{1,3}$').hasMatch(value)) {
    if (value == '0') return value;
    final numeric = int.tryParse(value);
    if (numeric == null) return value;
    return numeric >= 1 && numeric <= 99
        ? numeric.toString().padLeft(2, '0')
        : numeric.toString();
  }
  return value;
}

final RegExp _markerCodePattern = RegExp(
  r'(?:^|[^A-Z0-9.])((?:0\.5|0|[A-Z]{1,4}\d(?:\.\d)?|[A-Z]{1,4}\d{2,3}|\d{1,3}))(?:#[0-9A-F]{6})?(?=[^A-Z0-9.]|$)',
);

/// Extracts and normalizes a marker code from loosely-formatted model output.
/// Ported from the Kotlin `normalizeMarkerCode`.
String normalizeMarkerCode(String raw) {
  final input = _stripTrailingDots(raw.trim().toUpperCase());
  if (input.isEmpty) return '';
  final extracted = _stripTrailingDots(
    _markerCodePattern.firstMatch(input)?.group(1) ?? '',
  );
  if (extracted.isEmpty) return '';
  if (extracted == '0.5') return extracted;
  if (RegExp(r'^\d{1,3}$').hasMatch(extracted)) {
    if (extracted == '0') return extracted;
    final numeric = int.tryParse(extracted);
    if (numeric == null) return extracted;
    return numeric >= 1 && numeric <= 99
        ? numeric.toString().padLeft(2, '0')
        : numeric.toString();
  }
  return extracted;
}

/// Parses the assistant's text into a normalized palette response.
///
/// Tolerates what real models return: a bare object, an object inside
/// ```json fences or surrounded by prose or reasoning text, a single-code
/// object, a plain array, and schema keys in any letter case. Every balanced
/// top-level JSON value in the text is tried in order and the first one that
/// holds palette codes wins. Throws [OpenRouterFormatException] when nothing
/// usable can be recovered.
AiProviderPaletteResponse parsePaletteContent(String content) {
  final raw = content.trim();
  if (raw.isEmpty) {
    throw const OpenRouterFormatException('Model returned empty content');
  }

  var sawJson = false;
  for (final payload in _jsonCandidates(raw)) {
    final Object? decoded;
    try {
      decoded = jsonDecode(payload);
    } on FormatException {
      continue;
    }
    sawJson = true;
    final AiPaletteJsonEnvelope envelope;
    try {
      envelope = _decodeEnvelope(decoded);
    } on OpenRouterFormatException {
      continue;
    }
    final items = <AiPaletteItem>[];
    for (final entry in envelope.palette) {
      final code = normalizeMarkerCode(entry.code);
      final rawCode = (entry.rawCode ?? entry.code).trim();
      final name = (entry.name ?? '').trim();
      final hex = (entry.hex ?? '').trim();
      // Keep what a lenient match can still use: the answer may identify the
      // colour by name or hex instead of a usable code.
      if (code.isEmpty && rawCode.isEmpty && name.isEmpty && hex.isEmpty) {
        continue;
      }
      final role = (entry.role ?? '').trim();
      final reason = (entry.reason ?? '').trim();
      items.add(
        AiPaletteItem(
          code: code,
          role: role,
          reason: reason.isEmpty ? 'AI suggestion' : reason,
          name: name,
          hex: hex,
          rawCode: rawCode,
        ),
      );
    }
    if (items.isNotEmpty) {
      return AiProviderPaletteResponse(items: items, tips: envelope.tips);
    }
  }
  throw OpenRouterFormatException(
    sawJson
        ? 'Model returned no palette codes'
        : 'Model did not return valid JSON',
  );
}

/// Trims, unquotes and de-duplicates model tips, dropping placeholders.
List<String> sanitizeTips(List<String> tips) => tips
    .map((tip) => _stripQuotes(sanitizeDisplayText(tip, 200)))
    .map((tip) => tip.startsWith('-') ? tip.substring(1).trim() : tip)
    .where((tip) => tip.isNotEmpty && !_isPlaceholder(tip))
    .toSet()
    .take(5)
    .toList();

AiPaletteJsonEnvelope _decodeEnvelope(Object? decoded) {
  if (decoded is Map) {
    final map = _lowerKeys(decoded);
    final tips = _parseTips(map['tips']);
    for (final key in const ['palette', 'items', 'colors', 'suggestions']) {
      if (!map.containsKey(key)) continue;
      final entries = _parseEntries(map[key]);
      if (entries.isNotEmpty) {
        return AiPaletteJsonEnvelope(palette: entries, tips: tips);
      }
    }
    final single = _entryFromFields(map);
    if (single != null) {
      return AiPaletteJsonEnvelope(palette: [single], tips: tips);
    }
    throw const OpenRouterFormatException('AI JSON object missing palette');
  }
  if (decoded is List) {
    return AiPaletteJsonEnvelope(palette: _parseEntries(decoded));
  }
  throw const OpenRouterFormatException('Unsupported AI JSON format');
}

Map<String, dynamic> _lowerKeys(Map<dynamic, dynamic> source) => {
  for (final entry in source.entries)
    if (entry.key is String) (entry.key as String).toLowerCase(): entry.value,
};

List<AiPaletteJsonItem> _parseEntries(Object? element) {
  final list = element is List
      ? element
      : element == null
      ? const []
      : [element];
  final result = <AiPaletteJsonItem>[];
  for (final item in list) {
    if (item is Map) {
      final entry = _entryFromFields(_lowerKeys(item));
      if (entry != null) result.add(entry);
    } else if (item is String) {
      final raw = _clip(item);
      if (raw.isNotEmpty) {
        result.add(
          AiPaletteJsonItem(code: normalizeMarkerCode(raw), rawCode: raw),
        );
      }
    }
  }
  return result;
}

/// Builds an entry from the fields of one palette object. Small models name
/// the keys loosely and identify a colour by code, name or hex, so every one of
/// them is kept; the lenient matcher decides later. `null` when the object
/// identifies no colour at all.
AiPaletteJsonItem? _entryFromFields(Map<String, dynamic> fields) {
  final rawCode = _clip(_firstString(fields, _codeKeys) ?? '');
  var name = _clip(_firstString(fields, _nameKeys) ?? '');
  var hex = _clip(_firstString(fields, _hexKeys) ?? '');
  if (hex.isEmpty && (_hashHex.hasMatch(name) || _bareHex.hasMatch(name))) {
    hex = name;
    name = '';
  }
  if (rawCode.isEmpty && name.isEmpty && hex.isEmpty) return null;
  return AiPaletteJsonItem(
    code: normalizeMarkerCode(rawCode),
    rawCode: rawCode,
    name: name,
    hex: hex,
    role: _asString(fields['role']),
    reason: _asString(fields['reason']),
  );
}

const List<String> _codeKeys = ['code', 'marker', 'marker_code', 'id'];
const List<String> _nameKeys = ['name', 'colour', 'color', 'color_name'];
const List<String> _hexKeys = ['hex', 'hex_code', 'hexcode', 'color_hex'];

String? _firstString(Map<String, dynamic> fields, List<String> keys) {
  for (final key in keys) {
    final value = fields[key];
    if (value is String && value.trim().isNotEmpty) return value;
    if (value is num) return value.toString();
  }
  return null;
}

/// Trims model-supplied identifiers to a sane length.
String _clip(String value) {
  final trimmed = value.trim();
  return trimmed.length <= 80 ? trimmed : trimmed.substring(0, 80);
}

List<String> _parseTips(Object? element) {
  if (element is! List) return const [];
  return [
    for (final tip in element)
      if (tip is String) tip,
  ];
}

/// Upper bound on the text scanned and on the JSON starts tried, so a hostile
/// or runaway response cannot make parsing quadratic.
const int _maxScanChars = 200 * 1024;
const int _maxJsonStarts = 24;

final RegExp _fenceLine = RegExp(r'^\s*```[A-Za-z0-9_-]*\s*$');

/// Yields the balanced `{...}` / `[...]` substrings of [raw], in order, after
/// dropping code-fence marker lines. Brackets inside JSON strings are ignored.
Iterable<String> _jsonCandidates(String raw) sync* {
  var text = raw
      .split(RegExp(r'\r?\n'))
      .where((line) => !_fenceLine.hasMatch(line))
      .join(' ');
  if (text.length > _maxScanChars) text = text.substring(0, _maxScanChars);

  var index = 0;
  var starts = 0;
  while (index < text.length && starts < _maxJsonStarts) {
    final unit = text.codeUnitAt(index);
    if (unit != 0x7B && unit != 0x5B) {
      index++;
      continue;
    }
    starts++;
    final end = _balancedEnd(text, index);
    if (end == null) {
      index++;
      continue;
    }
    yield text.substring(index, end + 1);
    index = end + 1;
  }
}

/// The index of the bracket closing the one at [start], or `null`.
int? _balancedEnd(String text, int start) {
  var depth = 0;
  var inString = false;
  var escaped = false;
  for (var i = start; i < text.length; i++) {
    final unit = text.codeUnitAt(i);
    if (inString) {
      if (escaped) {
        escaped = false;
      } else if (unit == 0x5C) {
        escaped = true;
      } else if (unit == 0x22) {
        inString = false;
      }
      continue;
    }
    switch (unit) {
      case 0x22:
        inString = true;
      case 0x7B || 0x5B:
        depth++;
      case 0x7D || 0x5D:
        depth--;
        if (depth == 0) return i;
    }
  }
  return null;
}

/// System prompt shared by the palette advisors.
String buildPaletteSystemPrompt(AiPaletteRequest request) =>
    '''
You are a marker palette assistant for BRAND=${request.brandLabel}.
Return ONLY valid minified JSON with this schema:
{"palette":[{"code":"B315","role":"Shadow","reason":"..."}],"tips":["..."]}
Rules: use only codes in AVAILABLE_COLORS; code must be marker code only (no #HEX); if BASE_CODE is not NONE, exclude BASE_CODE; max PALETTE_SIZE items; unique codes; short reasons/tips; no prose; no markdown; no analysis.''';

/// User prompt (one line of KEY=value fields) shared by the palette advisors.
String buildPaletteUserPrompt(AiPaletteRequest request) {
  final baseCode = request.baseColor?.newCode.toUpperCase() ?? 'NONE';
  final baseName = _oneLine(request.baseColor?.newName ?? 'None');
  final available = request.candidates
      .map(
        (color) => '${color.newCode.toUpperCase()}#${color.hex.toUpperCase()}',
      )
      .join(',');
  return 'BRAND_ID=${request.brandId}'
      '|BRAND_LABEL=${_oneLine(request.brandLabel)}'
      '|MODE=${request.mode.label}'
      '|SCENARIO=${request.scenario?.label ?? 'None'}'
      '|BASE_CODE=$baseCode'
      '|BASE_NAME=$baseName'
      '|BASE_LOCKED=${request.baseColor != null}'
      '|PALETTE_SIZE=${request.paletteSize}'
      '|GOAL=Generate balanced suggestions for this scene.'
      '|IMAGE_ATTACHED=false'
      '|IMAGE_SOURCE=N/A'
      '|AVAILABLE_COLORS=$available';
}

/// The roles the palette UI understands, in display form.
const List<String> paletteRoles = <String>[
  'Base',
  'Shadow',
  'Midtone',
  'Highlight',
  'Accent',
  'Companion',
  'Neutral',
  'Complement',
];

/// Maps a free-form model role ("shadow", "Highlights", "mid-tone",
/// "Complementary") onto [paletteRoles], or `null` when it names none of them.
String? normalizePaletteRole(String raw) {
  final words = raw
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z]+'), ' ')
      .trim()
      .split(' ')
      .where((word) => word.isNotEmpty);
  for (final word in words) {
    if (word == 'base') return 'Base';
    if (word.startsWith('shadow')) return 'Shadow';
    if (word.startsWith('highlight')) return 'Highlight';
    if (word == 'mid' || word.startsWith('midtone')) return 'Midtone';
    if (word.startsWith('accent')) return 'Accent';
    if (word.startsWith('companion')) return 'Companion';
    if (word.startsWith('neutral')) return 'Neutral';
    if (word.startsWith('complement')) return 'Complement';
  }
  return null;
}

/// Combines a model's [rawRole] and [rawReason] into one consistent pair.
///
/// The role is the model's own, normalised to [paletteRoles]; when it is
/// missing or unknown, a recognised `"<Role>:"` prefix of the reason supplies
/// it instead. Any leading role prefix is stripped from the reason so the UI
/// never repeats (or contradicts) the role column. The role is `null` when
/// neither names a known role; the UI then derives one from the reason.
({String? role, String reason}) splitRoleAndReason(
  String rawRole,
  String rawReason,
) {
  var role = normalizePaletteRole(
    _stripQuotes(sanitizeDisplayText(rawRole, 40)),
  );
  var reason = _stripQuotes(sanitizeDisplayText(rawReason, 200));
  for (var pass = 0; pass < 2; pass++) {
    final colon = reason.indexOf(':');
    if (colon <= 0 || colon > 30) break;
    final prefix = reason.substring(0, colon);
    final prefixRole = normalizePaletteRole(prefix);
    if (prefixRole == null || prefix.trim().split(RegExp(r'\s+')).length > 3) {
      break;
    }
    role ??= prefixRole;
    reason = _stripQuotes(reason.substring(colon + 1).trim());
  }
  if (reason.isEmpty || _isPlaceholder(reason)) reason = 'AI suggestion';
  return (role: role, reason: reason);
}

String _stripQuotes(String value) =>
    value.replaceAll(RegExp(r'''^[\[\]"']+|[\[\]"']+$'''), '');

String _stripTrailingDots(String value) =>
    value.replaceAll(RegExp(r'\.+$'), '');

String _oneLine(String value) =>
    value.replaceAll('\n', ' ').replaceAll('|', '/').trim();

bool _isPlaceholder(String value) {
  final trimmed = value.trim();
  return trimmed == '...' ||
      trimmed == '..' ||
      trimmed == '.' ||
      trimmed.toLowerCase() == 'n/a';
}

String? _asString(Object? value) => value is String ? value : null;

LabColor? _safeLab(String hex) {
  try {
    return hexToLab(hex);
  } on FormatException {
    return null;
  }
}

double _safeHue(String hex) {
  try {
    return hexToHsv(hex)[0];
  } on FormatException {
    return 0;
  }
}
