import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../share/share_sink.dart';
import '../../widgets/section_card.dart';
import 'blend_recipes_page.dart';
import 'collection_transfer_page.dart';
import 'colour_map_page.dart';
import 'recipe_translate_page.dart';

/// The entries of the "Tools" group of My collection that open a page of
/// their own: the colour map, the recipe translator, the user's blending
/// recipes and the export / import of the collection.
///
/// The rows are plain navigable list rows, so the group stays short and its
/// height never depends on the collection.
List<Widget> collectionToolRows(BuildContext context, {ShareSink? shareSink}) {
  final AppLocalizations l10n = context.l10n;
  return <Widget>[
    InkListRow(
      key: const ValueKey<String>('tools-map'),
      label: l10n.toolsMapTitle,
      subtitle: l10n.toolsMapHint,
      chevron: true,
      onTap: () => ColourMapPage.open(context),
    ),
    InkListRow(
      key: const ValueKey<String>('tools-translate'),
      label: l10n.toolsTranslateTitle,
      subtitle: l10n.toolsTranslateHint,
      chevron: true,
      onTap: () => RecipeTranslatePage.open(context, shareSink: shareSink),
    ),
    InkListRow(
      key: const ValueKey<String>('tools-recipes'),
      label: l10n.toolsBlendsTitle,
      subtitle: l10n.toolsBlendsHint,
      chevron: true,
      onTap: () => BlendRecipesPage.open(context),
    ),
    InkListRow(
      key: const ValueKey<String>('tools-transfer'),
      label: l10n.toolsTransferTitle,
      subtitle: l10n.toolsTransferHint,
      chevron: true,
      onTap: () => CollectionTransferPage.open(context, shareSink: shareSink),
    ),
  ];
}
