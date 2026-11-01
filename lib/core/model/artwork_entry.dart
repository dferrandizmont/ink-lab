import '../json_value.dart';

/// How far an artwork is.
enum ArtworkStatus {
  /// Still being painted.
  inProgress('inProgress'),

  /// Done.
  finished('finished');

  const ArtworkStatus(this.wire);

  /// The value written to storage and to backups.
  final String wire;

  /// An unknown or missing value reads as [finished], the default.
  static ArtworkStatus fromWire(Object? value) =>
      value == inProgress.wire ? inProgress : finished;
}

/// One line of the artwork diary: a page of a colouring book, a sheet, a
/// sketchbook page, anything the user painted.
///
/// Generic on purpose: [onWhat] is free text and nothing links to a catalogue
/// of publications. Markers are brand-scoped ids (`brandId:CODE`), the palette
/// is a saved palette's id (which may have been deleted since), and [photos]
/// are file names relative to the app's private artwork folder, never paths.
final class ArtworkEntry with JsonValue {
  ArtworkEntry({
    required this.id,
    required this.title,
    required DateTime date,
    this.onWhat = '',
    this.status = ArtworkStatus.finished,
    List<String> markerIds = const <String>[],
    this.paletteId,
    this.notes = '',
    List<String> photos = const <String>[],
    required this.createdAtEpochMs,
  }) : date = DateTime(date.year, date.month, date.day),
       markerIds = List<String>.unmodifiable(markerIds),
       photos = List<String>.unmodifiable(photos);

  /// Photos an entry can hold.
  static const int maxPhotos = 4;

  final String id;
  final String title;

  /// The day it was painted (local, without a time).
  final DateTime date;

  /// What it was painted on, free text ("Forest colouring book").
  final String onWhat;
  final ArtworkStatus status;

  /// The markers used, as `brandId:CODE` ids.
  final List<String> markerIds;

  /// The saved palette it links to, if any.
  final String? paletteId;

  /// How it was painted: technique, paper, blending...
  final String notes;

  /// Photo file names, relative to the private artwork folder.
  final List<String> photos;

  final int createdAtEpochMs;

  /// `yyyy-MM-dd`, the way [date] is stored.
  static String formatDate(DateTime date) {
    final String month = date.month.toString().padLeft(2, '0');
    final String day = date.day.toString().padLeft(2, '0');
    return '${date.year.toString().padLeft(4, '0')}-$month-$day';
  }

  /// Reads an entry; missing optional fields take their defaults and a photo
  /// list longer than [maxPhotos] is cut. A missing id or title is an error.
  factory ArtworkEntry.fromJson(Map<String, dynamic> json) {
    final int createdAt = json['createdAtEpochMs'] as int? ?? 0;
    final DateTime? date = DateTime.tryParse(json['date'] as String? ?? '');
    List<String> strings(Object? value) => <String>[
      if (value is List)
        for (final Object? item in value)
          if (item is String) item,
    ];
    return ArtworkEntry(
      id: json['id'] as String,
      title: json['title'] as String,
      date: date ?? DateTime.fromMillisecondsSinceEpoch(createdAt),
      onWhat: json['onWhat'] as String? ?? '',
      status: ArtworkStatus.fromWire(json['status']),
      markerIds: strings(json['markers']),
      paletteId: json['paletteId'] as String?,
      notes: json['notes'] as String? ?? '',
      photos: strings(json['photos']).take(maxPhotos).toList(),
      createdAtEpochMs: createdAt,
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'title': title,
    'date': formatDate(date),
    'onWhat': onWhat,
    'status': status.wire,
    'markers': markerIds,
    'paletteId': paletteId,
    'notes': notes,
    'photos': photos,
    'createdAtEpochMs': createdAtEpochMs,
  };
}
