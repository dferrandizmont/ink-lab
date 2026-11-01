import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../data/data.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_sheet.dart';
import '../../widgets/section_card.dart';

/// The name of [language] as it is shown in the row and in the picker.
///
/// Each language is named in itself (an endonym), whatever the current
/// language; "System" is the only translated name.
String languageName(AppLocalizations l10n, AppLanguage language) =>
    switch (language) {
      AppLanguage.system => l10n.settingsLanguageSystem,
      AppLanguage.spanish => l10n.settingsLanguageSpanish,
      AppLanguage.english => l10n.settingsLanguageEnglish,
      AppLanguage.german => l10n.settingsLanguageGerman,
      AppLanguage.french => l10n.settingsLanguageFrench,
      AppLanguage.portuguese => l10n.settingsLanguagePortuguese,
      AppLanguage.italian => l10n.settingsLanguageItalian,
    };

/// The "Language" row of the "Display" card: the current choice as its value,
/// a chevron, and a picker sheet on tap.
///
/// The page owns the group. "System" follows the device (any of the supported
/// languages, else English). A list of languages that can keep growing does
/// not belong inline: it lives behind the picker, like the AI models.
class LanguageSection extends StatelessWidget {
  const LanguageSection({super.key, required this.scope, required this.state});

  /// Key of the row.
  static const Key rowKey = ValueKey<String>('settings-language');

  /// The app services.
  final AppScope scope;

  /// The current settings snapshot.
  final AppSettingsState state;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return InkListRow(
      key: rowKey,
      label: l10n.settingsLanguageTitle,
      value: languageName(l10n, state.language),
      chevron: true,
      onTap: () => showLanguagePicker(context, scope: scope),
    );
  }
}

/// Opens the language picker in an [InkSheet]; choosing a language applies it
/// at once and closes the sheet.
Future<void> showLanguagePicker(
  BuildContext context, {
  required AppScope scope,
}) => showInkSheet<void>(
  context: context,
  builder: (BuildContext context) => LanguagePickerSheet(scope: scope),
);

/// System first, then every language by its own name; the current one is
/// ticked. Scrolls when the list does not fit.
class LanguagePickerSheet extends StatelessWidget {
  const LanguagePickerSheet({super.key, required this.scope});

  /// The app services.
  final AppScope scope;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final InkColors ink = InkColors.of(context);
    final AppLanguage current = scope.settings.language;
    final double maxListHeight = MediaQuery.sizeOf(context).height * 0.6;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: InkSpacing.sheetCloseClearance),
          child: Semantics(
            header: true,
            child: Text(
              l10n.settingsLanguageTitle,
              style: AppTypography.section.copyWith(color: ink.fg),
            ),
          ),
        ),
        const SizedBox(height: InkSpacing.block),
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxListHeight),
            child: ListView(
              key: const ValueKey<String>('language-list'),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: <Widget>[
                for (final AppLanguage language in AppLanguage.values)
                  _LanguageRow(
                    key: ValueKey<String>('language-${language.toJson()}'),
                    label: languageName(l10n, language),
                    selected: language == current,
                    onTap: () async {
                      final NavigatorState navigator = Navigator.of(context);
                      await scope.settings.setLanguage(language);
                      await navigator.maybePop();
                    },
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LanguageRow extends StatelessWidget {
  const _LanguageRow({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: selected,
      button: true,
      excludeSemantics: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: InkGeometry.target),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: InkSpacing.s8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    label,
                    style: AppTypography.body.copyWith(color: ink.fg),
                  ),
                ),
                SizedBox(
                  width: 32,
                  child: selected
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: InkIcon(
                            InkIcons.check,
                            size: InkGeometry.mediumIcon,
                            color: ink.action,
                          ),
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
