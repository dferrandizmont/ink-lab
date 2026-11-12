import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:ui' show Locale, PlatformDispatcher;

import 'package:flutter/widgets.dart';
import 'package:home_widget/home_widget.dart';

import '../core/collection_selection.dart';
import '../core/ideas_engine.dart';
import '../core/marker_repository.dart';
import '../core/models.dart';
import '../l10n/l10n.dart';
import 'app_settings_repository.dart';
import 'app_settings_state.dart';
import 'color_id_set_repository.dart';
import 'own_color_repository.dart';

/// Writes the widget's JSON where the Android widget reads it, and asks the
/// home screen to redraw. Tests inject a recorder.
typedef IdeaWidgetWriter = Future<void> Function(String json);

/// Day zero of the idea of the day: the widget counts the days since this one
/// (it is part of the JSON, so the Kotlin side never hard-codes it).
const String ideaWidgetEpoch = '2024-01-01';

/// Key under which the JSON is stored for the widget.
const String ideaWidgetDataKey = 'ideas';

/// Fully qualified class of the Android widget provider.
const String ideaWidgetProvider = 'dev.inklab.ink_lab.IdeaWidgetProvider';

/// The most colour chips the widget draws.
const int ideaWidgetMaxColors = 5;

/// Placeholder for the minutes inside the localised "N min" pattern.
const String _minutesToken = '{n}';

/// A number no real duration reaches: swapped for [_minutesToken] after the
/// localisation formatted it.
const int _minutesProbe = 987654;

/// The language the widget texts use: the one forced in the settings, or the
/// first of the device's languages the app has, or English.
Locale ideaWidgetLocale(AppLanguage language, List<Locale> device) {
  final String? forced = language.languageCode;
  if (forced != null) return Locale(forced);
  for (final Locale locale in device) {
    if (AppLocalizations.supportedLocales.any(
      (Locale l) => l.languageCode == locale.languageCode,
    )) {
      return Locale(locale.languageCode);
    }
  }
  return const Locale('en');
}

/// `#RRGGBB` for a catalogue hex (`rrggbb`, with or without `#`), or `null`.
String? ideaWidgetHex(String hex) {
  final String raw = hex.startsWith('#') ? hex.substring(1) : hex;
  return RegExp(r'^[0-9a-fA-F]{6}$').hasMatch(raw)
      ? '#${raw.toUpperCase()}'
      : null;
}

/// The JSON the Android widget reads: every idea of the catalogue, in the
/// catalogue's order, with the user's own markers picked for its palette.
///
/// The widget works out today's idea itself (days since [ideaWidgetEpoch]
/// modulo the number of items, like [IdeasEngine.featuredFor]), so it shows
/// the right idea every day without the app running.
String buildIdeaWidgetJson({
  required AppLocalizations l10n,
  required List<MarkerColor> candidates,
}) {
  final List<Map<String, Object>> items = <Map<String, Object>>[];
  for (final IdeaPreset preset in IdeasEngine.presets) {
    final IdeaPlan plan = IdeasEngine.generatePlan(preset, candidates);
    final List<String> colors = <String>[
      for (final s in plan.palette)
        if (ideaWidgetHex(s.color.hex) case final String hex) hex,
    ].take(ideaWidgetMaxColors).toList();
    items.add(<String, Object>{
      'id': preset.id,
      'title': l10n.ideaTitle(preset),
      'summary': l10n.ideaSummary(preset),
      'category': preset.category.name,
      'minutes': preset.minutes,
      'colors': colors,
    });
  }
  return jsonEncode(<String, Object>{
    'epoch': ideaWidgetEpoch,
    'label': l10n.ideasFeaturedLabel,
    'minutesFmt': l10n
        .ideasMinutes(_minutesProbe)
        .replaceAll('$_minutesProbe', _minutesToken),
    'items': items,
  });
}

/// The default [IdeaWidgetWriter]: stores the JSON for the widget and asks the
/// launcher to redraw it (Android only).
Future<void> writeIdeaWidgetData(String json) async {
  await HomeWidget.saveWidgetData<String>(ideaWidgetDataKey, json);
  await HomeWidget.updateWidget(qualifiedAndroidName: ideaWidgetProvider);
}

