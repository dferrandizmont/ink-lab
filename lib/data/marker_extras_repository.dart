import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'artwork_photo_store.dart';
import 'brand_scoping.dart';
import 'color_id_set_repository.dart';
import 'data_exceptions.dart';
import 'key_value_store.dart';
import 'replay_stream.dart';

/// How much ink an owned marker has left.
///
/// [dried] keeps its old meaning (Match, Palette and Ideas skip the marker);
/// [runningOut] is a reminder only: the marker is still used everywhere, and
/// shows up in the wishlist card so the user remembers to buy or refill it.
enum InkLevel {
  /// The default: nothing is stored.
  full,

  /// Still usable, but about to run dry.
  runningOut,

  /// Ran dry. Stored in the [DriedMarkerRepository].
  dried,
}

/// What the user keeps about a single marker besides owning it: how much ink
/// is left, a short refill note and a photo of the real paper swatch.
///
/// Everything is keyed by the brand-scoped id (`brandId:CODE`). The photos are
/// files in a private folder behind an [ArtworkPhotoStore], referenced by
/// file name, like the artwork diary's; they never leave the device.
abstract class MarkerExtrasRepository {
  /// The longest a refill note may be.
  static const int maxNoteLength = 80;

  /// The biggest photo kept, in bytes. The picker already scales photos down
  /// to about 1024 px (a few hundred kilobytes); this only refuses what
  /// escaped it.
  static const int maxPhotoBytes = 4 * 1024 * 1024;

  /// The start of the file name of every swatch photo. It keeps them apart
  /// from the diary's photos in the same folder, so a name that comes from a
  /// backup can never delete or replace a diary photo.
  static const String photoNamePrefix = 'sw-';

  /// Goes up on every change, so results can be cached per revision.
  int get revision;

  /// Emits the revision immediately, then after every change.
  Stream<int> get changes;

  /// Loads the running-out ids, the notes and the photo names.
  Future<void> load();

  /// The markers that are running out (and not dried out).
  Set<String> get runningOutIds;

  /// The ink level of [colorId]: dried out wins, then running out.
  InkLevel levelOf(String colorId);

  /// Sets the ink level of [colorId]. A marker is in one level at a time:
  /// the others are cleared.
  Future<void> setLevel(String colorId, InkLevel level);

  /// Every refill note, by scoped id.
  Map<String, String> get notes;

  /// The refill note of [colorId], or `null`.
  String? noteOf(String colorId);

  /// Sets (or, when blank, removes) the refill note. The text is trimmed,
  /// kept on one line and cut to [maxNoteLength] characters.
  Future<void> setNote(String colorId, String? note);

  /// The file name of the swatch photo of each marker, by scoped id.
  Map<String, String> get photoNames;

  /// The file name of the photo of [colorId], or `null`.
  String? photoNameOf(String colorId);

  /// The bytes of the photo of [colorId], or `null` when there is none (or
  /// its file is missing).
  Future<Uint8List?> photoBytes(String colorId);

  /// Keeps [bytes] as the swatch photo of [colorId], replacing the previous
  /// one. Returns `false` (and keeps the previous photo) when [bytes] are not
  /// a photo or are over [maxPhotoBytes].
  Future<bool> setPhoto(String colorId, Uint8List bytes);

  /// Removes the photo of [colorId] and deletes its file.
  Future<void> removePhoto(String colorId);

  /// The store the photos live in, for the backup file that carries them.
  ArtworkPhotoStore get photoStore;

  /// Replaces the sections given, as a backup restore does; a `null` section
  /// is left as it is. Photos that go away are deleted from the device.
  Future<void> restore({
    Iterable<String>? runningOut,
    Map<String, String>? notes,
    Map<String, String>? photos,
  });
}

/// [MarkerExtrasRepository] on top of a [KeyValueStore], the dried-out set
/// and an [ArtworkPhotoStore].
///
/// Stored under `running_out_marker_ids` (a sorted JSON array of scoped ids),
/// `marker_refill_notes` and `marker_swatch_photos` (JSON objects of scoped
/// id to text); a key is removed while its section is empty.
final class StoredMarkerExtrasRepository implements MarkerExtrasRepository {
  StoredMarkerExtrasRepository(
    this._store, {
    required this.dried,
    required this._photos,
    Random? random,
  }) : _random = random ?? Random.secure(),
       _runningOut = StoredColorIdSetRepository(_store, runningOutKey);

  static const String runningOutKey = 'running_out_marker_ids';
  static const String notesKey = 'marker_refill_notes';
  static const String photosKey = 'marker_swatch_photos';

