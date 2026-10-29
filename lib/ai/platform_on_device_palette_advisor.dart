import 'dart:async';

import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/models.dart' show AiProviderPaletteResponse;
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
    final candidates = paletteCandidateColors(
      colors: request.availableColors,
      brand: request.brand,
      activeSetIds: request.activeSetIds,
      ownedMarkerCodes: request.ownedMarkerCodes,
    );
    if (candidates.isEmpty) {
      return PaletteAdviceFailure(PaletteFailureReason.noAvailableColors);
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
