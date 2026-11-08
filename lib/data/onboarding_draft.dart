import 'dart:convert';

/// Where the first-run setup stood when the app was left: the step and the
/// choices made so far. It only lives until the setup is finished or skipped;
/// the choices reach the real settings with "Start", never from here.
///
/// Ids are kept as plain strings so a draft written by an older or newer
/// version never fails to load: the page drops what it no longer knows.
final class OnboardingDraft {
  OnboardingDraft({
    required this.step,
    required this.brandId,
    Set<String> seriesIds = const <String>{},
    Set<String> setIds = const <String>{},
    Set<String> extraMarkerIds = const <String>{},
  }) : seriesIds = Set<String>.unmodifiable(seriesIds),
       setIds = Set<String>.unmodifiable(setIds),
       extraMarkerIds = Set<String>.unmodifiable(extraMarkerIds);

  /// The step name (`brand`, `series`, `sets`, `markers` or `done`).
  final String step;
  final String brandId;
  final Set<String> seriesIds;
  final Set<String> setIds;
  final Set<String> extraMarkerIds;

  Map<String, Object?> toJson() => <String, Object?>{
    'step': step,
    'brand': brandId,
    'series': (seriesIds.toList()..sort()),
    'sets': (setIds.toList()..sort()),
    'extras': (extraMarkerIds.toList()..sort()),
  };

  String encode() => jsonEncode(toJson());

  /// Reads a draft from [raw]; anything malformed gives `null`.
  static OnboardingDraft? decode(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    try {
      final Object? json = jsonDecode(raw);
      if (json is! Map<String, dynamic>) return null;
      final Object? step = json['step'];
      final Object? brand = json['brand'];
      if (step is! String || brand is! String) return null;
      Set<String> ids(Object? value) => value is List
          ? <String>{
              for (final Object? id in value)
                if (id is String && id.trim().isNotEmpty) id.trim(),
            }
          : <String>{};
      return OnboardingDraft(
        step: step,
        brandId: brand,
        seriesIds: ids(json['series']),
        setIds: ids(json['sets']),
        extraMarkerIds: ids(json['extras']),
      );
    } on FormatException {
      return null;
    }
  }

  @override
  bool operator ==(Object other) =>
      other is OnboardingDraft &&
      other.step == step &&
      other.brandId == brandId &&
      _same(other.seriesIds, seriesIds) &&
      _same(other.setIds, setIds) &&
      _same(other.extraMarkerIds, extraMarkerIds);

  @override
  int get hashCode => Object.hash(
    step,
    brandId,
    Object.hashAllUnordered(seriesIds),
    Object.hashAllUnordered(setIds),
    Object.hashAllUnordered(extraMarkerIds),
  );
}

bool _same(Set<String> a, Set<String> b) =>
    a.length == b.length && a.containsAll(b);
