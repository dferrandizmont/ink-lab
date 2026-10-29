import 'package:intl/intl.dart';

import '../ai/palette_advisor.dart' as ai;
import '../core/ideas_engine.dart';
import '../core/models.dart';
import '../core/palette_generator.dart' show QuickPaletteVariation;
import 'app_localizations.dart';
import 'phrases.dart';

/// Localised text for the values the core engines and the AI layer expose as
/// English identifiers (enum labels, roles, reasons, typed failures).
///
/// The core and `lib/ai` stay pure and language-free; this UI-layer helper maps
/// their values to the ARB messages. Unknown values (for example a free-text
/// reason written by an AI model) are returned unchanged.
final RegExp _countedPackPattern = RegExp(
  r'^(\d+) (Skin|Pastels?|Basic|Illustration|Landscape|Sweetness Pastels|'
  r'Mid-Tones|Blossoming Pastels)$',
);
final RegExp _whiteCasePattern = RegExp(r'^White Case (\d+)(?: \(V(\d)\))?$');
final RegExp _japanPackPattern = RegExp(r'^Japan (\d+) \(V(\d)\)$');

extension CoreLabelLocalizations on AppLocalizations {
  String modeLabel(PaletteMode mode) =>
      paletteModeText(mode.label) ?? mode.label;

  String scenarioLabel(DrawingScenario scenario) =>
      scenarioText(scenario.label) ?? scenario.label;

  String packModeLabel(PackSelectionMode mode) =>
      packModeText(mode.label) ?? mode.label;

  /// The pack name inside its line ("160", "White Case 24"), translated.
  String packSetLabel(OahuSet set) {
    final String label = set.label;
    final String? known = packLabelText(label);
    if (known != null) return known;
    final RegExpMatch? counted = _countedPackPattern.firstMatch(label);
    if (counted != null) {
      final String n = counted.group(1)!;
      switch (counted.group(2)!) {
        case 'Skin':
          return packLabelSkin(n);
        case 'Pastel':
          return packLabelPastel(n);
        case 'Pastels':
          return packLabelPastels(n);
        case 'Basic':
          return packLabelBasic(n);
        case 'Illustration':
          return packLabelIllustration(n);
        case 'Landscape':
          return packLabelLandscape(n);
        case 'Sweetness Pastels':
          return packLabelSweetPastels(n);
        case 'Mid-Tones':
          return packLabelMidTones(n);
        case 'Blossoming Pastels':
          return packLabelBlossomPastels(n);
      }
    }
    final RegExpMatch? white = _whiteCasePattern.firstMatch(label);
    if (white != null) {
      final String n = white.group(1)!;
      final String? version = white.group(2);
      return version == null
          ? packLabelWhiteCase(n)
          : packLabelWhiteCaseVersion(n, version);
    }
    final RegExpMatch? japan = _japanPackPattern.firstMatch(label);
    if (japan != null) {
      return packLabelJapanVersion(japan.group(1)!, japan.group(2)!);
    }
    return label;
  }

  /// The pack name with its line when the line is not Oahu ("Honolulu 48"),
  /// or the classic packs as "Classic 160". Use it where packs of several
  /// lines meet (filters, details); inside a line [packSetLabel] is enough.
  String packSetFullLabel(OahuSet set) {
    final String label = packSetLabel(set);
    if (set.line != MarkerLine.oahu) {
      return packFullLabel(set.line.label, label);
    }
    return set.id.startsWith('classic_') ? swatchesClassicPack(label) : label;
  }

  String ideaCategoryLabel(IdeaCategory category) =>
      ideaCategoryText(category.label) ?? category.label;

  String variationName(QuickPaletteVariation variation) =>
      variationLabelText(variation.label) ?? variation.label;

  String ideaTitle(IdeaPreset preset) =>
      ideaTitleText(preset.id) ?? preset.title;

  String ideaSummary(IdeaPreset preset) =>
      ideaSummaryText(preset.id) ?? preset.summary;

  /// Label of an AI result: the badge and the model that produced it. When the
  /// colour-theory engine completed a short AI answer, [aiCount] of [total]
  /// colours came from the model and the label says so.
  String aiResultLabel(String model, {int? aiCount, int? total}) {
    final String name = shortModelName(model);
    if (aiCount == null || total == null || aiCount >= total) {
      return paletteAiLabel(name);
    }
    return paletteAiLabelPartial(name, aiCount, total);
  }

  /// Download progress of the on-device model: megabytes, and the total and
  /// percentage when known.
  String onDeviceProgressText(int bytes, {int total = 0}) {
    String mb(int value) {
      final double v = value / (1024 * 1024);
      return NumberFormat(v >= 10 ? '0' : '0.0', localeName).format(v);
    }

    if (total > 0 && bytes <= total) {
      final int percent = (bytes * 100 ~/ total).clamp(0, 100);
      return settingsAiOnDeviceProgressTotal(mb(bytes), mb(total), percent);
    }
    return settingsAiOnDeviceProgressBytes(mb(bytes));
  }

  /// A short quality label for a CIELAB76 distance.
  String matchQualityLabel(double deltaE) {
    if (deltaE <= 1.0) return matchQualityExcellent;
    if (deltaE <= 2.5) return matchQualityVeryClose;
    if (deltaE <= 5.0) return matchQualityClose;
    if (deltaE <= 8.0) return matchQualityFair;
    return matchQualityApproximate;
  }

