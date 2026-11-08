import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/collection_wheel.dart';
import '../../../core/models.dart';
import '../../../l10n/l10n.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_adaptive.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/ink_sheet.dart';
import '../../widgets/section_card.dart';
import '../settings/settings_widgets.dart';
import 'collection_snapshot.dart';
import 'colour_map_painter.dart';
import 'tools_widgets.dart';

/// The words for the hue bands of the colour map, in the app's languages.
extension ColourMapLabels on AppLocalizations {
  String hueFamilyLabel(HueFamily family) => switch (family) {
    HueFamily.red => toolsHueRed,
    HueFamily.orange => toolsHueOrange,
    HueFamily.yellow => toolsHueYellow,
    HueFamily.green => toolsHueGreen,
    HueFamily.teal => toolsHueTeal,
    HueFamily.blue => toolsHueBlue,
    HueFamily.violet => toolsHueViolet,
    HueFamily.magenta => toolsHueMagenta,
  };
}

/// "Colour map": the markers the user owns placed by hue and lightness, so a
/// gap in the hues or in the values shows at a glance. The greys have a value
/// strip of their own, the whole range of the user's brands can be laid
/// faintly under the map to see what is missing, and every hue band is also
/// listed as text (the alternative for a screen reader).
class ColourMapPage extends StatefulWidget {
  const ColourMapPage({super.key});

  /// Key of the page body.
  static const Key pageKey = Key('colour-map-page');

  /// Pushes the page on the nearest navigator.
  static Future<void> open(BuildContext context) =>
      AppScope.push(context, const ColourMapPage());

  @override
  State<ColourMapPage> createState() => _ColourMapPageState();
}

/// Height of the map, hue strip included.
const double _mapHeight = 248;

class _MapData {
  _MapData(this.snapshot)
    : wheel = CollectionWheel.of(snapshot.usable),
      rangeDots = <WheelDot>[
        for (final MarkerBrand brand in _rangeBrands(snapshot))
          for (final MarkerColor color in snapshot.rangeOf(brand))
            if (WheelDot.of(color) case final WheelDot dot)
              if (!dot.isGrey) dot,
      ];

  /// The brands whose whole range is laid under the map: the ones the user
  /// owns something of, or the brand of Settings when they own nothing yet.
  static List<MarkerBrand> _rangeBrands(CollectionSnapshot snapshot) {
    final List<MarkerBrand> owned = snapshot.ownedBrands;
    return owned.isEmpty ? <MarkerBrand>[snapshot.activeBrand] : owned;
  }

  final CollectionSnapshot snapshot;
  final CollectionWheel wheel;
  final List<WheelDot> rangeDots;

  bool get mixed => snapshot.ownedBrands.length > 1;
}

