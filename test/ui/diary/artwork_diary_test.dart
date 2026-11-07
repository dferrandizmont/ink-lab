import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/ideas_engine.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/ui/pages/diary/artwork_diary_view.dart';
import 'package:ink_lab/ui/pages/diary/artwork_entry_page.dart';
import 'package:ink_lab/ui/pages/diary/artwork_photo_viewer.dart';
import 'package:ink_lab/ui/pages/ideas/ideas_page.dart';
import 'package:ink_lab/ui/pages/match/image_picker_service.dart';
import 'package:ink_lab/ui/theme/app_typography.dart';
import 'package:ink_lab/ui/widgets/ink_segmented.dart';

import '../../support/l10n.dart';
import 'diary_test_support.dart';

/// The first [count] markers of the default collection, in code order.
Future<List<MarkerColor>> _owned(AppScope scope, {int count = 2}) async {
  final List<MarkerColor> catalog = await scope.markers.loadColors(
    MarkerBrand.ohuhuOahu,
  );
  return ownedColors(
    colors: catalog,
    brand: MarkerBrand.ohuhuOahu,
    ownedSetIds: scope.settings.settings.effectiveSetIds(),
    ownedMarkerCodes: scope.settings.settings.ownedMarkerCodes,
  ).take(count).toList();
}

/// Whether the "Save entry" button can be pressed.
bool _canSave(WidgetTester tester) =>
    tester
        .widget<FilledButton>(
          find.descendant(
            of: key('diary-save'),
            matching: find.byType(FilledButton),
          ),
        )
        .onPressed !=
    null;

/// Opens the entry [id] by tapping the corner of its card (the middle may
/// land on a photo).
Future<void> _openEntry(WidgetTester tester, String id) async {
  await tester.tapAt(
    tester.getTopLeft(key('diary-entry-$id')) + const Offset(8, 8),
  );
  await tester.pumpAndSettle();
}

Future<void> _tapKey(WidgetTester tester, String value) async {
  await tester.ensureVisible(key(value));
  await tester.pumpAndSettle();
  await tester.tap(key(value));
  await tester.pumpAndSettle();
}

/// Opens the header's "More actions" menu (share, and delete when editing).
Future<void> _openMenu(WidgetTester tester) async {
  await tester.tap(find.byTooltip(l10n.commonMoreActions));
  await tester.pumpAndSettle();
}

