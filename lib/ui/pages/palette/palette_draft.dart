import 'package:flutter/foundation.dart';

import '../../../core/models.dart';

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
final ValueNotifier<List<MarkerColor>?> paletteDraft =
    ValueNotifier<List<MarkerColor>?>(null);

/// Hand-off slot for a single base colour (Swatches detail sheet "Add to
/// palette").
///
/// The shell sets it and switches to the Palette tab; the Palette page uses the
/// marker as its base colour and consumes it by setting the value back to
/// `null`, exactly like [paletteDraft].
final ValueNotifier<MarkerColor?> paletteBaseDraft =
    ValueNotifier<MarkerColor?>(null);
