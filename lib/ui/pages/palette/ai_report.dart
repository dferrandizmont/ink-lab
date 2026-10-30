import '../settings/constants.dart';

/// Why the user reports an AI suggestion.
enum AiReportReason {
  offensive('offensive'),
  wrong('wrong'),
  other('other');

  const AiReportReason(this.key);

  /// Stable English key, written in the subject of the email.
  final String key;
}

/// One suggestion shown on screen: the plain values the report quotes.
final class AiReportItem {
  const AiReportItem({
    required this.code,
    required this.role,
    required this.reason,
  });

  final String code;
  final String role;
  final String reason;
}

/// Builds the email that reports an AI suggestion to the developer.
///
/// Pure and free of any secret: it takes plain values only. The page passes
/// the model id, the brand, the mode or scene, the base code and what is shown;
/// never the API key, the photo or any other setting.
abstract final class AiReport {
  /// Longest body, in characters, before the suggestions are cut.
  static const int maxBodyLength = 1500;

  /// Longest reason, role or tip kept per item.
  static const int maxFieldLength = 200;

  static String subject(AiReportReason reason) =>
      'Ink Lab: AI suggestion report (${reason.key})';

  static String _clip(String value) {
    final String flat = value.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (flat.length <= maxFieldLength) return flat;
    return '${flat.substring(0, maxFieldLength - 1)}…';
  }

  static String body({
    required String appVersion,
    required String provider,
    required String model,
    required String brand,
    required String context,
    required String baseCode,
    required List<AiReportItem> items,
    String tips = '',
  }) {
    final StringBuffer head = StringBuffer()
      ..writeln('App version: $appVersion')
      ..writeln('AI provider: $provider')
      ..writeln('Model: ${_clip(model)}')
      ..writeln('Brand: $brand')
      ..writeln('Palette: ${_clip(context)}')
      ..writeln('Base marker: $baseCode')
      ..writeln()
      ..writeln('Suggestions:');
    const String tail = '\nAnything to add:\n';
    final String tipsLine = tips.trim().isEmpty ? '' : 'Tips: ${_clip(tips)}\n';
    final int room =
        maxBodyLength - head.length - tail.length - tipsLine.length;
    final StringBuffer list = StringBuffer();
    for (final AiReportItem item in items) {
      final String line =
          '- ${item.code} | ${_clip(item.role)} | ${_clip(item.reason)}\n';
      if (list.length + line.length > room) break;
      list.write(line);
    }
    return '$head$list$tipsLine$tail';
  }

  /// The `mailto:` address. Subject and body are percent-encoded by hand so
  /// spaces become `%20`, not `+`.
  static Uri mailto({required String subject, required String body}) =>
      Uri.parse(
        'mailto:${SettingsConstants.contactEmail}'
        '?subject=${Uri.encodeComponent(subject)}'
        '&body=${Uri.encodeComponent(body)}',
      );

  /// The same report as plain text, for the clipboard fallback.
  static String plainText({required String subject, required String body}) =>
      'To: ${SettingsConstants.contactEmail}\n'
      'Subject: $subject\n\n$body';
}
