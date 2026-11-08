import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import '../core/models.dart';
import 'artwork_diary_storage.dart';
import 'artwork_photo_store.dart';
import 'brand_scoping.dart';
import 'data_exceptions.dart';
import 'replay_stream.dart';

/// The user's own blending recipes, the last one edited first.
///
/// The recipes are text and ids kept in a private JSON file (the same atomic
/// storage the artwork diary uses); the optional photo of a recipe is a file
/// in the private photo folder, referenced by file name. Photos never leave
/// the device: nothing here uploads, shares or sends them anywhere.
abstract class BlendRecipeRepository {
  /// Every recipe, the last one edited first.
  List<BlendRecipe> get recipes;

  /// Emits the current list, then every change.
  Stream<List<BlendRecipe>> get changes;

  /// The recipe with [id], or `null`.
  BlendRecipe? byId(String id);

  Future<void> load();

  /// Adds [recipe], or replaces the recipe with the same id. A photo the old
  /// version had and the new one does not is deleted from the device.
  Future<void> save(BlendRecipe recipe);

  /// Removes the recipe and deletes its photo from the device.
  Future<void> delete(String id);

  /// Replaces every recipe, as a backup restore does. Photos of the recipes
  /// that go away are deleted; a photo name with no file just shows no photo.
  Future<void> restore(Iterable<BlendRecipe> recipes);

  /// Copies a new photo into the private folder and returns its file name.
  Future<String> addPhoto(Uint8List bytes);

  /// The bytes of the photo [name], or `null` when the file is missing.
  Future<Uint8List?> photoBytes(String name);
}

/// [BlendRecipeRepository] on top of an [ArtworkDiaryStorage] document and an
/// [ArtworkPhotoStore].
///
/// The photo store can be the diary's own: photo names are unique, and each
/// repository only ever deletes the photos of its own records. A JSON array of
/// [BlendRecipe] objects; markers are stored brand-scoped (`brandId:CODE`).
final class StoredBlendRecipeRepository implements BlendRecipeRepository {
  StoredBlendRecipeRepository({
    required this._storage,
    required this._photos,
  });

  static const String storageKey = 'blend_recipes';

  /// The document's file name, next to the diary's.
  static const String fileName = 'blend_recipes.json';

  final ArtworkDiaryStorage _storage;
  final ArtworkPhotoStore _photos;
  Future<void> _pending = Future<void>.value();
  final StreamController<List<BlendRecipe>> _controller =
      StreamController<List<BlendRecipe>>.broadcast();

  List<BlendRecipe> _recipes = const <BlendRecipe>[];

  @override
  List<BlendRecipe> get recipes => _recipes;

  @override
  Stream<List<BlendRecipe>> get changes =>
      replayStream<List<BlendRecipe>>(() => _recipes, _controller.stream);

  @override
  BlendRecipe? byId(String id) {
    for (final BlendRecipe recipe in _recipes) {
      if (recipe.id == id) return recipe;
    }
    return null;
  }

  @override
  Future<void> load() => _serial(() async {
    // Never publish an empty list over an unreadable document: try the live
    // file, then the last verified copy, and fail loudly when both are bad.
    String? raw;
    Object? failure;
    try {
      raw = await _storage.read();
      if (raw != null) _decode(raw);
    } on Exception catch (error) {
      failure = error;
      raw = null;
    }
    if (raw == null) {
      try {
        raw = await _storage.read(backup: true);
        if (raw != null) _decode(raw);
      } on Exception catch (error) {
        failure ??= error;
        raw = null;
      }
      if (raw == null && failure != null) throw failure;
      if (raw != null) await _writeVerified(raw);
    } else {
      // Also repairs a missing or stale copy after an interrupted save.
      await _storage.write(raw, backup: true);
    }
    _recipes = _normalize(_decode(raw));
    _controller.add(_recipes);
  });

  @override
  Future<void> save(BlendRecipe recipe) => _serial(() async {
    final String? oldPhoto = byId(recipe.id)?.photo;
    await _persist(<BlendRecipe>[
      for (final BlendRecipe r in _recipes)
        if (r.id != recipe.id) r,
      recipe,
    ]);
    if (oldPhoto != null) await _deletePhotos(<String>[oldPhoto]);
  });

