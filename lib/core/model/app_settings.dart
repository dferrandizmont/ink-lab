import '../json_value.dart';
import 'oahu_set.dart';

enum PackSelectionMode {
  single('Single pack'),
  compare('Compare packs');

  const PackSelectionMode(this.label);
  final String label;
  String toJson() => enumJson(this);
  static PackSelectionMode fromJson(Object? json) => decodeEnum(values, json);
}

/// Collection-related settings from Kotlin AppSettings, without UI settings.
final class AppSettings {
  AppSettings({
    this.packSelectionMode = PackSelectionMode.single,
    Set<String> selectedCoreSetIds = const {'classic_160'},
    Set<String> selectedAddonSetIds = const {},
    Set<String> ownedMarkerCodes = const {},
  }) : selectedCoreSetIds = Set.unmodifiable(selectedCoreSetIds),
       selectedAddonSetIds = Set.unmodifiable(selectedAddonSetIds),
       ownedMarkerCodes = Set.unmodifiable(ownedMarkerCodes);

  final PackSelectionMode packSelectionMode;
  final Set<String> selectedCoreSetIds, selectedAddonSetIds, ownedMarkerCodes;

  Set<String> effectiveSetIds() {
    final core = packSelectionMode == PackSelectionMode.single
        ? selectedCoreSetIds.take(1)
        : selectedCoreSetIds;
    final combined = {...core, ...selectedAddonSetIds};
    return combined.isEmpty ? {OahuSet.classic160.id} : combined;
  }
}
