import 'package:ink_lab/core/palette_advisor.dart'
    show PaletteAdvisorRequest, PaletteSuggestion;

/// Failure reasons produced by the AI advisor layer.
///
/// These are deliberately separate from the pure-domain
/// `PaletteFailureReason` in `core/`: they describe transport, provider and
/// response problems that only exist above the network boundary. Every value
/// has a plain-language [userMessage] that can be shown without leaking any
/// request detail.
enum PaletteFailureReason {
  /// Cloud/on-device advisors are turned off in settings.
  disabled,

  /// No API key is configured for the selected provider.
  missingKey,

  /// No model is selected (or every configured model id was blank).
  noModelSelected,

  /// The provider rejected the credentials (HTTP 401).
  unauthorized,

  /// The account has no credit or the key is out of quota (HTTP 402).
  paymentRequired,

  /// The provider throttled the request (HTTP 429).
  rateLimited,

  /// The provider returned a server error (HTTP 5xx).
  serverError,

  /// Any other non-2xx HTTP status.
  httpError,

  /// The request could not reach the provider.
  networkError,

  /// The provider returned something that was not parseable JSON.
  invalidJson,

  /// The provider responded, but with no usable palette.
  invalidResponse,

  /// The provider returned only codes that are not in the active collection.
  noValidSuggestions,

  /// The active collection has no usable colours.
  noAvailableColors,

  /// Nothing to suggest (domain-level failure of the local engine).
  noSuggestions,

  /// The on-device model did not answer in time.
  timeout,

  /// The on-device model is missing, still downloading or unsupported.
  onDeviceUnavailable,

  /// Anything not classified above.
  unknown;

  /// Human-readable, key-free explanation of this failure.
  String get userMessage => switch (this) {
    PaletteFailureReason.disabled => 'AI suggestions are turned off.',
    PaletteFailureReason.missingKey => 'No API key configured.',
    PaletteFailureReason.noModelSelected => 'No AI model selected.',
    PaletteFailureReason.unauthorized => 'The API key was rejected.',
    PaletteFailureReason.paymentRequired =>
      'The account has no credit or the key is out of quota.',
    PaletteFailureReason.rateLimited =>
      'The provider is rate limiting requests. Try again shortly.',
    PaletteFailureReason.serverError =>
      'The provider had a server error. Try again later.',
    PaletteFailureReason.httpError => 'The provider rejected the request.',
    PaletteFailureReason.networkError =>
      'The provider could not be reached. Check the connection.',
    PaletteFailureReason.invalidJson =>
      'The provider returned an unreadable response.',
    PaletteFailureReason.invalidResponse =>
      'The provider returned no usable palette.',
    PaletteFailureReason.noValidSuggestions =>
      'The provider suggested colours that are not in the active collection.',
    PaletteFailureReason.noAvailableColors =>
      'There are no available markers to choose from.',
    PaletteFailureReason.noSuggestions => 'No suggestions could be generated.',
    PaletteFailureReason.timeout =>
      'The on-device model took too long. Try again.',
    PaletteFailureReason.onDeviceUnavailable =>
      'The on-device model is not ready on this phone.',
    PaletteFailureReason.unknown => 'AI suggestions are unavailable.',
  };
}

/// The result of asking an advisor for a palette.
sealed class PaletteAdvice {
  const PaletteAdvice();
}

/// A usable set of suggestions.
final class PaletteAdviceSuccess extends PaletteAdvice {
  PaletteAdviceSuccess(
    List<PaletteSuggestion> suggestions, {
    List<String> tips = const [],
    this.modelUsed = '',
    this.usedFallback = false,
    int? aiCount,
  }) : suggestions = List.unmodifiable(suggestions),
       tips = List.unmodifiable(tips),
       aiCount = aiCount ?? suggestions.length;

  final List<PaletteSuggestion> suggestions;
  final List<String> tips;

  /// Id of the model that produced these suggestions, when known.
  final String modelUsed;

  /// Whether a fallback model (or the local engine) produced the result.
  final bool usedFallback;

  /// How many of [suggestions] came from the AI model. The rest, when fewer,
  /// were completed by the local colour-theory engine.
  final int aiCount;

  /// Whether the local engine completed an AI answer that was too short.
  bool get isPartial => aiCount < suggestions.length;
}

/// No suggestions, with a typed reason and a displayable message.
final class PaletteAdviceFailure extends PaletteAdvice {
  PaletteAdviceFailure(this.reason, {String? message})
    : message = message ?? reason.userMessage;

  final PaletteFailureReason reason;
  final String message;
}

/// Async counterpart of the pure-domain `core` advisor.
///
/// It reuses the same [PaletteAdvisorRequest] and [PaletteSuggestion] types so
/// an AI result is interchangeable with the local engine's, but the call is
/// asynchronous because a remote/on-device advisor may need I/O.
abstract interface class PaletteAdvisor {
  Future<PaletteAdvice> advise(PaletteAdvisorRequest request);
}

/// Advisor backed by a model exposed by the operating system.
///
/// The Android implementation is `PlatformOnDevicePaletteAdvisor`; iOS reports
/// "unavailable" until its implementation lands. [isAvailable] never prompts
/// the user or downloads anything.
abstract class OnDevicePaletteAdvisor implements PaletteAdvisor {
  Future<bool> isAvailable();
}
