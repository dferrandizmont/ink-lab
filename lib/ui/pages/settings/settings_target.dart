import 'package:flutter/foundation.dart';

/// A part of the Settings page other tabs can ask to bring into view.
enum SettingsTarget {
  /// The owned markers manager of the "Collection" group.
  ownedMarkers,
}

/// Hand-off slot between any page and the Settings page.
///
/// A page sets it and asks the shell to open the Settings tab; the Settings
/// page scrolls to the target and consumes it by setting the value back to
/// `null`, exactly like `paletteDraft`.
final ValueNotifier<SettingsTarget?> settingsTarget =
    ValueNotifier<SettingsTarget?>(null);
