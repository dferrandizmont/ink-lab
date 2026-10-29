import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../data/data.dart';
import '../../../l10n/l10n.dart';
import '../../widgets/ink_segmented.dart';
import 'settings_widgets.dart';

/// System / Español / English language of the app.
///
/// Renders the "Language" row of the "Display" card; the page owns the group.
/// "System" follows the device (Spanish for any Spanish locale, else English).
class LanguageSection extends StatelessWidget {
  const LanguageSection({super.key, required this.scope, required this.state});

  /// The app services.
  final AppScope scope;

  /// The current settings snapshot.
  final AppSettingsState state;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return SettingsControlRow(
      label: l10n.settingsLanguageTitle,
      stacked: true,
      control: InkSegmented<AppLanguage>(
        semanticLabel: l10n.settingsLanguageTitle,
        expand: true,
        segments: <InkSegment<AppLanguage>>[
          InkSegment<AppLanguage>(
            value: AppLanguage.system,
            label: l10n.settingsLanguageSystem,
          ),
          // Each language is named in itself, whatever the current language.
          InkSegment<AppLanguage>(
            value: AppLanguage.spanish,
            label: l10n.settingsLanguageSpanish,
          ),
          InkSegment<AppLanguage>(
            value: AppLanguage.english,
            label: l10n.settingsLanguageEnglish,
          ),
        ],
        selected: state.language,
        onChanged: (AppLanguage language) =>
            scope.settings.setLanguage(language),
      ),
    );
  }
}
