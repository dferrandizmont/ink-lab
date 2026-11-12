import 'dart:async';

import '../core/json_value.dart';
import '../core/models.dart';
import 'app_settings_state.dart';
import 'brand_scoping.dart';
import 'key_value_store.dart';
import 'onboarding_draft.dart';
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

  /// Whether the store's review dialog was already asked for on this device.
  /// Not part of [state] or of backups: a restore must not bring the question
  /// back, and the question is about this install.
  bool get reviewPromptAsked;

  /// How many times the store said it has no review dialog on this device
  /// (a side-loaded app, no Play). Not part of [state] or of backups.
  int get reviewPromptUnavailable;

  /// The first-run setup left half-way (step and choices), or null. Not part
  /// of [state] or of backups: it is cleared when the setup ends.
  OnboardingDraft? get onboardingDraft;

  /// Light / dark / system appearance.
  AppThemeMode get themeMode;

  /// App language (system / Spanish / English).
  AppLanguage get language;

  /// Whether the navigation rail of a wide screen shows its labels beside the
  /// icons (default: folded).
  bool get railExpanded;

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

  /// Adds [ids] to the single markers the user owns, keeping the ones they
  /// already have.
  ///
  /// The ids are added to the collection the repository holds when the write
  /// runs: a marker the user added elsewhere in between is never lost. Two
  /// calls that overlap are applied one after the other, never on the same
  /// state.
  Future<void> addExtraMarkerIds(Set<String> ids);

  /// Removes [ids] from the single markers the user owns.
  ///
  /// The ids are taken from the collection the repository holds when the
  /// write runs: a marker the user added elsewhere in between is never lost.
  /// Two calls that overlap are applied one after the other, never on the
  /// same state.
  Future<void> removeExtraMarkerIds(Set<String> ids);

  /// Same as [setExtraMarkerIds] (the name older call sites use).
  Future<void> setOwnedMarkerCodes(Set<String> codes);

  /// Replaces both parts of the collection in one change.
  Future<void> setCollection(AppSettings settings);
  Future<void> setMatchSuggestUnowned(bool value);

  /// Whether the colours the user stored for their markers are used.
  Future<void> setUseOwnColors(bool value);
  Future<void> setFavorites(Set<String> colorIds);
  Future<void> setNameDisplayMode(NameDisplayMode mode);
  Future<void> setOnboardingCompleted(bool value);

  /// Saves the half-done setup, or forgets it when [draft] is null.
  Future<void> setOnboardingDraft(OnboardingDraft? draft);
  Future<void> setThemeMode(AppThemeMode mode);
  Future<void> setLanguage(AppLanguage language);

  /// Unfolds (true) or folds (false) the navigation rail of a wide screen.
  Future<void> setRailExpanded(bool value);

  /// When a backup file was last saved or shared on this device, or `null`.
  DateTime? get lastBackupAt;

  /// Stores [time] as the moment of the last backup file.
  Future<void> setLastBackupAt(DateTime time);

  /// Remembers that the review dialog was asked for (or that it never will
  /// be). Once true it is never reset.
  Future<void> setReviewPromptAsked(bool value);

  /// Stores how many times the review dialog was unavailable.
  Future<void> setReviewPromptUnavailable(int count);

  /// Replaces the whole snapshot, as a backup restore does. The date of the
  /// last backup is kept: it describes this device, not the backup.
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
/// * `match_suggest_unowned`, `use_own_colors`, `rail_expanded` (the
///   navigation rail of a wide screen is unfolded)
/// * `favorite_marker_ids` (brand-scoped) with legacy fallback
///   `favorite_marker_codes`
/// * `name_display_mode`, `onboarding_completed`, `theme_mode`, `language`
/// * `onboarding_draft`: the half-done first-run setup as one JSON string
///   (removed when the setup ends; not part of the snapshot or of backups)
/// * `last_backup_at` (epoch milliseconds; never part of a backup)
/// * `review_prompt_asked`: whether the store review dialog was asked for
///   (not part of the snapshot or of backups)
/// * `review_prompt_unavailable`: how many times the store had no review
///   dialog (same)
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
  static const String keyUseOwnColors = 'use_own_colors';
  static const String keyRailExpanded = 'rail_expanded';
  static const String keyFavorites = 'favorite_marker_ids';
  static const String keyLegacyFavorites = 'favorite_marker_codes';
  static const String keyNameDisplayMode = 'name_display_mode';
  static const String keyOnboardingCompleted = 'onboarding_completed';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  static const String keyOnboardingDraft = 'onboarding_draft';
  static const String keyLastBackupAt = 'last_backup_at';
  static const String keyReviewPromptAsked = 'review_prompt_asked';
  static const String keyReviewPromptUnavailable = 'review_prompt_unavailable';

  final KeyValueStore _store;
  final StreamController<AppSettingsState> _controller =
      StreamController<AppSettingsState>.broadcast();

  AppSettingsState _state;
  OnboardingDraft? _draft;
  bool _reviewPromptAsked = false;
  int _reviewPromptUnavailable = 0;

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
  OnboardingDraft? get onboardingDraft => _draft;

  @override
  bool get reviewPromptAsked => _reviewPromptAsked;

  @override
  int get reviewPromptUnavailable => _reviewPromptUnavailable;

  @override
  AppThemeMode get themeMode => _state.themeMode;

  @override
  AppLanguage get language => _state.language;

  @override
  bool get railExpanded => _state.railExpanded;

  @override
  DateTime? get lastBackupAt {
    final int? millis = _state.lastBackupAtEpochMs;
    return millis == null ? null : DateTime.fromMillisecondsSinceEpoch(millis);
  }

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
      useOwnColors: await _store.getBool(keyUseOwnColors) ?? true,
      railExpanded: await _store.getBool(keyRailExpanded) ?? false,
      lastBackupAtEpochMs: await _store.getInt(keyLastBackupAt),
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
    _draft = OnboardingDraft.decode(await _store.getString(keyOnboardingDraft));
    _reviewPromptAsked = await _store.getBool(keyReviewPromptAsked) ?? false;
    _reviewPromptUnavailable =
        await _store.getInt(keyReviewPromptUnavailable) ?? 0;
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
      _mutate((AppSettings settings) => settings.copyWith(ownedSetIds: ids));

  @override
  Future<void> setExtraMarkerIds(Set<String> ids) =>
      _mutate((AppSettings settings) => settings.copyWith(extraMarkerIds: ids));

  @override
  Future<void> addExtraMarkerIds(Set<String> ids) => _mutate(
    (AppSettings settings) => settings.copyWith(
      extraMarkerIds: <String>{...settings.extraMarkerIds, ...ids},
    ),
  );

  @override
  Future<void> removeExtraMarkerIds(Set<String> ids) =>
      _mutate((AppSettings settings) {
        final Set<String> next = <String>{...settings.extraMarkerIds}
          ..removeAll(ids);
        return settings.copyWith(extraMarkerIds: next);
      });

  @override
  Future<void> setOwnedMarkerCodes(Set<String> codes) =>
      setExtraMarkerIds(codes);

  @override
  Future<void> setCollection(AppSettings settings) =>
      _enqueue(() => _writeCollection(settings));

  /// Low-level write of a collection snapshot: normalises it and persists it.
  /// Not queued on its own; callers are expected to run it inside the queue.
  Future<void> _writeCollection(AppSettings settings) {
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
  Future<void> setUseOwnColors(bool value) => _apply(
    _state.copyWith(useOwnColors: value),
    boolKeys: {keyUseOwnColors: value},
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
  Future<void> setOnboardingDraft(OnboardingDraft? draft) async {
    if (draft == null) {
      await _store.remove(keyOnboardingDraft);
    } else {
      await _store.setString(keyOnboardingDraft, draft.encode());
    }
    _draft = draft;
  }

  @override
  Future<void> setReviewPromptAsked(bool value) async {
    await _store.setBool(keyReviewPromptAsked, value);
    _reviewPromptAsked = value;
  }

  @override
  Future<void> setReviewPromptUnavailable(int count) async {
    await _store.setInt(keyReviewPromptUnavailable, count);
    _reviewPromptUnavailable = count;
  }

  @override
  Future<void> setThemeMode(AppThemeMode mode) => _apply(
    _state.copyWith(themeMode: mode),
    keys: {keyThemeMode: mode.toJson()},
  );

  @override
  Future<void> setRailExpanded(bool value) => _apply(
    _state.copyWith(railExpanded: value),
    boolKeys: {keyRailExpanded: value},
  );

  @override
  Future<void> setLanguage(AppLanguage language) => _apply(
    _state.copyWith(language: language),
    keys: {keyLanguage: language.toJson()},
  );

  @override
  Future<void> setLastBackupAt(DateTime time) {
    final int millis = time.millisecondsSinceEpoch;
    return _apply(
      _state.copyWith(lastBackupAtEpochMs: millis),
      intKeys: {keyLastBackupAt: millis},
    );
  }

  @override
  Future<void> restore(AppSettingsState state) =>
      _enqueue(() => _restore(state));

  Future<void> _restore(AppSettingsState state) => _apply(
    state.copyWith(lastBackupAtEpochMs: _state.lastBackupAtEpochMs),
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
      keyUseOwnColors: state.useOwnColors,
      keyRailExpanded: state.railExpanded,
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

  /// The writes of the collection, one after the other.
  ///
  /// Two changes that overlap (the user ticks two markers before the first
  /// write lands) must not read the same state: the second one would write
  /// the collection of before the first one and the marker of the first one
  /// would be lost.
  Future<void> _writes = Future<void>.value();

  /// Enqueue primitive shared by every writer of collection state: each job
  /// waits for the previous one to finish, then runs. A failed job is swallowed
  /// for the chain (the error still reaches its own caller) so the next job
  /// still runs from the stored state.
  Future<void> _enqueue(Future<void> Function() action) {
    final Future<void> run = _writes.then((_) => action());
    _writes = run.catchError((Object _) {});
    return run;
  }

  /// Applies [change] to the collection the repository holds when the write
  /// runs, not when it was asked for.
  ///
  /// The writes are serialised: each one starts when the previous one has
  /// landed, so the merge is always made on the latest collection.
  Future<void> _mutate(AppSettings Function(AppSettings) change) =>
      _enqueue(() => _writeCollection(change(_state.settings)));

  Future<void> _apply(
    AppSettingsState next, {
    Map<String, String> keys = const {},
    Map<String, bool> boolKeys = const {},
    Map<String, int> intKeys = const {},
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
    for (final entry in intKeys.entries) {
      await _store.setInt(entry.key, entry.value);
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
