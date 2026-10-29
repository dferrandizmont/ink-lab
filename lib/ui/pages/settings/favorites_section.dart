import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/models.dart';
import '../../../data/data.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/section_card.dart';
import 'dialogs.dart';
import 'settings_widgets.dart';
import '../../../l10n/l10n.dart';

/// The manager of the favorite colors of the active brand.
///
/// Favorites are brand-scoped, so the manager only shows (and only removes)
/// the favorites of the brand that is active. Renders rows of the "Your data"
/// card; the page owns the group.
class FavoritesSection extends StatelessWidget {
  const FavoritesSection({super.key, required this.scope, required this.state});

  /// The app services.
  final AppScope scope;

  /// The current settings snapshot.
  final AppSettingsState state;

  @override
  Widget build(BuildContext context) {
    final MarkerBrand brand = state.brand;
    final List<String> favorites =
        state.favorites
            .where((String id) => colorIdBelongsToBrand(id, brand))
            .toList()
          ..sort();

    return FutureBuilder<List<MarkerColor>>(
      future: scope.markers.loadColors(brand),
      builder:
          (BuildContext context, AsyncSnapshot<List<MarkerColor>> snapshot) {
            final List<MarkerColor> colors =
                snapshot.data ?? const <MarkerColor>[];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                InkListRow(
                  label: context.l10n.settingsFavoritesTitle,
                  value: brand.label,
                  trailing: favorites.isEmpty
                      ? null
                      : InkButton.text(
                          label: context.l10n.settingsClearFavorites,
                          onPressed: () => _clearAll(context, brand),
                        ),
                ),
                if (favorites.isEmpty)
                  SettingsCaption(context.l10n.settingsFavoritesEmpty)
                else
                  for (final String id in favorites) ...<Widget>[
                    const Divider(),
                    _FavoriteTile(
                      colorId: id,
                      color: _findColor(colors, id),
                      onDelete: () => _delete(id),
                    ),
                  ],
              ],
            );
          },
    );
  }

  MarkerColor? _findColor(List<MarkerColor> colors, String colorId) {
    final String code = colorId.substring(colorId.indexOf(':') + 1);
    for (final MarkerColor color in colors) {
      if (color.newCode.toUpperCase() == code) return color;
    }
    return null;
  }

  Future<void> _delete(String colorId) async {
    final Set<String> next = {...state.favorites}..remove(colorId);
    await scope.settings.setFavorites(next);
  }

  Future<void> _clearAll(BuildContext context, MarkerBrand brand) async {
    final bool confirmed = await confirmAction(
      context,
      title: context.l10n.settingsClearFavoritesTitle,
      body: context.l10n.settingsClearFavoritesBody,
      confirmLabel: context.l10n.settingsClearFavorites,
    );
    if (!confirmed) return;
    final Set<String> next = state.favorites
        .where((String id) => !colorIdBelongsToBrand(id, brand))
        .toSet();
    await scope.settings.setFavorites(next);
  }
}

/// One favorite color.
class _FavoriteTile extends StatelessWidget {
  const _FavoriteTile({
    required this.colorId,
    required this.color,
    required this.onDelete,
  });

  /// The brand-scoped id of the color.
  final String colorId;

  /// The color of the catalogue, when it is still known.
  final MarkerColor? color;

  /// Called when the user removes the favorite.
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final MarkerColor? known = color;
    final String code = colorId.substring(colorId.indexOf(':') + 1);
    return ListTile(
      contentPadding: const EdgeInsets.only(left: InkSpacing.cardH, right: 4),
      leading: known == null
          ? Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: ink.bg,
                borderRadius: InkRadii.cellRadius,
                border: Border.all(color: ink.line),
              ),
            )
          : SwatchBlock(hex: known.hex, size: 36),
      title: Text(code, style: AppTypography.code.copyWith(color: ink.fg)),
      subtitle: known == null ? null : Text(known.newName),
      trailing: InkIconButton(
        icon: InkIcons.star,
        selected: true,
        tooltip: context.l10n.settingsDeleteFavorite,
        onPressed: onDelete,
      ),
    );
  }
}
