import '../../../core/app_version.dart' as app_version;

/// Non-translatable constants of the settings screen (brand name, version,
/// links and input placeholders). All user-facing text lives in the ARB files.
abstract final class SettingsConstants {
  /// The app name shown before the version.
  static const String appName = 'Ink Lab';

  /// The version of the app (single source: `core/app_version.dart`).
  static const String appVersion = app_version.appVersion;

  /// Address of the repository of the app.
  static const String repositoryUrl =
      'https://github.com/dferrandizmont/ink-lab';

  /// Address that receives the reports of AI suggestions.
  static const String contactEmail = 'inklab@mainshai.com';

  /// Privacy policy page in each language of the website: English lives at
  /// the root, the others under `/<code>/privacy/`.
  static const String privacyUrlEn = 'https://inklab.mainshai.com/privacy/';
  static const String privacyUrlEs = 'https://inklab.mainshai.com/es/privacy/';
  static const String privacyUrlDe = 'https://inklab.mainshai.com/de/privacy/';
  static const String privacyUrlFr = 'https://inklab.mainshai.com/fr/privacy/';
  static const String privacyUrlPt = 'https://inklab.mainshai.com/pt/privacy/';
  static const String privacyUrlIt = 'https://inklab.mainshai.com/it/privacy/';

  /// The policy page for [languageCode]; English for any other language.
  static String privacyUrlFor(String languageCode) => switch (languageCode) {
    'es' => privacyUrlEs,
    'de' => privacyUrlDe,
    'fr' => privacyUrlFr,
    'pt' => privacyUrlPt,
    'it' => privacyUrlIt,
    _ => privacyUrlEn,
  };

  /// Google group that opens the Google Play beta (closed test) to testers.
  static const String betaGroupUrl =
      'https://groups.google.com/g/ink-lab-testers';

  /// Placeholder of the maximum tokens field.
  static const String aiMaxTokensHint = '1200';

  /// Placeholder of the API key field.
  static const String aiApiKeyHint = 'sk-or-...';
}
