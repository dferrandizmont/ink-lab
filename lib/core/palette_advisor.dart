import 'json_value.dart';
import 'models.dart';

final class PaletteSuggestion with JsonValue {
  const PaletteSuggestion({
    required this.color,
    required this.reason,
    this.role,
  });
  final MarkerColor color;
  final String reason;

  /// The role the producer assigned (for example `Shadow`), when it gave one.
  ///
  /// The AI advisor sets it from the same palette item as [reason], so the two
  /// can never disagree; the local engine leaves it `null` and the UI derives a
  /// role from [reason].
  final String? role;
  factory PaletteSuggestion.fromJson(Map<String, dynamic> json) =>
      PaletteSuggestion(
        color: MarkerColor.fromJson(json['color'] as Map<String, dynamic>),
        reason: json['reason'] as String,
        role: json['role'] as String?,
      );
  @override
  Map<String, dynamic> toJson() => {
    'color': color.toJson(),
    'reason': reason,
    if (role != null) 'role': role,
  };
}

final class PaletteAdvisorRequest {
  PaletteAdvisorRequest({
    this.scenario,
    this.baseColor,
    required List<MarkerColor> availableColors,
    this.paletteSize = 5,
    this.mode = PaletteMode.recommended,
    this.brand = MarkerBrand.ohuhuOahu,
    this.scope = BrandScope.singleBrand,
    Set<String> ownedMarkerCodes = const {},
    Set<String> activeSetIds = const {},
    Set<String> driedColorIds = const {},
    this.variationToken = 0,
  }) : availableColors = List.unmodifiable(availableColors),
       ownedMarkerCodes = Set.unmodifiable(ownedMarkerCodes),
       activeSetIds = Set.unmodifiable(activeSetIds),
       driedColorIds = Set.unmodifiable(driedColorIds);
  final Scene? scenario;
  final MarkerColor? baseColor;
  final List<MarkerColor> availableColors;
  final int paletteSize, variationToken;
  final PaletteMode mode;
  final MarkerBrand brand;
  final BrandScope scope;

  /// Uses brand:code IDs; legacy bare codes apply only to Ohuhu.
  final Set<String> ownedMarkerCodes, activeSetIds;

  /// The markers the user owns that ran dry (`brandId:CODE`). They are left
  /// out of [availableColors], and a base among them is refused with its own
  /// reason: the user has it, it just does not paint.
  final Set<String> driedColorIds;
}

sealed class PaletteAdvice {
  const PaletteAdvice();
}

final class PaletteAdviceSuccess extends PaletteAdvice {
  PaletteAdviceSuccess(List<PaletteSuggestion> suggestions)
    : suggestions = List.unmodifiable(suggestions);
  final List<PaletteSuggestion> suggestions;
}

enum PaletteFailureReason {
  noAvailableColors,
  missingBaseColor,
  invalidBaseColor,

  /// The base is a marker the user owns, but it ran dry: it is not out of
  /// the collection, it just does not paint.
  baseDried,
  noSuggestions,
}

final class PaletteAdviceFailure extends PaletteAdvice {
  const PaletteAdviceFailure(this.reason);
  final PaletteFailureReason reason;
}

abstract interface class PaletteAdvisor {
  PaletteAdvice advise(PaletteAdvisorRequest request);
}
