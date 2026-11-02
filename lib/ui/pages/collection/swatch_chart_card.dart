import 'package:flutter/material.dart';

import '../../../core/models.dart';
import '../../../core/swatch_chart_layout.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../share/share_actions.dart';
import '../../share/share_sink.dart';
import '../../share/swatch_chart_renderer.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_disclosure.dart';
import '../settings/settings_widgets.dart';

/// The "Printable swatch chart" card of My collection: what the chart will
/// hold, the switch for the catalogue colour and the button that renders the
/// A4 pages and hands them to the system share sheet.
///
/// Folded (spec §2.6): its summary says how many markers and pages it holds;
/// the switch and the button are inside.
class SwatchChartCard extends StatefulWidget {
  const SwatchChartCard({
    super.key,
    required this.brand,
    required this.markers,
    required this.nameDisplay,
    this.shareSink,
  });

  /// The brand of the active collection.
  final MarkerBrand brand;

  /// The markers of the active collection (any order; the chart sorts them).
  final List<MarkerColor> markers;

  /// How codes and names are written under each box.
  final NameDisplayMode nameDisplay;

  /// Where the pages go. Production opens the system share sheet; tests inject
  /// a fake.
  final ShareSink? shareSink;

  @override
  State<SwatchChartCard> createState() => _SwatchChartCardState();
}

class _SwatchChartCardState extends State<SwatchChartCard> {
  bool _showColour = false;
  bool _busy = false;
  bool _open = false;

  ShareSink get _sink => widget.shareSink ?? const SystemShareSink();

  Future<void> _share() async {
    if (_busy || widget.markers.isEmpty) return;
    final AppLocalizations l10n = context.l10n;
    final ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(
      context,
    );
    final SwatchChartSpec spec = SwatchChartSpec(
      brand: widget.brand.label,
      title: l10n.chartImageTitle,
      pageLabel: (int page, int count) => l10n.chartImagePage(page, count),
      showCatalogueColour: _showColour,
      markers: <ChartMarker>[
        for (final MarkerColor marker in chartMarkers(widget.markers))
          ChartMarker(
            code: marker.displayCode(widget.nameDisplay),
            name: marker.displayName(widget.nameDisplay),
            hex: marker.hex,
          ),
      ],
    );
    setState(() => _busy = true);
    try {
      await shareSwatchChart(_sink, spec);
    } catch (_) {
      messenger
        ?..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            key: const ValueKey<String>('collection-chart-failed'),
            content: Text(l10n.shareFailed),
          ),
        );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final int count = widget.markers.length;
    final int pages = const SwatchChartLayout().pageCount(count);
    return InkDisclosure(
      key: const ValueKey<String>('collection-chart'),
      title: l10n.collectionChartTitle,
      subtitle: count == 0
          ? l10n.collectionChartEmpty
          : '${l10n.collectionMarkers(count)} · ${l10n.collectionChartPages(pages)}',
      expanded: _open,
      onToggle: () => setState(() => _open = !_open),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SettingsSwitchRow(
            key: const ValueKey<String>('collection-chart-colour'),
            label: l10n.collectionChartShowColour,
            subtitle: l10n.collectionChartShowColourHint,
            value: _showColour,
            onChanged: (bool on) => setState(() => _showColour = on),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              InkSpacing.cardH,
              InkSpacing.cardV,
              InkSpacing.cardH,
              InkSpacing.cardV,
            ),
            child: InkButton.secondary(
              key: const ValueKey<String>('collection-chart-share'),
              label: _busy
                  ? l10n.collectionChartPreparing
                  : l10n.collectionChartCreate,
              icon: InkIcons.share,
              expand: true,
              loading: _busy,
              onPressed: count == 0 ? null : _share,
            ),
          ),
        ],
      ),
    );
  }
}
