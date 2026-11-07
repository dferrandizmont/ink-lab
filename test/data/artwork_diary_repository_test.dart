import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

Uint8List _jpeg(int seed) =>
    Uint8List.fromList(<int>[0xFF, 0xD8, 0xFF, seed, 1, 2, 3]);

Uint8List _png() =>
    Uint8List.fromList(<int>[0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]);

ArtworkEntry _entry({
  String id = 'a1',
  String title = 'Forest page',
  DateTime? date,
  String onWhat = '',
  ArtworkStatus status = ArtworkStatus.finished,
  List<String> markerIds = const <String>[],
  String? paletteId,
  String notes = '',
  List<String> photos = const <String>[],
  int createdAtEpochMs = 1000,
}) => ArtworkEntry(
  id: id,
  title: title,
  date: date ?? DateTime(2026, 10, 30),
  onWhat: onWhat,
  status: status,
  markerIds: markerIds,
  paletteId: paletteId,
  notes: notes,
  photos: photos,
  createdAtEpochMs: createdAtEpochMs,
);

({
  StoredArtworkDiaryRepository repo,
  InMemoryKeyValueStore store,
  InMemoryArtworkPhotoStore photos,
  InMemoryArtworkDiaryStorage storage,
})
_repo([Map<String, Object>? initial]) {
  final InMemoryKeyValueStore store = InMemoryKeyValueStore(initial);
  final InMemoryArtworkPhotoStore photos = InMemoryArtworkPhotoStore();
  final storage = InMemoryArtworkDiaryStorage();
  return (
    storage: storage,
    repo: StoredArtworkDiaryRepository(store, photos: photos, storage: storage),
    store: store,
    photos: photos,
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('file storage and migration', () {
    late Directory temp;
    late FileArtworkDiaryStorage storage;
    late InMemoryKeyValueStore preferences;

    StoredArtworkDiaryRepository repository({
      KeyValueStore? store,
      ArtworkDiaryStorage? documents,
    }) => StoredArtworkDiaryRepository(
      store ?? preferences,
      photos: InMemoryArtworkPhotoStore(),
      storage: documents ?? storage,
    );
    File document([bool backup = false]) => File(
      '${temp.path}/${FileArtworkDiaryStorage.fileName}${backup ? '.bak' : ''}',
    );
    String json([String title = 'Forest page']) =>
        jsonEncode([_entry(title: title).toJson()]);

    setUp(() {
      temp = Directory.systemTemp.createTempSync('ink_lab_diary_document');
      storage = FileArtworkDiaryStorage(directory: () => temp);
      preferences = InMemoryKeyValueStore();
    });
    tearDown(() => temp.deleteSync(recursive: true));

    test(
      'migrates SharedPreferences once, verifies the file and removes the key',
      () async {
        SharedPreferences.setMockInitialValues({'artwork_diary': json()});
        final store = await SharedPreferencesStore.open();
        final repo = repository(store: store);
        await repo.load();
        expect(repo.entries.single.title, 'Forest page');
        expect(await document().readAsString(), json());
        expect(await document(true).readAsString(), json());
        expect(await store.containsKey('artwork_diary'), isFalse);

        // An interrupted removal must prefer the already migrated document.
        await store.setString('artwork_diary', json('Obsolete'));
        await repository(store: store).load();
        expect(await document().readAsString(), json());
        expect(await store.containsKey('artwork_diary'), isFalse);
      },
    );

    test(
      'round trips saves through the file and keeps a verified backup',
      () async {
        final repo = repository();
        await repo.load();
        await repo.save(_entry());
        await repo.save(_entry(title: 'Edited'));
        final again = repository();
        await again.load();
        expect(again.entries, repo.entries);
        expect(
          await document(true).readAsString(),
          await document().readAsString(),
        );
        expect(await preferences.containsKey('artwork_diary'), isFalse);
        expect(
          temp.listSync().where((file) => file.path.endsWith('.tmp')),
          isEmpty,
        );
      },
    );

    test(
      'recovers a corrupt file from the legacy key before the backup',
      () async {
        await storage.write(json('Backup'), backup: true);
        await document().writeAsString('[partial');
        await preferences.setString('artwork_diary', json('Legacy'));
        final repo = repository();
        await repo.load();
        expect(repo.entries.single.title, 'Legacy');
        expect(await document().readAsString(), json('Legacy'));
        expect(await preferences.containsKey('artwork_diary'), isFalse);
      },
    );

    test(
      'recovers corrupt, empty and missing files from the last good backup',
      () async {
        final repo = repository();
        await repo.save(_entry());
        await repo.save(_entry(title: 'Latest'));
        for (final corrupt in ['[partial', '', '{"wrong":true}']) {
          await document().writeAsString(corrupt);
          final again = repository();
          await again.load();
          expect(again.entries.single.title, 'Latest');
          expect(await document().readAsString(), json('Latest'));
        }
        await document().delete();
        final again = repository();
        await again.load();
        expect(again.entries.single.title, 'Latest');
      },
    );

    test('uses the backup even when the legacy key is also corrupt', () async {
      await storage.write(json(), backup: true);
      await document().writeAsString('bad file');
      await preferences.setString('artwork_diary', 'bad legacy');
      final repo = repository();
      await repo.load();
      expect(repo.entries.single.title, 'Forest page');
    });

    test(
      'reports unrecoverable corruption without replacing files or memory',
      () async {
        final repo = repository();
        await repo.save(_entry());
        await document().writeAsString('bad file');
        await document(true).writeAsString('bad backup');
        await expectLater(repo.load(), throwsA(isA<DataStoreException>()));
        expect(repo.entries.single.title, 'Forest page');
        expect(await document().readAsString(), 'bad file');
        expect(await document(true).readAsString(), 'bad backup');
      },
    );

    test(
      'a failed rename retains the migration key and removes temporary files',
      () async {
        await preferences.setString('artwork_diary', json());
        await Directory(document().path).create();
        await expectLater(
          repository().load(),
          throwsA(isA<FileSystemException>()),
        );
        expect(await preferences.getString('artwork_diary'), json());
        expect(
          temp.listSync().where((file) => file.path.endsWith('.tmp')),
          isEmpty,
        );
      },
    );

    test(
      'a failed read-back retains the legacy key and does not publish entries',
      () async {
        await preferences.setString('artwork_diary', json());
        final repo = repository(documents: _BadReadbackStorage());
        await expectLater(repo.load(), throwsA(isA<DataStoreException>()));
        expect(await preferences.getString('artwork_diary'), json());
        expect(repo.entries, isEmpty);
      },
    );

    test('overlapping saves keep both entries', () async {
      final repo = repository();
      await repo.load();
      await Future.wait([
        repo.save(_entry(id: 'one')),
        repo.save(_entry(id: 'two')),
      ]);
      final again = repository();
      await again.load();
      expect(again.entries.map((entry) => entry.id).toSet(), {'one', 'two'});
    });
  });

  group('entries', () {
    test('adds, edits and deletes an entry, keeping its id', () async {
      final r = _repo();
      await r.repo.load();
      expect(r.repo.entries, isEmpty);

      await r.repo.save(_entry());
      expect(r.repo.entries.single.title, 'Forest page');

      await r.repo.save(
        _entry(title: 'Forest page, done', status: ArtworkStatus.inProgress),
      );
      expect(r.repo.entries, hasLength(1));
      expect(r.repo.byId('a1')!.title, 'Forest page, done');
      expect(r.repo.byId('a1')!.status, ArtworkStatus.inProgress);

      await r.repo.delete('a1');
      expect(r.repo.entries, isEmpty);
      expect(r.repo.byId('a1'), isNull);
      // Deleting what is not there does nothing.
      await r.repo.delete('a1');
    });

    test('lists the newest first, by date and then by creation', () async {
      final r = _repo();
      await r.repo.load();
      await r.repo.save(_entry(id: 'old', date: DateTime(2026, 1, 5)));
      await r.repo.save(
        _entry(id: 'mid-a', date: DateTime(2026, 6, 1), createdAtEpochMs: 1),
      );
      await r.repo.save(
        _entry(id: 'mid-b', date: DateTime(2026, 6, 1), createdAtEpochMs: 2),
      );
      await r.repo.save(_entry(id: 'new', date: DateTime(2026, 10, 30)));
      expect(r.repo.entries.map((e) => e.id), ['new', 'mid-b', 'mid-a', 'old']);

      // Editing the date moves the entry.
      await r.repo.save(_entry(id: 'old', date: DateTime(2026, 12, 1)));
      expect(r.repo.entries.first.id, 'old');
    });

    test('round-trips through the store as JSON', () async {
      final r = _repo();
      await r.repo.load();
      await r.repo.save(
        _entry(
          onWhat: 'Forest colouring book',
          markerIds: const ['ohuhu_oahu:B08', 'copic:BV04'],
          paletteId: 'p9',
          notes: 'Blended with colourless',
          photos: const ['one.jpg', 'two.jpg'],
        ),
      );
      final String raw = (await r.storage.read())!;
      expect(await r.store.containsKey('artwork_diary'), isFalse);
      final List<dynamic> json = jsonDecode(raw) as List<dynamic>;
      expect(json.single, {
        'id': 'a1',
        'title': 'Forest page',
        'date': '2026-10-30',
        'onWhat': 'Forest colouring book',
        'status': 'finished',
        'markers': ['ohuhu_oahu:B08', 'copic:BV04'],
        'paletteId': 'p9',
        'notes': 'Blended with colourless',
        'photos': ['one.jpg', 'two.jpg'],
        'createdAtEpochMs': 1000,
      });

      final again = StoredArtworkDiaryRepository(
        r.store,
        storage: r.storage,
        photos: InMemoryArtworkPhotoStore(),
      );
      await again.load();
      expect(again.entries, r.repo.entries);
    });

    test('scopes marker ids, drops duplicates and caps the photos', () async {
      final r = _repo();
      await r.repo.load();
      await r.repo.save(
        _entry(
          markerIds: const ['b08', 'ohuhu_oahu:B08', 'copic:bv04', ':', ''],
          photos: const ['1.jpg', '2.jpg', '3.jpg', '4.jpg', '5.jpg', '1.jpg'],
        ),
      );
      final ArtworkEntry saved = r.repo.entries.single;
      expect(saved.markerIds, ['ohuhu_oahu:B08', 'copic:BV04']);
      expect(saved.photos, ['1.jpg', '2.jpg', '3.jpg', '4.jpg']);
    });

    test(
      'streams the list: the current one first, then every change',
      () async {
        final r = _repo();
        await r.repo.load();
        final List<List<String>> seen = [];
        final sub = r.repo.changes.listen(
          (entries) => seen.add([for (final e in entries) e.id]),
        );
        await Future<void>.delayed(Duration.zero);
        await r.repo.save(_entry());
        await r.repo.delete('a1');
        await Future<void>.delayed(Duration.zero);
        await sub.cancel();
        expect(seen, [
          <String>[],
          ['a1'],
          <String>[],
        ]);
      },
    );

    test('a damaged entry is skipped, a damaged store is reported', () async {
      final good = jsonEncode(_entry().toJson());
      final r = _repo({
        'artwork_diary': '[$good, {"id": 5}, "x", {"title": "no id"}]',
      });
      await r.repo.load();
      expect(r.repo.entries.map((e) => e.id), ['a1']);

      await expectLater(
        _repo({'artwork_diary': '{"a": 1}'}).repo.load(),
        throwsA(isA<DataStoreException>()),
      );
      await expectLater(
        _repo({'artwork_diary': 'not json'}).repo.load(),
        throwsA(isA<DataStoreException>()),
      );
    });

    test('an entry without a date falls back to when it was created', () {
      final entry = ArtworkEntry.fromJson({
        'id': 'x',
        'title': 'Old',
        'createdAtEpochMs': DateTime(2026, 3, 4, 15).millisecondsSinceEpoch,
      });
      expect(entry.date, DateTime(2026, 3, 4));
      expect(entry.status, ArtworkStatus.finished);
      expect(entry.photos, isEmpty);
      expect(entry.paletteId, isNull);
    });
  });

  group('photos', () {
    test('a photo is copied in and read back by its name', () async {
      final r = _repo();
      final String name = await r.repo.addPhoto(_jpeg(1));
      expect(name, endsWith('.jpg'));
      expect(isSafePhotoName(name), isTrue);
      expect(await r.repo.photoBytes(name), _jpeg(1));
      expect(await r.repo.photoBytes('missing.jpg'), isNull);
      expect(await r.repo.addPhoto(_png()), endsWith('.png'));
    });

    test('removing a photo from an entry deletes its file', () async {
      final r = _repo();
      await r.repo.load();
      final String a = await r.repo.addPhoto(_jpeg(1));
      final String b = await r.repo.addPhoto(_jpeg(2));
      await r.repo.save(_entry(photos: [a, b]));
      expect(r.photos.names, {a, b});

      await r.repo.save(_entry(photos: [b]));
      expect(r.photos.names, {b});
      expect(r.repo.entries.single.photos, [b]);
    });

    test('deleting an entry deletes its photos, and only its own', () async {
      final r = _repo();
      await r.repo.load();
      final String a = await r.repo.addPhoto(_jpeg(1));
      final String b = await r.repo.addPhoto(_jpeg(2));
      await r.repo.save(_entry(id: 'one', photos: [a]));
      await r.repo.save(_entry(id: 'two', photos: [b]));

      await r.repo.delete('one');
      expect(r.photos.names, {b});
    });

    test('a photo still used by another entry is kept', () async {
      final r = _repo();
      await r.repo.load();
      final String shared = await r.repo.addPhoto(_jpeg(1));
      await r.repo.save(_entry(id: 'one', photos: [shared]));
      await r.repo.save(_entry(id: 'two', photos: [shared]));
      await r.repo.delete('one');
      expect(r.photos.names, {shared});
    });

    test('a missing file is ignored when its entry goes', () async {
      final r = _repo();
      await r.repo.load();
      await r.repo.save(_entry(photos: ['gone.jpg']));
      await r.repo.delete('a1');
      expect(r.repo.entries, isEmpty);
    });

    test('a name that is a path is never read or deleted', () async {
      expect(isSafePhotoName('../secret.jpg'), isFalse);
      expect(isSafePhotoName('a/b.jpg'), isFalse);
      expect(isSafePhotoName(r'a\b.jpg'), isFalse);
      expect(isSafePhotoName('.hidden'), isFalse);
      expect(isSafePhotoName(''), isFalse);
      expect(isSafePhotoName('abc-1_2.jpg'), isTrue);

      final r = _repo();
      r.photos.put('ok.jpg', _jpeg(1));
      expect(await r.repo.photoBytes('../ok.jpg'), isNull);
      await r.photos.delete('../ok.jpg');
      expect(r.photos.names, {'ok.jpg'});
    });

    test(
      'restoring replaces the entries and deletes the photos that go',
      () async {
        final r = _repo();
        await r.repo.load();
        final String keep = await r.repo.addPhoto(_jpeg(1));
        final String drop = await r.repo.addPhoto(_jpeg(2));
        await r.repo.save(_entry(id: 'kept', photos: [keep]));
        await r.repo.save(_entry(id: 'dropped', photos: [drop]));

        await r.repo.restore([
          _entry(id: 'kept', photos: [keep], title: 'Restored'),
          _entry(id: 'new', photos: ['from-another-phone.jpg']),
        ]);
        expect(r.repo.entries.map((e) => e.id).toSet(), {'kept', 'new'});
        expect(r.photos.names, {keep});
        // The photo of the other phone is not there: no bytes, no crash.
        expect(await r.repo.photoBytes('from-another-phone.jpg'), isNull);
      },
    );
  });

  group('DirectoryArtworkPhotoStore', () {
    late Directory temp;

    setUp(() => temp = Directory.systemTemp.createTempSync('ink_lab_diary'));
    tearDown(() => temp.deleteSync(recursive: true));

    DirectoryArtworkPhotoStore store() => DirectoryArtworkPhotoStore(
      () => Directory('${temp.path}${Platform.pathSeparator}artworks'),
    );

    test('creates its folder, saves, reads and deletes real files', () async {
      final s = store();
      expect(await s.read('nothing.jpg'), isNull);

      final String name = await s.save(_jpeg(7));
      final File file = File(
        '${temp.path}${Platform.pathSeparator}artworks'
        '${Platform.pathSeparator}$name',
      );
      expect(file.existsSync(), isTrue);
      expect(await s.read(name), _jpeg(7));

      await s.delete(name);
      expect(file.existsSync(), isFalse);
      expect(await s.read(name), isNull);
      // A second delete, or a path, is quietly ignored.
      await s.delete(name);
      await s.delete('../x');
    });

    test('the repository cleans real files up with the entry', () async {
      final repo = StoredArtworkDiaryRepository(
        InMemoryKeyValueStore(),
        photos: store(),
        storage: FileArtworkDiaryStorage(directory: () => temp),
      );
      await repo.load();
      final String a = await repo.addPhoto(_jpeg(1));
      final String b = await repo.addPhoto(_png());
      await repo.save(_entry(photos: [a, b]));
      final Directory folder = Directory(
        '${temp.path}${Platform.pathSeparator}artworks',
      );
      expect(folder.listSync(), hasLength(2));

      await repo.save(_entry(photos: [b]));
      expect(folder.listSync(), hasLength(1));
      await repo.delete('a1');
      expect(folder.listSync(), isEmpty);
    });
  });
}

/// Simulates a storage backend that does not return the document just written.
final class _BadReadbackStorage implements ArtworkDiaryStorage {
  bool written = false;

  @override
  Future<String?> read({bool backup = false}) async => written ? '[]' : null;

  @override
  Future<void> write(String json, {bool backup = false}) async {
    written = true;
  }
}
