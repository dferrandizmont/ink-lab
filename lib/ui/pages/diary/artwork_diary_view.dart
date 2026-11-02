import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/models.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/ink_button.dart';
import '../match/image_picker_service.dart';
import 'artwork_entry_page.dart';
import 'artwork_photo_viewer.dart';
import 'diary_summary_card.dart';
import 'diary_widgets.dart';

/// The artwork diary list, newest first, with a way to add an entry. It lives
/// in the Ideas tab, next to the ideas.
///
/// Each entry is a card with its date and status, title, what it was painted
/// on, photo thumbnails (tap for full screen), the markers as small swatches
/// and the linked palette. Tapping the card opens the entry to edit or delete
/// it. With entries, a summary card at the top (counts and the markers used
/// most) opens the diary numbers. An empty diary explains itself in one
/// sentence.
class ArtworkDiaryView extends StatefulWidget {
  const ArtworkDiaryView({super.key, this.picker});

  /// Key of the view, handy for tests.
  static const Key viewKey = Key('diary-view');

  /// Photo picker handed to the entry form (tests inject a fake).
  final ImagePickerService? picker;

  @override
  State<ArtworkDiaryView> createState() => _ArtworkDiaryViewState();
}

class _ArtworkDiaryViewState extends State<ArtworkDiaryView> {
  AppScope? _scope;
  final List<StreamSubscription<List<SavedPalette>>> _palettes =
      <StreamSubscription<List<SavedPalette>>>[];

