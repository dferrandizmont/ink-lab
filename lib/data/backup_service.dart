import 'dart:convert';

import '../core/models.dart';
import 'ai_settings.dart';
import 'ai_settings_repository.dart';
import 'app_settings_repository.dart';
import 'app_settings_state.dart';
import 'artwork_diary_repository.dart';
import 'color_id_set_repository.dart';
import 'color_match_history_repository.dart';
import 'data_exceptions.dart';
import 'own_color_repository.dart';
import 'saved_palette_repository.dart';

/// Export and import of user data as a versioned, plain (unencrypted) JSON
/// document.
///
/// The document holds settings + favourites, saved palettes, colour-match
/// history, the colours the user stored for their own markers, the wishlist,
/// the dried-out markers, the artwork diary entries and the non-secret AI
/// settings. It never contains an API key or any other secret: those live
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
///   "aiSettings": { ...AiSettings... }
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
  });

  /// Version written by [exportJson]; the newest version this service imports.
  static const int currentVersion = 1;

  static const String versionField = 'version';

  final AppSettingsRepository appSettings;
  final SavedPaletteRepository savedPalettes;
  final ColorMatchHistoryRepository history;
  final AiSettingsRepository aiSettings;
  final OwnColorRepository ownColors;
  final WishlistRepository wishlist;
  final DriedMarkerRepository dried;
  final ArtworkDiaryRepository artworkDiary;

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
    };
    return pretty
        ? const JsonEncoder.withIndent('  ').convert(payload)
        : jsonEncode(payload);
  }

  /// Restores the state from [source], replacing every section the document
  /// carries. Missing sections are left untouched; unknown fields are ignored.
  ///
  /// Throws a [BackupFormatException] for anything that is not a readable
  /// backup document.
  Future<void> importJson(String source) async {
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

    final settings = payload['appSettings'];
    if (settings != null) {
      await appSettings.restore(
        _parse('appSettings', settings, AppSettingsState.fromJson),
      );
    }

    final palettes = payload['savedPalettes'];
    if (palettes != null) {
      final byBrand = _asMap(palettes, 'savedPalettes', 'an object by brand');
      final restored = <String, List<SavedPalette>>{};
      for (final entry in byBrand.entries) {
        restored[entry.key] = _parseList(
          'savedPalettes',
          entry.value,
          SavedPalette.fromJson,
        );
      }
      await savedPalettes.restore(restored);
    }

    final picks = payload['colorMatchHistory'];
    if (picks != null) {
      await history.restore(
        _parseList('colorMatchHistory', picks, ColorMatchPick.fromJson),
      );
    }

    // Backups written before own colours existed have no such section: the
    // colours the user has stay as they are.
    final own = payload['ownColors'];
    if (own != null) {
      final map = _asMap(own, 'ownColors', 'an object of colours');
      for (final value in map.values) {
        if (value is! String) {
          throw const BackupFormatException(
            'each own colour must be a hex string',
            field: 'ownColors',
          );
        }
      }
      await ownColors.restore(map.cast<String, String>());
    }

    // Same for the wishlist and the dried-out markers (added in 0.7).
    final wished = payload['wishlist'];
    if (wished != null) {
      await wishlist.restore(_parseIds('wishlist', wished));
    }
    final dry = payload['driedMarkers'];
    if (dry != null) {
      await dried.restore(_parseIds('driedMarkers', dry));
    }

    // Backups from before the artwork diary have no such section: the entries
    // (and photos) the user has stay as they are.
    final diary = payload['artworkDiary'];
    if (diary != null) {
      await artworkDiary.restore(
        _parseList('artworkDiary', diary, ArtworkEntry.fromJson),
      );
    }

    final ai = payload['aiSettings'];
    if (ai != null) {
      // Never let an imported file switch the AI on: it is an explicit opt-in.
      final imported = _parse('aiSettings', ai, AiSettings.fromJson);
      await aiSettings.replace(imported.copyWith(enabled: false));
    }
  }
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
