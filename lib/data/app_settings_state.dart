import '../core/json_value.dart';
import '../core/models.dart';
import 'brand_scoping.dart';

/// The appearance the user picked: follow the system, or force light / dark.
enum AppThemeMode {
  system,
  light,
  dark;

  String toJson() => enumJson(this);
  static AppThemeMode fromJson(Object? json) => decodeEnum(values, json);
}

/// The language of the app: follow the device, or force Spanish / English.
///
/// Stored as `system`, `es` or `en`. Decoding is lenient (case-insensitive,
/// also accepts `spanish` / `english`) and falls back to [system], so an old
/// or hand-written backup never fails to import.
enum AppLanguage {
  system(null),
  spanish('es'),
  english('en');

  const AppLanguage(this.languageCode);

  /// The ISO 639-1 code forced by this choice, or `null` to follow the device.
  final String? languageCode;

  String toJson() => languageCode ?? 'system';

  static AppLanguage fromJson(Object? json) {
    final raw = json is String ? json.trim().toLowerCase() : '';
    return switch (raw) {
      'es' || 'spanish' || 'español' || 'es-es' || 'es_es' => spanish,
      'en' || 'english' || 'en-us' || 'en_us' || 'en-gb' => english,
      _ => system,
    };
  }
}

/// Everything the Kotlin `AppSettingsStore` persisted: the collection settings
/// (brand, scope, owned sets and extra markers) plus the UI-adjacent
/// preferences that the pure-Dart [AppSettings] intentionally leaves out
/// (favourites, name display, onboarding).
///
/// This is the snapshot a repository exposes and the unit a backup restores.
/// Its wire shape is flat; the backup envelope stores it under `appSettings`.
final class AppSettingsState with JsonValue {
  AppSettingsState({
    this.brand = MarkerBrand.ohuhuOahu,
    this.scope = BrandScope.singleBrand,
    AppSettings? settings,
    Set<String> favorites = const {},
    this.nameDisplayMode = NameDisplayMode.newOnly,
    this.onboardingCompleted = false,
    this.themeMode = AppThemeMode.system,
    this.language = AppLanguage.system,
    this.matchSuggestUnowned = true,
  }) : settings = settings ?? AppSettings(),
       favorites = Set.unmodifiable(favorites);

  final MarkerBrand brand;
  final BrandScope scope;
  final AppSettings settings;

  /// Brand-scoped ids (`brandId:CODE`) of the favourite swatches.
  final Set<String> favorites;
  final NameDisplayMode nameDisplayMode;
  final bool onboardingCompleted;

  /// Light / dark / system appearance (backward compatible default: system).
  final AppThemeMode themeMode;

  /// App language (backward compatible default: follow the device).
  final AppLanguage language;

  /// Match also shows the closest marker of the whole range when none of the
  /// user's markers is close (backward compatible default: on).
  final bool matchSuggestUnowned;

  AppSettingsState copyWith({
    MarkerBrand? brand,
    BrandScope? scope,
    AppSettings? settings,
    Set<String>? favorites,
    NameDisplayMode? nameDisplayMode,
    bool? onboardingCompleted,
    AppThemeMode? themeMode,
    AppLanguage? language,
    bool? matchSuggestUnowned,
  }) => AppSettingsState(
    brand: brand ?? this.brand,
    scope: scope ?? this.scope,
    settings: settings ?? this.settings,
    favorites: favorites ?? this.favorites,
    nameDisplayMode: nameDisplayMode ?? this.nameDisplayMode,
    onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
    themeMode: themeMode ?? this.themeMode,
    language: language ?? this.language,
    matchSuggestUnowned: matchSuggestUnowned ?? this.matchSuggestUnowned,
  );

  /// Adds or removes a favourite, returning a new state.
  AppSettingsState withFavorite(String colorId, {bool favorite = true}) {
    final next = {...favorites};
    if (favorite) {
      next.add(colorId);
    } else {
      next.remove(colorId);
    }
    return copyWith(favorites: next);
  }

  factory AppSettingsState.fromJson(Map<String, dynamic> json) =>
      AppSettingsState(
        brand: MarkerBrand.fromId(_string(json['brand'])),
        scope: _enum(BrandScope.values, json['scope'], BrandScope.singleBrand),
        settings: _settingsFromJson(json),
        favorites: scopedColorIds(_strings(json['favorites']) ?? const {}),
        nameDisplayMode: _enum(
          NameDisplayMode.values,
          json['nameDisplayMode'],
          NameDisplayMode.newOnly,
        ),
        // A backup of an older version with a configured collection does not
        // ask for the first-run setup again.
        onboardingCompleted:
            json['onboardingCompleted'] == true ||
            (!json.containsKey('ownedSetIds') && _hasLegacyCollection(json)),
        themeMode: _enum(
          AppThemeMode.values,
          json['themeMode'],
          AppThemeMode.system,
        ),
        language: AppLanguage.fromJson(json['language']),
        matchSuggestUnowned: json['matchSuggestUnowned'] != false,
      );

  @override
  Map<String, dynamic> toJson() => {
    'brand': brand.id,
    'scope': scope.toJson(),
    'ownedSetIds': sortedStrings(settings.ownedSetIds),
    'extraMarkerIds': sortedStrings(settings.extraMarkerIds),
    'chosenSeriesIds': sortedStrings(settings.chosenSeriesIds),
    'favorites': sortedStrings(favorites),
    'nameDisplayMode': nameDisplayMode.toJson(),
    'onboardingCompleted': onboardingCompleted,
    'themeMode': themeMode.toJson(),
    'language': language.toJson(),
    'matchSuggestUnowned': matchSuggestUnowned,
  };
}

/// The collection of a backup: the current fields, or the pack and owned
/// marker fields older versions wrote (migrated, see [AppSettings.fromLegacy]).
AppSettings _settingsFromJson(Map<String, dynamic> json) {
  final ownedSets = _strings(json['ownedSetIds']);
  final extras = _strings(json['extraMarkerIds']);
  if (ownedSets != null || extras != null) {
    return AppSettings(
      ownedSetIds: ownedSets ?? const {},
      extraMarkerIds: scopedColorIds(extras ?? const {}),
      chosenSeriesIds: _strings(json['chosenSeriesIds']) ?? const {},
    );
  }
  final legacy = AppSettings.fromLegacy(
    singlePackMode: '${json['packSelectionMode']}'.toLowerCase() != 'compare',
    selectedCoreSetIds: _strings(json['selectedCoreSetIds']),
    selectedAddonSetIds: _strings(json['selectedAddonSetIds']) ?? const {},
    ownedMarkerCodes: _strings(json['ownedMarkerCodes']) ?? const {},
  );
  return legacy.copyWith(extraMarkerIds: scopedColorIds(legacy.extraMarkerIds));
}

bool _hasLegacyCollection(Map<String, dynamic> json) =>
    json['selectedCoreSetIds'] is List ||
    json['selectedAddonSetIds'] is List ||
    (json['ownedMarkerCodes'] is List &&
        (json['ownedMarkerCodes'] as List).isNotEmpty);

/// Deterministic, sorted string list for set-backed fields.
List<String> sortedStrings(Iterable<String> values) => values.toList()..sort();

String? _string(Object? value) => value is String ? value : null;

Set<String>? _strings(Object? value) {
  if (value is! List) return null;
  return {
    for (final item in value)
      if (item is String) item,
  };
}

T _enum<T extends Enum>(List<T> values, Object? json, T fallback) {
  try {
    return decodeEnum(values, json);
  } on FormatException {
    return fallback;
  }
}