  ImagePickerService? get picker => widget.picker;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppScope scope = AppScope.of(context);
    if (identical(scope, _scope)) return;
    _scope = scope;
    // A palette an entry links to may be saved or deleted in the meantime.
    for (final StreamSubscription<List<SavedPalette>> s in _palettes) {
      s.cancel();
    }
    _palettes.clear();
    for (final MarkerBrand brand in MarkerBrand.values) {
      _palettes.add(
        scope.savedPalettes.watch(brand).skip(1).listen((_) => setState(() {})),
      );
    }
  }

  @override
  void dispose() {
    for (final StreamSubscription<List<SavedPalette>> s in _palettes) {
      s.cancel();
    }
    super.dispose();
  }

  Future<void> _add(BuildContext context) async {
    final ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(
      context,
    );
    final String notice = context.l10n.diaryAddedNotice;
    final bool saved = await ArtworkEntryPage.open(context, picker: picker);
    if (!saved) return;
    messenger
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          key: const ValueKey<String>('diary-added'),
          content: Text(notice),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final AppScope scope = AppScope.of(context);
    return StreamBuilder<List<ArtworkEntry>>(
      key: ArtworkDiaryView.viewKey,
      stream: scope.artworkDiary.changes,
      initialData: scope.artworkDiary.entries,
      builder: (BuildContext context, AsyncSnapshot<List<ArtworkEntry>> s) {
        final List<ArtworkEntry> entries = s.data ?? const <ArtworkEntry>[];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // "Add to diary" is the primary of the segment and sits in the
            // same 48 dp slot as the search field of the Ideas segment, so
            // switching segments never moves anything.
            Padding(
              padding: const EdgeInsets.fromLTRB(
                InkSpacing.pageMargin,
                0,
                InkSpacing.pageMargin,
                InkSpacing.group,
              ),
              child: SizedBox(
                key: const ValueKey<String>('diary-add-slot'),
                height: InkGeometry.fieldHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    InkButton(
                      key: const ValueKey<String>('diary-add'),
                      label: context.l10n.diaryAdd,
                      icon: InkIcons.plus,
                      expand: true,
                      onPressed: () => _add(context),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(
                  top: InkSpacing.block,
                  bottom: InkSpacing.pageBottom,
                ),
                children: <Widget>[
                  if (entries.isEmpty)
                    EmptyState(
                      icon: InkIcons.edit3,
                      title: context.l10n.diaryEmptyTitle,
                      message: context.l10n.diaryEmptyMessage,
                    )
                  else ...<Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: InkSpacing.gutter,
                      ),
                      child: DiarySummaryCard(
                        key: const ValueKey<String>('diary-stats-card'),
                        entries: entries,
                      ),
                    ),
                    for (final ArtworkEntry entry in entries)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          InkSpacing.gutter,
                          InkSpacing.block,
                          InkSpacing.gutter,
                          0,
                        ),
                        child: _EntryCard(
                          key: ValueKey<String>('diary-entry-${entry.id}'),
                          entry: entry,
                          picker: picker,
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

/// One entry of the diary.
class _EntryCard extends StatelessWidget {
  const _EntryCard({super.key, required this.entry, this.picker});

  final ArtworkEntry entry;
  final ImagePickerService? picker;

  /// Opens the photos of the entry at full screen, starting at [name].
  Future<void> _openPhoto(BuildContext context, String name) async {
    final AppScope scope = AppScope.of(context);
    final List<Uint8List> photos = <Uint8List>[];
    int start = 0;
    for (final String photo in entry.photos) {
      final Uint8List? bytes = await scope.artworkDiary.photoBytes(photo);
      if (bytes == null) continue;
      if (photo == name) start = photos.length;
      photos.add(bytes);
    }
    if (!context.mounted) return;
    await ArtworkPhotoViewer.open(context, photos: photos, initialIndex: start);
  }

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    final AppScope scope = AppScope.of(context);
    final String? linked = entry.paletteId;
    final SavedPalette? palette = linked == null
        ? null
        : findSavedPalette(scope, linked);
    final String status = entry.status == ArtworkStatus.inProgress
        ? l10n.diaryStatusInProgress
        : l10n.diaryStatusFinished;
    final String date = MaterialLocalizations.of(context)
        .formatMediumDate(entry.date);
    return Card(
      child: InkWell(
        onTap: () =>
            ArtworkEntryPage.open(context, entry: entry, picker: picker),
        borderRadius: InkRadii.cardRadius,
        child: Padding(
          padding: InkSpacing.card,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppTypography.caps('$date · $status'),
                style: AppTypography.capsStyle.copyWith(
                  color: entry.status == ArtworkStatus.inProgress
                      ? ink.action
                      : ink.fg2,
                ),
              ),
              const SizedBox(height: InkSpacing.s4),
              Semantics(
                header: true,
                child: Text(
                  entry.title,
                  style: AppTypography.section.copyWith(color: ink.fg),
                ),
              ),
              if (entry.onWhat.isNotEmpty) ...<Widget>[
                const SizedBox(height: InkSpacing.s2),
                Text(
                  entry.onWhat,
                  style: AppTypography.secondary.copyWith(color: ink.fg2),
                ),
              ],
              if (entry.photos.isNotEmpty) ...<Widget>[
                const SizedBox(height: InkSpacing.buttonGap),
                Wrap(
                  spacing: InkSpacing.s8,
                  runSpacing: InkSpacing.s8,
                  children: <Widget>[
                    for (final String name in entry.photos)
                      ArtworkPhoto(
                        key: ValueKey<String>('diary-thumb-$name'),
                        name: name,
                        size: 64,
                        onTap: (_) => _openPhoto(context, name),
                      ),
                  ],
                ),
              ],
              if (entry.markerIds.isNotEmpty) ...<Widget>[
                const SizedBox(height: InkSpacing.buttonGap),
                DiaryMarkerDots(ids: entry.markerIds),
              ],
              if (palette != null) ...<Widget>[
                const SizedBox(height: InkSpacing.buttonGap),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 72,
                      child: DiaryPaletteStrip(palette: palette),
                    ),
                    const SizedBox(width: InkSpacing.s12),
                    Expanded(
                      child: Text(
                        palette.name,
                        style: AppTypography.secondary.copyWith(color: ink.fg2),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
