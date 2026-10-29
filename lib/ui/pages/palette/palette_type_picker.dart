import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/models.dart';
import '../../../core/palette_generator.dart';
import '../../../core/scene_catalog.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/color_swatch_tile.dart';
import '../../widgets/ink_search_field.dart';
import '../../widgets/ink_sheet.dart';
import '../../widgets/section_card.dart';

// The palette type and the scene of the palette page: two rectangular fields
// that open bottom sheets. The type sheet lists the colour-theory modes and
// "Scenes"; the scene sheet lists the scenes grouped by category.

/// What the user chose in the palette type sheet.
sealed class PaletteTypeChoice {
  const PaletteTypeChoice();
}

/// A colour-theory mode.
final class ModeChoice extends PaletteTypeChoice {
  const ModeChoice(this.mode);
  final PaletteMode mode;
}

/// The scenes (a second field then picks which one).
final class ScenesChoice extends PaletteTypeChoice {
  const ScenesChoice();
}

/// Colour-theory modes in the order the type sheet lists them.
const List<PaletteMode> paletteTypeModes = <PaletteMode>[
  PaletteMode.recommended,
  PaletteMode.complementary,
  PaletteMode.analogous,
  PaletteMode.splitComplementary,
  PaletteMode.triad,
  PaletteMode.square,
  PaletteMode.rectangle,
  PaletteMode.monochrome,
  PaletteMode.shadow,
  PaletteMode.customPalette,
];

/// The one-line explanation of [mode] in the type sheet.
String paletteModeDescription(AppLocalizations t, PaletteMode mode) =>
    switch (mode) {
      PaletteMode.recommended => t.paletteTypeDescRecommended,
      PaletteMode.complementary => t.paletteTypeDescComplementary,
      PaletteMode.analogous => t.paletteTypeDescAnalogous,
      PaletteMode.splitComplementary => t.paletteTypeDescSplitComplementary,
      PaletteMode.triad => t.paletteTypeDescTriad,
      PaletteMode.square => t.paletteTypeDescSquare,
      PaletteMode.rectangle => t.paletteTypeDescRectangle,
      PaletteMode.monochrome => t.paletteTypeDescMonochrome,
      PaletteMode.shadow => t.paletteTypeDescShadow,
      PaletteMode.customPalette => t.paletteTypeDescCustomPalette,
    };

// -----------------------------------------------------------------------------
// Field
// -----------------------------------------------------------------------------

/// A rectangular choice field: a caps label, then a box (the look of the
/// base-marker field) that shows the current choice and opens a sheet.
class PaletteChoiceField extends StatelessWidget {
  const PaletteChoiceField({
    super.key,
    required this.label,
    required this.semanticLabel,
    required this.onTap,
    required this.child,
    this.leading,
    this.fieldKey,
  });

  /// Caps label above the box.
  final String label;

  /// What a screen reader says for the whole field.
  final String semanticLabel;

  /// Opens the sheet; `null` disables the field (while it is busy).
  final VoidCallback? onTap;

  /// The current choice.
  final Widget child;

  /// Optional glyph before [child].
  final Widget? leading;

