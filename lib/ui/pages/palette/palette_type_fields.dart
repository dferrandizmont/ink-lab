import 'package:flutter/material.dart';

import '../../../core/color_utils.dart';
import '../../../core/models.dart';
import '../../../core/photo_palette.dart';
import '../../../l10n/l10n.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import 'palette_layout.dart';
import 'palette_photo_scene.dart';
import 'palette_type_picker.dart';

/// The palette type field and, once Scenes is the type, the scene field.
class PaletteTypeFields extends StatelessWidget {
  const PaletteTypeFields({
    super.key,
    required this.useScenario,
    required this.mode,
    required this.scenario,
    required this.photoScene,
    required this.photoBusy,
    required this.previews,
    required this.photoPicks,
    required this.onPickType,
    required this.onPickScene,
  });

  /// Whether Scenes is the type in use.
  final bool useScenario;
  final PaletteMode mode;

  /// The scene in use (when [useScenario] and no photo).
  final Scene scenario;

  /// The photo the palette was built from, or `null`.
  final PhotoScene? photoScene;
  final bool photoBusy;
  final ScenePreviews previews;
  final List<PhotoMarkerPick> photoPicks;
  final VoidCallback onPickType;
  final VoidCallback onPickScene;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations t = context.l10n;
    final InkColors ink = InkColors.of(context);
    final String typeName = useScenario
        ? t.paletteScenarioToggle
        : t.modeLabel(mode);
    final Widget type = PaletteChoiceField(
      label: t.paletteTypeTitle,
      semanticLabel: t.paletteTypeSemantic(typeName),
      fieldKey: const ValueKey<String>('palette-type-field'),
      onTap: onPickType,
      leading: useScenario ? const ScenesGlyph() : PaletteModeGlyph(mode: mode),
      child: Text(
        typeName,
        key: const ValueKey<String>('palette-type-value'),
        style: AppTypography.button.copyWith(color: ink.fg),
      ),
    );
    if (!useScenario) return paletteInset(type, top: InkSpacing.block);
    final PhotoScene? photo = photoScene;
    final Scene scene = scenario;
    final String sceneName = photo != null
        ? t.paletteFromPhotoValue
        : t.scenarioLabel(scene);
    final Widget sceneValue = photoBusy
        ? Row(
            children: <Widget>[
              SizedBox.square(
                dimension: InkGeometry.smallIcon,
                child: CircularProgressIndicator(
                  key: const ValueKey<String>('palette-photo-busy'),
                  strokeWidth: 2,
                  color: ink.action,
                ),
              ),
              const SizedBox(width: InkSpacing.s8),
              Expanded(
                child: Text(
                  t.matchLoadingPhoto,
                  key: const ValueKey<String>('palette-scene-value'),
                  style: AppTypography.button.copyWith(color: ink.fg2),
                ),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                sceneName,
                key: const ValueKey<String>('palette-scene-value'),
                style: AppTypography.button.copyWith(color: ink.fg),
              ),
              const SizedBox(height: InkSpacing.s8),
              SceneStrip(
                key: photo == null
                    ? null
                    : const ValueKey<String>('palette-photo-strip'),
                hexes: photo == null
                    ? previews.of(scene)
                    : <String>[
                        for (final PhotoMarkerPick pick in photoPicks)
                          colorIntToHex(pick.source.colorInt),
                      ],
                height: 16,
              ),
            ],
          );
    return paletteInset(
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          type,
          const SizedBox(height: InkSpacing.block),
          PaletteChoiceField(
            label: t.paletteSceneTitle,
            semanticLabel: photoBusy
                ? t.matchLoadingPhoto
                : t.paletteSceneSemantic(sceneName),
            fieldKey: const ValueKey<String>('palette-scene-field'),
            onTap: photoBusy ? null : onPickScene,
            leading: photo == null || photoBusy
                ? null
                : PhotoThumb(
                    key: const ValueKey<String>('palette-photo-thumb'),
                    image: photo.thumbnail,
                  ),
            child: sceneValue,
          ),
        ],
      ),
      top: InkSpacing.block,
    );
  }
}
