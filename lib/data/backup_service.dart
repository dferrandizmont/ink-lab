import 'dart:convert';

import '../core/models.dart';
import 'ai_settings.dart';
import 'ai_settings_repository.dart';
import 'app_settings_repository.dart';
import 'app_settings_state.dart';
import 'artwork_diary_repository.dart';
import 'artwork_photo_store.dart';
import 'color_id_set_repository.dart';
import 'color_match_history_repository.dart';
import 'data_exceptions.dart';
import 'idea_favorites_repository.dart';
import 'own_color_repository.dart';
import 'saved_palette_repository.dart';

/// Export and import of user data as a versioned, plain (unencrypted) JSON
/// document.
///
/// The document holds settings + favourites, saved palettes, colour-match
/// history, the colours the user stored for their own markers, the wishlist,
/// the dried-out markers, the artwork diary entries, the favourite ideas with
/// the ideas opened last, and the non-secret AI settings. It never contains an
/// API key or any other secret: those live
/// behind `SecretStore` and are out of scope here. The diary entries carry
/// their text, date, marker ids, palette id and the *names* of their photo
/// files, never the photos themselves: the document goes to the clipboard.
/// Encryption/password variants are also out of scope.
///
/// The envelope is:
///
/// ```json
/// {
///   "version": 1,
///   "appSettings": { ...AppSettingsState... },
///   "savedPalettes": { "<brandId>": [ ...SavedPalette... ] },
///   "colorMatchHistory": [ ...ColorMatchPick... ],
///   "ownColors": { "<brandId>:<CODE>": "rrggbb" },
///   "wishlist": [ "<brandId>:<CODE>", ... ],
///   "driedMarkers": [ "<brandId>:<CODE>", ... ],
///   "artworkDiary": [ ...ArtworkEntry... ],
///   "aiSettings": { ...AiSettings... },
///   "ideaFavorites": [ "<ideaId>", ... ],
///   "recentIdeas": [ "<ideaId>", ... ]
/// }
/// ```
///
/// The inner objects use the Kotlin wire field names (`SavedPalette.toJson`,
/// `ColorMatchPick.toJson`, and so on), which is what makes a backup written by
/// the Kotlin `BackupCodec` plain variant importable here.
final class BackupService {
  BackupService({
    required this.appSettings,
    required this.savedPalettes,
    required this.history,
    required this.aiSettings,
    required this.ownColors,
    required this.wishlist,
    required this.dried,
    required this.artworkDiary,
    required this.ideaFavorites,
  });

  /// Version written by [exportJson]; the newest version this service imports.
  static const int currentVersion = 1;

  static const String versionField = 'version';

  /// The most characters a backup document may have.
  ///
  /// The documents the app writes are far below it (the diary texts and the
  /// photo file names are the only free text). A bigger one is refused
  /// instead of read, so a hostile document cannot make the app walk an
  /// unbounded amount of data.
  static const int maxDocumentLength = 4 * 1024 * 1024;

  /// The longest an idea id may be.
  ///
  /// The ids of the ideas catalogue are short words; anything longer is not
  /// an id this build could have written.
  static const int maxIdeaIdLength = 64;

  /// The shape of an idea id: the lower-case words of the catalogue, joined
  /// with underscores.
  static final RegExp _ideaIdPattern = RegExp(r'^[a-z0-9_]+$');

  final AppSettingsRepository appSettings;
  final SavedPaletteRepository savedPalettes;
  final ColorMatchHistoryRepository history;
  final AiSettingsRepository aiSettings;
  final OwnColorRepository ownColors;
  final WishlistRepository wishlist;
  final DriedMarkerRepository dried;
  final ArtworkDiaryRepository artworkDiary;

  /// The favourite ideas and the ideas opened last.
  final IdeaFavoritesRepository ideaFavorites;

  /// Serialises the current state. Deterministic for a given state, so
  /// `export -> import -> export` is byte-identical.
  String exportJson({bool pretty = false}) {
    final payload = <String, dynamic>{
      versionField: currentVersion,
      'appSettings': appSettings.state.toJson(),
      'savedPalettes': {
        for (final entry in savedPalettes.exportByBrand().entries)
          entry.key: [for (final palette in entry.value) palette.toJson()],
      },
      'colorMatchHistory': [for (final pick in history.entries) pick.toJson()],
      'ownColors': ownColors.colors,
      'wishlist': wishlist.ids.toList(),
      'driedMarkers': dried.ids.toList(),
      'artworkDiary': [
        for (final entry in artworkDiary.entries) entry.toJson(),
      ],
      'aiSettings': aiSettings.value.toJson(),
      'ideaFavorites': ideaFavorites.favorites.toList()..sort(),
      'recentIdeas': ideaFavorites.recent,
    };
    return pretty
        ? const JsonEncoder.withIndent('  ').convert(payload)
        : jsonEncode(payload);
  }