  /// The dried-out markers: the third level lives there.
  final DriedMarkerRepository dried;

  final KeyValueStore _store;
  final ArtworkPhotoStore _photos;
  final Random _random;
  final StoredColorIdSetRepository _runningOut;
  final StreamController<int> _controller = StreamController<int>.broadcast();
  Future<void> _pending = Future<void>.value();

  Map<String, String> _notes = const <String, String>{};
  Map<String, String> _photoNames = const <String, String>{};
  int _revision = 0;

  @override
  int get revision => _revision;

  @override
  Stream<int> get changes =>
      replayStream<int>(() => _revision, _controller.stream);

  @override
  ArtworkPhotoStore get photoStore => _photos;

  /// Runs [task] after the ones before it: two changes in a row (a photo
  /// replaced twice) never interleave.
  Future<T> _serial<T>(Future<T> Function() task) {
    final Future<T> result = _pending.then((_) => task());
    _pending = result.then<void>((_) {}, onError: (Object _) {});
    return result;
  }

  void _changed() {
    _revision++;
    _controller.add(_revision);
  }

  @override
  Future<void> load() async {
    await _runningOut.load();
    _notes = _normalizeNotes(
      _decodeMap(await _store.getString(notesKey), notesKey),
    );
    _photoNames = _normalizePhotos(
      _decodeMap(await _store.getString(photosKey), photosKey),
    );
    _changed();
  }

  @override
  Set<String> get runningOutIds => <String>{
    for (final String id in _runningOut.ids)
      if (!dried.contains(id)) id,
  };

  @override
  InkLevel levelOf(String colorId) {
    if (dried.contains(colorId)) return InkLevel.dried;
    if (_runningOut.contains(colorId)) return InkLevel.runningOut;
    return InkLevel.full;
  }

  @override
  Future<void> setLevel(String colorId, InkLevel level) => _serial(() async {
    switch (level) {
      case InkLevel.full:
        await dried.remove(colorId);
        await _runningOut.remove(colorId);
      case InkLevel.runningOut:
        await dried.remove(colorId);
        await _runningOut.add(colorId);
      case InkLevel.dried:
        await _runningOut.remove(colorId);
        await dried.add(colorId);
    }
    _changed();
  });

  @override
  Map<String, String> get notes => _notes;

  @override
  String? noteOf(String colorId) {
    final String? scoped = scopedColorId(colorId);
    return scoped == null ? null : _notes[scoped];
  }

  @override
  Future<void> setNote(String colorId, String? note) => _serial(() async {
    final String? scoped = scopedColorId(colorId);
    if (scoped == null) return;
    final String? clean = cleanRefillNote(note);
    final Map<String, String> next = <String, String>{..._notes};
    if (clean == null) {
      if (next.remove(scoped) == null) return;
    } else {
      if (next[scoped] == clean) return;
      next[scoped] = clean;
    }
    await _persistMap(notesKey, _normalizeNotes(next), (Map<String, String> m) {
      _notes = m;
    });
  });

  @override
  Map<String, String> get photoNames => _photoNames;

  @override
  String? photoNameOf(String colorId) {
    final String? scoped = scopedColorId(colorId);
    return scoped == null ? null : _photoNames[scoped];
  }

  @override
  Future<Uint8List?> photoBytes(String colorId) async {
    final String? name = photoNameOf(colorId);
    return name == null ? null : _photos.read(name);
  }

  @override
  Future<bool> setPhoto(String colorId, Uint8List bytes) => _serial(() async {
    final String? scoped = scopedColorId(colorId);
    if (scoped == null ||
        bytes.isEmpty ||
        bytes.length > MarkerExtrasRepository.maxPhotoBytes ||
        !looksLikePhotoBytes(bytes)) {
      return false;
    }
    final String name = _newName(bytes);
    await _photos.restore(name, bytes);
    final String? previous = _photoNames[scoped];
    try {
      await _persistMap(
        photosKey,
        _normalizePhotos(<String, String>{..._photoNames, scoped: name}),
        (Map<String, String> m) => _photoNames = m,
      );
    } catch (_) {
      await _photos.delete(name);
      rethrow;
    }
    if (previous != null) await _photos.delete(previous);
    return true;
  });

  @override
  Future<void> removePhoto(String colorId) => _serial(() async {
    final String? scoped = scopedColorId(colorId);
    final String? name = scoped == null ? null : _photoNames[scoped];
    if (scoped == null || name == null) return;
    await _persistMap(
      photosKey,
      _normalizePhotos(<String, String>{..._photoNames}..remove(scoped)),
      (Map<String, String> m) => _photoNames = m,
    );
    await _photos.delete(name);
  });

