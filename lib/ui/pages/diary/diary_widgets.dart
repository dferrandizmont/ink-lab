import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/models.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/palette_strip.dart';

/// The saved palette with [id], looked for in every brand, or `null` when it
/// was deleted since the entry linked to it.
SavedPalette? findSavedPalette(AppScope scope, String id) {
  for (final MarkerBrand brand in MarkerBrand.values) {
    for (final SavedPalette palette in scope.savedPalettes.palettesOf(brand)) {
      if (palette.id == id) return palette;
    }
  }
  return null;
}

/// The marker ids (`brandId:CODE`) a saved palette holds.
List<String> paletteMarkerIds(SavedPalette palette) => <String>[
  for (final String code in palette.colorCodes)
    '${palette.brandId}:${code.toUpperCase()}',
];

/// Resolves marker ids to their colours (own colours applied) and hands them
/// to [builder]; ids the catalogue does not know are left out of the map.
///
/// The catalogues load once per brand and come back from the repository's
/// cache, so a list of these is cheap.
class MarkerLookup extends StatefulWidget {
  const MarkerLookup({super.key, required this.ids, required this.builder});

  /// The `brandId:CODE` ids to resolve.
  final List<String> ids;

  final Widget Function(BuildContext context, Map<String, MarkerColor> colors)
  builder;

  @override
  State<MarkerLookup> createState() => _MarkerLookupState();
}

class _MarkerLookupState extends State<MarkerLookup> {
  AppScope? _scope;
  Future<Map<String, MarkerColor>>? _future;
  String _signature = '';

  Set<MarkerBrand> get _brands => <MarkerBrand>{
    for (final String id in widget.ids)
      if (id.contains(':'))
        MarkerBrand.fromId(id.substring(0, id.indexOf(':'))),
  };

  Future<Map<String, MarkerColor>> _load(AppScope scope) async {
    final Set<String> wanted = widget.ids.toSet();
    final Map<String, MarkerColor> found = <String, MarkerColor>{};
    for (final MarkerBrand brand in _brands) {
      List<MarkerColor> colors;
      try {
        colors = await scope.markers.loadColors(brand);
      } catch (_) {
        colors = const <MarkerColor>[];
      }
      for (final MarkerColor color in colors) {
        if (wanted.contains(color.colorId)) found[color.colorId] = color;
      }
    }
    return found;
  }

  @override
  Widget build(BuildContext context) {
    final AppScope scope = AppScope.of(context);
    final String signature =
        '${widget.ids.join(',')}|${scope.markers.colorRevision}';
    if (!identical(scope, _scope) || signature != _signature) {
      _scope = scope;
      _signature = signature;
      _future = _load(scope);
    }
    return FutureBuilder<Map<String, MarkerColor>>(
      future: _future,
      builder: (
        BuildContext context,
        AsyncSnapshot<Map<String, MarkerColor>> s,
      ) => widget.builder(context, s.data ?? const <String, MarkerColor>{}),
    );
  }
}

/// The markers of an entry as small colour swatches, in the order picked.
/// Markers the catalogue does not know are left out.
class DiaryMarkerDots extends StatelessWidget {
  const DiaryMarkerDots({super.key, required this.ids});

  final List<String> ids;