  /// The swatch card location from the core label (`Card 4`).
  String cardLocationLabel(String coreLabel) {
    final RegExpMatch? match = RegExp(r'^Card (\d+)$').firstMatch(coreLabel);
    if (match == null) return coreLabel;
    return commonCardLocation(int.parse(match.group(1)!));
  }

  /// The role of a palette color, from an English role or reason.
  String roleLabel(String role) => reasonLabel(role);

  /// The reason a color was suggested. The core engines write English
  /// sentences; known ones are translated, the rest (AI text) is kept.
  String reasonLabel(String reason) {
    final String value = reason.trim();
    final String? known = phrase(value);
    if (known != null) return known;
    final RegExpMatch? variation = _variationPattern.firstMatch(value);
    if (variation != null) {
      final String prefix = variation.group(1)!;
      return reasonVariation(
        variationPrefixText(prefix) ?? prefix,
        reasonLabel(variation.group(2)!),
      );
    }
    final RegExpMatch? nearby = _nearbyPattern.firstMatch(value);
    if (nearby != null) return reasonNearbyHue(int.parse(nearby.group(1)!));
    final RegExpMatch? shadow = _shadowPattern.firstMatch(value);
    if (shadow != null) return reasonShadowTone(int.parse(shadow.group(1)!));
    return reason;
  }

  /// The message of a typed AI failure.
  String aiFailureText(ai.PaletteFailureReason reason) => switch (reason) {
    ai.PaletteFailureReason.disabled => errDisabled,
    ai.PaletteFailureReason.missingKey => errMissingKey,
    ai.PaletteFailureReason.noModelSelected => errNoModelSelected,
    ai.PaletteFailureReason.unauthorized => errUnauthorized,
    ai.PaletteFailureReason.paymentRequired => errPaymentRequired,
    ai.PaletteFailureReason.rateLimited => errRateLimited,
    ai.PaletteFailureReason.serverError => errServerError,
    ai.PaletteFailureReason.httpError => errHttpError,
    ai.PaletteFailureReason.networkError => errNetworkError,
    ai.PaletteFailureReason.invalidJson => errInvalidJson,
    ai.PaletteFailureReason.invalidResponse => errInvalidResponse,
    ai.PaletteFailureReason.noValidSuggestions => errNoValidSuggestions,
    ai.PaletteFailureReason.noAvailableColors => errNoAvailableColors,
    ai.PaletteFailureReason.noSuggestions => errNoSuggestions,
    ai.PaletteFailureReason.timeout => errTimeout,
    ai.PaletteFailureReason.onDeviceUnavailable => errOnDeviceUnavailable,
    ai.PaletteFailureReason.unknown => errUnknown,
  };

  /// The message of an AI failure: the localised text of its typed [reason]
  /// when [message] is the default one, otherwise [message] itself (after
  /// translating the fallback note the AI layer composes).
  String aiFailureMessage(ai.PaletteFailureReason reason, String message) {
    if (message.isEmpty || message == reason.userMessage) {
      return aiFailureText(reason);
    }
    return aiNote(message);
  }

  /// Translates the notes the AI layer writes when it falls back to the local
  /// engine; any other note is returned unchanged.
  String aiNote(String note) {
    if (note == aiFellBackNote) return paletteAiFellBack;
    for (final ai.PaletteFailureReason reason
        in ai.PaletteFailureReason.values) {
      if (reason.userMessage == note) return aiFailureText(reason);
    }
    if (note.startsWith(_fellBackPrefix) && note.endsWith(_fellBackSuffix)) {
      final String inner = note.substring(
        _fellBackPrefix.length,
        note.length - _fellBackSuffix.length,
      );
      for (final ai.PaletteFailureReason reason
          in ai.PaletteFailureReason.values) {
        if (reason.userMessage == inner) {
          return errAiUnavailableWithReason(aiFailureText(reason));
        }
      }
      return errAiUnavailableWithReason(inner);
    }
    return note;
  }
}

/// The model id without its provider prefix and `:free`/`:beta` variant
/// suffix, for example `gemini-2.5-flash-lite` for
/// `google/gemini-2.5-flash-lite:free`.
String shortModelName(String model) {
  var name = model.trim();
  final int slash = name.lastIndexOf('/');
  if (slash >= 0 && slash < name.length - 1) name = name.substring(slash + 1);
  final int colon = name.indexOf(':');
  if (colon > 0) name = name.substring(0, colon);
  return name;
}

final RegExp _variationPattern = RegExp(
  r'^(Vibrant|Soft|Contrast|Warm|Cool):\s*(.+)$',
);
final RegExp _nearbyPattern = RegExp(r'^Nearby hue harmony \((\d+)deg\)$');
final RegExp _shadowPattern = RegExp(r'^Shadow tone \((\d+)% darker\)$');

/// The note the AI layer writes when it fell back without a typed reason.
const String aiFellBackNote = 'AI unavailable. Showing local suggestions.';
const String _fellBackPrefix = 'AI unavailable (';
const String _fellBackSuffix = ') Showing local suggestions.';
