import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/models.dart';
import '../../../data/data.dart';
import '../../widgets/ink_segmented.dart';
import 'settings_widgets.dart';
import '../../../l10n/l10n.dart';

/// How the marker codes and names are shown in the app.
///
/// Renders the row of the "Display" card; the page owns the group.
class LabelsSection extends StatelessWidget {
  const LabelsSection({super.key, required this.scope, required this.state});

  /// The app services.
  final AppScope scope;

  /// The current settings snapshot.
  final AppSettingsState state;

  @override
  Widget build(BuildContext context) {
    return SettingsControlRow(
      label: context.l10n.settingsLabelsTitle,
      control: InkSegmented<NameDisplayMode>(
        semanticLabel: context.l10n.settingsLabelsTitle,
        segments: <InkSegment<NameDisplayMode>>[
          InkSegment<NameDisplayMode>(
            value: NameDisplayMode.newOnly,
            label: context.l10n.settingsNewLabels,
          ),
          InkSegment<NameDisplayMode>(
            value: NameDisplayMode.oldOnly,
            label: context.l10n.settingsOldLabels,
          ),
          InkSegment<NameDisplayMode>(
            value: NameDisplayMode.both,
            label: context.l10n.settingsBothLabels,
          ),
        ],
        selected: state.nameDisplayMode,
        onChanged: (NameDisplayMode mode) =>
            scope.settings.setNameDisplayMode(mode),
      ),
    );
  }
}