  @override
  Future<void> restore({
    Iterable<String>? runningOut,
    Map<String, String>? notes,
    Map<String, String>? photos,
  }) => _serial(() async {
    if (runningOut != null) await _runningOut.restore(runningOut);
    if (notes != null) {
      await _persistMap(
        notesKey,
        _normalizeNotes(notes),
        (Map<String, String> m) => _notes = m,
      );
    }
    if (photos != null) {
      final Map<String, String> before = _photoNames;
      final Map<String, String> next = _normalizePhotos(photos);
      await _persistMap(
        photosKey,
        next,
        (Map<String, String> m) => _photoNames = m,
      );
      // The photos of markers that go away leave the device too.
      final Set<String> kept = next.values.toSet();
      for (final String name in before.values) {
        if (!kept.contains(name)) await _photos.delete(name);
      }
    }
    _changed();
  });

  Future<void> _persistMap(
    String key,
    Map<String, String> next,
    void Function(Map<String, String>) assign,
  ) async {
    if (next.isEmpty) {
      await _store.remove(key);
    } else {
      await _store.setString(key, jsonEncode(next));
    }
    assign(next);
    _changed();
  }

  String _newName(Uint8List bytes) {
    final String time = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
    final String salt = _random.nextInt(1 << 31).toRadixString(36);
    return '${MarkerExtrasRepository.photoNamePrefix}$time-$salt'
        '.${photoExtension(bytes)}';
  }

  static Map<String, String> _decodeMap(String? raw, String key) {
    if (raw == null || raw.trim().isEmpty) return const <String, String>{};
    try {
      final Object? decoded = jsonDecode(raw);
      if (decoded is! Map) {
        throw DataStoreException('expected a JSON object', key: key);
      }
      return <String, String>{
        for (final MapEntry<dynamic, dynamic> entry in decoded.entries)
          if (entry.key is String && entry.value is String)
            entry.key as String: entry.value as String,
      };
    } on DataStoreException {
      rethrow;
    } catch (error) {
      throw DataStoreException('could not parse $key: $error', key: key);
    }
  }
}

/// [note] trimmed, on one line and cut to
/// [MarkerExtrasRepository.maxNoteLength] characters; `null` when nothing is
/// left.
String? cleanRefillNote(String? note) {
  if (note == null) return null;
  final String oneLine = note.replaceAll(RegExp(r'\s+'), ' ').trim();
  if (oneLine.isEmpty) return null;
  final List<int> runes = oneLine.runes.toList();
  if (runes.length <= MarkerExtrasRepository.maxNoteLength) return oneLine;
  return String.fromCharCodes(runes.take(MarkerExtrasRepository.maxNoteLength))
      .trim();
}

/// Whether [name] is the name of a swatch photo: a safe photo name that
/// starts with [MarkerExtrasRepository.photoNamePrefix].
bool isSwatchPhotoName(String name) =>
    isSafePhotoName(name) &&
    name.startsWith(MarkerExtrasRepository.photoNamePrefix);

/// [notes] with scoped ids and clean texts, sorted by id; entries that are not
/// a marker id or have no text are dropped.
Map<String, String> normalizeRefillNotes(Map<String, String> notes) =>
    _normalizeNotes(notes);

/// [photos] with scoped ids, sorted by id; entries whose name is not a swatch
/// photo name are dropped.
Map<String, String> normalizeSwatchPhotos(Map<String, String> photos) =>
    _normalizePhotos(photos);

Map<String, String> _normalizeNotes(Map<String, String> notes) {
  final Map<String, String> result = <String, String>{};
  for (final MapEntry<String, String> entry in notes.entries) {
    final String? id = scopedColorId(entry.key);
    final String? text = cleanRefillNote(entry.value);
    if (id != null && text != null) result[id] = text;
  }
  return _sorted(result);
}

Map<String, String> _normalizePhotos(Map<String, String> photos) {
  final Map<String, String> result = <String, String>{};
  for (final MapEntry<String, String> entry in photos.entries) {
    final String? id = scopedColorId(entry.key);
    if (id != null && isSwatchPhotoName(entry.value)) result[id] = entry.value;
  }
  return _sorted(result);
}

Map<String, String> _sorted(Map<String, String> map) {
  final List<String> ids = map.keys.toList()..sort();
  return Map<String, String>.unmodifiable(<String, String>{
    for (final String id in ids) id: map[id]!,
  });
}