  /// Restores the state from [source], replacing every section the document
  /// carries. Missing sections are left untouched; unknown fields are ignored.
  ///
  /// The whole document is read and checked before anything is written, so a
  /// document that is refused leaves the data the user has exactly as it was:
  /// the diary, its photos and the palettes included.
  ///
  /// Throws a [BackupFormatException] for anything that is not a readable
  /// backup document.
  Future<void> importJson(String source) async {
    final _BackupDocument document = _readDocument(source);
    await _writeDocument(document);
  }

  /// Reads and checks [source] as a backup document, without writing
  /// anything.
  ///
  /// This is the very check the import runs, so a document refused here
  /// would be refused there too: a caller that wants to know whether a
  /// document is readable before it replaces anything can ask.
  ///
  /// Throws a [BackupFormatException] for anything that is not a readable
  /// backup document.
  void validateJson(String source) {
    _readDocument(source);
  }

  /// The photo names the diary entries of [source] refer to, read and
  /// checked, without writing anything.
  ///
  /// The whole document is read and checked, exactly as [validateJson] does,
  /// so a document that is refused throws a [BackupFormatException] here too.
  /// `null` means the document carries no diary section: the diary the user
  /// has stays as it is.
  ///
  /// Only names that are safe photo names are returned, so a name that comes
  /// from a hostile document can never point outside the photo folder.
  Set<String>? readDiaryPhotoNames(String source) {
    final _BackupDocument document = _readDocument(source);
    final List<ArtworkEntry>? diary = document.artworkDiary;
    if (diary == null) return null;
    return <String>{
      for (final ArtworkEntry entry in diary)
        for (final String name in entry.photos)
          if (isSafePhotoName(name)) name,
    };
  }

  /// Reads every section of the document and checks it. Nothing is written
  /// here: a document that does not pass leaves the user data alone.
  _BackupDocument _readDocument(String source) {
    if (source.length > maxDocumentLength) {
      throw BackupFormatException(
        'the document is too long (${source.length} characters, the limit is '
        '$maxDocumentLength)',
      );
    }

    final Object? decoded;
    try {
      decoded = jsonDecode(source);
    } on FormatException catch (error) {
      throw BackupFormatException('not valid JSON: ${error.message}');
    }
    final payload = _asMap(decoded, null, 'the backup root');

    final rawVersion = payload[versionField] ?? currentVersion;
    if (rawVersion is! int) {
      throw const BackupFormatException(
        'version must be an integer',
        field: versionField,
      );
    }
    if (rawVersion < 1 || rawVersion > currentVersion) {
      throw BackupFormatException(
        'unsupported backup version $rawVersion '
        '(this build supports 1..$currentVersion)',
        field: versionField,
      );
    }

    // Backups written before own colours existed have no such section: the
    // colours the user has stay as they are. Same for the wishlist, the
    // dried-out markers (added in 0.7), the artwork diary and the ideas
    // (added in 0.8).
    final settings = payload['appSettings'];
    final palettes = payload['savedPalettes'];
    final picks = payload['colorMatchHistory'];
    final own = payload['ownColors'];
    final wished = payload['wishlist'];
    final dry = payload['driedMarkers'];
    final diary = payload['artworkDiary'];
    final ai = payload['aiSettings'];
    final favorites = payload['ideaFavorites'];
    final recent = payload['recentIdeas'];

    return _BackupDocument(
      appSettings: settings == null
          ? null
          : _parse('appSettings', settings, AppSettingsState.fromJson),
      savedPalettes: palettes == null
          ? null
          : _readPalettes(palettes),
      history: picks == null
          ? null
          : _parseList('colorMatchHistory', picks, ColorMatchPick.fromJson),
      ownColors: own == null ? null : _readOwnColors(own),
      wishlist: wished == null ? null : _parseIds('wishlist', wished),
      driedMarkers: dry == null ? null : _parseIds('driedMarkers', dry),
      artworkDiary: diary == null
          ? null
          : _parseList('artworkDiary', diary, ArtworkEntry.fromJson),
      // Never let an imported file switch the AI on: it is an explicit opt-in.
      aiSettings: ai == null
          ? null
          : _parse('aiSettings', ai, AiSettings.fromJson).copyWith(
              enabled: false,
            ),
      ideaFavorites: favorites == null
          ? null
          : _parseIdeaIds(
              'ideaFavorites',
              favorites,
              IdeaFavoritesRepository.maxFavorites,
            ),
      recentIdeas: recent == null
          ? null
          : _parseIdeaIds(
              'recentIdeas',
              recent,
              IdeaFavoritesRepository.maxRecent,
            ),
    );
  }

  /// Writes the sections the document carries. The order is the one the
  /// export uses.
  Future<void> _writeDocument(_BackupDocument document) async {
    final AppSettingsState? settings = document.appSettings;
    if (settings != null) await appSettings.restore(settings);

    final Map<String, List<SavedPalette>>? palettes = document.savedPalettes;
    if (palettes != null) await savedPalettes.restore(palettes);

    final List<ColorMatchPick>? picks = document.history;
    if (picks != null) await history.restore(picks);

    final Map<String, String>? own = document.ownColors;
    if (own != null) await ownColors.restore(own);

    final List<String>? wished = document.wishlist;
    if (wished != null) await wishlist.restore(wished);

    final List<String>? dry = document.driedMarkers;
    if (dry != null) await dried.restore(dry);

    final List<ArtworkEntry>? diary = document.artworkDiary;
    if (diary != null) await artworkDiary.restore(diary);

    final AiSettings? ai = document.aiSettings;
    if (ai != null) await aiSettings.replace(ai);

    final List<String>? favorites = document.ideaFavorites;
    if (favorites != null) await ideaFavorites.restoreFavorites(favorites);

    final List<String>? recent = document.recentIdeas;
    if (recent != null) await ideaFavorites.restoreRecent(recent);
  }

