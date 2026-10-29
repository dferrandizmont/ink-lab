import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/collection_selection.dart';
import '../../../core/models.dart';
import '../../../data/data.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_search_field.dart';
import '../../widgets/section_card.dart';
import 'dialogs.dart';
import 'settings_widgets.dart';
import '../../../l10n/l10n.dart';

/// The manager of the markers the user owns.
///
/// The owned markers are stored brand-scoped (`<brandId>:<code>`), which is
/// the shape the core collection rules expect. DecoTime only shows the
/// colors of the owned markers, so this manager is where that list is kept.
/// Renders rows of the "Collection" card; the page owns the group.
class OwnedMarkersSection extends StatefulWidget {
  const OwnedMarkersSection({
    super.key,
    required this.scope,
    required this.state,
  });

  /// The app services.
  final AppScope scope;

  /// The current settings snapshot.
  final AppSettingsState state;

  @override
  State<OwnedMarkersSection> createState() => _OwnedMarkersSectionState();
}

class _OwnedMarkersSectionState extends State<OwnedMarkersSection> {
  final TextEditingController _search = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final MarkerBrand brand = widget.state.brand;
    final Set<String> owned = scopedCodesForBrand(
      widget.state.settings.ownedMarkerCodes,
      brand.id,
    );

    return FutureBuilder<List<MarkerColor>>(
      future: widget.scope.markers.loadColors(brand),
      builder:
          (BuildContext context, AsyncSnapshot<List<MarkerColor>> snapshot) {
            final List<MarkerColor> colors =
                (snapshot.data ?? const <MarkerColor>[])
                    .where((MarkerColor color) => color.brandId == brand.id)
                    .toList();
            final List<MarkerColor> visible = colors
                .where(_matches)
                .toList(growable: false);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                InkListRow(
                  label: context.l10n.settingsOwnedTitle,
                  value: context.l10n.settingsOwnedCount(
                    owned.length,
                    colors.length,
                  ),
                  valueIsData: true,
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    InkSpacing.cardH,
                    InkSpacing.cardV,
                    InkSpacing.cardH,
                    0,
                  ),
                  child: InkSearchField(
                    controller: _search,
                    hintText: context.l10n.settingsOwnedSearchHint,
                    onChanged: (String value) =>
                        setState(() => _query = value.trim().toLowerCase()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    InkSpacing.s4,
                    InkSpacing.group,
                    InkSpacing.s4,
                    InkSpacing.s4,
                  ),
                  child: Wrap(
                    children: <Widget>[
                      InkButton.text(
                        label: context.l10n.settingsSelectAll,
                        onPressed: visible.isEmpty
                            ? null
                            : () => _selectAll(visible),
                      ),
                      InkButton.text(
                        label: context.l10n.settingsSelectNone,
                        onPressed: visible.isEmpty
                            ? null
                            : () => _selectNone(visible),
                      ),
                      InkButton.text(
                        label: context.l10n.settingsClearOwned,
                        onPressed: owned.isEmpty
                            ? null
                            : () => _clearAll(brand),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                if (visible.isEmpty)
                  SettingsCaption(context.l10n.settingsOwnedEmpty)
                else
                  SizedBox(
                    height: 320,
                    child: ListView.builder(
                      itemCount: visible.length,
                      itemBuilder: (BuildContext context, int index) {
                        final MarkerColor color = visible[index];
                        return CheckboxListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: InkSpacing.cardH,
                          ),
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: owned.contains(color.newCode.toUpperCase()),
                          onChanged: (bool? value) =>
                              _toggle(color, value ?? false),
                          title: Text(
                            color.newCode,
                            style: AppTypography.code.copyWith(color: ink.fg),
                          ),
                          subtitle: Text(
                            color.newName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          secondary: SwatchBlock(hex: color.hex, size: 36),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
    );
  }

  bool _matches(MarkerColor color) {
    if (_query.isEmpty) return true;
    return color.newCode.toLowerCase().contains(_query) ||
        color.oldCode.toLowerCase().contains(_query) ||
        color.newName.toLowerCase().contains(_query) ||
        color.oldName.toLowerCase().contains(_query);
  }

  Future<void> _toggle(MarkerColor color, bool value) async {
    final Set<String> next = {...widget.state.settings.ownedMarkerCodes};
    final String id = color.colorId;
    if (value) {
      next.add(id);
    } else {
      next.remove(id);
      if (widget.state.brand == MarkerBrand.ohuhuOahu) {
        // The legacy store kept the codes of Ohuhu without a brand prefix.
        next.remove(color.newCode.toUpperCase());
      }
    }
    await widget.scope.settings.setOwnedMarkerCodes(next);
  }

  Future<void> _selectAll(List<MarkerColor> visible) async {
    final Set<String> next = {...widget.state.settings.ownedMarkerCodes};
    for (final MarkerColor color in visible) {
      next.add(color.colorId);
    }
    await widget.scope.settings.setOwnedMarkerCodes(next);
  }

  Future<void> _selectNone(List<MarkerColor> visible) async {
    final Set<String> next = {...widget.state.settings.ownedMarkerCodes};
    for (final MarkerColor color in visible) {
      next.remove(color.colorId);
      if (widget.state.brand == MarkerBrand.ohuhuOahu) {
        next.remove(color.newCode.toUpperCase());
      }
    }
    await widget.scope.settings.setOwnedMarkerCodes(next);
  }

  Future<void> _clearAll(MarkerBrand brand) async {
    final bool confirmed = await confirmAction(
      context,
      title: context.l10n.settingsClearOwnedTitle,
      body: context.l10n.settingsClearOwnedBody,
      confirmLabel: context.l10n.settingsClearOwned,
    );
    if (!confirmed) return;
    final Set<String> next = {...widget.state.settings.ownedMarkerCodes}
      ..removeWhere((String id) => colorIdBelongsToBrand(id, brand));
    await widget.scope.settings.setOwnedMarkerCodes(next);
  }
}
