/// The canonical (English) roles of a palette colour and how a reason or a
/// role is grouped. The core engines and the AI write English, so the grouping
/// works on these ids and the text is localised only when it is drawn (see
/// roleLabel / reasonLabel in l10n/core_labels.dart).
abstract final class PaletteRoles {
  static const String base = 'Base';
  static const String shadow = 'Shadow';
  static const String highlight = 'Highlight';
  static const String neutral = 'Neutral';
  static const String accent = 'Accent';
  static const String complement = 'Complement';
  static const String companion = 'Companion';

  /// The role a generated reason implies ("Darker for depth" is a shadow).
  static String fromReason(String reason) {
    final value = reason.toLowerCase();
    if (value.contains('shadow') ||
        value.contains('depth') ||
        value.contains('darker')) {
      return shadow;
    }
    if (value.contains('highlight') ||
        value.contains('lift') ||
        value.contains('lighter')) {
      return highlight;
    }
    if (value.contains('neutral')) return neutral;
    if (value.contains('contrast') ||
        value.contains('split') ||
        value.contains('complement') ||
        value.contains('triad') ||
        value.contains('square') ||
        value.contains('rectangle') ||
        value.contains('opposite')) {
      return accent;
    }
    return companion;
  }

  /// The paint group of a role: 0 shadows, 1 highlights, 2 accents, 3 the rest.
  static int group(String role) {
    final value = role.toLowerCase();
    if (value.contains(shadow.toLowerCase()) || value.contains('depth')) {
      return 0;
    }
    if (value.contains(highlight.toLowerCase()) || value.contains('light')) {
      return 1;
    }
    if (value.contains(accent.toLowerCase()) ||
        value.contains(complement.toLowerCase()) ||
        value.contains('contrast')) {
      return 2;
    }
    return 3;
  }
}
