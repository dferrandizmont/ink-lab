import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/widgets.dart';
import 'package:quick_actions/quick_actions.dart';

import '../../l10n/l10n.dart';

/// A jump the user can start from the home screen: the Android long-press menu
/// of the app icon, or the iOS Home Screen quick actions.
enum AppShortcut {
  /// Opens the Match tab.
  match(
    type: 'match_colour',
    destinationId: 'Match',
    androidIcon: 'ic_shortcut_match',
  ),

  /// Opens the Palette tab.
  newPalette(
    type: 'new_palette',
    destinationId: 'Palette',
    androidIcon: 'ic_shortcut_palette',
  ),

  /// Opens the Swatches tab with the search field focused.
  searchSwatches(
    type: 'search_swatches',
    destinationId: 'Swatches',
    androidIcon: 'ic_shortcut_search',
  );

  const AppShortcut({
    required this.type,
    required this.destinationId,
    required this.androidIcon,
  });

  /// The stable, language-independent type the platform hands back when the
  /// shortcut is used.
  final String type;

  /// Id of the shell destination the shortcut opens (`AppDestination.id`).
  final String destinationId;

  /// Name of the drawable under `android/app/src/main/res/drawable/`. iOS has
  /// no icon: `quick_actions` only takes the name of an image of the app's
  /// asset catalogue there, not an SF Symbol.
  final String androidIcon;

  /// The shortcut of a platform [type], or `null` for one this app does not
  /// know (a stale shortcut of an older version).
  static AppShortcut? fromType(String? type) {
    for (final AppShortcut shortcut in values) {
      if (shortcut.type == type) return shortcut;
    }
    return null;
  }

  /// The label in the language of [l10n].
  String label(AppLocalizations l10n) => switch (this) {
    AppShortcut.match => l10n.shortcutMatchLabel,
    AppShortcut.newPalette => l10n.shortcutNewPaletteLabel,
    AppShortcut.searchSwatches => l10n.shortcutSearchSwatchesLabel,
  };
}

/// The shortcut the user used and the app shell has not acted on yet, or
/// `null`. The shell opens the tab and consumes the value by setting it back
/// to `null`, so a shortcut is acted on once. Module-level and tiny, like
/// `ideaDeepLink`: a launch shortcut can arrive before the shell exists.
final ValueNotifier<AppShortcut?> appShortcutRequest =
    ValueNotifier<AppShortcut?>(null);

/// The focus node of the Swatches search field. The page takes it as the
/// field's `focusNode`; the shell asks it for focus after the "Search
/// swatches" shortcut.
final FocusNode swatchesSearchFocus = FocusNode(
  debugLabel: 'SwatchesSearchField',
);

/// Whether the platform has app shortcuts the plugin supports.
bool get _platformHasShortcuts {
  try {
    return Platform.isAndroid || Platform.isIOS;
  } catch (_) {
    return false;
  }
}

/// Publishes the app's shortcuts and reports the ones the user uses.
///
/// Holds no state of its own besides the plugin: [AppShortcutsHost] decides
/// when to publish. [quickActions] is the plugin (tests pass a fake). Without
/// one the service only works on Android and iOS and does nothing elsewhere
/// (desktop, tests), and a failure of the plugin is swallowed: a shortcut that
/// does not work never gets in the way of the app.
class AppShortcutsService {
  AppShortcutsService({QuickActions? quickActions, bool? useIcons})
    : _quickActions =
          quickActions ?? (_platformHasShortcuts ? const QuickActions() : null),
      _useIcons = useIcons ?? _isAndroid;

  final QuickActions? _quickActions;
  final bool _useIcons;

  static bool get _isAndroid {
    try {
      return Platform.isAndroid;
    } catch (_) {
      return false;
    }
  }

  /// Whether there is a plugin to talk to.
  bool get enabled => _quickActions != null;

  /// Starts listening: [onShortcut] gets the shortcut that launched the app
  /// and the ones used while it runs. Unknown types are dropped.
  Future<void> start(void Function(AppShortcut shortcut) onShortcut) async {
    try {
      await _quickActions?.initialize((String type) {
        final AppShortcut? shortcut = AppShortcut.fromType(type);
        if (shortcut != null) onShortcut(shortcut);
      });
    } catch (_) {
      // No shortcut support; the app opens normally.
    }
  }

  /// Sets the shortcuts, labelled in the language of [l10n].
  Future<void> publish(AppLocalizations l10n) async {
    try {
      await _quickActions?.setShortcutItems(<ShortcutItem>[
        for (final AppShortcut shortcut in AppShortcut.values)
          ShortcutItem(
            type: shortcut.type,
            localizedTitle: shortcut.label(l10n),
            icon: _useIcons ? shortcut.androidIcon : null,
          ),
      ]);
    } catch (_) {
      // The old shortcuts stay; nothing else to do.
    }
  }

  /// Removes the shortcuts.
  Future<void> clear() async {
    try {
      await _quickActions?.clearShortcutItems();
    } catch (_) {
      // Nothing to remove.
    }
  }
}

/// Keeps the app shortcuts in step with the app: publishes them in the
/// language the app shows (and again when the user changes it), and hands the
/// ones the user uses to [appShortcutRequest].
///
/// It sits above the first-run setup and the app shell. Until the setup is
/// done the shortcuts are removed and a launch or tap is ignored: the user
/// has not seen the app yet.
class AppShortcutsHost extends StatefulWidget {
  const AppShortcutsHost({
    super.key,
    required this.onboardingCompleted,
    required this.child,
    this.service,
  });

  /// Whether the first-run setup is done.
  final bool onboardingCompleted;

  /// The plugin wrapper; tests pass one over a fake `QuickActions`.
  final AppShortcutsService? service;

  final Widget child;

  @override
  State<AppShortcutsHost> createState() => _AppShortcutsHostState();
}

class _AppShortcutsHostState extends State<AppShortcutsHost> {
  late final AppShortcutsService _service =
      widget.service ?? AppShortcutsService();

  /// What was last published: the language and whether there were shortcuts.
  String? _published;

  @override
  void initState() {
    super.initState();
    unawaited(_service.start(_onShortcut));
  }

  void _onShortcut(AppShortcut shortcut) {
    if (!mounted || !widget.onboardingCompleted) return;
    appShortcutRequest.value = shortcut;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sync();
  }

  @override
  void didUpdateWidget(AppShortcutsHost oldWidget) {
    super.didUpdateWidget(oldWidget);
    _sync();
  }

  /// Publishes the shortcuts when the language or the setup state changed.
  void _sync() {
    final AppLocalizations l10n = context.l10n;
    final String state = widget.onboardingCompleted
        ? l10n.localeName
        : 'onboarding';
    if (state == _published) return;
    _published = state;
    if (widget.onboardingCompleted) {
      unawaited(_service.publish(l10n));
    } else {
      unawaited(_service.clear());
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
