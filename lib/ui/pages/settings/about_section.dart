import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/section_card.dart';
import 'dialogs.dart';
import 'constants.dart';
import 'settings_widgets.dart';
import '../../../l10n/l10n.dart';

/// The version, the source code and the disclaimer of the project.
///
/// Renders rows of the "About" card; the page owns the group.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        InkListRow(
          label: context.l10n.settingsVersion,
          value: SettingsConstants.appVersion,
          valueIsData: true,
        ),
        const Divider(),
        ListTile(
          contentPadding: const EdgeInsets.only(
            left: InkSpacing.cardH,
            right: 4,
          ),
          title: Text(context.l10n.settingsSourceCode),
          subtitle: Text(
            SettingsConstants.repositoryUrl,
            style: AppTypography.data.copyWith(color: ink.fg2),
          ),
          trailing: InkIconButton(
            icon: InkIcons.copy,
            tooltip: context.l10n.settingsCopyRepository,
            onPressed: () => _copyLink(context),
          ),
        ),
        const Divider(),
        SettingsCaption(context.l10n.settingsDisclaimer),
      ],
    );
  }

  Future<void> _copyLink(BuildContext context) async {
    await Clipboard.setData(
      const ClipboardData(text: SettingsConstants.repositoryUrl),
    );
    if (!context.mounted) return;
    showMessage(context, context.l10n.settingsRepositoryCopied);
  }
}