  /// Key of the tappable box.
  final Key? fieldKey;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          AppTypography.caps(label),
          style: AppTypography.capsStyle.copyWith(color: ink.fg2),
        ),
        const SizedBox(height: InkSpacing.group),
        Semantics(
          button: true,
          enabled: onTap != null,
          label: semanticLabel,
          excludeSemantics: true,
          onTap: onTap,
          child: Material(
            color: ink.surface,
            shape: RoundedRectangleBorder(
              borderRadius: InkRadii.inputRadius,
              side: BorderSide(color: ink.strong),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              key: fieldKey,
              onTap: onTap,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: InkGeometry.fieldHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: InkSpacing.s12,
                    vertical: InkSpacing.s8,
                  ),
                  child: Row(
                    children: <Widget>[
                      if (leading != null) ...<Widget>[
                        leading!,
                        const SizedBox(width: InkSpacing.s12),
                      ],
                      Expanded(child: child),
                      const SizedBox(width: InkSpacing.s8),
                      InkIcon(
                        InkIcons.chevronDown,
                        size: InkGeometry.mediumIcon,
                        color: ink.fg2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// Glyphs
// -----------------------------------------------------------------------------

/// Side of the glyph box of a palette sheet row (type, scene, source) and of
/// the photo thumbnail that stands in for it.
const double kPaletteGlyphSize = 32;

/// A line icon in the glyph box of a palette sheet row.
class PaletteIconGlyph extends StatelessWidget {
  const PaletteIconGlyph(this.icon, {super.key, this.selected = false});

  final InkIcons icon;

  /// Whether the row is the current choice (the icon takes the action colour).
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return SizedBox.square(
      dimension: kPaletteGlyphSize,
      child: Center(
        child: InkIcon(
          icon,
          size: InkGeometry.iconSize,
          color: selected ? ink.action : ink.fg2,
        ),
      ),
    );
  }
}

/// A colour strip of up to a handful of marker colours (a scene preview).
///
/// Plain coloured boxes with a hairline outline, so many of them stay cheap
/// in a long list. An empty [hexes] draws an empty outline.
class SceneStrip extends StatelessWidget {
  const SceneStrip({
    super.key,
    required this.hexes,
    this.width,
    this.height = 16,
  });

  final List<String> hexes;
  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return ExcludeSemantics(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: InkRadii.xsRadius,
          border: Border.all(color: ink.line),
        ),
        child: ClipRRect(
          borderRadius: InkRadii.xsRadius,
          child: SizedBox(
            width: width,
            height: height,
            child: Row(
              children: <Widget>[
                for (final String hex in hexes)
                  Expanded(
                    child: ColoredBox(
                      color: swatchColor(hex),
                      child: const SizedBox.expand(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A tiny drawing of a palette type: the hues of a colour-theory mode on the
/// wheel, or a few bars for the modes that are not about hue.
class PaletteModeGlyph extends StatelessWidget {
  const PaletteModeGlyph({
    super.key,
    required this.mode,
    this.size = kPaletteGlyphSize,
  });

  final PaletteMode mode;
  final double size;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return ExcludeSemantics(
      child: SizedBox.square(
        dimension: size,
        child: CustomPaint(
          painter: _ModeGlyphPainter(mode, ink.strong, ink.fg2, ink.surface),
        ),
      ),
    );
  }
}

/// The glyph of the "Scenes" type: four bars of a sample scene.
class ScenesGlyph extends StatelessWidget {
  const ScenesGlyph({super.key, this.size = kPaletteGlyphSize});

  final double size;

  static const List<String> _sample = <String>[
    'e9b872',
    'c8704f',
    '6f8fb4',
    '3e5c76',
  ];

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: size,
    child: Center(
      child: SceneStrip(hexes: _sample, width: size, height: 20),
    ),
  );
}

class _ModeGlyphPainter extends CustomPainter {
  _ModeGlyphPainter(this.mode, this.ring, this.line, this.halo);

  final PaletteMode mode;
  final Color ring, line, halo;

  /// Hue offsets (degrees) of the wheel modes.
  static const Map<PaletteMode, List<double>> _wheel =
      <PaletteMode, List<double>>{
        PaletteMode.complementary: <double>[0, 180],
        PaletteMode.analogous: <double>[-30, 0, 30],
        PaletteMode.splitComplementary: <double>[0, 150, 210],
        PaletteMode.triad: <double>[0, 120, 240],
        PaletteMode.square: <double>[0, 90, 180, 270],
        PaletteMode.rectangle: <double>[0, 60, 180, 240],
      };

  static const double _baseHue = 200;

  static Color _hsv(double hue, double s, double v) =>
      HSVColor.fromAHSV(1, (hue % 360 + 360) % 360, s, v).toColor();

  @override
  void paint(Canvas canvas, Size size) {
    final List<double>? hues = _wheel[mode];
    if (hues != null) {
      _paintWheel(canvas, size, hues);
    } else {
      _paintBars(canvas, size);
    }
  }

  void _paintWheel(Canvas canvas, Size size, List<double> hues) {
    final Offset centre = size.center(Offset.zero);
    final double radius = size.shortestSide / 2 - 4;
    canvas.drawCircle(
      centre,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = ring,
    );
    final List<Offset> points = <Offset>[
      for (final double h in hues)
        centre + Offset.fromDirection((h - 90) * math.pi / 180, radius),
    ];
    if (points.length > 1) {
      final Path path = Path()..moveTo(points.first.dx, points.first.dy);
      for (final Offset p in points.skip(1)) {
        path.lineTo(p.dx, p.dy);
      }
      if (points.length > 2) path.close();
      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = line.withValues(alpha: 0.6),
      );
    }
    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i], 4.5, Paint()..color = halo);
      canvas.drawCircle(
        points[i],
        3.5,
        Paint()..color = _hsv(_baseHue + hues[i], 0.62, 0.9),
      );
    }
  }

  void _paintBars(Canvas canvas, Size size) {
    final List<Color?> bars = switch (mode) {
      PaletteMode.recommended => <Color?>[
        _hsv(_baseHue, 0.55, 0.9),
        _hsv(_baseHue + 150, 0.5, 0.92),
        _hsv(_baseHue + 20, 0.3, 0.97),
        _hsv(_baseHue - 40, 0.6, 0.6),
      ],
      PaletteMode.monochrome => <Color?>[
        _hsv(_baseHue, 0.18, 0.98),
        _hsv(_baseHue, 0.4, 0.86),
        _hsv(_baseHue, 0.6, 0.68),
        _hsv(_baseHue, 0.75, 0.46),
      ],
      PaletteMode.shadow => <Color?>[
        _hsv(_baseHue, 0.55, 0.85),
        _hsv(_baseHue, 0.62, 0.62),
        _hsv(_baseHue, 0.7, 0.42),
        _hsv(_baseHue, 0.74, 0.24),
      ],
      _ => <Color?>[null, null, null], // custom: empty slots
    };
    final double barWidth = size.width / bars.length;
    final double top = size.height * 0.2, bottom = size.height * 0.8;
    for (int i = 0; i < bars.length; i++) {
      final Rect rect = Rect.fromLTRB(
        i * barWidth + 1,
        top,
        (i + 1) * barWidth - 1,
        bottom,
      );
      final RRect rrect = RRect.fromRectAndRadius(
        rect,
        const Radius.circular(InkRadii.xs / 2),
      );
      final Color? colour = bars[i];
      if (colour == null) {
        canvas.drawRRect(
          rrect,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.2
            ..color = ring,
        );
      } else {
        canvas.drawRRect(rrect, Paint()..color = colour);
      }
    }
  }

  @override
  bool shouldRepaint(_ModeGlyphPainter old) =>
      old.mode != mode ||
      old.ring != ring ||
      old.line != line ||
      old.halo != halo;
}

// -----------------------------------------------------------------------------
// Scene previews
// -----------------------------------------------------------------------------

/// Preview colours of scenes against a whole brand range (never only the
/// markers the user owns), computed on demand and kept.
class ScenePreviews {
  ScenePreviews(this.range);

  /// Every marker of the brand.
  final List<MarkerColor> range;

  final Map<String, List<String>> _cache = <String, List<String>>{};

  /// Hex colours (base first) of [scene].
  List<String> of(Scene scene) => _cache.putIfAbsent(
    scene.id,
    () => <String>[
      for (final MarkerColor c in scenePreviewColors(scene, range)) c.hex,
    ],
  );
}

// -----------------------------------------------------------------------------
// Type sheet
// -----------------------------------------------------------------------------

/// Opens the palette type sheet; resolves to the choice, or `null` when it is
/// dismissed.
Future<PaletteTypeChoice?> showPaletteTypeSheet(
  BuildContext context, {
  required PaletteMode mode,
  required bool scenesSelected,
  required bool scenesAvailable,
}) => showInkSheet<PaletteTypeChoice>(
  context: context,
  builder: (BuildContext context) => _TypeSheet(
    mode: mode,
    scenesSelected: scenesSelected,
    scenesAvailable: scenesAvailable,
  ),
);

class _TypeSheet extends StatelessWidget {
  const _TypeSheet({
    required this.mode,
    required this.scenesSelected,
    required this.scenesAvailable,
  });

  final PaletteMode mode;
  final bool scenesSelected, scenesAvailable;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations t = context.l10n;
    return Column(
      key: const ValueKey<String>('palette-type-sheet'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: InkSpacing.sheetCloseClearance),
          child: Semantics(
            header: true,
            child: Text(
              t.paletteTypeSheetTitle,
              style: AppTypography.section.copyWith(color: ink.fg),
            ),
          ),
        ),
        const SizedBox(height: InkSpacing.block),
        Flexible(
          // A few rows only: all of them are built, none lazily.
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                InkGroupHead(t.paletteTypeTheoryGroup),
                for (final PaletteMode m in paletteTypeModes)
                  PaletteChoiceRow(
                    rowKey: ValueKey<String>('palette-mode-${m.name}'),
                    glyph: PaletteModeGlyph(mode: m),
                    title: t.modeLabel(m),
                    description: paletteModeDescription(t, m),
                    selected: !scenesSelected && mode == m,
                    onTap: () => Navigator.of(context).pop(ModeChoice(m)),
                  ),
                if (scenesAvailable) ...<Widget>[
                  const SizedBox(height: InkSpacing.block),
                  InkGroupHead(t.paletteTypeScenesGroup),
                  PaletteChoiceRow(
                    rowKey: const ValueKey<String>('palette-scenario-toggle'),
                    glyph: const ScenesGlyph(),
                    title: t.paletteScenarioToggle,
                    description: t.paletteTypeScenesHint,
                    selected: scenesSelected,
                    onTap: () =>
                        Navigator.of(context).pop(const ScenesChoice()),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// A row of a palette sheet: a glyph, a one-line title, an optional one-line
/// explanation and a check slot (always reserved, so rows do not shift).
class PaletteChoiceRow extends StatelessWidget {
  const PaletteChoiceRow({
    super.key,
    required this.rowKey,
    required this.glyph,
    required this.title,
    required this.selected,
    required this.onTap,
    this.description,
  });

  final Key rowKey;
  final Widget glyph;
  final String title;
  final String? description;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: InkSpacing.s4),
      child: MergeSemantics(
        child: Semantics(
          button: true,
          selected: selected,
          child: Material(
            color: selected ? ink.pale : Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: InkRadii.controlRadius,
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              key: rowKey,
              onTap: onTap,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: InkGeometry.target,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: InkSpacing.s12,
                    vertical: InkSpacing.s8,
                  ),
                  child: Row(
                    children: <Widget>[
                      glyph,
                      const SizedBox(width: InkSpacing.s12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              title,
                              key: ValueKey<String>(
                                'palette-type-title-${(rowKey as ValueKey<String>).value}',
                              ),
                              style: AppTypography.button.copyWith(
                                color: selected ? ink.action : ink.fg,
                              ),
                            ),
                            if (description != null)
                              Text(
                                description!,
                                key: ValueKey<String>(
                                  'palette-type-desc-${(rowKey as ValueKey<String>).value}',
                                ),
                                style: AppTypography.secondary.copyWith(
                                  color: ink.fg2,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: InkSpacing.s8),
                      SizedBox.square(
                        dimension: InkGeometry.smallIcon,
                        child: selected
                            ? InkIcon(
                                InkIcons.check,
                                size: InkGeometry.smallIcon,
                                color: ink.action,
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Scene sheet
// -----------------------------------------------------------------------------

/// Lower-cases [text] and strips the accents, so "dragon" finds "Dragón".
String foldForSearch(String text) {
  const String from = 'àáâãäåçèéêëìíîïñòóôõöùúûüýÿ';
  const String to = 'aaaaaaceeeeiiiinooooouuuuyy';
  final StringBuffer out = StringBuffer();
  for (final int unit in text.toLowerCase().runes) {
    final String ch = String.fromCharCode(unit);
    final int at = from.indexOf(ch);
    out.write(at < 0 ? ch : to[at]);
  }
  return out.toString();
}

/// What the user chose in the scene sheet.
sealed class SceneSheetResult {
  const SceneSheetResult();
}

/// A scene of the catalogue.
final class ScenePicked extends SceneSheetResult {
  const ScenePicked(this.scene);
  final Scene scene;
}

/// "From a photo": the colours of a photo, matched to the user's markers.
final class PhotoScenePicked extends SceneSheetResult {
  const PhotoScenePicked();
}

/// Opens the tall scene sheet; resolves to what was picked, or `null` when it
/// is dismissed.
///
/// [selected] is the scene in use, or `null` while a photo palette is shown
/// ([photoSelected]).
Future<SceneSheetResult?> showPaletteSceneSheet(
  BuildContext context, {
  required Scene? selected,
  required ScenePreviews previews,
  bool photoSelected = false,
}) => showInkSheet<SceneSheetResult>(
  context: context,
  builder: (BuildContext context) => _SceneSheet(
    selected: selected,
    previews: previews,
    photoSelected: photoSelected,
  ),
);

sealed class _SceneItem {
  const _SceneItem();
}

/// The "From a photo" entry, above the categories.
final class _PhotoItem extends _SceneItem {
  const _PhotoItem();
}

final class _CategoryItem extends _SceneItem {
  const _CategoryItem(this.id, {required this.first});
  final String id;
  final bool first;
}

final class _SceneEntry extends _SceneItem {
  const _SceneEntry(this.scene);
  final Scene scene;
}

class _SceneSheet extends StatefulWidget {
  const _SceneSheet({
    required this.selected,
    required this.previews,
    required this.photoSelected,
  });

  final Scene? selected;
  final ScenePreviews previews;
  final bool photoSelected;

  @override
  State<_SceneSheet> createState() => _SceneSheetState();
}

class _SceneSheetState extends State<_SceneSheet> {
  String _query = '';

  /// Search text of every scene: both names and both category names.
  late final Map<String, String> _haystack = _buildHaystack();

  Map<String, String> _buildHaystack() {
    final AppLocalizations en = lookupAppLocalizations(const Locale('en'));
    final AppLocalizations es = lookupAppLocalizations(const Locale('es'));
    return <String, String>{
      for (final Scene s in SceneCatalog.current.scenes)
        s.id: foldForSearch(
          '${s.nameFor('en')} ${s.nameFor('es')} '
          '${en.sceneCategoryLabel(s.category)} '
          '${es.sceneCategoryLabel(s.category)}',
        ),
    };
  }

  /// Search text of the photo entry (both languages).
  static final String _photoHaystack = foldForSearch('photo foto');

  bool _matches(Scene scene, List<String> tokens) {
    final String text = _haystack[scene.id]!;
    return tokens.every(text.contains);
  }

  List<_SceneItem> _items() {
    final SceneCatalog catalog = SceneCatalog.current;
    final List<String> tokens = foldForSearch(_query)
        .split(RegExp(r'\s+'))
        .where((String t) => t.isNotEmpty)
        .toList();
    final List<_SceneItem> items = <_SceneItem>[
      if (tokens.every(_photoHaystack.contains)) const _PhotoItem(),
    ];
    for (final String category in catalog.categories) {
      final List<Scene> scenes = <Scene>[
        for (final Scene s in catalog.inCategory(category))
          if (_matches(s, tokens)) s,
      ];
      if (scenes.isEmpty) continue;
      items.add(_CategoryItem(category, first: items.isEmpty));
      items.addAll(scenes.map(_SceneEntry.new));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations t = context.l10n;
    final MediaQueryData media = MediaQuery.of(context);
    final double height =
        (media.size.height - media.padding.top - media.viewInsets.bottom) *
        0.78;
    final List<_SceneItem> items = _items();
    return Padding(
      padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
      child: SizedBox(
        key: const ValueKey<String>('palette-scene-sheet'),
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                right: InkSpacing.sheetCloseClearance,
              ),
              child: Semantics(
                header: true,
                child: Text(
                  t.paletteSceneSheetTitle,
                  style: AppTypography.section.copyWith(color: ink.fg),
                ),
              ),
            ),
            const SizedBox(height: InkSpacing.block),
            InkSearchField(
              key: const ValueKey<String>('palette-scene-search'),
              hintText: t.paletteSceneSearchHint,
              semanticLabel: t.paletteSceneSearchHint,
              onChanged: (String value) => setState(() => _query = value),
            ),
            const SizedBox(height: InkSpacing.s8),
            Expanded(
              child: items.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: InkSpacing.block),
                      child: Text(
                        t.paletteSceneEmpty,
                        key: const ValueKey<String>('palette-scene-empty'),
                        style: AppTypography.secondary.copyWith(color: ink.fg2),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        final _SceneItem item = items[index];
                        return switch (item) {
                          _PhotoItem() => PaletteChoiceRow(
                            rowKey: const ValueKey<String>(
                              'palette-scene-photo',
                            ),
                            glyph: PaletteIconGlyph(
                              InkIcons.camera,
                              selected: widget.photoSelected,
                            ),
                            title: t.paletteFromPhotoTitle,
                            description: t.paletteFromPhotoHint,
                            selected: widget.photoSelected,
                            onTap: () =>
                                Navigator.of(context)
                                    .pop(const PhotoScenePicked()),
                          ),
                          _CategoryItem() => Padding(
                            key: ValueKey<String>(
                              'palette-scene-category-${item.id}',
                            ),
                            padding: EdgeInsets.only(
                              top: item.first
                                  ? InkSpacing.s4
                                  : InkSpacing.block,
                            ),
                            child: InkGroupHead(t.sceneCategoryLabel(item.id)),
                          ),
                          _SceneEntry() => _SceneRow(
                            scene: item.scene,
                            hexes: widget.previews.of(item.scene),
                            selected: item.scene == widget.selected,
                            onTap: () =>
                                Navigator.of(context)
                                    .pop(ScenePicked(item.scene)),
                          ),
                        };
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SceneRow extends StatelessWidget {
  const _SceneRow({
    required this.scene,
    required this.hexes,
    required this.selected,
    required this.onTap,
  });

  final Scene scene;
  final List<String> hexes;
  final bool selected;
  final VoidCallback onTap;

  static const double _stripWidth = 72;
  // Check icon slot (always reserved so rows do not shift) plus its gap.
  static const double _checkSlot = InkGeometry.mediumIcon + InkSpacing.s12;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final String name = context.l10n.scenarioLabel(scene);
    final TextStyle style = AppTypography.button.copyWith(
      color: selected ? ink.action : ink.fg,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: InkSpacing.s4),
      child: MergeSemantics(
        child: Semantics(
          button: true,
          selected: selected,
          child: Material(
            color: selected ? ink.pale : Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: InkRadii.controlRadius,
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              key: ValueKey<String>('palette-scene-${scene.id}'),
              onTap: onTap,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: InkGeometry.target,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: InkSpacing.s12,
                    vertical: InkSpacing.s8,
                  ),
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints box) {
                      // Name and strip share a line when they fit; a long name
                      // (or large text) puts the strip under it instead of
                      // cutting or wrapping the name.
                      final TextPainter painter = TextPainter(
                        text: TextSpan(text: name, style: style),
                        textDirection: Directionality.of(context),
                        textScaler: MediaQuery.textScalerOf(context),
                        maxLines: 1,
                      )..layout();
                      final double needed =
                          painter.width +
                          InkSpacing.s12 +
                          _stripWidth +
                          _checkSlot;
                      painter.dispose();
                      final Text label = Text(
                        name,
                        key: ValueKey<String>('palette-scene-name-${scene.id}'),
                        style: style,
                      );
                      final Widget check = Padding(
                        padding: const EdgeInsets.only(left: InkSpacing.s12),
                        child: SizedBox.square(
                          dimension: InkGeometry.mediumIcon,
                          child: selected
                              ? InkIcon(
                                  InkIcons.check,
                                  size: InkGeometry.mediumIcon,
                                  color: ink.action,
                                )
                              : null,
                        ),
                      );
                      if (needed <= box.maxWidth) {
                        return Row(
                          children: <Widget>[
                            Expanded(child: label),
                            const SizedBox(width: InkSpacing.s12),
                            SceneStrip(hexes: hexes, width: _stripWidth),
                            check,
                          ],
                        );
                      }
                      return Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                label,
                                const SizedBox(height: InkSpacing.s6),
                                SceneStrip(hexes: hexes, width: _stripWidth),
                              ],
                            ),
                          ),
                          check,
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
