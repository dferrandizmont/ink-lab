import '../json_value.dart';

/// One of the user's own blending recipes: a title, the markers in the order
/// they go on the paper, a free-text note ("B000 → B01 → B04, E40 on the
/// edges") and, optionally, one photo of the result.
///
/// Markers are brand-scoped ids (`brandId:CODE`), so a recipe can mix brands.
/// The [photo] is a file name relative to the app's private artwork folder,
/// never a path (see `ArtworkPhotoStore`).
final class BlendRecipe with JsonValue {
  BlendRecipe({
    required this.id,
    required this.title,
    List<String> markerIds = const <String>[],
    this.note = '',
    this.photo,
    required this.createdAtEpochMs,
    int? updatedAtEpochMs,
  }) : markerIds = List<String>.unmodifiable(markerIds),
       updatedAtEpochMs = updatedAtEpochMs ?? createdAtEpochMs;

  /// The longest title the form accepts.
  static const int maxTitleLength = 80;

  /// The longest note the form accepts.
  static const int maxNoteLength = 2000;

  /// The most markers one recipe holds.
  static const int maxMarkers = 24;

  final String id;
  final String title;

  /// The markers in the order of the blend, as `brandId:CODE` ids.
  final List<String> markerIds;

  /// How it is blended: free text.
  final String note;

  /// The photo file name, or `null` for a recipe without one.
  final String? photo;

  final int createdAtEpochMs;
  final int updatedAtEpochMs;

  BlendRecipe copyWith({
    String? title,
    List<String>? markerIds,
    String? note,
    String? Function()? photo,
    int? updatedAtEpochMs,
  }) => BlendRecipe(
    id: id,
    title: title ?? this.title,
    markerIds: markerIds ?? this.markerIds,
    note: note ?? this.note,
    photo: photo == null ? this.photo : photo(),
    createdAtEpochMs: createdAtEpochMs,
    updatedAtEpochMs: updatedAtEpochMs ?? this.updatedAtEpochMs,
  );

  /// Reads a recipe; optional fields take their defaults, a marker list
  /// longer than [maxMarkers] is cut. A missing id or title is an error.
  factory BlendRecipe.fromJson(Map<String, dynamic> json) {
    final int createdAt = json['createdAtEpochMs'] as int? ?? 0;
    final Object? markers = json['markers'];
    final Object? photo = json['photo'];
    return BlendRecipe(
      id: json['id'] as String,
      title: json['title'] as String,
      markerIds: <String>[
        if (markers is List)
          for (final Object? item in markers)
            if (item is String) item,
      ].take(maxMarkers).toList(),
      note: json['note'] as String? ?? '',
      photo: photo is String && photo.isNotEmpty ? photo : null,
      createdAtEpochMs: createdAt,
      updatedAtEpochMs: json['updatedAtEpochMs'] as int? ?? createdAt,
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'title': title,
    'markers': markerIds,
    'note': note,
    'photo': photo,
    'createdAtEpochMs': createdAtEpochMs,
    'updatedAtEpochMs': updatedAtEpochMs,
  };
}
