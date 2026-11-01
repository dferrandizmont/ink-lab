import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../data/data.dart';
import '../../../l10n/l10n.dart';
import 'settings_widgets.dart';

/// System / Español / English / Deutsch / Français / Português / Italiano
/// language of the app.
///
/// Renders the "Language" row of the "Display" card; the page owns the group.
/// "System" follows the device (any of the six languages, else English).
/// Seven options do not fit side by side, so it is a radio list.
class LanguageSection extends StatelessWidget {
  const LanguageSection({super.key, required this.scope, required this.state});

  /// The app services.
  final AppScope scope;

  /// The current settings snapshot.
  final AppSettingsState state;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    // Each language is named in itself, whatever the current language.
    final List<(AppLanguage, String)> options = <(AppLanguage, String)>[
      (AppLanguage.system, l10n.settingsLanguageSystem),
      (AppLanguage.spanish, l10n.settingsLanguageSpanish),
      (AppLanguage.english, l10n.settingsLanguageEnglish),
      (AppLanguage.german, l10n.settingsLanguageGerman),
      (AppLanguage.french, l10n.settingsLanguageFrench),
      (AppLanguage.portuguese, l10n.settingsLanguagePortuguese),
      (AppLanguage.italian, l10n.settingsLanguageItalian),
    ];
    return SettingsControlRow(
      label: l10n.settingsLanguageTitle,
      stacked: true,
      control: Semantics(
        container: true,
        label: l10n.settingsLanguageTitle,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            for (final (AppLanguage language, String label) in options)
              SettingsRadioRow(
                key: ValueKey<String>('language-${language.toJson()}'),
                label: label,
                selected: state.language == language,
                onTap: () => scope.settings.setLanguage(language),
              ),
          ],
        ),
      ),
    );
  }
}