/// Keeps the "Idea of the day" home-screen widget up to date.
///
/// It writes the widget's JSON ([buildIdeaWidgetJson]) when the app starts or
/// comes back to the front, and when the language, the collection, the brand,
/// an own colour or a dried-out marker changes. Nothing runs in the
/// background: between those moments the widget picks the day's idea itself.
///
/// It does nothing off Android (iOS has no widget yet) and in tests, unless a
/// [writer] is injected, and a failure of any kind is swallowed: a widget that
/// is not updated never gets in the way of the app.
class IdeaWidgetSync with WidgetsBindingObserver {
  IdeaWidgetSync({
    required this.settings,
    required this.markers,
    required this.ownColors,
    required this.dried,
    IdeaWidgetWriter? writer,
    bool? enabled,
    List<Locale> Function()? deviceLocales,
    this.debounce = const Duration(milliseconds: 600),
  }) : writer = writer ?? writeIdeaWidgetData,
       enabled = enabled ?? (writer != null || _isAndroid),
       deviceLocales = deviceLocales ?? _platformLocales;

  final AppSettingsRepository settings;
  final MarkerRepository markers;
  final OwnColorRepository ownColors;
  final DriedMarkerRepository dried;

  /// Where the JSON goes.
  final IdeaWidgetWriter writer;

  /// Whether to sync at all; off by default off Android.
  final bool enabled;

  /// The device's preferred languages, for the "system" language setting.
  final List<Locale> Function() deviceLocales;

  /// How long to wait after a change before writing, so a burst of changes
  /// (a whole set ticked) writes once.
  final Duration debounce;

  final List<StreamSubscription<Object?>> _subscriptions =
      <StreamSubscription<Object?>>[];
  Timer? _timer;
  bool _observing = false;
  bool _running = false;
  bool _again = false;

  static bool get _isAndroid {
    try {
      return Platform.isAndroid;
    } catch (_) {
      return false;
    }
  }

  static List<Locale> _platformLocales() => PlatformDispatcher.instance.locales;

  /// Starts listening to the changes that alter the widget and writes once
  /// now. With [observeLifecycle] it also writes again every time the app comes
  /// back to the front (needs the widgets binding).
  void start({bool observeLifecycle = true}) {
    if (!enabled || _subscriptions.isNotEmpty) return;
    // Each of these emits its current value first, which is the start-up sync.
    _subscriptions
      ..add(settings.changes.listen((_) => _schedule()))
      ..add(ownColors.changes.listen((_) => _schedule()))
      ..add(dried.changes.listen((_) => _schedule()));
    if (observeLifecycle) {
      try {
        WidgetsBinding.instance.addObserver(this);
        _observing = true;
      } catch (_) {
        // No binding (a plain unit test): the streams are enough.
      }
    }
  }

  /// Stops listening.
  Future<void> dispose() async {
    _timer?.cancel();
    _timer = null;
    for (final StreamSubscription<Object?> s in _subscriptions) {
      await s.cancel();
    }
    _subscriptions.clear();
    if (_observing) {
      try {
        WidgetsBinding.instance.removeObserver(this);
      } catch (_) {}
      _observing = false;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _schedule();
  }

  @override
  void didChangeLocales(List<Locale>? locales) => _schedule();

  void _schedule() {
    _timer?.cancel();
    _timer = Timer(debounce, () => unawaited(sync()));
  }

  /// Writes the widget's JSON now. Never throws.
  Future<void> sync() async {
    if (!enabled) return;
    if (_running) {
      _again = true;
      return;
    }
    _running = true;
    try {
      do {
        _again = false;
        await _write();
      } while (_again);
    } catch (_) {
      // The widget keeps its last data; the app does not care.
    } finally {
      _running = false;
    }
  }

  Future<void> _write() async {
    final MarkerBrand brand = settings.brand;
    final AppSettings collection = settings.settings;
    List<MarkerColor> catalog;
    try {
      catalog = await markers.loadCollectionCatalog(
        brand: brand,
        settings: collection,
        scope: settings.scope,
      );
    } catch (_) {
      catalog = const <MarkerColor>[];
    }
    final List<MarkerColor> candidates = paletteCandidateColors(
      colors: catalog,
      scope: settings.scope,
      brand: brand,
      activeSetIds: collection.effectiveSetIds(),
      ownedMarkerCodes: collection.ownedMarkerCodes,
      driedColorIds: dried.ids,
    );
    final Locale locale = ideaWidgetLocale(settings.language, deviceLocales());
    await writer(
      buildIdeaWidgetJson(
        l10n: lookupAppLocalizations(locale),
        candidates: candidates,
      ),
    );
  }
}
