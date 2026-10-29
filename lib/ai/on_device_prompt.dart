import 'package:ink_lab/core/collection_utils.dart';
import 'package:ink_lab/core/color_utils.dart';
import 'package:ink_lab/core/models.dart';

/// Default size of the colour list in the on-device prompt: the model's
/// context window is small (about 4000 tokens).
const int onDeviceMaxCandidates = 40;

/// How many of those colours are the nearest to the base; the rest are spread
/// across hue and lightness so the model still sees the whole gamut.
const int onDeviceNearestCandidates = 15;

/// Caps [colors] to [limit] for the on-device prompt: the [nearest] colours by
/// deltaE to [base], then the rest spread across hue and lightness (hue
/// sectors, each contributing a dark, a mid or a light colour in turn, plus a
/// few neutrals), so the list is never only neighbours of the base.
List<MarkerColor> capOnDeviceCandidates(
  List<MarkerColor> colors,
  MarkerColor? base,
  int limit, {
  int nearest = onDeviceNearestCandidates,
}) {
  if (colors.length <= limit) return colors;
  final picked = <MarkerColor>[];
  final pickedIds = <String>{};
  void add(MarkerColor color) {
    if (picked.length >= limit) return;
    if (pickedIds.add(color.colorId)) picked.add(color);
  }

  final baseLab = base == null ? null : _lab(base.hex);
  if (baseLab != null) {
    final byDistance = stableSortedBy(colors, (color) {
      final lab = _lab(color.hex);
      return lab == null ? double.infinity : deltaE76(baseLab, lab);
    });
    for (final color in byDistance) {
      if (picked.length >= nearest) break;
      add(color);
    }
  }

  final rest = colors.where((c) => !pickedIds.contains(c.colorId)).toList();
  final neutrals = <(MarkerColor, List<double>)>[];
  final chromatic = <(MarkerColor, List<double>)>[];
  for (final color in rest) {
    final hsv = _hsv(color.hex);
    (hsv[1] < 0.12 ? neutrals : chromatic).add((color, hsv));
  }

  final remaining = limit - picked.length;
  final neutralQuota = neutrals.length < remaining ~/ 5
      ? neutrals.length
      : remaining ~/ 5;
  final chromaticQuota = remaining - neutralQuota;

  // Neutrals: evenly spaced from dark to light.
  final byValue = stableSortedBy(neutrals, (entry) => entry.$2[2]);
  for (var i = 0; i < neutralQuota; i++) {
    add(byValue[(i * byValue.length / neutralQuota).floor()].$1);
  }

  // Chromatic: one sector per slot around the hue wheel; the slot takes the
  // darkest, the middle or the lightest colour of its sector in turn.
  final byHue = stableSortedBy(chromatic, (entry) => entry.$2[0]);
  if (chromaticQuota > 0 && byHue.isNotEmpty) {
    for (var i = 0; i < chromaticQuota; i++) {
      final start = (i * byHue.length / chromaticQuota).floor();
      final end = ((i + 1) * byHue.length / chromaticQuota).floor();
      if (end <= start) continue;
      final sector = stableSortedBy(
        byHue.sublist(start, end),
        (entry) => entry.$2[2],
      );
      add(switch (i % 3) {
        0 => sector.first.$1,
        1 => sector[sector.length ~/ 2].$1,
        _ => sector.last.$1,
      });
    }
  }

  // Small pools leave gaps: top up in the original order.
  for (final color in rest) {
    if (picked.length >= limit) break;
    add(color);
  }
  return picked;
}

/// The whole prompt sent to the on-device model: short and explicit, because a
/// small model drifts easily. Colours are listed as `CODE | name | #HEX`, the
/// answer is strict JSON with `code` and `role` (and an optional short
/// `reason`), and a one-shot example uses two real codes of the list.
String buildOnDevicePrompt(AiPaletteRequest request) {
  final candidates = request.candidates;
  final base = request.baseColor;
  final size = request.paletteSize <= 0 ? 1 : request.paletteSize;
  final list = candidates.map(_colorLine).join('\n');

  final exampleItems = <String>[];
  if (candidates.isNotEmpty) {
    exampleItems.add(
      '{"code":"${_code(candidates.first)}","role":"Shadow",'
      '"reason":"Darker tone for depth."}',
    );
  }
  if (candidates.length > 1) {
    exampleItems.add(
      '{"code":"${_code(candidates[candidates.length ~/ 2])}",'
      '"role":"Highlight"}',
    );
  }

  final scene = request.scenario?.label;
  return '''
You pick marker colours for a palette. Brand: ${_oneLine(request.brandLabel)}.
BASE: ${base == null ? 'none' : _colorLine(base)}
TASK: choose $size colours that go well with the base. Harmony: ${request.mode.label}.${scene == null ? '' : ' Scene: $scene.'}
RULES:
- Use ONLY codes from the COLORS list, exactly as written.
- Never invent codes. Never use the base code. No repeated codes.
- Give every colour a DIFFERENT role. Never use the same role twice.
- Pick the role that fits the colour: Shadow if darker than the base, Highlight if lighter, Accent if vivid with a different hue, Companion if a close hue, Neutral if greyish, Midtone only if none of those fit, Complement for the opposite hue.
- Reply with strict JSON only. No other text.
COLORS (CODE | name | #hex):
$list
FORMAT: {"palette":[{"code":"CODE","role":"ROLE"}]}
ROLE is one of: Shadow, Midtone, Highlight, Accent, Companion, Neutral, Complement. Use each ROLE at most once.
"reason" is optional, at most 12 words.
EXAMPLE: {"palette":[${exampleItems.join(',')}]}
Now reply with exactly $size items.''';
}

String _code(MarkerColor color) => color.newCode.toUpperCase();

String _colorLine(MarkerColor color) =>
    '${_code(color)} | ${_oneLine(color.newName)} | '
    '#${color.hex.replaceFirst('#', '').toUpperCase()}';

String _oneLine(String value) =>
    value.replaceAll(RegExp(r'[\r\n|]+'), ' ').trim();

LabColor? _lab(String hex) {
  try {
    return hexToLab(hex);
  } on FormatException {
    return null;
  }
}

List<double> _hsv(String hex) {
  try {
    return hexToHsv(hex);
  } on FormatException {
    return const [0, 0, 0];
  }
}
