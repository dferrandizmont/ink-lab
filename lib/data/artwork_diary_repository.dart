import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import '../core/models.dart';
import 'artwork_photo_store.dart';
import 'brand_scoping.dart';
import 'data_exceptions.dart';
import 'key_value_store.dart';
import 'replay_stream.dart';

/// The artwork diary: a log of finished or in-progress artworks, newest first.
///
/// The entries are text and ids kept in the key-value store; the photos are
/// files in a private folder behind an [ArtworkPhotoStore], referenced by file
/// name. Photos never leave the device: nothing here uploads, shares or sends
/// them to the AI features.
abstract class ArtworkDiaryRepository {
  /// Every entry, newest first (by date, then by when it was created).
  List<ArtworkEntry> get entries;

  /// Emits the current list, then every change.
  Stream<List<ArtworkEntry>> get changes;

  /// The entry with [id], or `null`.
  ArtworkEntry? byId(String id);

  Future<void> load();

  /// Adds [entry], or replaces the entry with the same id. Photos the old
  /// version had and the new one does not are deleted from the device.
  Future<void> save(ArtworkEntry entry);

  /// Removes the entry and deletes its photos from the device.
  Future<void> delete(String id);

  /// Replaces every entry, as a backup restore does. Photos of the entries
  /// that go away are deleted; a photo name with no file just shows no photo.
  Future<void> restore(Iterable<ArtworkEntry> entries);

  /// Copies a new photo into the private folder and returns its file name.
  Future<String> addPhoto(Uint8List bytes);

  /// The bytes of the photo [name], or `null` when the file is missing.
  Future<Uint8List?> photoBytes(String name);
}

/// [ArtworkDiaryRepository] on top of a [KeyValueStore] and an
/// [ArtworkPhotoStore].
///
/// One key, `artwork_diary`, holding the JSON array of [ArtworkEntry]
/// objects. Ids stay stable across edits; a marker id is stored brand-scoped
/// (`brandId:CODE`).
final class StoredArtworkDiaryRepository implements ArtworkDiaryRepository {
  StoredArtworkDiaryRepository(this._store, {required this._photos});

  static const String storageKey = 'artwork_diary';

  final KeyValueStore _store;
  final ArtworkPhotoStore _photos;
  final StreamController<List<ArtworkEntry>> _controller =
      StreamController<List<ArtworkEntry>>.broadcast();

  List<ArtworkEntry> _entries = const <ArtworkEntry>[];

  @override
  List<ArtworkEntry> get entries => _entries;

  @override
  Stream<List<ArtworkEntry>> get changes =>
      replayStream<List<ArtworkEntry>>(() => _entries, _controller.stream);

  @override
  ArtworkEntry? byId(String id) {
    for (final ArtworkEntry entry in _entries) {
      if (entry.id == id) return entry;
    }
    return null;
  }

  @override
  Future<void> load() async {
    _entries = _normalize(_decode(await _store.getString(storageKey)));
    _controller.add(_entries);
  }

  @override
  Future<void> save(ArtworkEntry entry) async {
    final ArtworkEntry? previous = byId(entry.id);
    await _persist(<ArtworkEntry>[
      for (final ArtworkEntry e in _entries)
        if (e.id != entry.id) e,
      entry,
    ]);
    if (previous != null) await _deletePhotos(previous.photos);
  }

  @override
  Future<void> delete(String id) async {
    final ArtworkEntry? gone = byId(id);
    if (gone == null) return;
    await _persist(<ArtworkEntry>[
      for (final ArtworkEntry e in _entries)
        if (e.id != id) e,
    ]);
    await _deletePhotos(gone.photos);
  }

  @override
  Future<void> restore(Iterable<ArtworkEntry> entries) async {
    final List<ArtworkEntry> before = _entries;
    await _persist(entries);
    await _deletePhotos(<String>[
      for (final ArtworkEntry e in before) ...e.photos,
    ]);
  }

  @override
  Future<String> addPhoto(Uint8List bytes) => _photos.save(bytes);

  @override
  Future<Uint8List?> photoBytes(String name) => _photos.read(name);

  /// Deletes the photos in [names] that no entry uses any more.
  Future<void> _deletePhotos(Iterable<String> names) async {
    final Set<String> used = <String>{
      for (final ArtworkEntry e in _entries) ...e.photos,
    };
    for (final String name in names.toSet()) {
      if (!used.contains(name)) await _photos.delete(name);
    }
  }

  Future<void> _persist(Iterable<ArtworkEntry> next) async {
    final List<ArtworkEntry> normalized = _normalize(next);
    await _store.setString(
      storageKey,
      jsonEncode(<Object>[for (final ArtworkEntry e in normalized) e.toJson()]),
    );
    _entries = normalized;
    _controller.add(_entries);
  }

  /// Scoped markers, at most [ArtworkEntry.maxPhotos] photos, no duplicate id
  /// (the last wins), newest first.
  List<ArtworkEntry> _normalize(Iterable<ArtworkEntry> entries) {
    final Map<String, ArtworkEntry> byId = <String, ArtworkEntry>{};
    for (final ArtworkEntry entry in entries) {
      byId[entry.id] = _normalizeEntry(entry);
    }
    final List<ArtworkEntry> sorted = byId.values.toList()
      ..sort((ArtworkEntry a, ArtworkEntry b) {
        final int byDate = b.date.compareTo(a.date);
        if (byDate != 0) return byDate;
        final int byCreated = b.createdAtEpochMs.compareTo(a.createdAtEpochMs);
        return byCreated != 0 ? byCreated : a.id.compareTo(b.id);
      });
    return List<ArtworkEntry>.unmodifiable(sorted);
  }

  ArtworkEntry _normalizeEntry(ArtworkEntry entry) {
    final List<String> markers = <String>[];
    for (final String raw in entry.markerIds) {
      final String? scoped = scopedColorId(raw);
      if (scoped != null && !markers.contains(scoped)) markers.add(scoped);
    }
    return ArtworkEntry(
      id: entry.id,
      title: entry.title,
      date: entry.date,
      onWhat: entry.onWhat,
      status: entry.status,
      markerIds: markers,
      paletteId: entry.paletteId,
      notes: entry.notes,
      photos: entry.photos.toSet().take(ArtworkEntry.maxPhotos).toList(),
      createdAtEpochMs: entry.createdAtEpochMs,
    );
  }

  List<ArtworkEntry> _decode(String? raw) {
    if (raw == null || raw.trim().isEmpty) return const <ArtworkEntry>[];
    final Object? decoded;
    try {
      decoded = jsonDecode(raw);
    } on FormatException catch (error) {
      throw DataStoreException(
        'could not parse the artwork diary: ${error.message}',
        key: storageKey,
      );
    }
    if (decoded is! List) {
      throw const DataStoreException(
        'expected a JSON array of artworks',
        key: storageKey,
      );
    }
    // One damaged entry must not hide the others (or stop the app).
    final List<ArtworkEntry> entries = <ArtworkEntry>[];
    for (final Object? item in decoded) {
      try {
        entries.add(
          ArtworkEntry.fromJson((item as Map).cast<String, dynamic>()),
        );
      } catch (_) {
        continue;
      }
    }
    return entries;
  }
}