class _ColourMapPageState extends State<ColourMapPage> {
  AppScope? _scope;
  Future<_MapData>? _data;
  bool _showRange = false;
  String? _selectedId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppScope scope = AppScope.of(context);
    if (!identical(scope, _scope)) {
      _scope = scope;
      _data = CollectionSnapshot.load(scope).then(_MapData.new);
    }
  }

  Future<void> _showInfo(
    _MapData data,
    WheelDot dot, {
    required bool owned,
  }) async {
    setState(() => _selectedId = dot.color.colorId);
    await showInkSheet<void>(
      context: context,
      builder: (BuildContext context) => ToolsMarkerInfoSheet(
        marker: dot.color,
        owned: owned,
        nameDisplay: _scope!.settings.nameDisplayMode,
      ),
    );
    if (mounted) setState(() => _selectedId = null);
  }

  Future<void> _showFamily(_MapData data, String title, List<WheelDot> dots) =>
      showInkSheet<void>(
        context: context,
        builder: (BuildContext context) => ToolsMarkerListSheet(
          title: title,
          markers: <MarkerColor>[for (final WheelDot d in dots) d.color],
          showBrand: data.mixed,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.toolsMapTitle)),
      body: InkReadableWidth(
        child: FutureBuilder<_MapData>(
          future: _data,
          builder: (BuildContext context, AsyncSnapshot<_MapData> snapshot) {
            final _MapData? data = snapshot.data;
            if (data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            if (data.wheel.coloured.isEmpty && data.wheel.greys.isEmpty) {
              return EmptyState(
                title: context.l10n.toolsMapEmptyTitle,
                message: context.l10n.collectionChartEmpty,
              );
            }
            return _content(context, data);
          },
        ),
      ),
    );
  }

  Widget _content(BuildContext context, _MapData data) {
    final AppLocalizations l10n = context.l10n;
    final InkColors ink = InkColors.of(context);
    final CollectionWheel wheel = data.wheel;
    final TextStyle caption = AppTypography.secondary.copyWith(color: ink.fg2);
    final int markers = wheel.coloured.length + wheel.greys.length;
    final String summary = l10n.toolsMapSummary(
      l10n.collectionMarkers(markers),
      wheel.emptyCells,
      CollectionWheel.cellCount,
    );
    return SingleChildScrollView(
      key: ColourMapPage.pageKey,
      padding: EdgeInsets.fromLTRB(
        InkSpacing.gutter,
        InkSpacing.group,
        InkSpacing.gutter,
        InkSpacing.pageBottomOf(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(l10n.toolsMapIntro, style: caption),
          const SizedBox(height: InkSpacing.block),
          InkListCard(
            children: <Widget>[
              SettingsSwitchRow(
                key: const ValueKey<String>('colour-map-range-switch'),
                label: l10n.toolsMapShowRange,
                subtitle: l10n.toolsMapShowRangeHint,
                value: _showRange,
                onChanged: (bool on) => setState(() => _showRange = on),
              ),
            ],
          ),
          const SizedBox(height: InkSpacing.block),
          _frame(
            context,
            key: const ValueKey<String>('colour-map-chart'),
            height: _mapHeight,
            semanticLabel: summary,
            paint: (Size size) => CustomPaint(
              size: size,
              painter: ColourMapPainter(
                wheel: wheel,
                range: _showRange ? data.rangeDots : const <WheelDot>[],
                colors: ink,
                selectedId: _selectedId,
              ),
            ),
            onTap: (Offset at, Size size) {
              final ColourMapHit? hit = colourMapHit(
                at,
                size,
                wheel,
                range: _showRange ? data.rangeDots : const <WheelDot>[],
              );
              if (hit != null) _showInfo(data, hit.dot, owned: hit.owned);
            },
          ),
          const SizedBox(height: InkSpacing.group),
          Text(l10n.toolsMapAxes, style: caption),
          const SizedBox(height: InkSpacing.section),
          InkGroupHead(
            l10n.toolsMapGreysTitle,
            trailing: '${wheel.greys.length}',
          ),
          _frame(
            context,
            key: const ValueKey<String>('colour-map-greys'),
            height: valueStripHeight,
            semanticLabel:
                '${l10n.toolsMapGreysTitle}: '
                '${l10n.collectionMarkers(wheel.greys.length)}',
            paint: (Size size) => CustomPaint(
              size: size,
              painter: ValueStripPainter(
                greys: wheel.greys,
                colors: ink,
                selectedId: _selectedId,
              ),
            ),
            onTap: (Offset at, Size size) {
              final WheelDot? hit = valueStripHit(at, size, wheel.greys);
              if (hit != null) _showInfo(data, hit, owned: true);
            },
          ),
          const SizedBox(height: InkSpacing.group),
          Text(l10n.toolsMapGreysAxis, style: caption),
          const SizedBox(height: InkSpacing.section),
          InkGroupHead(l10n.toolsMapFamiliesTitle),
          InkListCard(
            children: <Widget>[
              for (final HueFamily family in HueFamily.values)
                _familyRow(context, data, family),
              InkListRow(
                key: const ValueKey<String>('colour-map-family-greys'),
                label: l10n.toolsMapGreysTitle,
                value: '${wheel.greys.length}',
                valueIsData: true,
                chevron: wheel.greys.isNotEmpty,
                onTap: wheel.greys.isEmpty
                    ? null
                    : () => _showFamily(
                        data,
                        l10n.toolsMapGreysTitle,
                        wheel.greys,
                      ),
              ),
            ],
          ),
          const SizedBox(height: InkSpacing.group),
          Text(l10n.toolsMapDriedNote, style: caption),
        ],
      ),
    );
  }

  Widget _familyRow(BuildContext context, _MapData data, HueFamily family) {
    final AppLocalizations l10n = context.l10n;
    final CollectionWheel wheel = data.wheel;
    final int total = wheel.familyCount(family);
    final String bands = l10n.toolsFamilyBands(
      wheel.count(family, LightnessBand.light),
      wheel.count(family, LightnessBand.mid),
      wheel.count(family, LightnessBand.dark),
    );
    return InkListRow(
      key: ValueKey<String>('colour-map-family-${family.name}'),
      label: l10n.hueFamilyLabel(family),
      value: '$total',
      valueIsData: true,
      subtitle: bands,
      chevron: total > 0,
      onTap: total == 0
          ? null
          : () => _showFamily(
              data,
              l10n.hueFamilyLabel(family),
              wheel.inFamily(family),
            ),
    );
  }

  /// A bordered chart of fixed [height]: the paint, a tap that reports where
  /// it landed and one label for a screen reader (the list below says the
  /// rest).
  Widget _frame(
    BuildContext context, {
    required Key key,
    required double height,
    required String semanticLabel,
    required Widget Function(Size size) paint,
    required void Function(Offset at, Size size) onTap,
  }) {
    final InkColors ink = InkColors.of(context);
    return Semantics(
      container: true,
      image: true,
      label: semanticLabel,
      child: ExcludeSemantics(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: ink.surface,
            borderRadius: InkRadii.cardRadius,
            border: Border.all(color: ink.line),
          ),
          child: ClipRRect(
            borderRadius: InkRadii.cardRadius,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final Size size = Size(constraints.maxWidth, height);
                return GestureDetector(
                  key: key,
                  behavior: HitTestBehavior.opaque,
                  onTapUp: (TapUpDetails d) => onTap(d.localPosition, size),
                  child: SizedBox(
                    width: size.width,
                    height: size.height,
                    child: paint(size),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
