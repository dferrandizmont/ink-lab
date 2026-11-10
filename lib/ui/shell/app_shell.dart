import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../app_scope.dart';
import '../../data/data.dart';

import '../../core/models.dart';
import '../../core/palette_advisor.dart' show PaletteSuggestion;
import '../../l10n/l10n.dart';
import '../icons/ink_icons.dart';
import '../pages/collection/collection_page.dart';
import '../pages/ideas/idea_deep_link.dart';
import '../pages/ideas/ideas_page.dart';
import '../pages/match/match_page.dart';
import '../pages/palette/palette_draft.dart';
import '../pages/palette/palette_page.dart';
import '../pages/settings/settings_page.dart';
import '../pages/swatches/swatches_page.dart';
import '../theme/app_typography.dart';
import '../theme/tokens.dart';
import 'app_shortcuts.dart';

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

/// Index of the Ideas destination in [appDestinations].
const int _ideasIndex = 3;

Widget _buildSwatches(BuildContext context) => SwatchesPage(
  onAddToPalette: (MarkerColor color) {
    // Hand the marker to the Palette tab as its base colour and open the tab.
    paletteBaseDraft.value = color;
    context.findAncestorStateOfType<_AppShellState>()?._goTo(_paletteIndex);
  },
  onBlendingChain: (MarkerColor color) {
    // Same hand-off, with the Blending Chain type asked for first.
    paletteBaseMode.value = PaletteMode.blendingChain;
    paletteBaseDraft.value = color;
    context.findAncestorStateOfType<_AppShellState>()?._goTo(_paletteIndex);
  },
  onOpenCollection: () => CollectionPage.open(context),
);

Widget _buildMatch(BuildContext context) => const MatchPage();

Widget _buildPalette(BuildContext context) => const PalettePage();

Widget _buildIdeas(BuildContext context) => IdeasPage(
  onOpenPalette: () =>
      context.findAncestorStateOfType<_AppShellState>()?._goTo(_paletteIndex),
);

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

/// Bounds, in logical pixels, of the width of the unfolded rail. The width is
/// computed from the longest label (see [extendedRailWidthFor]): it is never
/// narrower than [extendedRailMinWidth], and grows with the text scale up to
/// [extendedRailMaxWidth].
const double extendedRailMinWidth = 200, extendedRailMaxWidth = 320;

/// Key of the button that folds and unfolds the navigation rail (shown from
/// [AppShell.extendedRailBreakpoint] on).
const Key railToggleKey = ValueKey<String>('rail-toggle');

/// Key of the box that sets the width of the unfolded rail.
const Key extendedRailKey = ValueKey<String>('extended-rail');

/// Key of the box that holds the rail from [AppShell.extendedRailBreakpoint]
/// on: its width follows the fold/unfold animation.
const Key railBoxKey = ValueKey<String>('rail-box');

/// Key of the pill (the whole row: icon and label) of the destination [id] in
/// the unfolded rail.
Key extendedRailItemKey(String id) => ValueKey<String>('extended-rail-$id');

