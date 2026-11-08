import 'constants.dart';

/// The e-mail the "Send feedback" row prepares.
///
/// The body is an empty space for the message and three technical lines: the
/// app version, the platform and the system version. Nothing that identifies
/// the device or the user. The user sees it all in their mail app and decides
/// whether to send it.
abstract final class FeedbackEmail {
  static String subject(String appVersion) => 'Ink Lab $appVersion feedback';

  static String body({
    required String appVersion,
    required String platform,
    required String osVersion,
  }) =>
      '\n\n'
      '---\n'
      'App version: $appVersion\n'
      'Platform: $platform\n'
      'System version: $osVersion\n';

  /// The `mailto:` address. Subject and body are percent-encoded by hand so
  /// spaces become `%20`, not `+`.
  static Uri mailto({
    required String appVersion,
    required String platform,
    required String osVersion,
  }) => Uri.parse(
    'mailto:${SettingsConstants.contactEmail}'
    '?subject=${Uri.encodeComponent(subject(appVersion))}'
    '&body=${Uri.encodeComponent(body(appVersion: appVersion, platform: platform, osVersion: osVersion))}',
  );
}