  @override
  Widget build(BuildContext context) {
    if (ids.isEmpty) return const SizedBox.shrink();
    return MarkerLookup(
      ids: ids,
      builder: (BuildContext context, Map<String, MarkerColor> colors) {
        final List<MarkerColor> known = <MarkerColor>[
          for (final String id in ids) ?colors[id],
        ];
        if (known.isEmpty) return const SizedBox.shrink();
        return Semantics(
          container: true,
          label: known.map((MarkerColor c) => c.newCode).join(', '),
          child: ExcludeSemantics(
            child: Wrap(
              spacing: InkSpacing.s4,
              runSpacing: InkSpacing.s4,
              children: <Widget>[
                for (final MarkerColor color in known)
                  SwatchBlock(
                    hex: color.hex,
                    size: 20,
                    radius: InkRadii.xs,
                    own: color.hasOwnColor,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// A saved palette as one colour strip.
class DiaryPaletteStrip extends StatelessWidget {
  const DiaryPaletteStrip({
    super.key,
    required this.palette,
    this.colorHeight = 14,
  });

  final SavedPalette palette;
  final double colorHeight;

  @override
  Widget build(BuildContext context) {
    final List<String> ids = paletteMarkerIds(palette);
    return MarkerLookup(
      ids: ids,
      builder: (BuildContext context, Map<String, MarkerColor> colors) {
        final List<String> hexes = <String>[
          for (final String id in ids) ?colors[id]?.hex,
        ];
        if (hexes.isEmpty) return SizedBox(height: colorHeight);
        return ExcludeSemantics(
          child: PaletteStrip(
            colors: hexes,
            colorHeight: colorHeight,
            radius: InkRadii.xs,
          ),
        );
      },
    );
  }
}

/// One photo of the diary, read from the private folder and drawn square.
/// A photo whose file is missing draws nothing.
class ArtworkPhoto extends StatefulWidget {
  const ArtworkPhoto({
    super.key,
    required this.name,
    required this.size,
    this.onTap,
  });

  /// File name in the private artwork folder.
  final String name;
  final double size;

  /// Called with the bytes once they are read.
  final void Function(Uint8List bytes)? onTap;

  @override
  State<ArtworkPhoto> createState() => _ArtworkPhotoState();
}

class _ArtworkPhotoState extends State<ArtworkPhoto> {
  AppScope? _scope;
  Future<Uint8List?>? _bytes;
  String? _name;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppScope scope = AppScope.of(context);
    if (identical(scope, _scope) && widget.name == _name) return;
    _scope = scope;
    _name = widget.name;
    _bytes = scope.artworkDiary.photoBytes(widget.name);
  }

  @override
  void didUpdateWidget(ArtworkPhoto oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.name != widget.name) {
      _name = widget.name;
      _bytes = _scope!.artworkDiary.photoBytes(widget.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return FutureBuilder<Uint8List?>(
      future: _bytes,
      builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
        final Uint8List? bytes = snapshot.data;
        if (snapshot.connectionState == ConnectionState.done && bytes == null) {
          return const SizedBox.shrink();
        }
        return SizedBox.square(
          dimension: widget.size,
          child: bytes == null
              ? DecoratedBox(
                  decoration: BoxDecoration(
                    color: ink.surface,
                    borderRadius: InkRadii.controlRadius,
                    border: Border.all(color: ink.line),
                  ),
                )
              : DiaryPhotoImage(
                  bytes: bytes,
                  size: widget.size,
                  onTap: widget.onTap == null
                      ? null
                      : () => widget.onTap!(bytes),
                ),
        );
      },
    );
  }
}

/// A square thumbnail of [bytes]: control radius, `line` outline, cover fit.
class DiaryPhotoImage extends StatelessWidget {
  const DiaryPhotoImage({
    super.key,
    required this.bytes,
    required this.size,
    this.onTap,
    this.semanticLabel,
  });

  final Uint8List bytes;
  final double size;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final double pixels = MediaQuery.devicePixelRatioOf(context) * size;
    return Semantics(
      button: onTap != null,
      image: true,
      label: semanticLabel ?? context.l10n.diaryPhotosTitle,
      excludeSemantics: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: InkRadii.controlRadius,
          border: Border.all(color: ink.line),
        ),
        child: ClipRRect(
          borderRadius: InkRadii.controlRadius,
          child: InkWell(
            onTap: onTap,
            child: Image.memory(
              bytes,
              width: size,
              height: size,
              fit: BoxFit.cover,
              cacheWidth: pixels.ceil(),
              gaplessPlayback: true,
              errorBuilder: (BuildContext context, Object error, _) => Center(
                child: InkIcon(
                  InkIcons.image,
                  size: InkGeometry.iconSize,
                  color: ink.fg2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
