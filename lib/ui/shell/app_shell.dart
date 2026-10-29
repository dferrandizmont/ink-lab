import 'package:flutter/material.dart';

import '../../core/models.dart';
import '../../l10n/l10n.dart';
import '../icons/ink_icons.dart';
import '../pages/ideas/ideas_page.dart';
import '../pages/match/match_page.dart';
import '../pages/palette/palette_draft.dart';
import '../pages/palette/palette_page.dart';
import '../pages/settings/settings_page.dart';
import '../pages/settings/settings_target.dart';
import '../pages/swatches/swatches_page.dart';
import '../theme/app_typography.dart';
import '../theme/tokens.dart';

/// One destination of the app shell.
@immutable
class AppDestination {
  const AppDestination({
    required this.id,
    required this.label,
    required this.icon,
    required this.builder,
    this.inkIcon,
  });

  /// Stable, language-independent id of the destination (also its page key).
  final String id;

  /// Localised label shown under the icon in the navigation bar or rail.
  final String Function(AppLocalizations l10n) label;

  /// Material fallback icon (kept for compatibility; the shell draws
  /// [inkIcon] when set).
  final IconData icon;

  /// Design G line icon of the destination.
  final InkIcons? inkIcon;

  /// Builds the page of the destination.
  final WidgetBuilder builder;
}

/// Index of the Palette destination in [appDestinations].
const int _paletteIndex = 2;

/// Index of the Settings destination in [appDestinations].
const int _settingsIndex = 4;

Widget _buildSwatches(BuildContext context) => SwatchesPage(
  onAddToPalette: (MarkerColor color) {
    // Hand the marker to the Palette tab as its base colour and open the tab.
    paletteBaseDraft.value = color;
    context.findAncestorStateOfType<_AppShellState>()?._goTo(_paletteIndex);
  },
  onOpenOwnedMarkers: () {
    // Ask Settings to bring the owned markers manager into view, then open
    // the tab.
    settingsTarget.value = SettingsTarget.ownedMarkers;
    context.findAncestorStateOfType<_AppShellState>()?._goTo(_settingsIndex);
  },
);

Widget _buildMatch(BuildContext context) => const MatchPage();

Widget _buildPalette(BuildContext context) => const PalettePage();

Widget _buildIdeas(BuildContext context) => const IdeasPage();

Widget _buildSettings(BuildContext context) => const SettingsPage();

String _swatchesLabel(AppLocalizations l10n) => l10n.swatchesTitle;
String _matchLabel(AppLocalizations l10n) => l10n.matchTitle;
String _paletteLabel(AppLocalizations l10n) => l10n.paletteTitle;
String _ideasLabel(AppLocalizations l10n) => l10n.ideasTitle;
String _settingsLabel(AppLocalizations l10n) => l10n.settingsTitle;

/// The destinations of the app shell, in navigation order.
const List<AppDestination> appDestinations = <AppDestination>[
  AppDestination(
    id: 'Swatches',
    label: _swatchesLabel,
    icon: Icons.grid_view,
    inkIcon: InkIcons.grid,
    builder: _buildSwatches,
  ),
  AppDestination(
    id: 'Match',
    label: _matchLabel,
    icon: Icons.photo_camera_outlined,
    inkIcon: InkIcons.camera,
    builder: _buildMatch,
  ),
  AppDestination(
    id: 'Palette',
    label: _paletteLabel,
    icon: Icons.view_column_outlined,
    inkIcon: InkIcons.columns,
    builder: _buildPalette,
  ),
  AppDestination(
    id: 'Ideas',
    label: _ideasLabel,
    icon: Icons.edit_outlined,
    inkIcon: InkIcons.edit3,
    builder: _buildIdeas,
  ),
  AppDestination(
    id: 'Settings',
    label: _settingsLabel,
    icon: Icons.tune,
    inkIcon: InkIcons.sliders,
    builder: _buildSettings,
  ),
];

Widget _destinationIcon(AppDestination destination, {double size = 24}) =>
    destination.inkIcon == null
    ? Icon(destination.icon, size: size)
    : InkIcon(destination.inkIcon!, size: size);

