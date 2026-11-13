import 'dart:async' show unawaited;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_scope.dart';
import 'data/data.dart';
import 'l10n/l10n.dart';
import 'ui/pages/onboarding/onboarding_page.dart';
import 'ui/shell/app_shell.dart';
import 'ui/shell/app_shortcuts.dart';
import 'ui/theme/app_theme.dart';

/// The root widget of Ink Lab.
///
/// It follows the appearance stored in the app settings (System / Light /
/// Dark). Without an [AppScope] above it (previews) it follows the system.
class InkLabApp extends StatefulWidget {
  const InkLabApp({super.key, this.shortcutsService});

  /// The home-screen shortcuts (long-press menu of the app icon). Tests inject
  /// one over a fake plugin; by default it only works on Android and iOS.
  final AppShortcutsService? shortcutsService;

  @override
  State<InkLabApp> createState() => _InkLabAppState();
}

class _InkLabAppState extends State<InkLabApp> {
  AppScope? _scope;
  Stream<AppSettingsState>? _changes;
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(onResume: _recordOpen);
  }

  void _recordOpen() => unawaited(_scope?.reviewPrompt?.recordOpen());

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppScope? scope = context
        .dependOnInheritedWidgetOfExactType<AppScope>();
    if (!identical(scope, _scope)) {
      _scope = scope;
      // Captured once so the StreamBuilder does not resubscribe every build.
      _changes = scope?.settings.changes;
      _recordOpen();
    }
  }

  /// The first of the device's preferred languages that the app has
  /// (English, Spanish, German, French, Portuguese or Italian, whatever the
  /// region: es-MX, pt-BR...), English when none is. A Catalan phone with
  /// Spanish as its second language gets Spanish.
  static Locale resolveLocales(
    List<Locale>? locales,
    Iterable<Locale> supportedLocales,
  ) {
    for (final Locale locale in locales ?? const <Locale>[]) {
      final String code = locale.languageCode;
      if (supportedLocales.any((l) => l.languageCode == code)) {
        return Locale(code);
      }
    }
    return const Locale('en');
  }

  /// Maps the stored appearance to the framework's [ThemeMode].
  static ThemeMode themeModeOf(AppThemeMode mode) => switch (mode) {
    AppThemeMode.system => ThemeMode.system,
    AppThemeMode.light => ThemeMode.light,
    AppThemeMode.dark => ThemeMode.dark,
  };

  @override
  Widget build(BuildContext context) {
    final AppScope? scope = _scope;
    if (scope == null) return _app(ThemeMode.system, null, const AppShell());
    return StreamBuilder<AppSettingsState>(
      stream: _changes,
      initialData: scope.settings.state,
      builder:
          (BuildContext context, AsyncSnapshot<AppSettingsState> snapshot) {
            final AppSettingsState state =
                snapshot.data ?? scope.settings.state;
            // The first-run setup comes before the app until it is done or
            // skipped.
            return _app(
              themeModeOf(state.themeMode),
              localeOf(state.language),
              AppShortcutsHost(
                service: widget.shortcutsService,
                onboardingCompleted: state.onboardingCompleted,
                child: state.onboardingCompleted
                    ? const AppShell()
                    : const OnboardingPage(),
              ),
            );
          },
    );
  }

  /// The forced locale, or `null` to follow the device. A device in a
  /// supported language resolves to it ([resolveLocales]); every other device
  /// gets English.
  static Locale? localeOf(AppLanguage language) {
    final String? code = language.languageCode;
    return code == null ? null : Locale(code);
  }

  Widget _app(ThemeMode mode, Locale? locale, Widget home) => MaterialApp(
    onGenerateTitle: (BuildContext context) => context.l10n.appTitle,
    locale: locale,
    localizationsDelegates: const <LocalizationsDelegate<Object?>>[
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    localeListResolutionCallback: resolveLocales,
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light(),
    darkTheme: AppTheme.dark(),
    themeMode: mode,
    home: home,
  );
}
