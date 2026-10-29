import 'dart:async';

import '../core/json_value.dart';
import '../core/models.dart';
import 'app_settings_state.dart';
import 'brand_scoping.dart';
import 'key_value_store.dart';
import 'replay_stream.dart';

/// Reads and writes the user's app settings: active brand and scope, pack
/// selection, owned markers, favourites (brand-scoped), name display mode and
/// the onboarding flag.
///
/// The Kotlin original exposed a `StateFlow`; here the equivalent is [changes]
/// (a broadcast stream that replays the current snapshot to every new
/// listener) plus [settingsChanges] for the pure-Dart collection settings.
abstract class AppSettingsRepository {
  /// The complete snapshot.
  AppSettingsState get state;

  /// Collection settings only ([AppSettings]).
  AppSettings get settings;

  MarkerBrand get brand;
  BrandScope get scope;

  /// Brand-scoped favourites (`brandId:CODE`).
  Set<String> get favorites;
  NameDisplayMode get nameDisplayMode;
  bool get onboardingCompleted;

  /// Light / dark / system appearance.
  AppThemeMode get themeMode;

  /// App language (system / Spanish / English).
  AppLanguage get language;

  /// Emits the current snapshot immediately, then every change.
  Stream<AppSettingsState> get changes;

  /// [changes] projected onto the collection settings.
  Stream<AppSettings> get settingsChanges;

  /// Reads every stored value into the snapshot (idempotent).
  Future<void> load();

  Future<void> setBrand(MarkerBrand brand);
  Future<void> setScope(BrandScope scope);

  /// The Ohuhu sets the user owns.
  Future<void> setOwnedSetIds(Set<String> ids);

  /// The single markers the user added by hand (brand-scoped ids).
  Future<void> setExtraMarkerIds(Set<String> ids);

  /// Same as [setExtraMarkerIds] (the name older call sites use).
  Future<void> setOwnedMarkerCodes(Set<String> codes);

  /// Replaces both parts of the collection in one change.
  Future<void> setCollection(AppSettings settings);
  Future<void> setMatchSuggestUnowned(bool value);
  Future<void> setFavorites(Set<String> colorIds);
  Future<void> setNameDisplayMode(NameDisplayMode mode);
  Future<void> setOnboardingCompleted(bool value);
  Future<void> setThemeMode(AppThemeMode mode);
  Future<void> setLanguage(AppLanguage language);

  /// Replaces the whole snapshot, as a backup restore does.
  Future<void> restore(AppSettingsState state);

  /// Whether [colorId] is a favourite (the id is scoped first).
  bool isFavorite(String colorId);

  /// Adds [colorId] to favourites, or removes it when already present.
  Future<void> toggleFavorite(String colorId);
}

/// [AppSettingsRepository] on top of a [KeyValueStore].
///
/// Storage keys (a design decision documented in the final report: the Kotlin
/// key names were not readable from this worktree, so stable, descriptive keys
/// were chosen and the legacy shapes the Kotlin store is known to have written
/// — bare, unscoped favourite codes — are still read):
///
/// * `active_brand`, `brand_scope`
/// * `owned_set_ids`, `extra_marker_ids` (the collection). Older versions
///   wrote `pack_selection_mode`, `selected_core_set_ids`,
///   `selected_addon_set_ids` and `owned_marker_codes`: [load] migrates them
///   once (see [AppSettings.fromLegacy]) and writes the new keys.
/// * `match_suggest_unowned`
/// * `favorite_marker_ids` (brand-scoped) with legacy fallback
///   `favorite_marker_codes`
/// * `name_display_mode`, `onboarding_completed`, `theme_mode`, `language`
final class StoredAppSettingsRepository implements AppSettingsRepository {
  StoredAppSettingsRepository(this._store, {AppSettingsState? initial})
    : _state = initial ?? AppSettingsState();

  /// Convenience: open the platform store and load it.
  static Future<StoredAppSettingsRepository> open() async {
    final repository = StoredAppSettingsRepository(
      await SharedPreferencesStore.open(),
    );
    await repository.load();
    return repository;
  }

  static const String keyBrand = 'active_brand';
  static const String keyScope = 'brand_scope';
  static const String keyPackSelectionMode = 'pack_selection_mode';
  static const String keySelectedCoreSetIds = 'selected_core_set_ids';
  static const String keySelectedAddonSetIds = 'selected_addon_set_ids';
  static const String keyOwnedMarkerCodes = 'owned_marker_codes';
  static const String keyOwnedSetIds = 'owned_set_ids';
  static const String keyExtraMarkerIds = 'extra_marker_ids';
  static const String keyChosenSeriesIds = 'chosen_series_ids';
  static const String keyMatchSuggestUnowned = 'match_suggest_unowned';
  static const String keyFavorites = 'favorite_marker_ids';
  static const String keyLegacyFavorites = 'favorite_marker_codes';
  static const String keyNameDisplayMode = 'name_display_mode';
  static const String keyOnboardingCompleted = 'onboarding_completed';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';

