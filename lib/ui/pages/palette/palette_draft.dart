import 'package:flutter/foundation.dart';

import '../../../core/models.dart';
import '../../../core/palette_advisor.dart';

/// A palette handed from the Ideas page to the Palette page.
///
/// The suggestions keep the role and the reason the idea gave each marker
/// (light, base, shadow…), so the Palette page shows them instead of a
/// generic "Applied from Ideas".
@immutable
class PaletteDraft {
  const PaletteDraft({required this.suggestions, this.title});

  /// The markers, in the idea's order (light to dark for ladders).
  final List<PaletteSuggestion> suggestions;

  /// Localised title of the idea, for the confirmation notice.
  final String? title;
}

/// Hand-off slot between the Ideas page and the Palette page.
///
/// The Ideas page sets [paletteDraft] to the palette it wants the Palette page
/// to show. The Palette page listens for changes, shows the draft and then
/// consumes it by setting the value back to `null`, so a draft is applied once
/// and never replayed on a later rebuild.
///
/// The notifier is intentionally module-level and tiny: pages in this app are
/// parameterless and talk to each other only through the composition root, so a
/// single shared [ValueNotifier] keeps the two screens decoupled.
final ValueNotifier<PaletteDraft?> paletteDraft = ValueNotifier<PaletteDraft?>(
  null,
);

/// Hand-off slot for a single base colour (Swatches detail sheet "Add to
/// palette").
///
/// The shell sets it and switches to the Palette tab; the Palette page uses the
/// marker as its base colour and consumes it by setting the value back to
/// `null`, exactly like [paletteDraft]. When that replaces a palette already
/// on screen, the Palette page offers to undo it.
final ValueNotifier<MarkerColor?> paletteBaseDraft =
    ValueNotifier<MarkerColor?>(null);

/// The palette type to use together with a [paletteBaseDraft] (Swatches detail
/// sheet "Blending chain"). The shell sets it just before the base; the
/// Palette page reads it and consumes it by setting the value back to `null`.
/// Without it the base keeps the type already chosen.
final ValueNotifier<PaletteMode?> paletteBaseMode = ValueNotifier<PaletteMode?>(
  null,
);

/// Hand-off slot for a saved palette to open in the Palette tab (a row of the
/// saved palettes sheet opened from Settings).
///
/// The sheet sets it; the shell switches to the Palette tab; the Palette page
/// loads the palette and consumes it by setting the value back to `null`,
/// exactly like [paletteDraft]. The Palette page itself loads a palette
/// directly, without this slot.
final ValueNotifier<SavedPalette?> paletteSavedDraft =
    ValueNotifier<SavedPalette?>(null);
