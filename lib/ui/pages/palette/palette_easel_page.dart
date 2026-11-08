import 'package:flutter/material.dart';

import '../../../core/color_utils.dart';
import '../../../core/color_vision.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../screen_awake.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import 'palette_vision.dart';

/// One marker of the palette in easel mode. [hex] is the true colour; the
/// page draws it as the colour vision preview asks.
typedef EaselColor = ({String code, String name, String role, String hex});

/// Easel mode: the palette on screen, big enough to keep beside the paper
/// while painting.
///
/// Each marker is a large swatch with its code in large, high-contrast text
/// and its name and role below or beside it. Portrait and landscape both
/// fill the screen, and the screen stays awake while the page is open: the
/// [awake] seam is enabled on open and resume, and released on dispose, back
/// and when the app is paused. The colour vision preview of the palette page
/// ([vision], or the greyscale [values] view) is kept.
class PaletteEaselPage extends StatefulWidget {
  const PaletteEaselPage({
    super.key,
    required this.colors,
    this.vision,
    this.values = false,
    this.awake = const WakelockScreenAwake(),
  });

  /// Key of the page, handy for tests.
  static const Key pageKey = Key('palette-easel');

  /// The markers, in palette order.
  final List<EaselColor> colors;

  /// The colour vision the palette is previewed with; `null` is normal.
  final ColorVisionType? vision;

  /// Whether the palette is drawn in values (greyscale); it wins over
  /// [vision].
  final bool values;

  /// What keeps the screen awake.
  final ScreenAwake awake;

  /// Opens the page on top of the current one.
  static Future<void> open(
    BuildContext context, {
    required List<EaselColor> colors,
    ColorVisionType? vision,
    bool values = false,
    ScreenAwake awake = const WakelockScreenAwake(),
  }) {
    if (colors.isEmpty) return Future<void>.value();
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (BuildContext context) => PaletteEaselPage(
          colors: colors,
          vision: vision,
          values: values,
          awake: awake,
        ),
      ),
    );
  }

  @override
  State<PaletteEaselPage> createState() => _PaletteEaselPageState();
}