  /// The saved palettes of the document, by brand id.
  Map<String, List<SavedPalette>> _readPalettes(Object? value) {
    final byBrand = _asMap(value, 'savedPalettes', 'an object by brand');
    final restored = <String, List<SavedPalette>>{};
    for (final entry in byBrand.entries) {
      restored[entry.key] = _parseList(
        'savedPalettes',
        entry.value,
        SavedPalette.fromJson,
      );
    }
    return restored;
  }

  /// The own colours of the document: a string for every marker.
  Map<String, String> _readOwnColors(Object? value) {
    final map = _asMap(value, 'ownColors', 'an object of colours');
    for (final color in map.values) {
      if (color is! String) {
        throw const BackupFormatException(
          'each own colour must be a hex string',
          field: 'ownColors',
        );
      }
    }
    return map.cast<String, String>();
  }
}

/// The sections of a backup document, read and checked before any of them is
/// written.
///
/// A `null` section is one the document does not carry: the data the user has
/// stays as it is.
final class _BackupDocument {
  const _BackupDocument({
    this.appSettings,
    this.savedPalettes,
    this.history,
    this.ownColors,
    this.wishlist,
    this.driedMarkers,
    this.artworkDiary,
    this.aiSettings,
    this.ideaFavorites,
    this.recentIdeas,
  });

  final AppSettingsState? appSettings;
  final Map<String, List<SavedPalette>>? savedPalettes;
  final List<ColorMatchPick>? history;
  final Map<String, String>? ownColors;
  final List<String>? wishlist;
  final List<String>? driedMarkers;
  final List<ArtworkEntry>? artworkDiary;
  final AiSettings? aiSettings;
  final List<String>? ideaFavorites;
  final List<String>? recentIdeas;
}

Map<String, dynamic> _asMap(Object? value, String? field, String label) {
  if (value is Map) return value.cast<String, dynamic>();
  throw BackupFormatException('expected $label', field: field);
}

List<Object?> _asList(Object? value, String field) {
  if (value is List) return value;
  throw BackupFormatException('expected an array', field: field);
}

List<String> _parseIds(String field, Object? value) {
  final list = _asList(value, field);
  for (final item in list) {
    if (item is! String) {
      throw BackupFormatException(
        'each entry must be a marker id',
        field: field,
      );
    }
  }
  return list.cast<String>();
}

/// The idea ids of a section: strings, never anything else.
///
/// The list is bounded by [max] and every id is bounded by
/// [BackupService.maxIdeaIdLength], so a hostile document cannot make the app
/// walk an unbounded amount of data. An id that does not look like an id is
/// dropped, the same way the repository drops an id the catalogue does not
/// know. Duplicates are removed here, keeping the first one: the recent list
/// is newest first, so the first one is the newest.
List<String> _parseIdeaIds(String field, Object? value, int max) {
  final list = _asList(value, field);
  if (list.length > max) {
    throw BackupFormatException(
      'expected at most $max entries',
      field: field,
    );
  }
  final Set<String> ids = <String>{};
  for (final item in list) {
    if (item is! String) {
      throw BackupFormatException(
        'each entry must be an idea id',
        field: field,
      );
    }
    final String id = item.trim();
    if (id.length > BackupService.maxIdeaIdLength) {
      throw BackupFormatException(
        'an idea id cannot be longer than '
        '${BackupService.maxIdeaIdLength} characters',
        field: field,
      );
    }
    if (!BackupService._ideaIdPattern.hasMatch(id)) continue;
    ids.add(id);
  }
  return ids.toList();
}

Map<String, dynamic> _entryMap(Object? value, String field) {
  if (value is Map) return value.cast<String, dynamic>();
  throw BackupFormatException('each entry must be an object', field: field);
}

T _parse<T>(
  String field,
  Object? value,
  T Function(Map<String, dynamic>) fromJson,
) {
  try {
    return fromJson(_asMap(value, field, 'an object'));
  } on BackupFormatException {
    rethrow;
  } catch (error) {
    throw BackupFormatException('could not read $field: $error', field: field);
  }
}

List<T> _parseList<T>(
  String field,
  Object? value,
  T Function(Map<String, dynamic>) fromJson,
) {
  final list = _asList(value, field);
  try {
    return [for (final item in list) fromJson(_entryMap(item, field))];
  } on BackupFormatException {
    rethrow;
  } catch (error) {
    throw BackupFormatException('could not read $field: $error', field: field);
  }
}
