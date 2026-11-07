import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/collection_selection.dart';
import '../../../core/models.dart';
import '../../../data/data.dart';
import '../../../l10n/l10n.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_adaptive.dart';
import '../../widgets/brand_list.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_chip.dart';
import '../collection/collection_pickers.dart';
import '../collection/collection_summary.dart';
import '../collection/collection_summary_card.dart';
import '../collection/loose_markers_page.dart';

enum _Step { brand, series, sets, markers, done }

/// Key of a brand's row in the first-run setup: `onboarding-brand-ohuhu`
/// (the historical key of Ohuhu) or `onboarding-brand-<brand id>`.
String onboardingBrandCardKey(MarkerBrand brand) =>
    'onboarding-brand-${brand == MarkerBrand.ohuhuOahu ? 'ohuhu' : brand.id}';

/// The first-run setup: brand, then series and sets for retail-set brands
/// or individual markers (and available colour families), then a summary.
/// Every step can be skipped; the choices only reach the settings with "Start".
///
/// Shown by the app while `onboardingCompleted` is false, and again from
/// Settings (then [onDone] closes it).
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key, this.onDone});

  static const Key pageKey = Key('onboarding-page');

  /// Called after the setup is finished or skipped.
  final VoidCallback? onDone;

  /// Opens the setup again from another screen.
  static Future<void> open(BuildContext context) {
    final NavigatorState navigator = Navigator.of(context);
    return AppScope.push(context, OnboardingPage(onDone: navigator.pop));
  }

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late AppScope _scope;
  late MarkerBrand _brand;
  late Set<MarkerLine> _series;
  late Set<String> _sets;
  late Set<String> _extras;
  bool _ready = false;
  bool _finished = false;
  _Step _step = _Step.brand;

  /// The scroll of the step on screen; each step starts at its top.
  final ScrollController _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_ready) return;
    _ready = true;
    _scope = AppScope.of(context);
    final AppSettingsState state = _scope.settings.state;
    _brand = state.brand;
    _sets = <String>{...state.settings.ownedSetIds};
    _series = <MarkerLine>{...state.settings.ownedSeries};
    _extras = <String>{...state.settings.extraMarkerIds};
    _restore(_scope.settings.onboardingDraft);
  }

  /// Picks up a setup left half-way. A draft that names a brand, series, set
  /// or step this version does not know is ignored (and forgotten).
  void _restore(OnboardingDraft? draft) {
    if (draft == null) return;
    final MarkerBrand? brand = MarkerBrand.byId[draft.brandId.trim()];
    final Set<MarkerLine> series = <MarkerLine>{};
    bool known = brand != null;
    for (final String id in draft.seriesIds) {
      final MarkerLine? line = MarkerLine.fromId(id);
      if (line == null) {
        known = false;
      } else {
        series.add(line);
      }
    }
    known = known && draft.setIds.every(OahuSet.byId.containsKey);
    _Step? step;
    for (final _Step candidate in _Step.values) {
      if (candidate.name == draft.step) step = candidate;
    }
    if (known && step != null) {
      final List<_Step> steps = brand!.hasRetailSets
          ? _retailSteps
          : _plainSteps;
      known = steps.contains(step);
    }
    if (!known || step == null) {
      unawaited(_scope.settings.setOnboardingDraft(null));
      return;
    }
    _brand = brand!;
    _series = series;
    _sets = <String>{...draft.setIds};
    _extras = scopedColorIds(draft.extraMarkerIds);
    _step = step;
  }

  /// Applies [change], redraws and saves the draft.
  void _update(VoidCallback change) {
    setState(change);
    if (_finished) return;
    unawaited(
      _scope.settings.setOnboardingDraft(
        OnboardingDraft(
          step: _step.name,
          brandId: _brand.id,
          seriesIds: <String>{for (final MarkerLine line in _series) line.id},
          setIds: _sets,
          extraMarkerIds: _extras,
        ),
      ),
    );
  }

  static const List<_Step> _retailSteps = <_Step>[
    _Step.brand,
    _Step.series,
    _Step.sets,
    _Step.done,
  ];
  static const List<_Step> _plainSteps = <_Step>[
    _Step.brand,
    _Step.markers,
    _Step.done,
  ];

  List<_Step> get _steps => _brand.hasRetailSets ? _retailSteps : _plainSteps;

  int get _index => _steps.indexOf(_step);

  void _go(int delta) {
    _update(() => _step = _steps[_index + delta]);
    if (_scroll.hasClients) _scroll.jumpTo(0);
  }

  AppSettings _chosen() {
    return AppSettings(
      ownedSetIds: _sets,
      chosenSeriesIds: <String>{for (final MarkerLine line in _series) line.id},
      extraMarkerIds: _extras,
    );
  }

  Future<void> _finish({required bool apply}) async {
    final AppSettingsRepository settings = _scope.settings;
    _finished = true;
    if (apply) {
      await settings.setBrand(_brand);
      await settings.setCollection(_chosen());
    }
    await settings.setOnboardingCompleted(true);
    await settings.setOnboardingDraft(null);
    widget.onDone?.call();
  }

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final bool last = _step == _Step.done;
    final Widget note = Text(
      context.l10n.onboardingLaterNote,
      style: AppTypography.secondary.copyWith(color: ink.fg2),
    );
    // One fixed layout on every step: the primary action fills the width
    // and "Back" sits under it. On the first step "Back" keeps its place
    // (invisible), so nothing moves.
    final Widget next = InkButton(
      key: const ValueKey<String>('onboarding-next'),
      label: last ? context.l10n.onboardingFinish : context.l10n.onboardingNext,
      expand: true,
      onPressed: last ? () => _finish(apply: true) : () => _go(1),
    );
    final Widget back = Visibility(
      visible: _index > 0,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: InkButton.text(
        key: const ValueKey<String>('onboarding-back'),
        label: context.l10n.onboardingBack,
        expand: true,
        onPressed: () => _go(-1),
      ),
    );
    return Scaffold(
      key: OnboardingPage.pageKey,
      body: InkReadableWidth(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              // On a short screen (a phone in landscape) the note and the
              // two stacked buttons would take most of the height and squeeze
              // the content to a row: the note scrolls with the content and
              // the buttons share one row.
              final bool short =
                  constraints.maxHeight < InkLayout.shortPageHeight;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      InkSpacing.gutter,
                      InkSpacing.s4,
                      InkSpacing.s4,
                      0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            context.l10n.onboardingStep(
                              _index + 1,
                              _steps.length,
                            ),
                            style: AppTypography.data.copyWith(color: ink.fg2),
                          ),
                        ),
                        // Kept (invisible) on the last step so the header has
                        // the same height on every step and the title never
                        // jumps.
                        Visibility(
                          visible: !last,
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          child: InkButton.text(
                            key: const ValueKey<String>('onboarding-skip'),
                            label: context.l10n.onboardingSkip,
                            onPressed: () => _finish(apply: false),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      key: const ValueKey<String>('onboarding-scroll'),
                      controller: _scroll,
                      padding: const EdgeInsets.all(InkSpacing.gutter),
                      children: <Widget>[
                        ..._body(context),
                        // The note goes with the content when the buttons are
                        // squeezed into one row below.
                        if (short) ...<Widget>[
                          const SizedBox(height: InkSpacing.group),
                          note,
                        ],
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      InkSpacing.gutter,
                      0,
                      InkSpacing.gutter,
                      InkSpacing.gutter,
                    ),
                    child: short
                        ? Row(
                            children: <Widget>[
                              Expanded(child: back),
                              const SizedBox(width: InkSpacing.buttonGap),
                              Expanded(child: next),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              note,
                              const SizedBox(height: InkSpacing.block),
                              next,
                              const SizedBox(height: InkSpacing.buttonGap),
                              back,
                            ],
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _body(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    Widget title(String text) => Padding(
      padding: const EdgeInsets.only(bottom: InkSpacing.group),
      child: Text(
        text,
        style: AppTypography.sheetTitle.copyWith(color: ink.fg),
      ),
    );
    Widget body(String text) => Padding(
      padding: const EdgeInsets.only(bottom: InkSpacing.block),
      child: Text(text, style: AppTypography.body.copyWith(color: ink.fg2)),
    );
    switch (_step) {
      case _Step.brand:
        return <Widget>[
          title(context.l10n.onboardingWelcomeTitle),
          body(context.l10n.onboardingWelcomeBody),
          // 15 brands: a search field and two short groups (Popular, More
          // brands), not one tall card per brand.
          BrandList(
            selected: _brand,
            rowKey: (MarkerBrand brand) =>
                ValueKey<String>(onboardingBrandCardKey(brand)),
            onSelected: (MarkerBrand brand) => _update(() => _brand = brand),
          ),
        ];
      case _Step.series:
        return <Widget>[
          title(context.l10n.onboardingSeriesTitle),
          body(context.l10n.onboardingSeriesBody),
          SeriesCards(
            selected: _series,
            onToggle: (MarkerLine line, bool on) => _update(() {
              if (on) {
                _series.add(line);
              } else {
                _series.remove(line);
                _sets.removeWhere(
                  (String id) => OahuSet.byId[id]?.line == line,
                );
              }
            }),
          ),
          if (_series.contains(MarkerLine.honolulu)) ...<Widget>[
            const SizedBox(height: InkSpacing.block),
            Text(
              context.l10n.collectionHonoluluNote,
              style: AppTypography.secondary.copyWith(color: ink.fg2),
            ),
          ],
        ];
      case _Step.sets:
        return <Widget>[
          title(context.l10n.onboardingSetsTitle),
          body(context.l10n.onboardingSetsBody),
          if (_series.isEmpty)
            body(context.l10n.collectionSetsEmpty)
          else
            SeriesSetPicker(
              series: _series,
              ownedSetIds: _sets,
              onToggle: (OahuSet set, bool on) =>
                  _update(() => on ? _sets.add(set.id) : _sets.remove(set.id)),
            ),
        ];
      case _Step.markers:
        return <Widget>[
          title(context.l10n.onboardingMarkersTitle(_brand.label)),
          body(context.l10n.individualMarkersHint(_brand)),
          if (_brand == MarkerBrand.decoTime) ...<Widget>[
            body(context.l10n.collectionDecoSizesHint),
            _decoFamilies(context),
          ],
          InkButton.secondary(
            key: const ValueKey<String>('onboarding-pick-markers'),
            label: context.l10n.collectionDecoMarkersButton,
            onPressed: _pickMarkers,
          ),
        ];
      case _Step.done:
        return <Widget>[
          title(context.l10n.onboardingDoneTitle),
          FutureBuilder<List<MarkerColor>>(
            future: _scope.markers.loadColors(_brand),
            builder:
                (BuildContext context, AsyncSnapshot<List<MarkerColor>> s) {
                  final CollectionSummary summary = CollectionSummary.of(
                    _scope.settings.state.copyWith(
                      brand: _brand,
                      settings: _chosen(),
                    ),
                    s.data ?? const <MarkerColor>[],
                  );
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      CollectionSummaryCard(
                        key: const ValueKey<String>('onboarding-summary'),
                        summary: summary,
                      ),
                      const SizedBox(height: InkSpacing.block),
                      if (summary.isEmpty)
                        body(
                          _brand.hasRetailSets
                              ? context.l10n.onboardingDoneWholeRange(
                                  _brand.label,
                                )
                              : context.l10n.onboardingNoMarkers(_brand.label),
                        ),
                    ],
                  );
                },
          ),
          body(context.l10n.onboardingDoneNext),
        ];
    }
  }

  Widget _decoFamilies(BuildContext context) {
    return FutureBuilder<List<MarkerColor>>(
      future: _scope.markers.loadColors(MarkerBrand.decoTime),
      builder: (BuildContext context, AsyncSnapshot<List<MarkerColor>> s) {
        final List<MarkerColor> range = brandRangeColors(
          colors: s.data ?? const <MarkerColor>[],
          brand: MarkerBrand.decoTime,
        );
        bool all(List<MarkerColor> colors) =>
            colors.isNotEmpty &&
            colors.every((MarkerColor c) => _extras.contains(c.colorId));
        void toggle(List<MarkerColor> colors) => _update(() {
          final bool remove = all(colors);
          for (final MarkerColor c in colors) {
            remove ? _extras.remove(c.colorId) : _extras.add(c.colorId);
          }
        });
        return Wrap(
          spacing: InkSpacing.chipGap,
          runSpacing: InkSpacing.s4,
          children: <Widget>[
            InkChip(
              key: const ValueKey<String>('onboarding-family-all'),
              label: context.l10n.collectionWholeRange,
              selected: all(range),
              onSelected: (_) => toggle(range),
            ),
            for (final String id in decoTimeFamilyIds)
              if (range.any((MarkerColor c) => c.sets.contains(id)))
                Builder(
                  builder: (BuildContext context) {
                    final List<MarkerColor> members = range
                        .where((MarkerColor c) => c.sets.contains(id))
                        .toList(growable: false);
                    return InkChip(
                      key: ValueKey<String>('onboarding-family-$id'),
                      label: context.l10n.decoFamilyLabel(id)!,
                      selected: all(members),
                      onSelected: (_) => toggle(members),
                    );
                  },
                ),
          ],
        );
      },
    );
  }

  Future<void> _pickMarkers() async {
    final draft = StoredAppSettingsRepository(
      InMemoryKeyValueStore(),
      initial: _scope.settings.state.copyWith(
        brand: _brand,
        settings: _chosen(),
      ),
    );
    await AppScope.push(context, LooseMarkersPage(settings: draft));
    if (!mounted) return;
    _update(() => _extras = <String>{...draft.settings.extraMarkerIds});
  }
}
