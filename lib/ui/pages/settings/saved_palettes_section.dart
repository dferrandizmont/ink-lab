import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/models.dart';
import '../../../data/data.dart';
import '../../widgets/section_card.dart';
import '../palette/saved_palettes_sheet.dart';
import '../../../l10n/l10n.dart';

/// The summary row of the palettes saved for the active brand (spec §2.5).
///
/// The list left the screen: the row shows the count and opens the
/// [SavedPalettesSheet], which also carries "Clear all" in its "⋯".
class SavedPalettesSection extends StatelessWidget {
  const SavedPalettesSection({
    super.key,
    required this.scope,
    required this.state,
    required this.palettes,
  });

  /// The app services.
  final AppScope scope;

  /// The current settings snapshot (the brand whose palettes are listed).
  final AppSettingsState state;

  /// The palettes of the active brand.
  final Stream<List<SavedPalette>> palettes;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SavedPalette>>(
      stream: palettes,
      builder:
          (BuildContext context, AsyncSnapshot<List<SavedPalette>> snapshot) {
            final int count = snapshot.data?.length ?? 0;
            return InkListRow(
              key: const ValueKey<String>('settings-saved-palettes'),
              label: context.l10n.settingsPalettesTitle,
              value: '$count',
              chevron: true,
              onTap: () => SavedPalettesSheet.show(
                context,
                scope: scope,
                brand: state.brand,
                allowClearAll: true,
              ),
            );
          },
    );
  }
}