void main() {
  group('the Diary segment of the Ideas tab', () {
    testWidgets('sits next to Ideas and shows the empty state', (
      WidgetTester tester,
    ) async {
      await pumpDiaryPage(tester, IdeasPage(today: DateTime(2026, 10, 29)));
      // Ideas first: the list and the idea of the day are there.
      expect(key('ideas-view'), findsOneWidget);
      expect(key('ideas-search'), findsOneWidget);
      expect(find.byKey(ArtworkDiaryView.viewKey), findsNothing);
      final InkSegmented<dynamic> segmented = tester.widget(key('ideas-view'));
      expect(segmented.segments.map((s) => s.label), [
        l10n.ideasTitle,
        l10n.ideasDiarySegment,
      ]);

      await tester.tap(find.text(l10n.ideasDiarySegment));
      await tester.pumpAndSettle();

      expect(find.byKey(ArtworkDiaryView.viewKey), findsOneWidget);
      expect(key('ideas-search'), findsNothing);
      expect(find.text(l10n.ideasDiarySubtitle), findsOneWidget);
      expect(find.text(l10n.diaryEmptyTitle), findsOneWidget);
      expect(find.text(l10n.diaryEmptyMessage), findsOneWidget);
      expect(find.text(l10n.diaryAdd), findsOneWidget);

      // Back to the ideas.
      await tester.tap(find.text(l10n.ideasTitle).last);
      await tester.pumpAndSettle();
      expect(key('ideas-search'), findsOneWidget);
      expect(find.byKey(ArtworkDiaryView.viewKey), findsNothing);
    });

    testWidgets('lists the entries newest first with their details', (
      WidgetTester tester,
    ) async {
      final d = newDiary();
      final String photo = await d.diary.addPhoto(tinyPng);
      final AppScope scope = await pumpDiary(
        tester,
        diary: d.diary,
        setup: (AppScope s) async {
          await s.savedPalettes.save(savedPalette());
          await d.diary.save(
            entry(
              id: 'old',
              title: 'Old sheet',
              date: DateTime(2026, 3, 1),
              status: ArtworkStatus.inProgress,
            ),
          );
          await d.diary.save(
            entry(
              id: 'new',
              title: 'Forest page',
              date: DateTime(2026, 10, 30),
              onWhat: 'Forest colouring book',
              markerIds: const ['ohuhu_oahu:B08', 'ohuhu_oahu:R101'],
              paletteId: 'p1',
              photos: [photo],
            ),
          );
        },
      );

      expect(find.text(l10n.diaryEmptyTitle), findsNothing);
      expect(key('diary-add'), findsOneWidget);
      // Newest first in reading order: above, or on the left in the same row
      // (the default 800 dp test surface lays the entries in two columns).
      final Offset newest = tester.getTopLeft(key('diary-entry-new'));
      final Offset oldest = tester.getTopLeft(key('diary-entry-old'));
      expect(
        newest.dy < oldest.dy ||
            (newest.dy == oldest.dy && newest.dx < oldest.dx),
        isTrue,
        reason: 'newest $newest, oldest $oldest',
      );

      expect(find.text('Forest page'), findsOneWidget);
      expect(find.text('Forest colouring book'), findsOneWidget);
      // Date and status in the caps line.
      final String date = MaterialLocalizations.of(
        tester.element(key('diary-entry-new')),
      ).formatMediumDate(DateTime(2026, 10, 30));
      expect(
        find.text(AppTypography.caps('$date · ${l10n.diaryStatusFinished}')),
        findsOneWidget,
      );
      expect(
        find.textContaining(l10n.diaryStatusInProgress.toUpperCase()),
        findsOneWidget,
      );
      // The photo, the linked palette and its name.
      expect(key('diary-thumb-$photo'), findsOneWidget);
      expect(find.text('Sunrise'), findsOneWidget);
      expect(scope.artworkDiary.entries, hasLength(2));
    });

    testWidgets('a missing photo file or a deleted palette shows nothing', (
      WidgetTester tester,
    ) async {
      await pumpDiary(
        tester,
        setup: (AppScope s) => s.artworkDiary.save(
          entry(photos: const ['gone.jpg'], paletteId: 'deleted'),
        ),
      );
      expect(find.text('Forest page'), findsOneWidget);
      expect(find.byType(Image), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('a photo opens at full screen and closes', (
      WidgetTester tester,
    ) async {
      final d = newDiary();
      final String a = await d.diary.addPhoto(tinyPng);
      final String b = await d.diary.addPhoto(tinyPng);
      await pumpDiary(
        tester,
        diary: d.diary,
        setup: (AppScope s) => d.diary.save(entry(photos: [a, b])),
      );

      await tester.tap(key('diary-thumb-$b'));
      await tester.pumpAndSettle();
      expect(find.byKey(ArtworkPhotoViewer.pageKey), findsOneWidget);
      // Starts on the photo that was tapped: 2 of 2.
      expect(find.text(l10n.diaryPhotoSemantic(2, 2)), findsOneWidget);

      await tester.tap(key('diary-photo-close'));
      await tester.pumpAndSettle();
      expect(find.byKey(ArtworkPhotoViewer.pageKey), findsNothing);
    });

    testWidgets('Add to diary is the primary, in the 48 dp add slot', (
      WidgetTester tester,
    ) async {
      await pumpDiary(tester);
      final Finder add = key('diary-add');
      expect(
        find.descendant(of: add, matching: find.byType(FilledButton)),
        findsOneWidget,
      );
      expect(tester.getSize(add).height, closeTo(48, 0.5));
    });

    testWidgets('the add slot sits where the Ideas search field sits', (
      WidgetTester tester,
    ) async {
      await pumpDiaryPage(tester, IdeasPage(today: DateTime(2026, 10, 29)));
      final double searchTop = tester.getTopLeft(key('ideas-search')).dy;
      final double searchHeight = tester.getSize(key('ideas-search')).height;

      await tester.tap(find.text(l10n.ideasDiarySegment));
      await tester.pumpAndSettle();

      expect(tester.getTopLeft(key('diary-add')).dy, closeTo(searchTop, 0.5));
      expect(
        tester.getSize(key('diary-add')).height,
        closeTo(searchHeight, 0.5),
      );
    });
  });

  group('the entry form', () {
    testWidgets('needs a title, then adds an entry with everything on it', (
      WidgetTester tester,
    ) async {
      final d = newDiary();
      final FakeImagePickerService picker = FakeImagePickerService(
        PhotoPicked(tinyPng),
      );
      final AppScope scope = await pumpDiary(
        tester,
        picker: picker,
        diary: d.diary,
        setup: (AppScope s) => s.savedPalettes.save(savedPalette()),
      );

      await tester.tap(find.text(l10n.diaryAdd));
      await tester.pumpAndSettle();
      expect(find.byKey(ArtworkEntryPage.pageKey), findsOneWidget);
      expect(find.text(l10n.diaryNewTitle), findsOneWidget);
      expect(_canSave(tester), isFalse);

      await tester.enterText(key('diary-title'), '  Autumn leaves  ');
      // The optional fields live in "More details", folded while empty.
      await _tapKey(tester, 'diary-details');
      await tester.enterText(key('diary-on-what'), 'Sketchbook');
      await tester.enterText(
        key('diary-notes'),
        'Wet blending on cotton paper',
      );
      await tester.pumpAndSettle();
      expect(_canSave(tester), isTrue);

      // Status: finished by default, then in progress.
      final InkSegmented<dynamic> status = tester.widget(key('diary-status'));
      expect(status.selected, ArtworkStatus.finished);
      await tester.tap(find.text(l10n.diaryStatusInProgress));
      await tester.pumpAndSettle();

      // Markers from the collection, as chips.
      final List<MarkerColor> owned = await _owned(scope);
      await _tapKey(tester, 'diary-markers-choose');
      expect(key('diary-marker-picker'), findsOneWidget);
      for (final MarkerColor marker in owned) {
        await tester.tap(key('diary-marker-${marker.newCode}'));
        await tester.pumpAndSettle();
      }
      await tester.tap(find.byTooltip(l10n.commonClose));
      await tester.pumpAndSettle();
      for (final MarkerColor marker in owned) {
        expect(key('diary-marker-chip-${marker.colorId}'), findsOneWidget);
      }

      // A saved palette.
      await _tapKey(tester, 'diary-palette');
      expect(key('diary-palette-picker'), findsOneWidget);
      await tester.tap(key('diary-palette-p1'));
      await tester.pumpAndSettle();
      expect(find.text('Sunrise'), findsOneWidget);

      // Two photos.
      await _tapKey(tester, 'diary-photo-gallery');
      await _tapKey(tester, 'diary-photo-camera');
      expect(picker.calls, [PhotoSource.gallery, PhotoSource.camera]);
      expect(key('diary-photo-0'), findsOneWidget);
      expect(key('diary-photo-1'), findsOneWidget);
      // Nothing is copied before saving.
      expect(d.photos.names, isEmpty);

      await _tapKey(tester, 'diary-save');

      // Back on the list, with a notice, the entry and its photos.
      expect(find.byKey(ArtworkEntryPage.pageKey), findsNothing);
      expect(find.text(l10n.diaryAddedNotice), findsOneWidget);
      final ArtworkEntry saved = scope.artworkDiary.entries.single;
      expect(saved.title, 'Autumn leaves');
      expect(saved.onWhat, 'Sketchbook');
      expect(saved.notes, 'Wet blending on cotton paper');
      expect(saved.status, ArtworkStatus.inProgress);
      expect(saved.markerIds, [for (final m in owned) m.colorId]);
      expect(saved.paletteId, 'p1');
      expect(saved.photos, hasLength(2));
      expect(d.photos.names, saved.photos.toSet());
      final DateTime now = DateTime.now();
      expect(saved.date, DateTime(now.year, now.month, now.day));
      expect(find.text('Autumn leaves'), findsOneWidget);
      expect(
        find.byKey(ValueKey<String>('diary-thumb-${saved.photos.first}')),
        findsOneWidget,
      );
    });

    testWidgets('allows up to four photos', (WidgetTester tester) async {
      final FakeImagePickerService picker = FakeImagePickerService(
        PhotoPicked(tinyPng),
      );
      await pumpDiaryPage(tester, ArtworkEntryPage(picker: picker));
      for (var i = 0; i < 4; i++) {
        await _tapKey(tester, 'diary-photo-gallery');
      }
      expect(key('diary-photo-3'), findsOneWidget);
      expect(picker.calls, hasLength(4));
      for (final String button in [
        'diary-photo-gallery',
        'diary-photo-camera',
      ]) {
        expect(
          tester
              .widget<OutlinedButton>(
                find.descendant(
                  of: key(button),
                  matching: find.byType(OutlinedButton),
                ),
              )
              .onPressed,
          isNull,
          reason: button,
        );
      }
      // Removing one frees a place.
      await _tapKey(tester, 'diary-photo-remove-0');
      expect(key('diary-photo-3'), findsNothing);
      await _tapKey(tester, 'diary-photo-camera');
      expect(key('diary-photo-3'), findsOneWidget);
    });

    testWidgets('a refused camera or a cancelled pick adds no photo', (
      WidgetTester tester,
    ) async {
      final FakeImagePickerService picker = FakeImagePickerService(
        const PhotoPickDenied(PhotoSource.camera),
      );
      await pumpDiaryPage(tester, ArtworkEntryPage(picker: picker));

      await _tapKey(tester, 'diary-photo-camera');
      expect(find.text(l10n.matchCameraDenied), findsOneWidget);
      expect(key('diary-photo-0'), findsNothing);

      picker.result = const PhotoPickCancelled();
      await _tapKey(tester, 'diary-photo-gallery');
      expect(find.text(l10n.matchCameraDenied), findsNothing);
      expect(key('diary-photo-0'), findsNothing);
    });

    testWidgets('leaving without saving keeps nothing', (
      WidgetTester tester,
    ) async {
      final d = newDiary();
      final FakeImagePickerService picker = FakeImagePickerService(
        PhotoPicked(tinyPng),
      );
      final AppScope scope = await pumpDiary(
        tester,
        picker: picker,
        diary: d.diary,
      );
      await tester.tap(find.text(l10n.diaryAdd));
      await tester.pumpAndSettle();
      await tester.enterText(key('diary-title'), 'Draft');
      await _tapKey(tester, 'diary-photo-gallery');
      expect(key('diary-photo-0'), findsOneWidget);

      Navigator.of(tester.element(find.byKey(ArtworkEntryPage.pageKey))).pop();
      await tester.pumpAndSettle();

      expect(scope.artworkDiary.entries, isEmpty);
      expect(d.photos.names, isEmpty);
      expect(find.text(l10n.diaryAddedNotice), findsNothing);
    });

    testWidgets('the date opens a picker and keeps the day', (
      WidgetTester tester,
    ) async {
      await pumpDiaryPage(tester, ArtworkEntryPage(entry: entry()));
      final String shown = MaterialLocalizations.of(
        tester.element(key('diary-date')),
      ).formatMediumDate(DateTime(2026, 10, 30));
      expect(find.text(shown), findsOneWidget);

      await _tapKey(tester, 'diary-date');
      expect(find.byType(DatePickerDialog), findsOneWidget);
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      expect(find.byType(DatePickerDialog), findsNothing);
      expect(find.text(shown), findsOneWidget);
    });

    testWidgets('edits an entry, drops a photo and deletes its file', (
      WidgetTester tester,
    ) async {
      final d = newDiary();
      final String a = await d.diary.addPhoto(tinyPng);
      final String b = await d.diary.addPhoto(tinyPng);
      final AppScope scope = await pumpDiary(
        tester,
        diary: d.diary,
        setup: (AppScope s) => d.diary.save(
          entry(
            title: 'Forest page',
            onWhat: 'Colouring book',
            notes: 'First layer',
            photos: [a, b],
            markerIds: const ['ohuhu_oahu:B08'],
          ),
        ),
      );

      await _openEntry(tester, 'e1');
      expect(find.text(l10n.diaryEditTitle), findsOneWidget);
      expect(
        tester.widget<TextField>(key('diary-title')).controller!.text,
        'Forest page',
      );
      expect(
        tester.widget<TextField>(key('diary-notes')).controller!.text,
        'First layer',
      );
      expect(key('diary-photo-0'), findsOneWidget);
      expect(key('diary-photo-1'), findsOneWidget);
      expect(key('diary-marker-chip-ohuhu_oahu:B08'), findsOneWidget);

      await tester.enterText(key('diary-title'), 'Forest page, finished');
      await _tapKey(tester, 'diary-photo-remove-0');
      await _tapKey(tester, 'diary-marker-chip-ohuhu_oahu:B08');
      await _tapKey(tester, 'diary-save');

      final ArtworkEntry saved = scope.artworkDiary.entries.single;
      expect(saved.id, 'e1');
      expect(saved.title, 'Forest page, finished');
      expect(saved.photos, [b]);
      expect(saved.markerIds, isEmpty);
      expect(d.photos.names, {b});
      expect(find.text('Forest page, finished'), findsOneWidget);
      // Editing is not "adding": no notice.
      expect(find.text(l10n.diaryAddedNotice), findsNothing);
    });

    testWidgets(
      'a missing photo file is dropped, a deleted palette shows a note',
      (WidgetTester tester) async {
        final AppScope scope = await pumpDiary(
          tester,
          setup: (AppScope s) => s.artworkDiary.save(
            entry(photos: const ['gone.jpg'], paletteId: 'deleted'),
          ),
        );
        await _openEntry(tester, 'e1');

        expect(key('diary-photo-0'), findsNothing);
        expect(find.text(l10n.diaryPaletteMissing), findsOneWidget);
        expect(find.text(l10n.diaryPaletteNone), findsOneWidget);

        await _tapKey(tester, 'diary-save');
        expect(scope.artworkDiary.entries.single.photos, isEmpty);
      },
    );

    testWidgets('delete asks first, then removes the entry and its photos', (
      WidgetTester tester,
    ) async {
      final d = newDiary();
      final String a = await d.diary.addPhoto(tinyPng);
      final AppScope scope = await pumpDiary(
        tester,
        diary: d.diary,
        setup: (AppScope s) => d.diary.save(entry(photos: [a])),
      );
      await _openEntry(tester, 'e1');

      await _openMenu(tester);
      await tester.tap(key('diary-delete'));
      await tester.pumpAndSettle();
      expect(find.text(l10n.diaryDeleteTitle), findsOneWidget);
      expect(find.text(l10n.diaryDeleteBody), findsOneWidget);

      // Cancel keeps everything.
      await tester.tap(find.text(l10n.settingsCancel));
      await tester.pumpAndSettle();
      expect(scope.artworkDiary.entries, hasLength(1));
      expect(d.photos.names, {a});

      await _openMenu(tester);
      await tester.tap(key('diary-delete'));
      await tester.pumpAndSettle();
      await tester.tap(find.text(l10n.diaryDeleteConfirm));
      await tester.pumpAndSettle();

      expect(scope.artworkDiary.entries, isEmpty);
      expect(d.photos.names, isEmpty);
      expect(find.byKey(ArtworkEntryPage.pageKey), findsNothing);
      expect(find.text(l10n.diaryEmptyTitle), findsOneWidget);
    });

    testWidgets('the header menu shares and, when editing, deletes', (
      WidgetTester tester,
    ) async {
      await pumpDiaryPage(tester, const ArtworkEntryPage());
      await _openMenu(tester);
      expect(key('diary-share'), findsOneWidget);
      expect(key('diary-delete'), findsNothing);
      // Close the menu before pumping the next page.
      Navigator.of(tester.element(key('diary-overflow'))).pop();
      await tester.pumpAndSettle();

      await pumpDiaryPage(tester, ArtworkEntryPage(entry: entry()));
      await _openMenu(tester);
      expect(key('diary-share'), findsOneWidget);
      expect(key('diary-delete'), findsOneWidget);
    });

    testWidgets('Save entry is the only primary action of the form', (
      WidgetTester tester,
    ) async {
      await pumpDiaryPage(tester, ArtworkEntryPage(entry: entry()));
      expect(find.byType(FilledButton), findsOneWidget);
      expect(
        find.descendant(
          of: key('diary-save'),
          matching: find.byType(FilledButton),
        ),
        findsOneWidget,
      );
      // The delete button is no longer in the body.
      expect(key('diary-delete'), findsNothing);
    });

    testWidgets(
      'folds More details while empty, opens it when one has a value',
      (WidgetTester tester) async {
        await pumpDiaryPage(tester, const ArtworkEntryPage());
        expect(find.text(l10n.diaryMoreDetails), findsOneWidget);
        // Folded: the optional fields are not built.
        expect(key('diary-on-what'), findsNothing);
        expect(key('diary-date'), findsNothing);
        expect(key('diary-palette'), findsNothing);
        expect(key('diary-notes'), findsNothing);

        await _tapKey(tester, 'diary-details');
        expect(key('diary-on-what'), findsOneWidget);
        expect(key('diary-date'), findsOneWidget);
        expect(key('diary-palette'), findsOneWidget);
        expect(key('diary-notes'), findsOneWidget);

        // An entry with notes opens the block on its own.
        await pumpDiaryPage(
          tester,
          ArtworkEntryPage(entry: entry(notes: 'First layer')),
        );
        expect(key('diary-notes'), findsOneWidget);
      },
    );

    testWidgets('a new entry has no delete button', (
      WidgetTester tester,
    ) async {
      await pumpDiaryPage(tester, const ArtworkEntryPage());
      await _openMenu(tester);
      expect(key('diary-delete'), findsNothing);
      expect(key('diary-share'), findsOneWidget);
      expect(key('diary-save'), findsOneWidget);
    });
  });

  group('Add to diary', () {
    testWidgets('from an idea: the sheet closes and the title is filled in', (
      WidgetTester tester,
    ) async {
      final AppScope scope = await pumpDiaryPage(
        tester,
        IdeasPage(today: DateTime(2026, 10, 29)),
      );
      final IdeaPreset preset = IdeasEngine.byId('one_color')!;
      await tester.tap(key('ideas-preset-one_color'));
      await tester.pumpAndSettle();
      // "Add to diary" lives in the idea's ⋯ menu.
      await _tapKey(tester, 'ideas-overflow-one_color');
      await tester.tap(key('ideas-diary-one_color'));
      await tester.pumpAndSettle();

      // The sheet is gone and the form is open with the idea's name.
      expect(key('ideas-detail-one_color'), findsNothing);
      expect(find.byKey(ArtworkEntryPage.pageKey), findsOneWidget);
      final String title = l10n.ideaTitle(preset);
      expect(
        tester.widget<TextField>(key('diary-title')).controller!.text,
        title,
      );

      await _tapKey(tester, 'diary-save');
      expect(scope.artworkDiary.entries.single.title, title);
      expect(find.text(l10n.diaryAddedNotice), findsOneWidget);
    });

    testWidgets('from a saved palette: links it and its markers', (
      WidgetTester tester,
    ) async {
      final FakeImagePickerService picker = FakeImagePickerService(
        PhotoPicked(tinyPng),
      );
      final AppScope scope = await pumpPaletteWithSaved(
        tester,
        savedPalette(codes: const ['B08', 'R101', 'Y1']),
        picker: picker,
      );
      await _tapKey(tester, 'palette-saved-palettes');
      await _tapKey(tester, 'palette-saved-menu-p1');
      await _tapKey(tester, 'palette-diary-p1');

      expect(find.byKey(ArtworkEntryPage.pageKey), findsOneWidget);
      for (final String code in ['B08', 'R101', 'Y1']) {
        expect(key('diary-marker-chip-ohuhu_oahu:$code'), findsOneWidget);
      }
      expect(find.text('Sunrise'), findsOneWidget);
      // The title is the user's to write.
      expect(tester.widget<TextField>(key('diary-title')).controller!.text, '');
      expect(_canSave(tester), isFalse);

      await tester.enterText(key('diary-title'), 'Sunrise sheet');
      await _tapKey(tester, 'diary-save');

      final ArtworkEntry saved = scope.artworkDiary.entries.single;
      expect(saved.paletteId, 'p1');
      expect(saved.markerIds, [
        'ohuhu_oahu:B08',
        'ohuhu_oahu:R101',
        'ohuhu_oahu:Y1',
      ]);
      expect(find.text(l10n.diaryAddedNotice), findsOneWidget);
    });
  });
}