  final KeyValueStore _store;
  final StreamController<AppSettingsState> _controller =
      StreamController<AppSettingsState>.broadcast();

  AppSettingsState _state;

  @override
  AppSettingsState get state => _state;

  @override
  AppSettings get settings => _state.settings;

  @override
  MarkerBrand get brand => _state.brand;

  @override
  BrandScope get scope => _state.scope;

  @override
  Set<String> get favorites => _state.favorites;

  @override
  NameDisplayMode get nameDisplayMode => _state.nameDisplayMode;

  @override
  bool get onboardingCompleted => _state.onboardingCompleted;

  @override
  AppThemeMode get themeMode => _state.themeMode;

  @override
  AppLanguage get language => _state.language;

  @override
  Stream<AppSettingsState> get changes =>
      replayStream<AppSettingsState>(() => _state, _controller.stream);

  @override
  Stream<AppSettings> get settingsChanges =>
      changes.map((state) => state.settings);

  @override
  Future<void> load() async {
    final rawSets = await _store.getStringList(keyOwnedSetIds);
    final rawExtras = await _store.getStringList(keyExtraMarkerIds);
    final rawSeries = await _store.getStringList(keyChosenSeriesIds);
    final bool migrate = rawSets == null && rawExtras == null;
    AppSettings collection;
    var legacyConfigured = false;
    if (migrate) {
      final rawCore = await _store.getStringList(keySelectedCoreSetIds);
      final rawAddon = await _store.getStringList(keySelectedAddonSetIds);
      final rawOwned = await _store.getStringList(keyOwnedMarkerCodes);
      legacyConfigured =
          rawCore != null ||
          rawAddon != null ||
          (rawOwned != null && rawOwned.isNotEmpty);
      final legacy = AppSettings.fromLegacy(
        singlePackMode:
            (await _store.getString(keyPackSelectionMode))?.toLowerCase() !=
            'compare',
        selectedCoreSetIds: rawCore?.toSet(),
        selectedAddonSetIds: rawAddon?.toSet() ?? const {},
        ownedMarkerCodes: rawOwned?.toSet() ?? const {},
      );
      collection = legacy.copyWith(
        extraMarkerIds: scopedColorIds(legacy.extraMarkerIds),
      );
    } else {
      collection = AppSettings(
        ownedSetIds: rawSets?.toSet() ?? const {},
        extraMarkerIds: scopedColorIds(rawExtras ?? const []),
        chosenSeriesIds: rawSeries?.toSet() ?? const {},
      );
    }
    final rawFavorites = await _store.getStringList(keyFavorites);
    final legacyFavorites = rawFavorites == null
        ? await _store.getStringList(keyLegacyFavorites)
        : null;

    _state = AppSettingsState(
      brand: MarkerBrand.fromId(await _store.getString(keyBrand)),
      scope: _decode(
        BrandScope.values,
        await _store.getString(keyScope),
        BrandScope.singleBrand,
      ),
      settings: collection,
      favorites: scopedColorIds(rawFavorites ?? legacyFavorites ?? const []),
      nameDisplayMode: _decode(
        NameDisplayMode.values,
        await _store.getString(keyNameDisplayMode),
        NameDisplayMode.newOnly,
      ),
      // Users of older versions who had set up a collection are not asked
      // for the first-run setup again.
      onboardingCompleted:
          (await _store.getBool(keyOnboardingCompleted) ?? false) ||
          legacyConfigured,
      themeMode: _decode(
        AppThemeMode.values,
        await _store.getString(keyThemeMode),
        AppThemeMode.system,
      ),
      language: AppLanguage.fromJson(await _store.getString(keyLanguage)),
      matchSuggestUnowned: await _store.getBool(keyMatchSuggestUnowned) ?? true,
    );
    if (migrate) {
      await _store.setStringList(
        keyOwnedSetIds,
        sortedStrings(collection.ownedSetIds),
      );
      await _store.setStringList(
        keyExtraMarkerIds,
        sortedStrings(collection.extraMarkerIds),
      );
      if (legacyConfigured) await _store.setBool(keyOnboardingCompleted, true);
    }
    _controller.add(_state);
  }

  @override
  Future<void> setBrand(MarkerBrand brand) =>
      _apply(_state.copyWith(brand: brand), keys: {keyBrand: brand.id});

  @override
  Future<void> setScope(BrandScope scope) =>
      _apply(_state.copyWith(scope: scope), keys: {keyScope: scope.toJson()});

