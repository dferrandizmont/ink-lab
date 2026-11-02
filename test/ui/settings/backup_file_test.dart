import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show MethodCall, SystemChannels;
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/app_version.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/pages/settings/backup_file_io.dart';
import 'package:ink_lab/ui/pages/settings/backup_section.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';

import '../../support/fake_backup_file_io.dart';
import '../../support/l10n.dart';

MarkerRepository _markers() =>
    MarkerRepository(loadAsset: (String path) => File(path).readAsStringSync());

/// Bytes that look like a JPEG.
final Uint8List _jpeg = Uint8List.fromList(<int>[0xFF, 0xD8, 0xFF, 0xE0, 1, 2]);

ArtworkEntry _entry(String id, List<String> photos) => ArtworkEntry(
  id: id,
  title: 'Painting $id',
  date: DateTime(2026, 10, 30),
  photos: photos,
  createdAtEpochMs: 1,
);

/// A backup archive with one diary entry and its photo.
Uint8List _archive({String photo = 'new.jpg', Uint8List? photoBytes}) {
  final Archive archive = Archive()
    ..addFile(
      ArchiveFile.string(
        'manifest.json',
        jsonEncode(<String, Object>{
          'format': 'ink-lab-backup',
          'version': 1,
          'appVersion': appVersion,
          'photos': 1,
        }),
      ),
    )
    ..addFile(
      ArchiveFile.string(
        'backup.json',
        jsonEncode(<String, Object>{
          'version': 1,
          'artworkDiary': <Object>[
            <String, Object>{
              'id': 'from-file',
              'title': 'From the file',
              'date': '2026-10-30',
              'photos': <String>[photo],
              'createdAtEpochMs': 1,
            },
          ],
        }),
      ),
    )
    ..addFile(ArchiveFile.bytes('photos/$photo', photoBytes ?? _jpeg));
  return ZipEncoder().encodeBytes(archive);
}

class _Env {
  _Env(this.scope, this.photos, this.io);
  final AppScope scope;
  final InMemoryArtworkPhotoStore photos;
  final FakeBackupFileIo io;
}

Future<_Env> _pump(
  WidgetTester tester, {
  Locale locale = const Locale('en'),
  double width = 390,
  double textScale = 1.0,
}) async {
  tester.view.physicalSize = Size(width, 1600);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  final InMemoryArtworkPhotoStore photos = InMemoryArtworkPhotoStore();
  final FakeBackupFileIo io = FakeBackupFileIo();
  late AppScope scope;
  scope = AppScope.inMemory(
    markers: _markers(),
    artworkDiary: StoredArtworkDiaryRepository(
      InMemoryKeyValueStore(),
      photos: photos,
    ),
    child: MaterialApp(
      locale: locale,
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      theme: AppTheme.light(),
      builder: (BuildContext context, Widget? child) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: TextScaler.linear(textScale)),
        child: child!,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Builder(
            builder: (BuildContext context) =>
                BackupSection(scope: AppScope.of(context), fileIo: io),
          ),
        ),
      ),
    ),
  );
  await tester.pumpWidget(scope);
  await tester.pumpAndSettle();
  return _Env(scope, photos, io);
}

String _describe(Object? error) => error is FlutterError
    ? error.diagnostics.map((DiagnosticsNode n) => n.toStringDeep()).join(' | ')
    : '$error';

Finder _key(String key) => find.byKey(ValueKey<String>(key));

Finder _inDialog(String text) =>
    find.descendant(of: find.byType(AlertDialog), matching: find.text(text));

ButtonStyleButton _button(WidgetTester tester, String key) =>
    tester.widget<ButtonStyleButton>(
      find.descendant(
        of: _key(key),
        matching: find.byWidgetPredicate((Widget w) => w is ButtonStyleButton),
      ),
    );

