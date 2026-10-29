import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/collection_selection.dart';
import '../../../core/models.dart';
import '../../../data/data.dart';
import '../../../l10n/l10n.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_chip.dart';
import '../../widgets/select_card.dart';
import '../collection/collection_pickers.dart';
import '../collection/collection_summary.dart';
import '../collection/collection_summary_card.dart';

enum _Step { brand, series, sets, deco, done }

/// The first-run setup: brand, then (Ohuhu) series and sets, or (DecoTime)
/// the colour families, then a summary. Every step can be skipped; the
/// choices only reach the settings with "Start".
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
  late Set<String> _decoExtras;
  bool _ready = false;
  _Step _step = _Step.brand;

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
    _decoExtras = state.settings.extraMarkerIds
        .where((String id) => colorIdBelongsToBrand(id, MarkerBrand.decoTime))
        .toSet();
  }

  List<_Step> get _steps => _brand == MarkerBrand.ohuhuOahu
      ? const <_Step>[_Step.brand, _Step.series, _Step.sets, _Step.done]
      : const <_Step>[_Step.brand, _Step.deco, _Step.done];

  int get _index => _steps.indexOf(_step);

  void _go(int delta) => setState(() => _step = _steps[_index + delta]);

  AppSettings _chosen() {
    final AppSettings current = _scope.settings.settings;
    return AppSettings(
      ownedSetIds: _sets,
      chosenSeriesIds: <String>{for (final MarkerLine line in _series) line.id},
      extraMarkerIds: <String>{
        ...current.extraMarkerIds.where(
          (String id) => !colorIdBelongsToBrand(id, MarkerBrand.decoTime),
        ),
        ..._decoExtras,
      },
    );
  }

  Future<void> _finish({required bool apply}) async {
    final AppSettingsRepository settings = _scope.settings;
    if (apply) {
      await settings.setBrand(_brand);
      await settings.setCollection(_chosen());
    }
    await settings.setOnboardingCompleted(true);
    widget.onDone?.call();
  }

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final bool last = _step == _Step.done;
    return Scaffold(
      key: OnboardingPage.pageKey,
      body: SafeArea(
        child: Column(
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
                      context.l10n.onboardingStep(_index + 1, _steps.length),
                      style: AppTypography.data.copyWith(color: ink.fg2),
                    ),
                  ),
                  // Kept (invisible) on the last step so the header has the
                  // same height on every step and the title never jumps.
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
                padding: const EdgeInsets.all(InkSpacing.gutter),
                children: _body(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                InkSpacing.gutter,
                0,
                InkSpacing.gutter,
                InkSpacing.gutter,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    context.l10n.onboardingLaterNote,
                    style: AppTypography.secondary.copyWith(color: ink.fg2),
                  ),
                  const SizedBox(height: InkSpacing.block),
                  Row(
                    children: <Widget>[
                      if (_index > 0)
                        InkButton.secondary(
                          key: const ValueKey<String>('onboarding-back'),
                          label: context.l10n.onboardingBack,
                          onPressed: () => _go(-1),
                        ),
                      const Spacer(),
                      InkButton(
                        key: const ValueKey<String>('onboarding-next'),
                        label: last
                            ? context.l10n.onboardingFinish
                            : context.l10n.onboardingNext,
                        onPressed: last
                            ? () => _finish(apply: true)
                            : () => _go(1),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
          SelectCard(
            key: const ValueKey<String>('onboarding-brand-ohuhu'),
            title: MarkerBrand.ohuhuOahu.label,
            line: context.l10n.onboardingOhuhuLine,
            selected: _brand == MarkerBrand.ohuhuOahu,
            onTap: () => setState(() => _brand = MarkerBrand.ohuhuOahu),
          ),
          const SizedBox(height: InkSpacing.s12),
          SelectCard(
            key: const ValueKey<String>('onboarding-brand-decotime'),
            title: MarkerBrand.decoTime.label,
            line: context.l10n.onboardingDecoLine,
            selected: _brand == MarkerBrand.decoTime,
            onTap: () => setState(() => _brand = MarkerBrand.decoTime),
          ),
        ];
      case _Step.series:
        return <Widget>[
          title(context.l10n.onboardingSeriesTitle),
          body(context.l10n.onboardingSeriesBody),
          SeriesCards(
            selected: _series,
            onToggle: (MarkerLine line, bool on) => setState(() {
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
                  setState(() => on ? _sets.add(set.id) : _sets.remove(set.id)),
            ),
        ];
      case _Step.deco:
        return <Widget>[
          title(context.l10n.onboardingDecoTitle),
          body(context.l10n.collectionDecoHint),
          body(context.l10n.collectionDecoSizesHint),
          _decoFamilies(context),
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
                          _brand == MarkerBrand.ohuhuOahu
                              ? context.l10n.onboardingDoneWholeRange(
                                  _brand.label,
                                )
                              : context.l10n.onboardingDoneNoMarkers,
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
            colors.every((MarkerColor c) => _decoExtras.contains(c.colorId));
        void toggle(List<MarkerColor> colors) => setState(() {
          final bool remove = all(colors);
          for (final MarkerColor c in colors) {
            remove ? _decoExtras.remove(c.colorId) : _decoExtras.add(c.colorId);
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
}
