import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/models.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_adaptive.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/ink_button.dart';
import '../diary/diary_widgets.dart';
import '../match/image_picker_service.dart';
import 'blend_recipe_page.dart';

/// "My recipes": the blends the user saved, the last one edited first. Each
/// card shows the name, the markers in order as small colour swatches and the
/// photo if there is one; tapping it opens the recipe to edit.
class BlendRecipesPage extends StatelessWidget {
  const BlendRecipesPage({super.key, this.picker});

  /// Photo picker handed on to the recipe form. Production wraps
  /// `image_picker`; tests inject a fake.
  final ImagePickerService? picker;

  /// Key of the page body.
  static const Key pageKey = Key('blend-recipes-page');

  /// Pushes the page on the nearest navigator.
  static Future<void> open(
    BuildContext context, {
    ImagePickerService? picker,
  }) => AppScope.push(context, BlendRecipesPage(picker: picker));

  @override
  Widget build(BuildContext context) {
    final AppScope scope = AppScope.of(context);
    final AppLocalizations l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.toolsBlendsTitle)),
      body: InkReadableWidth(
        child: StreamBuilder<List<BlendRecipe>>(
          stream: scope.blendRecipes.changes,
          initialData: scope.blendRecipes.recipes,
          builder: (BuildContext context, AsyncSnapshot<List<BlendRecipe>> s) {
            final List<BlendRecipe> recipes = s.data ?? const <BlendRecipe>[];
            return ListView(
              key: pageKey,
              padding: EdgeInsets.fromLTRB(
                InkSpacing.gutter,
                InkSpacing.group,
                InkSpacing.gutter,
                InkSpacing.pageBottomOf(context),
              ),
              children: <Widget>[
                InkButton(
                  key: const ValueKey<String>('recipes-add'),
                  label: l10n.toolsBlendsNew,
                  icon: InkIcons.plus,
                  expand: true,
                  onPressed: () =>
                      BlendRecipePage.open(context, picker: picker),
                ),
                const SizedBox(height: InkSpacing.block),
                if (recipes.isEmpty)
                  EmptyState(
                    key: const ValueKey<String>('recipes-empty'),
                    title: l10n.toolsBlendsEmptyTitle,
                    message: l10n.toolsBlendsEmptyBody,
                    icon: InkIcons.droplet,
                  )
                else
                  for (final BlendRecipe recipe in recipes) ...<Widget>[
                    _RecipeCard(recipe: recipe, picker: picker),
                    const SizedBox(height: InkSpacing.buttonGap),
                  ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({required this.recipe, required this.picker});

  final BlendRecipe recipe;
  final ImagePickerService? picker;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    final String? photo = recipe.photo;
    return Card(
      child: InkWell(
        key: ValueKey<String>('recipe-card-${recipe.id}'),
        borderRadius: InkRadii.cardRadius,
        onTap: () =>
            BlendRecipePage.open(context, recipe: recipe, picker: picker),
        child: Padding(
          padding: InkSpacing.card,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Semantics(
                      header: true,
                      child: Text(
                        recipe.title,
                        style: AppTypography.body.copyWith(color: ink.fg),
                      ),
                    ),
                    const SizedBox(height: InkSpacing.s4),
                    Text(
                      l10n.collectionMarkers(recipe.markerIds.length),
                      style: AppTypography.secondary.copyWith(color: ink.fg2),
                    ),
                    if (recipe.markerIds.isNotEmpty) ...<Widget>[
                      const SizedBox(height: InkSpacing.group),
                      DiaryMarkerDots(ids: recipe.markerIds),
                    ],
                  ],
                ),
              ),
              if (photo != null) ...<Widget>[
                const SizedBox(width: InkSpacing.s12),
                ArtworkPhoto(
                  key: ValueKey<String>('recipe-card-photo-${recipe.id}'),
                  name: photo,
                  size: InkGeometry.thumbLarge,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
