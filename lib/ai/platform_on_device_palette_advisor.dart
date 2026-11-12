import 'dart:async';

import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/models.dart'
    show AiProviderPaletteResponse, MarkerColor;
import 'package:ink_lab/core/palette_advisor.dart' show PaletteAdvisorRequest;

import 'on_device_ai_platform.dart';
import 'open_router_client.dart' show OpenRouterFormatException;
import 'on_device_prompt.dart';
import 'open_router_palette_advisor.dart';
import 'palette_advisor.dart';

/// Palette advisor backed by the operating system's on-device model.
///
/// Nothing here touches the network or an API key: the prompt goes through the
/// platform channel to the local model (Gemini Nano on Android). The prompt
/// builder, the tolerant response parser and the validation are the OpenRouter
/// advisor's own, so only codes of the active collection can come out, with
/// normalised roles and sanitised text. On any failure the caller (see
/// `FallbackPaletteAdvisor`) answers with the local engine.
///
/// Prompts and responses are never logged.
final class PlatformOnDevicePaletteAdvisor implements OnDevicePaletteAdvisor {
  PlatformOnDevicePaletteAdvisor({
    required this.platform,
    this.maxCandidates = onDeviceMaxCandidates,
    this.timeout = defaultOnDeviceTimeout,
  });

  final OnDeviceAiPlatform platform;

  /// Upper bound on the candidate colours in the prompt: the on-device context
  /// window is small (about 4000 tokens).
  final int maxCandidates;

  /// How long to wait for the model.
  final Duration timeout;

  @override
  Future<bool> isAvailable() async =>
      (await platform.status()) == OnDeviceStatus.available;

  @override
  Future<PaletteAdvice> advise(PaletteAdvisorRequest request) async {
    // The collection of the request, narrowed to the markers the user owns:
    // there is no fallback to the whole range, so an empty collection simply
    // has nothing to offer.
    final candidates = paletteCandidateColors(
      colors: request.availableColors,
      brand: request.brand,
      scope: request.scope,
      driedColorIds: request.driedColorIds,
      activeSetIds: request.activeSetIds,
      ownedMarkerCodes: request.ownedMarkerCodes,
    );
    if (candidates.isEmpty) {
      return PaletteAdviceFailure(PaletteFailureReason.noAvailableColors);
    }

    // The base must be one of the user's own markers, like in the local
    // engine: a base out of the collection is refused, never sent to the
    // model and never painted as the user's.
    final MarkerColor? base = request.baseColor;
    if (base != null &&
        !candidates.any((MarkerColor c) => c.colorId == base.colorId)) {
      // A marker the user owns but that ran dry has its own reason: it is not
      // out of the collection, it just does not paint.
      return PaletteAdviceFailure(
        request.driedColorIds.contains(base.colorId)
            ? PaletteFailureReason.baseDried
            : PaletteFailureReason.invalidBaseColor,
      );
    }

    if (!await isAvailable()) {
      return PaletteAdviceFailure(PaletteFailureReason.onDeviceUnavailable);
    }

    final prepared = preparePaletteWire(
      request,
      candidates,
      maxCandidates,
      capper: capOnDeviceCandidates,
    );
    final prompt = buildOnDevicePrompt(prepared.wire);

    final String text;
    try {
      text = await platform.generate(prompt, timeout: timeout);
    } on OnDeviceAiException catch (error) {
      return PaletteAdviceFailure(switch (error.failure) {
        OnDeviceGenerateFailure.timeout => PaletteFailureReason.timeout,
        OnDeviceGenerateFailure.unavailable =>
          PaletteFailureReason.onDeviceUnavailable,
        _ => PaletteFailureReason.unknown,
      });
    } catch (_) {
      return PaletteAdviceFailure(PaletteFailureReason.unknown);
    }

    final AiProviderPaletteResponse parsed;
    try {
      parsed = parsePaletteContent(text);
    } on OpenRouterFormatException {
      return PaletteAdviceFailure(PaletteFailureReason.invalidJson);
    }
    final suggestions = validatePaletteItems(
      parsed.items,
      prepared.byCode,
      prepared.baseCode,
      request.paletteSize,
      baseColor: request.baseColor,
    );
    if (!hasEnoughPaletteSuggestions(suggestions)) {
      return PaletteAdviceFailure(PaletteFailureReason.noValidSuggestions);
    }
    return PaletteAdviceSuccess(
      suggestions,
      tips: sanitizeTips(parsed.tips),
      modelUsed: onDeviceModelId,
    );
  }
}
