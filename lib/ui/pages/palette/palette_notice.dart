part of 'palette_page.dart';

enum _PaletteNoticeKind { loaded, imported, draft, idea, diary }

/// Keep operation data so notices, including undo snapshots, follow the locale.
final class _PaletteNotice {
  const _PaletteNotice(
    this.kind, {
    this.name = '',
    this.count = 0,
    this.unknown = '',
    this.repeated = false,
  });

  final _PaletteNoticeKind kind;
  final String name, unknown;
  final int count;
  final bool repeated;

  String message(AppLocalizations t) => switch (kind) {
    _PaletteNoticeKind.loaded => t.paletteLoadedNotice(name),
    _PaletteNoticeKind.imported => <String>[
      t.paletteImportDone(count),
      if (unknown.isNotEmpty) t.paletteImportUnknown(unknown),
      if (repeated) t.paletteImportRepeated,
    ].join(' '),
    _PaletteNoticeKind.draft => t.paletteDraftApplied(count),
    _PaletteNoticeKind.idea => t.paletteIdeaApplied(name, count),
    _PaletteNoticeKind.diary => t.diaryAddedNotice,
  };
}
