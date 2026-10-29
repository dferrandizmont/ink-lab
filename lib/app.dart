import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_scope.dart';
import 'data/data.dart';
import 'l10n/l10n.dart';
import 'ui/pages/onboarding/onboarding_page.dart';
import 'ui/shell/app_shell.dart';
import 'ui/theme/app_theme.dart';

/// The root widget of Ink Lab.
///
/// It follows the appearance stored in the app settings (System / Light /
/// Dark). Without an [AppScope] above it (previews) it follows the system.
class InkLabApp extends StatefulWidget {
  const InkLabApp({super.key});

  @override
  State<InkLabApp> createState() => _InkLabAppState();
}

class _InkLabAppState extends State<InkLabApp> {
  AppScope? _scope;
  Stream<AppSettingsState>? _changes;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppScope? scope = context
        .dependOnInheritedWidgetOfExactType<AppScope>();
    if (!identical(scope, _scope)) {
      _scope = scope;
      // Captured once so the StreamBuilder does not resubscribe every build.
      _changes = scope?.settings.changes;
    }
  }

  /// Spanish for any Spanish locale (es, es-MX, es-419...), English otherwise.
  static Locale resolveLocale(
    Locale? locale,
    Iterable<Locale> supportedLocales,
  ) => locale?.languageCode == 'es' ? const Locale('es') : const Locale('en');

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
              state.onboardingCompleted
                  ? const AppShell()
                  : const OnboardingPage(),
            );
          },
    );
  }

  /// The forced locale, or `null` to follow the device. A device in any
  /// Spanish locale resolves to Spanish; every other device gets English.
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
    localeResolutionCallback: resolveLocale,
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light(),
    darkTheme: AppTheme.dark(),
    themeMode: mode,
    home: home,
  );
}