/// The adaptive shell of the app.
///
/// Phones get the design G bottom bar ([InkNavigationBar]); wide screens get
/// a [NavigationRail] on the leading edge, compact (labels under the icons).
/// From [extendedRailBreakpoint] on, a button at the top of the rail unfolds
/// it (labels beside the icons, in an [_ExtendedRail] of our own: one pill per
/// destination holding icon and label) or folds it back; the choice is remembered
/// (`AppSettingsState.railExpanded`, folded by default). Pages live in an
/// [IndexedStack], built the first time they are visited, so every tab keeps
/// its state.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  /// Width, in logical pixels, from which the shell uses a [NavigationRail]
  /// instead of the bottom bar.
  static const double wideLayoutBreakpoint = 720;

  /// Width, in logical pixels, from which the rail can be unfolded (extended)
  /// with the button at its top. Below it the rail is always compact.
  static const double extendedRailBreakpoint = 1100;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  /// The tab the app opens on and Back returns to: Swatches.
  static const int _homeIndex = 0;

  int _selectedIndex = _homeIndex;
  final Set<int> _visited = <int>{_homeIndex};

  AppScope? _scope;
  StreamSubscription<AppSettingsState>? _brandSubscription;

  /// The active brand. Palette and Ideas are keyed by it, so switching brand
  /// starts them fresh: no colour of the other brand stays on screen.
  String _brandId = '';

  /// Whether the user unfolded the rail (it only shows from the breakpoint on).
  bool _railExpanded = false;

  @override
  void initState() {
    super.initState();
    // The home-screen widget opens an idea: show the Ideas tab. A tap that
    // launched the app is already waiting here.
    ideaDeepLink.addListener(_onIdeaDeepLink);
    // A saved palette picked in Settings opens in the Palette tab.
    paletteSavedDraft.addListener(_onSavedPaletteDraft);
    if (ideaDeepLink.value != null) {
      _selectedIndex = _ideasIndex;
      _visited.add(_ideasIndex);
    }
    // A home-screen shortcut (long-press menu of the app icon) opens a tab. The
    // one that launched the app is already waiting here, but the navigator is
    // only usable from the first frame on.
    appShortcutRequest.addListener(_onShortcut);
    if (appShortcutRequest.value != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _onShortcut());
    }
  }

  /// Opens the tab of the shortcut the user used, over whatever page, sheet or
  /// dialog is open, and for "Search swatches" puts the cursor in the search
  /// field. The request is consumed, so a shortcut is acted on once.
  void _onShortcut() {
    final AppShortcut? shortcut = appShortcutRequest.value;
    if (shortcut == null || !mounted) return;
    appShortcutRequest.value = null;
    final int index = appDestinations.indexWhere(
      (AppDestination d) => d.id == shortcut.destinationId,
    );
    if (index < 0) return;
    Navigator.of(context).popUntil((Route<dynamic> route) => route.isFirst);
    _goTo(index);
    if (shortcut == AppShortcut.searchSwatches) {
      // The Swatches page is built (and its field attached) by the next frame.
      WidgetsBinding.instance
        ..addPostFrameCallback((_) {
          if (mounted) swatchesSearchFocus.requestFocus();
        })
        // Swatches may already be on screen, so nothing else asks for a frame.
        ..scheduleFrame();
    }
  }

  void _onSavedPaletteDraft() {
    if (paletteSavedDraft.value != null && mounted) _goTo(_paletteIndex);
  }

  void _onIdeaDeepLink() {
    if (ideaDeepLink.value != null && mounted) _goTo(_ideasIndex);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppScope? scope = context
        .dependOnInheritedWidgetOfExactType<AppScope>();
    if (scope == null || identical(scope, _scope)) return;
    _scope = scope;
    _brandId = scope.settings.brand.id;
    _railExpanded = scope.settings.railExpanded;
    _brandSubscription?.cancel();
    _brandSubscription = scope.settings.changes.listen((AppSettingsState s) {
      if (!mounted) return;
      if (s.railExpanded != _railExpanded) {
        setState(() => _railExpanded = s.railExpanded);
      }
      if (s.brand.id == _brandId) return;
      // Hand-offs still pending for the other brand are dropped.
      final MarkerColor? base = paletteBaseDraft.value;
      if (base != null && base.brandId != s.brand.id) {
        paletteBaseDraft.value = null;
        paletteBaseMode.value = null;
      }
      final PaletteDraft? draft = paletteDraft.value;
      if (draft != null &&
          draft.suggestions.any(
            (PaletteSuggestion p) => p.color.brandId != s.brand.id,
          )) {
        paletteDraft.value = null;
      }
      final SavedPalette? savedDraft = paletteSavedDraft.value;
      if (savedDraft != null && savedDraft.brandId != s.brand.id) {
        paletteSavedDraft.value = null;
      }
      // A notice of the old brand (Palette undo, Ideas hand-off) would act on
      // a page that is about to be rebuilt fresh.
      ScaffoldMessenger.maybeOf(context)?.removeCurrentSnackBar();
      // Palette and Ideas are re-keyed below, so their own state (base picker,
      // idea of the day, re-picked palettes, undo snapshot) starts fresh.
      setState(() => _brandId = s.brand.id);
    });
  }

  @override
  void dispose() {
    ideaDeepLink.removeListener(_onIdeaDeepLink);
    paletteSavedDraft.removeListener(_onSavedPaletteDraft);
    appShortcutRequest.removeListener(_onShortcut);
    _brandSubscription?.cancel();
    super.dispose();
  }

  /// Key of a destination's page: per brand for the pages that hold colours
  /// of one brand in their own state (Palette, Ideas).
  String _pageKey(int index) {
    final String id = appDestinations[index].id;
    return index == _paletteIndex || index == _ideasIndex
        ? '$id-$_brandId'
        : id;
  }

  void _goTo(int index) => _onDestinationSelected(index);

  /// Folds or unfolds the rail (it animates the move) and remembers the choice.
  void _setRailExpanded(bool value) {
    setState(() => _railExpanded = value);
    _scope?.settings.setRailExpanded(value);
  }

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
                    key: ValueKey<String>(_pageKey(i)),
                    child: Builder(builder: appDestinations[i].builder),
                  )
                : const SizedBox.shrink(),
        ],
      ),
    );
    // Swatches (the first tab) is the root: Back from another tab goes to it
    // and only Back from Swatches leaves the app. Pages, sheets and dialogs
    // above the shell are routes of their own and take Back first.
    return PopScope<Object?>(
      canPop: _selectedIndex == _homeIndex,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (!didPop) _onDestinationSelected(_homeIndex);
      },
      child: _buildLayout(context, body),
    );
  }

  Widget _buildLayout(BuildContext context, Widget body) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool wide = constraints.maxWidth >= AppShell.wideLayoutBreakpoint;
        if (wide) {
          // The button only exists where the rail has room to unfold.
          final bool canUnfold =
              constraints.maxWidth >= AppShell.extendedRailBreakpoint;
          return Scaffold(
            body: Row(
              children: <Widget>[
                if (canUnfold)
                  _AnimatedRail(
                    expanded: _railExpanded,
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: _onDestinationSelected,
                    onToggle: () => _setRailExpanded(!_railExpanded),
                  )
                else
                  NavigationRail(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: _onDestinationSelected,
                    labelType: NavigationRailLabelType.all,
                    minWidth: InkGeometry.railWidth,
                    destinations: _foldedDestinations(context),
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

/// The destinations of the folded rail, in the stock [NavigationRail].
List<NavigationRailDestination> _foldedDestinations(BuildContext context) =>
    <NavigationRailDestination>[
      for (final AppDestination d in appDestinations)
        NavigationRailDestination(
          icon: _destinationIcon(d),
          label: Text(d.label(context.l10n)),
        ),
    ];

/// The button at the top of a wide rail: unfolds it (labels beside the icons)
/// or folds it back. A 48 dp target in the colour of the unselected icons; the
/// chevron points the way the rail will move. The rail places it over its
/// icons.
class _RailToggle extends StatelessWidget {
  const _RailToggle({
    required this.expanded,
    required this.onPressed,
    this.focusNode,
  });

  final bool expanded;
  final VoidCallback onPressed;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return IconButton(
      key: railToggleKey,
      focusNode: focusNode,
      tooltip: expanded
          ? context.l10n.navRailCollapse
          : context.l10n.navRailExpand,
      onPressed: onPressed,
      style: IconButton.styleFrom(
        foregroundColor: ink.fg2,
        fixedSize: const Size.square(InkGeometry.androidTarget),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: const RoundedRectangleBorder(
          borderRadius: InkRadii.controlRadius,
        ),
      ),
      icon: Transform.flip(
        flipX: expanded,
        child: InkIcon(
          InkIcons.chevronRight,
          size: InkGeometry.iconSize,
          color: ink.fg2,
        ),
      ),
    );
  }
}

/// Margin between the edge of the unfolded rail and a destination pill.
const double _railMargin = InkSpacing.s12;

/// Inside a pill: between icon and label, after the label. (Before the icon
/// the pill pads so that the icon sits where it does in the folded rail: see
/// [_railItemStartFor].)
const double _railIconGap = InkSpacing.s12, _railItemEnd = InkSpacing.s16;

/// Horizontal padding of a destination in the stock [NavigationRail].
const double _foldedRailPadding = 8;

double _widestLabel(
  BuildContext context,
  List<String> labels,
  TextStyle style,
) {
  double widest = 0;
  for (final String label in labels) {
    final TextPainter painter = TextPainter(
      text: TextSpan(text: label, style: style),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
      maxLines: 1,
    )..layout();
    widest = math.max(widest, painter.width);
    painter.dispose();
  }
  return widest;
}

/// Width of the folded (stock) rail for [labels] at the text scale of
/// [context]: [InkGeometry.railWidth], or more when the widest label, with its
/// padding, needs it (large text).
double _foldedRailWidthFor(BuildContext context, List<String> labels) =>
    math.max(
      InkGeometry.railWidth,
      _widestLabel(context, labels, AppTypography.nav) + 2 * _foldedRailPadding,
    );

/// Distance from the edge of a pill to its icon, so that the centre of the icon
/// is the centre of the folded rail ([foldedWidth] / 2): the icons do not move
/// sideways when the rail folds or unfolds.
double _railItemStartFor(double foldedWidth) =>
    foldedWidth / 2 - InkGeometry.iconSize / 2 - _railMargin;

/// Width of the unfolded rail for [labels] at the text scale of [context]:
/// side margin + start padding + icon + gap + the widest label (measured in
/// the selected, medium weight, the widest) + end padding + side margin,
/// between [extendedRailMinWidth] and [extendedRailMaxWidth].
double extendedRailWidthFor(BuildContext context, List<String> labels) {
  final double widest = _widestLabel(
    context,
    labels,
    AppTypography.railLabelSelected,
  );
  final double content =
      2 * _railMargin +
      _railItemStartFor(_foldedRailWidthFor(context, labels)) +
      InkGeometry.iconSize +
      _railIconGap +
      widest.ceilToDouble() +
      _railItemEnd;
  return content.clamp(extendedRailMinWidth, extendedRailMaxWidth);
}

/// Where the folded rail fades out (and the pill of the unfolded one fades
/// in), as a share of the move.
const Interval _foldedFade = Interval(0, 0.4);

/// Where the labels of the unfolded rail fade in, as a share of the move: once
/// the width is mostly open (and the first thing to go when it closes).
const Interval _labelFade = Interval(0.6, 1);

/// The navigation rail of a screen wide enough to unfold it: the folded and
/// the unfolded rail, and the animation between them.
///
/// Folded is the stock [NavigationRail]; unfolded is an [_ExtendedRail]. At
/// rest only one of them is built. While the rail moves both are, in a
/// [_RailReveal] that clips them to the animating width:
///  * the unfolded rail is always laid out at its full width, so no label
///    wraps, is cut or overflows; the labels fade in when the width is
///    mostly open, and out first when it closes;
///  * the folded rail goes transparent (its labels and its indicator fade
///    out early in the opening) over the unfolded one, whose icons are at the
///    very same place: the icons and the button stay where they are, and the
///    indicator of the selected destination grows from the icon to the whole
///    row;
///  * the button belongs to the layer the rail is leaving, until the move
///    ends, so it never fades (the keyboard focus follows it).
///
/// It starts at rest in the state it is given: no animation on the first
/// build. With the system setting that disables animations the change is
/// instant.
class _AnimatedRail extends StatefulWidget {
  const _AnimatedRail({
    required this.expanded,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.onToggle,
  });

  final bool expanded;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final VoidCallback onToggle;

  @override
  State<_AnimatedRail> createState() => _AnimatedRailState();
}

class _AnimatedRailState extends State<_AnimatedRail>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _progress;
  final FocusNode _toggleFocus = FocusNode(debugLabel: 'rail toggle');

  /// Which layer holds the button: the unfolded one once the rail is open and
  /// while it closes, the folded one otherwise.
  late bool _toggleInExtended;

  @override
  void initState() {
    super.initState();
    _toggleInExtended = widget.expanded;
    _controller = AnimationController(
      vsync: this,
      duration: InkMotion.railFold,
      value: widget.expanded ? 1 : 0,
    )..addStatusListener(_onStatus);
    _progress = CurvedAnimation(
      parent: _controller,
      curve: InkMotion.railFoldCurve,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Animations switched off while the rail moves: finish at once.
    if (_controller.isAnimating && _instant) {
      _controller.value = widget.expanded ? 1 : 0;
    }
  }

  @override
  void didUpdateWidget(_AnimatedRail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expanded == widget.expanded) return;
    final double target = widget.expanded ? 1 : 0;
    if (_instant) {
      _controller.value = target;
    } else {
      _controller.animateTo(target);
    }
  }

  bool get _instant => MediaQuery.maybeDisableAnimationsOf(context) ?? false;

  void _onStatus(AnimationStatus status) {
    // animateTo reports `completed` when it ends, towards 0 as well: look at
    // where the rail is.
    if (status != AnimationStatus.completed &&
        status != AnimationStatus.dismissed) {
      return;
    }
    final bool inExtended = _controller.value >= 1;
    if (inExtended == _toggleInExtended || !mounted) return;
    // The button changes layer, so its element is rebuilt: give the focus
    // back to it once the frame is done.
    final bool hadFocus = _toggleFocus.hasFocus;
    setState(() => _toggleInExtended = inExtended);
    if (hadFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _toggleFocus.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    _progress.dispose();
    _controller.dispose();
    _toggleFocus.dispose();
    super.dispose();
  }

  Widget _toggle() => _RailToggle(
    expanded: widget.expanded,
    onPressed: widget.onToggle,
    focusNode: _toggleFocus,
  );

  /// The stock rail. While the rail moves it is transparent, and its labels
  /// and indicator fade out over the first part of the opening.
  Widget _foldedRail(BuildContext context, double progress) {
    Widget rail = NavigationRail(
      selectedIndex: widget.selectedIndex,
      onDestinationSelected: widget.onDestinationSelected,
      labelType: NavigationRailLabelType.all,
      minWidth: InkGeometry.railWidth,
      // The rail centres its leading widget, so the button gets a box as wide
      // as the rail: it stays over the icons.
      leading: SizedBox(
        width: InkGeometry.railWidth,
        child: Center(
          child: _toggleInExtended
              ? const SizedBox.square(dimension: InkGeometry.androidTarget)
              : _toggle(),
        ),
      ),
      destinations: _foldedDestinations(context),
    );
    if (progress > 0) {
      final double keep = 1 - _foldedFade.transform(progress);
      final NavigationRailThemeData base = NavigationRailTheme.of(context);
      TextStyle? faded(TextStyle? style) => style?.copyWith(
        color: style.color?.withValues(alpha: style.color!.a * keep),
      );
      rail = NavigationRailTheme(
        data: base.copyWith(
          backgroundColor: Colors.transparent,
          indicatorColor: base.indicatorColor?.withValues(
            alpha: base.indicatorColor!.a * keep,
          ),
          selectedLabelTextStyle: faded(base.selectedLabelTextStyle),
          unselectedLabelTextStyle: faded(base.unselectedLabelTextStyle),
        ),
        child: rail,
      );
    }
    return IgnorePointer(ignoring: _toggleInExtended, child: rail);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> labels = <String>[
      for (final AppDestination d in appDestinations) d.label(context.l10n),
    ];
    final double width = extendedRailWidthFor(context, labels);
    final double foldedWidth = _foldedRailWidthFor(context, labels);
    return AnimatedBuilder(
      animation: _progress,
      builder: (BuildContext context, Widget? _) {
        final double progress = _progress.value;
        return _RailReveal(
          key: railBoxKey,
          progress: progress,
          extendedWidth: width,
          folded: progress < 1 ? _foldedRail(context, progress) : null,
          extended: progress > 0
              ? IgnorePointer(
                  ignoring: !_toggleInExtended,
                  child: _ExtendedRail(
                    width: width,
                    foldedWidth: foldedWidth,
                    progress: progress,
                    expanded: widget.expanded,
                    toggle: _toggleInExtended ? _toggle() : null,
                    selectedIndex: widget.selectedIndex,
                    onDestinationSelected: widget.onDestinationSelected,
                  ),
                )
              : null,
        );
      },
    );
  }
}

enum _RailSlot { folded, extended }

/// Shows the folded rail and the unfolded one clipped to a width that goes
/// from the natural width of the first to [extendedWidth], as [progress] goes
/// from 0 to 1. Each layer keeps its own size (the unfolded one is laid out
/// at [extendedWidth] always) and the unfolded one is painted first. A layer
/// that is not given is not built (a rail at rest).
class _RailReveal
    extends SlottedMultiChildRenderObjectWidget<_RailSlot, RenderBox> {
  const _RailReveal({
    super.key,
    required this.progress,
    required this.extendedWidth,
    this.folded,
    this.extended,
  });

  final double progress;
  final double extendedWidth;
  final Widget? folded;
  final Widget? extended;

  @override
  Iterable<_RailSlot> get slots => _RailSlot.values;

  @override
  Widget? childForSlot(_RailSlot slot) => switch (slot) {
    _RailSlot.folded => folded,
    _RailSlot.extended => extended,
  };

  @override
  SlottedContainerRenderObjectMixin<_RailSlot, RenderBox> createRenderObject(
    BuildContext context,
  ) => _RenderRailReveal(progress, extendedWidth);

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _RenderRailReveal renderObject,
  ) {
    renderObject
      ..progress = progress
      ..extendedWidth = extendedWidth;
  }
}

class _RenderRailReveal extends RenderBox
    with SlottedContainerRenderObjectMixin<_RailSlot, RenderBox> {
  _RenderRailReveal(this._progress, this._extendedWidth);

  double _progress;
  double _extendedWidth;

  set progress(double value) {
    if (value == _progress) return;
    _progress = value;
    markNeedsLayout();
  }

  set extendedWidth(double value) {
    if (value == _extendedWidth) return;
    _extendedWidth = value;
    markNeedsLayout();
  }

  RenderBox? get _folded => childForSlot(_RailSlot.folded);
  RenderBox? get _extended => childForSlot(_RailSlot.extended);

  /// A Row gives loose heights: the rail takes the whole height.
  double _heightFor(BoxConstraints c) =>
      c.hasBoundedHeight ? c.maxHeight : c.minHeight;

  double _widthFor(double foldedWidth) {
    if (_folded == null) return _extendedWidth;
    if (_extended == null) return foldedWidth;
    return lerpDouble(foldedWidth, _extendedWidth, _progress)!;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final double height = _heightFor(constraints);
    final double foldedWidth =
        _folded
            ?.getDryLayout(BoxConstraints(minHeight: height, maxHeight: height))
            .width ??
        0;
    return constraints.constrain(Size(_widthFor(foldedWidth), height));
  }

  @override
  void performLayout() {
    final double height = _heightFor(constraints);
    double foldedWidth = 0;
    final RenderBox? folded = _folded;
    if (folded != null) {
      folded.layout(
        BoxConstraints(minHeight: height, maxHeight: height),
        parentUsesSize: true,
      );
      foldedWidth = folded.size.width;
    }
    _extended?.layout(
      BoxConstraints.tightFor(width: _extendedWidth, height: height),
    );
    size = constraints.constrain(Size(_widthFor(foldedWidth), height));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.pushClipRect(needsCompositing, offset, Offset.zero & size, (
      PaintingContext context,
      Offset offset,
    ) {
      // The unfolded rail first: the folded one, transparent, lies over it.
      for (final RenderBox? child in <RenderBox?>[_extended, _folded]) {
        if (child != null) context.paintChild(child, offset);
      }
    });
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    for (final RenderBox? child in <RenderBox?>[_folded, _extended]) {
      if (child != null && child.hitTest(result, position: position)) {
        return true;
      }
    }
    return false;
  }
}

/// The unfolded navigation rail: one row per destination, the label beside
/// the icon, and the selected row on one pill (the colour of the rail's
/// indicator) that holds icon and label together.
///
/// The Material rail only puts its indicator behind the icon when extended,
/// so the unfolded rail is built here. The folded rail stays the stock
/// [NavigationRail]; this one keeps its semantics (button, selected, "Tab n of
/// m"), 48 dp targets, focus and keyboard (every row is an [InkWell]), and
/// puts each destination at the same place as the folded rail does (the same
/// height, the icon under the same x), so folding or unfolding only changes
/// the width.
///
/// It is always laid out at [width]. [progress] (0 folded, 1 unfolded) only
/// changes how much of each pill is shown and how visible the labels are.
class _ExtendedRail extends StatelessWidget {
  const _ExtendedRail({
    required this.width,
    required this.foldedWidth,
    required this.progress,
    required this.expanded,
    required this.toggle,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final double width;

  /// Width of the folded rail: the icons stay under its centre.
  final double foldedWidth;
  final double progress;

  /// Whether the rail is going to be unfolded (what the button does next).
  final bool expanded;

  /// The button, when this layer holds it.
  final Widget? toggle;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    // In the folded rail a destination is 48 dp plus its label (12 sp, line
    // 16/12) under the icon, so its pitch grows with the text scale. Use the
    // same pitch: the destinations then stay at the same height.
    final double foldedLabel =
        (MediaQuery.textScalerOf(context).scale(AppTypography.nav.fontSize!) *
                AppTypography.nav.height!)
            .ceilToDouble();
    return Material(
      color: ink.surface,
      elevation: 0,
      child: SafeArea(
        right: false,
        child: SizedBox(
          key: extendedRailKey,
          width: width,
          // A Row gives its children loose heights: fill the screen, so the
          // rows start at the top.
          height: double.infinity,
          child: SingleChildScrollView(
            child: Semantics(
              container: true,
              explicitChildNodes: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Same 8 dp on top as the folded rail, then the button: its
                  // centre is the centre of the icons below.
                  const SizedBox(height: InkSpacing.s8),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: (foldedWidth - InkGeometry.androidTarget) / 2,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child:
                          toggle ??
                          const SizedBox.square(
                            dimension: InkGeometry.androidTarget,
                          ),
                    ),
                  ),
                  for (int i = 0; i < appDestinations.length; i++) ...<Widget>[
                    if (i > 0) SizedBox(height: foldedLabel),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: _railMargin,
                      ),
                      child: _RailItem(
                        destination: appDestinations[i],
                        selected: i == selectedIndex,
                        index: i,
                        count: appDestinations.length,
                        fullWidth: width - 2 * _railMargin,
                        start: _railItemStartFor(foldedWidth),
                        progress: progress,
                        onTap: () => onDestinationSelected(i),
                      ),
                    ),
                  ],
                  const SizedBox(height: InkSpacing.s8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// One row of the unfolded rail: a 48 dp pill holding icon and label.
///
/// The row is laid out at [fullWidth]; the pill shows [progress] of it, from
/// just the icon to the whole row, and the label fades in at the end.
class _RailItem extends StatelessWidget {
  const _RailItem({
    required this.destination,
    required this.selected,
    required this.index,
    required this.count,
    required this.fullWidth,
    required this.start,
    required this.progress,
    required this.onTap,
  });

  final AppDestination destination;
  final bool selected;
  final int index;
  final int count;
  final double fullWidth;

  /// Padding before the icon (see [_railItemStartFor]).
  final double start;
  final double progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final Color fg = selected ? ink.action : ink.fg2;
    final String label = destination.label(context.l10n);
    final bool moving = progress > 0 && progress < 1;
    // Folded, the pill holds just the icon, centred where it is in the rail.
    final double foldedPill = 2 * start + InkGeometry.iconSize;
    final double pillWidth = lerpDouble(foldedPill, fullWidth, progress)!;
    // The pill grows from the icon while the folded indicator fades out.
    final Color fill = progress >= 1
        ? ink.pale
        : ink.pale.withValues(
            alpha: ink.pale.a * _foldedFade.transform(progress),
          );
    final Widget text = Text(
      label,
      maxLines: 1,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      style:
          (selected ? AppTypography.railLabelSelected : AppTypography.railLabel)
              .copyWith(color: fg),
    );
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      hint: context.l10n.navTabHint(index + 1, count),
      excludeSemantics: true,
      child: SizedBox(
        height: InkGeometry.androidTarget,
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: SizedBox(
            width: pillWidth,
            child: Material(
              key: extendedRailItemKey(destination.id),
              color: selected ? fill : ink.pale.withValues(alpha: 0),
              // While the pill grows its colour follows the move.
              animationDuration: moving
                  ? Duration.zero
                  : InkMotion.accessible(context, InkMotion.crossFade),
              shape: const RoundedRectangleBorder(
                borderRadius: InkRadii.controlRadius,
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onTap,
                // The row keeps its full width under the clip of the pill.
                child: OverflowBox(
                  alignment: AlignmentDirectional.centerStart,
                  minWidth: fullWidth,
                  maxWidth: fullWidth,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: start,
                      end: _railItemEnd,
                    ),
                    child: Row(
                      children: <Widget>[
                        IconTheme.merge(
                          data: IconThemeData(
                            color: fg,
                            size: InkGeometry.iconSize,
                          ),
                          child: _destinationIcon(destination),
                        ),
                        const SizedBox(width: _railIconGap),
                        Expanded(
                          child: progress >= 1
                              ? text
                              : Opacity(
                                  opacity: _labelFade.transform(progress),
                                  child: text,
                                ),
                        ),
                      ],
                    ),
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

/// The design G bottom navigation (spec §4 "Bottom nav").
///
/// 72 high, `surface`, top hairline `line`, equal columns, always labelled.
/// Each item: a 56×32 indicator (8 radius) holding the 24 icon, gap 4, `nav`
/// label. Active: `pale` indicator, `action` icon and label. Inactive: none,
/// `fg2`.
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
                shape: const RoundedRectangleBorder(
                  borderRadius: InkRadii.controlRadius,
                ),
              ),
              alignment: Alignment.center,
              child: IconTheme.merge(
                data: IconThemeData(color: fg, size: 24),
                child: _destinationIcon(destination),
              ),
            ),
            const SizedBox(height: 4),
            // Five equal columns leave a fixed width per label, so the label
            // grows with the system scale only up to 1.1x (as most bottom bars
            // do) and never wraps or gets cut.
            MediaQuery.withClampedTextScaling(
              maxScaleFactor: 1.1,
              child: Text(
                destination.label(context.l10n),
                maxLines: 1,
                softWrap: false,
                style: AppTypography.nav.copyWith(color: fg),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