/// The adaptive shell of the app.
///
/// Phones get the design G bottom bar ([InkNavigationBar]); wide screens get
/// a [NavigationRail] on the leading edge. Pages live in an [IndexedStack],
/// built the first time they are visited, so every tab keeps its state.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  /// Width, in logical pixels, from which the shell uses a [NavigationRail]
  /// instead of the bottom bar.
  static const double wideLayoutBreakpoint = 720;

  /// Width, in logical pixels, from which the rail is shown extended.
  static const double extendedRailBreakpoint = 1100;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;
  final Set<int> _visited = <int>{0};

  void _goTo(int index) => _onDestinationSelected(index);

  void _onDestinationSelected(int index) {
    if (index == _selectedIndex) {
      return;
    }
    setState(() {
      _selectedIndex = index;
      _visited.add(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // One top safe area for every page, so no title is drawn under the
    // system status bar (pages must not add their own).
    final Widget body = SafeArea(
      bottom: false,
      child: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          for (int i = 0; i < appDestinations.length; i++)
            _visited.contains(i)
                ? KeyedSubtree(
                    key: ValueKey<String>(appDestinations[i].id),
                    child: Builder(builder: appDestinations[i].builder),
                  )
                : const SizedBox.shrink(),
        ],
      ),
    );
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool wide = constraints.maxWidth >= AppShell.wideLayoutBreakpoint;
        if (wide) {
          final bool extended =
              constraints.maxWidth >= AppShell.extendedRailBreakpoint;
          return Scaffold(
            body: Row(
              children: <Widget>[
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onDestinationSelected,
                  // An extended rail already shows the labels of the
                  // destinations, so it cannot show them twice.
                  labelType: extended
                      ? NavigationRailLabelType.none
                      : NavigationRailLabelType.all,
                  extended: extended,
                  minWidth: InkGeometry.railWidth,
                  destinations: <NavigationRailDestination>[
                    for (final AppDestination d in appDestinations)
                      NavigationRailDestination(
                        icon: _destinationIcon(d),
                        label: Text(d.label(context.l10n)),
                      ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(child: body),
              ],
            ),
          );
        }
        return Scaffold(
          body: body,
          bottomNavigationBar: InkNavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onDestinationSelected,
            destinations: appDestinations,
          ),
        );
      },
    );
  }
}

/// The design G bottom navigation (spec §4 "Bottom nav").
///
/// 72 high, `surface`, top hairline `line`, equal columns, always labelled.
/// Each item: a 56×32 pill holding the 24 icon, gap 4, `nav` label. Active:
/// `pale` pill, `action` icon and label. Inactive: no pill, `fg2`.
class InkNavigationBar extends StatelessWidget {
  const InkNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<AppDestination> destinations;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Semantics(
      container: true,
      explicitChildNodes: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: ink.surface,
          border: Border(top: BorderSide(color: ink.line)),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: InkGeometry.navHeight,
            child: Row(
              children: <Widget>[
                for (int i = 0; i < destinations.length; i++)
                  Expanded(
                    child: _NavItem(
                      destination: destinations[i],
                      selected: i == selectedIndex,
                      index: i,
                      count: destinations.length,
                      onTap: () => onDestinationSelected(i),
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

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.destination,
    required this.selected,
    required this.index,
    required this.count,
    required this.onTap,
  });

  final AppDestination destination;
  final bool selected;
  final int index;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final Color fg = selected ? ink.action : ink.fg2;
    final Duration duration = InkMotion.accessible(
      context,
      InkMotion.crossFade,
    );
    return Semantics(
      button: true,
      selected: selected,
      label: destination.label(context.l10n),
      hint: context.l10n.navTabHint(index + 1, count),
      excludeSemantics: true,
      child: InkResponse(
        onTap: onTap,
        highlightShape: BoxShape.rectangle,
        containedInkWell: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              duration: duration,
              curve: InkMotion.crossFadeCurve,
              width: InkGeometry.navPillWidth,
              height: InkGeometry.navPillHeight,
              decoration: ShapeDecoration(
                color: selected ? ink.pale : ink.pale.withValues(alpha: 0),
                shape: const StadiumBorder(),
              ),
              alignment: Alignment.center,
              child: IconTheme.merge(
                data: IconThemeData(color: fg, size: 24),
                child: _destinationIcon(destination),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              destination.label(context.l10n),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.nav.copyWith(color: fg),
            ),
          ],
        ),
      ),
    );
  }
}