class _PaletteEaselPageState extends State<PaletteEaselPage>
    with WidgetsBindingObserver {
  bool _held = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _hold();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _hold();
    } else {
      _release();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _release();
    super.dispose();
  }

  /// Keeps the screen awake. A platform that cannot is not an error: the page
  /// still works.
  void _hold() {
    if (_held) return;
    _held = true;
    _safely(widget.awake.enable);
  }

  void _release() {
    if (!_held) return;
    _held = false;
    _safely(widget.awake.disable);
  }

  static void _safely(Future<void> Function() call) {
    try {
      call().catchError((Object _) {});
    } catch (_) {
      // Nothing to do: the screen just may switch off.
    }
  }

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final String? seen = widget.values
        ? context.l10n.matchValuesButton
        : widget.vision == null
        ? null
        : colorVisionLabel(context, widget.vision);
    return PopScope(
      // Back releases the screen at once, not when the route is disposed.
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) _release();
      },
      child: Scaffold(
        key: PaletteEaselPage.pageKey,
        backgroundColor: ink.bg,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _EaselBar(
                title: context.l10n.paletteEaselTitle,
                seen: seen,
                exitLabel: context.l10n.paletteEaselExit,
                onExit: () => Navigator.of(context).maybePop(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    InkSpacing.s8,
                    0,
                    InkSpacing.s8,
                    InkSpacing.s8,
                  ),
                  child: _EaselGrid(
                    colors: widget.colors,
                    vision: widget.vision,
                    values: widget.values,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The bar on top: the title, the colour vision in use (its line is always
/// reserved, so nothing moves when it appears) and the exit button.
class _EaselBar extends StatelessWidget {
  const _EaselBar({
    required this.title,
    required this.seen,
    required this.exitLabel,
    required this.onExit,
  });

  /// The size of the exit button, in logical pixels.
  static const double exitTarget = 48;

  final String title;
  final String? seen;
  final String exitLabel;
  final VoidCallback onExit;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        InkSpacing.pageMargin,
        InkSpacing.s4,
        InkSpacing.s4,
        InkSpacing.s4,
      ),
      child: SizedBox(
        height: exitTarget,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Semantics(
                        header: true,
                        child: Text(
                          title,
                          maxLines: 1,
                          style: AppTypography.section.copyWith(color: ink.fg),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: InkGeometry.smallIcon,
                    child: seen == null
                        ? null
                        : Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                seen!,
                                key: const ValueKey<String>(
                                  'palette-easel-vision',
                                ),
                                maxLines: 1,
                                style: AppTypography.caption.copyWith(
                                  color: ink.fg2,
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            IconButton(
              key: const ValueKey<String>('palette-easel-exit'),
              tooltip: exitLabel,
              onPressed: onExit,
              style: IconButton.styleFrom(
                foregroundColor: ink.fg,
                fixedSize: const Size.square(exitTarget),
                minimumSize: const Size.square(exitTarget),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: const RoundedRectangleBorder(
                  borderRadius: InkRadii.controlRadius,
                ),
              ),
              icon: InkIcon(
                InkIcons.x,
                size: InkGeometry.mediumIcon,
                color: ink.fg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The swatches, filling the room they have: one column in portrait (two
/// from seven markers on), one row in landscape (two from seven on).
class _EaselGrid extends StatelessWidget {
  const _EaselGrid({
    required this.colors,
    required this.vision,
    required this.values,
  });

  final List<EaselColor> colors;
  final ColorVisionType? vision;
  final bool values;

  /// How many swatches sit side by side.
  static int columnsFor({required int count, required bool landscape}) {
    if (landscape) return count <= 6 ? count : (count + 1) ~/ 2;
    return count <= 6 ? 1 : 2;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool landscape = constraints.maxWidth > constraints.maxHeight;
        final int count = colors.length;
        final int columns = columnsFor(count: count, landscape: landscape);
        final int rows = (count + columns - 1) ~/ columns;
        return Column(
          children: <Widget>[
            for (int row = 0; row < rows; row++) ...<Widget>[
              if (row > 0) const SizedBox(height: InkSpacing.s8),
              Expanded(
                child: Row(
                  // Every swatch of the row is as tall as the row.
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    for (
                      int column = 0;
                      column < columns;
                      column++
                    ) ...<Widget>[
                      if (column > 0) const SizedBox(width: InkSpacing.s8),
                      Expanded(
                        child: row * columns + column < count
                            ? _EaselTile(
                                index: row * columns + column,
                                color: colors[row * columns + column],
                                vision: vision,
                                values: values,
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

/// One marker: a swatch with its code, name and role in the text colour that
/// reads best on it (at least 4.58:1).
class _EaselTile extends StatelessWidget {
  const _EaselTile({
    required this.index,
    required this.color,
    required this.vision,
    required this.values,
  });

  final int index;
  final EaselColor color;
  final ColorVisionType? vision;
  final bool values;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final Color fill = _parse(
      seenHex(color.hex, vision, values: values),
      fallback: ink.line,
    );
    final Color on = inkOn(fill);
    final TextStyle code = AppTypography.easelCode.copyWith(color: on);
    final TextStyle name = AppTypography.body.copyWith(color: on);
    final TextStyle role = AppTypography.capsStyle.copyWith(color: on);
    return Semantics(
      container: true,
      label: <String>[
        color.code,
        color.name,
        color.role,
      ].where((String part) => part.isNotEmpty).join(', '),
      child: ExcludeSemantics(
        child: DecoratedBox(
          key: ValueKey<String>('palette-easel-tile-$index'),
          decoration: BoxDecoration(
            color: fill,
            borderRadius: InkRadii.cellRadius,
            border: Border.all(
              color: ink.swatchEdge(fill),
              width: InkGeometry.border,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(InkSpacing.s12),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints box) {
                final Widget codeText = FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    color.code,
                    key: ValueKey<String>('palette-easel-code-$index'),
                    maxLines: 1,
                    style: code,
                  ),
                );
                final Widget details = _DetailsColumn(
                  name: color.name,
                  role: color.role,
                  nameStyle: name,
                  roleStyle: role,
                );
                // A wide, low swatch puts the code beside the name; a tall
                // one stacks them. Either way nothing is cut: whatever does
                // not fit is scaled down together.
                if (box.maxWidth > box.maxHeight * 1.6) {
                  return Row(
                    children: <Widget>[
                      Expanded(flex: 5, child: codeText),
                      const SizedBox(width: InkSpacing.s12),
                      Expanded(
                        flex: 6,
                        child: _ScaledDown(
                          width: (box.maxWidth - InkSpacing.s12) * 6 / 11,
                          child: details,
                        ),
                      ),
                    ],
                  );
                }
                return _ScaledDown(
                  width: box.maxWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      codeText,
                      const SizedBox(height: InkSpacing.s4),
                      details,
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  /// The colour of the hex string (with or without `#`); [fallback] when it
  /// is not one.
  static Color _parse(String hex, {required Color fallback}) {
    try {
      return Color(hexToColorInt(hex));
    } on FormatException {
      return fallback;
    }
  }
}

/// [child] laid out [width] wide (so its text wraps there) and scaled down,
/// never cut, when it is taller than the room it has.
class _ScaledDown extends StatelessWidget {
  const _ScaledDown({required this.width, required this.child});

  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerStart,
      child: SizedBox(width: width, child: child),
    );
  }
}

/// The name and the role (in capitals) of a marker.
class _DetailsColumn extends StatelessWidget {
  const _DetailsColumn({
    required this.name,
    required this.role,
    required this.nameStyle,
    required this.roleStyle,
  });

  final String name;
  final String role;
  final TextStyle nameStyle;
  final TextStyle roleStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(name, style: nameStyle),
        if (role.isNotEmpty) ...<Widget>[
          const SizedBox(height: InkSpacing.s2),
          Text(AppTypography.caps(role), style: roleStyle),
        ],
      ],
    );
  }
}
