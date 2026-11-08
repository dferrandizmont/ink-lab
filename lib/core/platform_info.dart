import 'dart:io' show Platform;

/// The platform and the system version, for a feedback e-mail and the error
/// log. Nothing that identifies the device: no model, no serial, no IDs.
abstract final class PlatformInfo {
  /// `android`, `ios`, `windows`... (what `dart:io` reports).
  static String get name => Platform.operatingSystem;

  /// The version string `dart:io` reports, on one line and short. On Android
  /// it is the kernel version (cut before the build banner, `#`), on iOS the
  /// system version.
  static String get osVersion =>
      clean(Platform.operatingSystemVersion.split('#').first);

  /// `android (Linux 5.10...)`.
  static String get summary => '$name ($osVersion)';

  /// [text] on one line, at most [max] characters.
  static String clean(String text, {int max = 100}) {
    final String line = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    return line.length <= max ? line : '${line.substring(0, max)}...';
  }
}