  @override
  Future<void> delete(String id) => _serial(() async {
    final BlendRecipe? gone = byId(id);
    if (gone == null) return;
    await _persist(<BlendRecipe>[
      for (final BlendRecipe r in _recipes)
        if (r.id != id) r,
    ]);
    final String? photo = gone.photo;
    if (photo != null) await _deletePhotos(<String>[photo]);
  });

  @override
  Future<void> restore(Iterable<BlendRecipe> recipes) => _serial(() async {
    final List<BlendRecipe> before = _recipes;
    await _persist(recipes);
    await _deletePhotos(<String>[for (final BlendRecipe r in before) ?r.photo]);
  });

  @override
  Future<String> addPhoto(Uint8List bytes) => _photos.save(bytes);

  @override
  Future<Uint8List?> photoBytes(String name) => _photos.read(name);

  /// Deletes the photos in [names] that no recipe uses any more.
  Future<void> _deletePhotos(Iterable<String> names) async {
    final Set<String> used = <String>{
      for (final BlendRecipe r in _recipes) ?r.photo,
    };
    for (final String name in names.toSet()) {
      if (!used.contains(name)) await _photos.delete(name);
    }
  }

  Future<void> _persist(Iterable<BlendRecipe> next) async {
    final List<BlendRecipe> normalized = _normalize(next);
    await _writeVerified(
      jsonEncode(<Object>[for (final BlendRecipe r in normalized) r.toJson()]),
    );
    _recipes = normalized;
    _controller.add(_recipes);
  }

  Future<void> _writeVerified(String raw) async {
    await _storage.write(raw);
    final String? written = await _storage.read();
    if (written != raw) {
      throw const DataStoreException(
        'recipes write verification failed',
        key: storageKey,
      );
    }
    _decode(written);
    await _storage.write(raw, backup: true);
  }

  // Queue the whole read/modify/write, including photo cleanup, so rapid
  // overlapping saves cannot overwrite each other's recipes or temp files.
  Future<void> _serial(Future<void> Function() action) {
    final Future<void> result = _pending.then((_) => action());
    _pending = result.then<void>((_) {}, onError: (Object _, StackTrace _) {});
    return result;
  }

  /// Scoped markers (at most [BlendRecipe.maxMarkers]), no duplicate id (the
  /// last wins), the last one edited first.
  List<BlendRecipe> _normalize(Iterable<BlendRecipe> recipes) {
    final Map<String, BlendRecipe> byId = <String, BlendRecipe>{};
    for (final BlendRecipe recipe in recipes) {
      byId[recipe.id] = _normalizeRecipe(recipe);
    }
    final List<BlendRecipe> sorted = byId.values.toList()
      ..sort((BlendRecipe a, BlendRecipe b) {
        final int byEdit = b.updatedAtEpochMs.compareTo(a.updatedAtEpochMs);
        if (byEdit != 0) return byEdit;
        final int byCreated = b.createdAtEpochMs.compareTo(a.createdAtEpochMs);
        return byCreated != 0 ? byCreated : a.id.compareTo(b.id);
      });
    return List<BlendRecipe>.unmodifiable(sorted);
  }

  BlendRecipe _normalizeRecipe(BlendRecipe recipe) {
    final List<String> markers = <String>[];
    for (final String raw in recipe.markerIds) {
      final String? scoped = scopedColorId(raw);
      if (scoped != null) markers.add(scoped);
    }
    return BlendRecipe(
      id: recipe.id,
      title: recipe.title,
      markerIds: markers.take(BlendRecipe.maxMarkers).toList(),
      note: recipe.note,
      photo: recipe.photo,
      createdAtEpochMs: recipe.createdAtEpochMs,
      updatedAtEpochMs: recipe.updatedAtEpochMs,
    );
  }

  List<BlendRecipe> _decode(String? raw) {
    if (raw == null) return const <BlendRecipe>[];
    final Object? decoded;
    try {
      decoded = jsonDecode(raw);
    } on FormatException catch (error) {
      throw DataStoreException(
        'could not parse the blending recipes: ${error.message}',
        key: storageKey,
      );
    }
    if (decoded is! List) {
      throw const DataStoreException(
        'expected a JSON array of recipes',
        key: storageKey,
      );
    }
    // One damaged recipe must not hide the others (or stop the app).
    final List<BlendRecipe> recipes = <BlendRecipe>[];
    for (final Object? item in decoded) {
      try {
        recipes.add(
          BlendRecipe.fromJson((item as Map).cast<String, dynamic>()),
        );
      } catch (_) {
        continue;
      }
    }
    return recipes;
  }
}