  @override
  Future<void> setOwnedSetIds(Set<String> ids) =>
      setCollection(_state.settings.copyWith(ownedSetIds: ids));

  @override
  Future<void> setExtraMarkerIds(Set<String> ids) =>
      setCollection(_state.settings.copyWith(extraMarkerIds: ids));

  @override
  Future<void> setOwnedMarkerCodes(Set<String> codes) =>
      setExtraMarkerIds(codes);

  @override
  Future<void> setCollection(AppSettings settings) {
    final next = AppSettings(
      ownedSetIds: {
        for (final id in settings.ownedSetIds)
          if (id.trim().isNotEmpty) id.trim(),
      },
      extraMarkerIds: scopedColorIds(settings.extraMarkerIds),
      chosenSeriesIds: {
        for (final id in settings.chosenSeriesIds)
          if (MarkerLine.fromId(id) != null) id.trim(),
      },
    );
    return _apply(
      _state.copyWith(settings: next),
      stringListKeys: {
        keyOwnedSetIds: sortedStrings(next.ownedSetIds),
        keyExtraMarkerIds: sortedStrings(next.extraMarkerIds),
        keyChosenSeriesIds: sortedStrings(next.chosenSeriesIds),
      },
    );
  }

  @override
  Future<void> setMatchSuggestUnowned(bool value) => _apply(
    _state.copyWith(matchSuggestUnowned: value),
    boolKeys: {keyMatchSuggestUnowned: value},
  );

  @override
  Future<void> setFavorites(Set<String> colorIds) {
    final scoped = scopedColorIds(colorIds);
    return _apply(
      _state.copyWith(favorites: scoped),
      stringListKeys: {keyFavorites: sortedStrings(scoped)},
    );
  }

  @override
  Future<void> setNameDisplayMode(NameDisplayMode mode) => _apply(
    _state.copyWith(nameDisplayMode: mode),
    keys: {keyNameDisplayMode: mode.toJson()},
  );

  @override
  Future<void> setOnboardingCompleted(bool value) => _apply(
    _state.copyWith(onboardingCompleted: value),
    boolKeys: {keyOnboardingCompleted: value},
  );

  @override
  Future<void> setThemeMode(AppThemeMode mode) => _apply(
    _state.copyWith(themeMode: mode),
    keys: {keyThemeMode: mode.toJson()},
  );

  @override
  Future<void> setLanguage(AppLanguage language) => _apply(
    _state.copyWith(language: language),
    keys: {keyLanguage: language.toJson()},
  );

  @override
  Future<void> restore(AppSettingsState state) => _apply(
    state,
    keys: {
      keyBrand: state.brand.id,
      keyScope: state.scope.toJson(),
      keyNameDisplayMode: state.nameDisplayMode.toJson(),
      keyThemeMode: state.themeMode.toJson(),
      keyLanguage: state.language.toJson(),
    },
    boolKeys: {
      keyOnboardingCompleted: state.onboardingCompleted,
      keyMatchSuggestUnowned: state.matchSuggestUnowned,
    },
    stringListKeys: {
      keyOwnedSetIds: sortedStrings(state.settings.ownedSetIds),
      keyExtraMarkerIds: sortedStrings(state.settings.extraMarkerIds),
      keyChosenSeriesIds: sortedStrings(state.settings.chosenSeriesIds),
      keyFavorites: sortedStrings(state.favorites),
    },
  );

  @override
  bool isFavorite(String colorId) {
    final scoped = scopedColorId(colorId);
    return scoped != null && _state.favorites.contains(scoped);
  }

  @override
  Future<void> toggleFavorite(String colorId) {
    final scoped = scopedColorId(colorId);
    if (scoped == null) return Future<void>.value();
    final next = {..._state.favorites};
    if (next.contains(scoped)) {
      next.remove(scoped);
    } else {
      next.add(scoped);
    }
    return setFavorites(next);
  }

  Future<void> _apply(
    AppSettingsState next, {
    Map<String, String> keys = const {},
    Map<String, bool> boolKeys = const {},
    Map<String, List<String>> stringListKeys = const {},
  }) async {
    for (final entry in stringListKeys.entries) {
      await _store.setStringList(entry.key, entry.value);
    }
    for (final entry in keys.entries) {
      await _store.setString(entry.key, entry.value);
    }
    for (final entry in boolKeys.entries) {
      await _store.setBool(entry.key, entry.value);
    }
    _state = next;
    _controller.add(_state);
  }
}

T _decode<T extends Enum>(List<T> values, String? json, T fallback) {
  try {
    return decodeEnum(values, json);
  } on FormatException {
    return fallback;
  }
}
