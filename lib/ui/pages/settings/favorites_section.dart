import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/models.dart';
import '../../../data/data.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_overflow_menu.dart';
import '../../widgets/ink_sheet.dart';
import '../../widgets/section_card.dart';
import 'dialogs.dart';
import '../../../l10n/l10n.dart';

/// Room for the "⋯" menu and the close button that float at the top right
/// of a sheet: the clearance of the close button plus the menu button and
/// the gap between them.
const double _actionsClearance =
    InkSpacing.sheetCloseClearance + InkGeometry.target + InkSpacing.s4;

/// The manager of the favorite colors of the active brand.
///
/// Favorites are brand-scoped, so the manager only shows (and only removes)
/// the favorites of the brand that is active. The list can be long, so it
/// does not live in the page: the row is a summary with the number of
/// favorites that opens a draggable sheet, where every row can be removed
/// and where the "⋯" menu clears them all. Renders one row of the "Your
/// data" card; the page owns the group.
class FavoritesSection extends StatelessWidget {
  const FavoritesSection({super.key, required this.scope, required this.state});

  /// Key of the summary row.
  static const Key rowKey = ValueKey<String>('settings-favorites-row');

  /// The app services.
  final AppScope scope;

  /// The current settings snapshot.
  final AppSettingsState state;

  @override
  Widget build(BuildContext context) {
    return InkListRow(
      key: rowKey,
      label: context.l10n.settingsFavoritesTitle,
      value: '${_favoritesOf(state).length}',
      chevron: true,
      onTap: () => showFavoritesSheet(context, scope: scope),
    );
  }
}

/// The favorites of the brand that is active, sorted by code.
List<String> _favoritesOf(AppSettingsState state) {
  final MarkerBrand brand = state.brand;
  return state.favorites
      .where((String id) => colorIdBelongsToBrand(id, brand))
      .toList()
    ..sort();
}

/// Opens the favorites of the active brand in a draggable sheet.
///
/// The list can grow without bound, so it does not belong inline: it lives
/// behind this sheet, where every row can be removed and where the "⋯" menu
/// clears them all.
Future<void> showFavoritesSheet(
  BuildContext context, {
  required AppScope scope,
}) {
  final AppLocalizations l10n = context.l10n;
  return showInkDraggableSheet<void>(
    context: context,
    actions: <Widget>[
      InkOverflowMenu(
        key: const ValueKey<String>('settings-favorites-menu'),
        items: <InkMenuItem>[
          InkMenuItem(
            key: const ValueKey<String>('settings-favorites-clear'),
            label: l10n.settingsClearFavorites,
            icon: InkIcons.trash2,
            destructive: true,
            onSelected: () => _clearAllFavorites(context, scope: scope),
          ),
        ],
      ),
    ],
    builder: (BuildContext context, ScrollController scroll) =>
        _FavoritesSheet(scope: scope, controller: scroll),
  );
}

/// Removes every favorite of the brand that is active, after asking.
Future<void> _clearAllFavorites(
  BuildContext context, {
  required AppScope scope,
}) async {
  final MarkerBrand brand = scope.settings.state.brand;
  final bool any = scope.settings.state.favorites.any(
    (String id) => colorIdBelongsToBrand(id, brand),
  );
  // Nothing to clear: no question.
  if (!any) return;
  final bool confirmed = await confirmAction(
    context,
    title: context.l10n.settingsClearFavoritesTitle,
    body: context.l10n.settingsClearFavoritesBody,
    confirmLabel: context.l10n.settingsClearFavorites,
  );
  if (!confirmed) return;
  final Set<String> next = scope.settings.state.favorites
      .where((String id) => !colorIdBelongsToBrand(id, brand))
      .toSet();
  await scope.settings.setFavorites(next);
}

/// The list of favorites inside the draggable sheet.
class _FavoritesSheet extends StatelessWidget {
  const _FavoritesSheet({required this.scope, required this.controller});

  final AppScope scope;

  /// The scroll of the sheet: the drag on the content resizes the sheet.
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return StreamBuilder<AppSettingsState>(
      stream: scope.settings.changes,
      initialData: scope.settings.state,
      builder:
          (BuildContext context, AsyncSnapshot<AppSettingsState> snapshot) {
            final AppSettingsState state =
                snapshot.data ?? scope.settings.state;
            final List<String> favorites = _favoritesOf(state);
            return FutureBuilder<List<MarkerColor>>(
              future: scope.markers.loadColors(state.brand),
              builder:
                  (
                    BuildContext context,
                    AsyncSnapshot<List<MarkerColor>> colors,
                  ) {
                    final List<MarkerColor> known =
                        colors.data ?? const <MarkerColor>[];
                    return ListView(
                      key: const ValueKey<String>('settings-favorites-list'),
                      controller: controller,
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        _SheetHeading(l10n.settingsFavoritesTitle),
                        if (favorites.isEmpty)
                          _SheetNote(l10n.settingsFavoritesEmpty)
                        else
                          for (final String id in favorites) ...<Widget>[
                            const Divider(),
                            _FavoriteTile(
                              colorId: id,
                              color: _findColor(known, id),
                              onDelete: () => _remove(id),
                            ),
                          ],
                      ],
                    );
                  },
            );
          },
    );
  }

  /// Removes one favorite; the list follows the settings.
  Future<void> _remove(String colorId) async {
    final Set<String> next = {...scope.settings.state.favorites}
      ..remove(colorId);
    await scope.settings.setFavorites(next);
  }
}

/// The color of the catalogue with [colorId], when it is still known.
MarkerColor? _findColor(List<MarkerColor> colors, String colorId) {
  final String code = colorId.substring(colorId.indexOf(':') + 1);
  for (final MarkerColor color in colors) {
    if (color.newCode.toUpperCase() == code) return color;
  }
  return null;
}

/// The title of the sheet, with room for the actions at its top right.
class _SheetHeading extends StatelessWidget {
  const _SheetHeading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: _actionsClearance),
      child: Semantics(
        header: true,
        child: Text(text, style: AppTypography.section.copyWith(color: ink.fg)),
      ),
    );
  }
}

/// A line of `secondary` text in `fg2` inside the sheet.
class _SheetNote extends StatelessWidget {
  const _SheetNote(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: InkSpacing.group),
      child: Text(
        text,
        style: AppTypography.secondary.copyWith(color: ink.fg2),
      ),
    );
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
    // Not a ListTile: inside a sheet its background would hide the splash.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: InkSpacing.s8),
      child: Row(
        children: <Widget>[
          known == null
              ? Container(
                  width: InkGeometry.swatchRow,
                  height: InkGeometry.swatchRow,
                  decoration: BoxDecoration(
                    color: ink.bg,
                    borderRadius: InkRadii.cellRadius,
                    border: Border.all(color: ink.line),
                  ),
                )
              : SwatchBlock(
                  hex: known.hex,
                  size: InkGeometry.swatchRow,
                  own: known.hasOwnColor,
                ),
          const SizedBox(width: InkSpacing.s12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(code, style: AppTypography.code.copyWith(color: ink.fg)),
                if (known != null) ...<Widget>[
                  const SizedBox(height: InkSpacing.s4),
                  Text(
                    known.newName,
                    style: AppTypography.secondary.copyWith(color: ink.fg2),
                  ),
                ],
              ],
            ),
          ),
          InkIconButton(
            icon: InkIcons.star,
            selected: true,
            tooltip: context.l10n.settingsDeleteFavorite,
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
