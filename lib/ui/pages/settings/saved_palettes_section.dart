import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/models.dart';
import '../../../data/data.dart';
import '../../icons/ink_icons.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/section_card.dart';
import 'dialogs.dart';
import 'settings_widgets.dart';
import '../../../l10n/l10n.dart';

/// The manager of the palettes saved for the active brand.
///
/// Renders rows of the "Your data" card; the page owns the group.
class SavedPalettesSection extends StatelessWidget {
  const SavedPalettesSection({
    super.key,
    required this.scope,
    required this.state,
    required this.palettes,
  });

  /// The app services.
  final AppScope scope;

  /// The current settings snapshot.
  final AppSettingsState state;

  /// The palettes of the active brand.
  final Stream<List<SavedPalette>> palettes;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SavedPalette>>(
      stream: palettes,
      builder: (BuildContext context, AsyncSnapshot<List<SavedPalette>> snapshot) {
        final List<SavedPalette> saved =
            snapshot.data ?? const <SavedPalette>[];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InkListRow(
              label: context.l10n.settingsPalettesTitle,
              value: state.brand.label,
              trailing: saved.isEmpty
                  ? null
                  : InkButton.text(
                      label: context.l10n.settingsClearPalettes,
                      onPressed: () => _clearAll(context),
                    ),
            ),
            if (saved.isEmpty)
              SettingsCaption(context.l10n.settingsPalettesEmpty)
            else
              for (final SavedPalette palette in saved) ...<Widget>[
                const Divider(),
                ListTile(
                  contentPadding: const EdgeInsets.only(
                    left: InkSpacing.cardH,
                    right: 4,
                  ),
                  title: Text(palette.name),
                  subtitle: Text(
                    '${context.l10n.settingsPaletteDescription(context.l10n.modeLabel(palette.mode), context.l10n.commonColorCount(palette.colorCodes.length))} · ${_formatDate(palette.createdAtEpochMs)}',
                  ),
                  trailing: InkIconButton(
                    icon: InkIcons.trash2,
                    tooltip: context.l10n.settingsDeletePalette,
                    onPressed: () =>
                        scope.savedPalettes.delete(state.brand, palette.id),
                  ),
                ),
              ],
          ],
        );
      },
    );
  }

  Future<void> _clearAll(BuildContext context) async {
    final bool confirmed = await confirmAction(
      context,
      title: context.l10n.settingsClearPalettesTitle,
      body: context.l10n.settingsClearPalettesBody,
      confirmLabel: context.l10n.settingsClearPalettes,
    );
    if (!confirmed) return;
    await scope.savedPalettes.clearBrand(state.brand);
  }
}

/// Formats a timestamp as `yyyy-MM-dd`, without pulling in a date package.
String _formatDate(int epochMs) {
  final DateTime date = DateTime.fromMillisecondsSinceEpoch(epochMs);
  final String month = date.month.toString().padLeft(2, '0');
  final String day = date.day.toString().padLeft(2, '0');
  return '${date.year}-$month-$day';
}
