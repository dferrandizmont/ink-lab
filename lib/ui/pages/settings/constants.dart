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

  /// Placeholder of the maximum tokens field.
  static const String aiMaxTokensHint = '1200';

  /// Placeholder of the API key field.
  static const String aiApiKeyHint = 'sk-or-...';
}