void main() {
  setUpAll(loadAppFonts);

  test('the backup file is named after the day', () {
    expect(
      backupFileName(DateTime(2026, 11, 1)),
      'ink-lab-backup-2026-11-01.zip',
    );
    expect(
      backupFileName(DateTime(2026, 12, 31)),
      'ink-lab-backup-2026-12-31.zip',
    );
  });

  testWidgets('keeps the clipboard backup and adds the two file buttons', (
    WidgetTester tester,
  ) async {
    await _pump(tester);

    // The file is the primary action of the card; the copy by text is
    // folded, so it is not in the way.
    expect(find.text(l10n.settingsSaveBackupFile), findsOneWidget);
    expect(find.text(l10n.settingsRestoreBackupFile), findsOneWidget);
    expect(find.text(l10n.settingsBackupFileCaption), findsOneWidget);
    expect(find.text(l10n.settingsBackupTextTitle), findsOneWidget);
    expect(find.text(l10n.settingsExportBackup), findsNothing);
    expect(find.text(l10n.settingsImportBackup), findsNothing);

    await tester.tap(find.text(l10n.settingsBackupTextTitle));
    await tester.pumpAndSettle();

    expect(find.text(l10n.settingsExportBackup), findsOneWidget);
    expect(find.text(l10n.settingsImportBackup), findsOneWidget);
  });

  testWidgets('the copy by text is exported from the folded block', (
    WidgetTester tester,
  ) async {
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (MethodCall call) async {
        if (call.method == 'Clipboard.setData') {
          copied = (call.arguments as Map<Object?, Object?>)['text'] as String;
        }
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );

    await _pump(tester);
    await tester.tap(find.text(l10n.settingsBackupTextTitle));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.settingsExportBackup));
    await tester.pumpAndSettle();

    expect(copied, isNotNull);
    final Map<String, Object?> backup =
        jsonDecode(copied!) as Map<String, Object?>;
    expect(backup['version'], 1);
    expect(find.text(l10n.settingsBackupExported), findsOneWidget);
  });

  testWidgets(
    'saving builds the ZIP with the photos and opens the share sheet',
    (WidgetTester tester) async {
      final _Env env = await _pump(tester);
      env.photos.put('a.jpg', _jpeg);
      await env.scope.artworkDiary.save(_entry('e1', <String>['a.jpg']));

      await tester.tap(_key('settings-backup-file-save'));
      await tester.pumpAndSettle();

      expect(
        env.io.sharedName,
        matches(RegExp(r'^ink-lab-backup-\d{4}-\d{2}-\d{2}\.zip$')),
      );
      final Archive zip = ZipDecoder().decodeBytes(env.io.sharedBytes!);
      expect(
        zip.files.map((ArchiveFile f) => f.name),
        containsAll(<String>['manifest.json', 'backup.json', 'photos/a.jpg']),
      );
      // Nothing is left running: the progress is gone and no error showed.
      expect(_key('settings-backup-file-progress'), findsNothing);
      expect(find.byType(SnackBar), findsNothing);
    },
  );

  testWidgets('shows progress while it works and blocks a second tap', (
    WidgetTester tester,
  ) async {
    final _Env env = await _pump(tester);
    env.io.shareGate = Completer<void>();

    await tester.tap(_key('settings-backup-file-save'));
    await tester.pump();
    await tester.pump();

    expect(find.text(l10n.settingsBackupFileSaving), findsOneWidget);
    // Both buttons are off while the backup is being made.
    expect(_button(tester, 'settings-backup-file-save').onPressed, isNull);
    expect(_button(tester, 'settings-backup-file-restore').onPressed, isNull);

    env.io.shareGate!.complete();
    await tester.pumpAndSettle();
    expect(find.text(l10n.settingsBackupFileSaving), findsNothing);
  });

  testWidgets('a share sheet that fails shows a clear message', (
    WidgetTester tester,
  ) async {
    final _Env env = await _pump(tester);
    env.io.shareError = const FileSystemException('disk full');

    await tester.tap(_key('settings-backup-file-save'));
    await tester.pumpAndSettle();

    expect(find.text(l10n.settingsBackupFileSaveFailed), findsOneWidget);
    expect(_key('settings-backup-file-progress'), findsNothing);
  });

  testWidgets(
    'restoring asks first, then brings the data and the photos back',
    (WidgetTester tester) async {
      final _Env env = await _pump(tester);
      // A photo the file does not have: it goes with the replaced entry.
      env.photos.put('old.jpg', _jpeg);
      await env.scope.artworkDiary.save(_entry('old', <String>['old.jpg']));
      env.io.pick = pickOf(_archive());

      await tester.tap(_key('settings-backup-file-restore'));
      await tester.pumpAndSettle();

      // The confirmation says the photos come back and the others go.
      expect(find.text(l10n.settingsImportConfirmTitle), findsOneWidget);
      expect(find.text(l10n.settingsRestoreConfirmBody), findsOneWidget);
      expect(l10n.settingsRestoreConfirmBody, contains('photos'));
      expect(env.scope.artworkDiary.entries.single.id, 'old');

      await tester.tap(_inDialog(l10n.settingsImportConfirm));
      await tester.pumpAndSettle();

      expect(env.scope.artworkDiary.entries.single.id, 'from-file');
      expect(await env.photos.read('new.jpg'), _jpeg);
      expect(await env.photos.read('old.jpg'), isNull);
      expect(find.text(l10n.settingsBackupFileRestored), findsOneWidget);
      expect(_key('settings-backup-file-progress'), findsNothing);
    },
  );

  testWidgets('declining the question leaves everything as it was', (
    WidgetTester tester,
  ) async {
    final _Env env = await _pump(tester);
    env.photos.put('old.jpg', _jpeg);
    await env.scope.artworkDiary.save(_entry('old', <String>['old.jpg']));
    env.io.pick = pickOf(_archive());

    await tester.tap(_key('settings-backup-file-restore'));
    await tester.pumpAndSettle();
    await tester.tap(_inDialog(l10n.settingsCancel));
    await tester.pumpAndSettle();

    expect(env.scope.artworkDiary.entries.single.id, 'old');
    expect(await env.photos.read('old.jpg'), _jpeg);
    expect(await env.photos.read('new.jpg'), isNull);
    expect(find.byType(SnackBar), findsNothing);
    expect(_key('settings-backup-file-progress'), findsNothing);
  });

  testWidgets('a cancelled picker does nothing', (WidgetTester tester) async {
    final _Env env = await _pump(tester);
    env.io.pick = null;

    await tester.tap(_key('settings-backup-file-restore'));
    await tester.pumpAndSettle();

    expect(env.io.picks, 1);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(SnackBar), findsNothing);
    expect(_key('settings-backup-file-progress'), findsNothing);
  });

  testWidgets('a file that is not a ZIP is refused before any question', (
    WidgetTester tester,
  ) async {
    final _Env env = await _pump(tester);
    env.io.pick = pickOf(Uint8List.fromList(utf8.encode('{"version": 1}')));

    await tester.tap(_key('settings-backup-file-restore'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text(l10n.settingsBackupFileNotZip), findsOneWidget);
  });

  testWidgets('the copy the picker made is discarded, even on a refusal', (
    WidgetTester tester,
  ) async {
    final _Env env = await _pump(tester);
    int discards = 0;
    env.io.pick = BackupFilePick(
      name: 'notes.zip',
      length: 14,
      read: () async => Uint8List.fromList(utf8.encode('{"version": 1}')),
      discard: () async => discards++,
    );

    await tester.tap(_key('settings-backup-file-restore'));
    await tester.pumpAndSettle();

    expect(find.text(l10n.settingsBackupFileNotZip), findsOneWidget);
    expect(discards, 1);
  });

  testWidgets('a file that is too big is refused without being read', (
    WidgetTester tester,
  ) async {
    final _Env env = await _pump(tester);
    env.io.pick = BackupFilePick(
      name: 'huge.zip',
      length: BackupArchiveService.defaultMaxArchiveBytes + 1,
      read: () async => fail('a file that is too big must not be read'),
    );

    await tester.tap(_key('settings-backup-file-restore'));
    await tester.pumpAndSettle();

    expect(find.text(l10n.settingsBackupFileTooLarge), findsOneWidget);
  });

  testWidgets('an archive the app refuses leaves the data alone and says why', (
    WidgetTester tester,
  ) async {
    final _Env env = await _pump(tester);
    env.photos.put('old.jpg', _jpeg);
    await env.scope.artworkDiary.save(_entry('old', <String>['old.jpg']));
    // A photo that is not an image.
    env.io.pick = pickOf(
      _archive(photoBytes: Uint8List.fromList(utf8.encode('not an image'))),
    );

    await tester.tap(_key('settings-backup-file-restore'));
    await tester.pumpAndSettle();
    await tester.tap(_inDialog(l10n.settingsImportConfirm));
    await tester.pumpAndSettle();

    expect(find.text(l10n.settingsBackupFileNotAPhoto), findsOneWidget);
    expect(env.scope.artworkDiary.entries.single.id, 'old');
    expect(await env.photos.read('old.jpg'), _jpeg);
    expect(_key('settings-backup-file-progress'), findsNothing);
  });

  group('the message of every refusal', () {
    test('has its own text in all six languages', () {
      final List<AppLocalizations> all = <AppLocalizations>[
        l10n,
        ...l10nTranslated,
      ];
      for (final AppLocalizations t in all) {
        final Map<BackupArchiveReason?, String> messages =
            <BackupArchiveReason?, String>{
              for (final BackupArchiveReason reason
                  in BackupArchiveReason.values)
                reason: backupArchiveMessage(
                  t,
                  BackupArchiveException('x', reason: reason),
                ),
              null: backupArchiveMessage(t, const BackupArchiveException('x')),
            };
        for (final MapEntry<BackupArchiveReason?, String> entry
            in messages.entries) {
          expect(
            entry.value,
            isNotEmpty,
            reason: '${t.localeName} ${entry.key}',
          );
          expect(entry.value.length, lessThan(90));
        }
        // The reasons that mean different things say different things.
        expect(
          <String>{
            for (final BackupArchiveReason reason in BackupArchiveReason.values)
              messages[reason]!,
          }.length,
          greaterThanOrEqualTo(7),
          reason: t.localeName,
        );
      }
    });

    test('an exception without a reason shows what it says', () {
      expect(
        backupArchiveMessage(
          l10n,
          const BackupArchiveException('nope', field: 'artworkDiary'),
        ),
        l10n.settingsImportFailed('nope (artworkDiary)'),
      );
    });
  });

  testWidgets(
    'the file buttons fit at 360 dp with big text in every language',
    (WidgetTester tester) async {
      for (final String code in <String>['en', 'es', 'de', 'fr', 'pt', 'it']) {
        await _pump(tester, locale: Locale(code), width: 360, textScale: 1.3);
        final Object? error = tester.takeException();
        expect(error, isNull, reason: '$code ${_describe(error)}');
        final AppLocalizations t = lookupAppLocalizations(Locale(code));
        for (final String label in <String>[
          t.settingsSaveBackupFile,
          t.settingsRestoreBackupFile,
        ]) {
          final Finder text = find.text(label);
          expect(text, findsOneWidget, reason: '$code $label');
          final RenderBox box = tester.renderObject(text);
          // One line: a label never wraps.
          expect(box.size.height, lessThan(30), reason: '$code $label');
        }
      }
    },
  );
}
