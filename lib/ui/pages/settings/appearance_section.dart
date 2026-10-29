import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../data/data.dart';
import '../../widgets/ink_segmented.dart';
import 'settings_widgets.dart';
import '../../../l10n/l10n.dart';

/// System / Light / Dark appearance.
///
/// Renders the "Appearance" row of the "Display" card; the page owns the group.
class AppearanceSection extends StatelessWidget {
  const AppearanceSection({
    super.key,
    required this.scope,
    required this.state,
  });

  /// The app services.
  final AppScope scope;

  /// The current settings snapshot.
  final AppSettingsState state;

  @override
  Widget build(BuildContext context) {
    return SettingsControlRow(
      label: context.l10n.settingsAppearanceTitle,
      control: InkSegmented<AppThemeMode>(
        semanticLabel: context.l10n.settingsAppearanceTitle,
        segments: <InkSegment<AppThemeMode>>[
          InkSegment<AppThemeMode>(
            value: AppThemeMode.system,
            label: context.l10n.settingsAppearanceSystem,
          ),
          InkSegment<AppThemeMode>(
            value: AppThemeMode.light,
            label: context.l10n.settingsAppearanceLight,
          ),
          InkSegment<AppThemeMode>(
            value: AppThemeMode.dark,
            label: context.l10n.settingsAppearanceDark,
          ),
        ],
        selected: state.themeMode,
        onChanged: (AppThemeMode mode) => scope.settings.setThemeMode(mode),
      ),
    );
  }
}
