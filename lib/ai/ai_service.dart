import 'package:http/http.dart' as http;

import '../core/palette_advisor.dart' as core;
import '../core/palette_generator.dart' show PaletteGenerator;
import '../data/ai_settings.dart';
import '../data/ai_settings_repository.dart';
import '../data/secret_store.dart';
import '../data/secure_secret_store.dart' show SecretStoreException;
import 'api_key_provider.dart';
import 'fallback_palette_advisor.dart';
import 'on_device_ai_platform.dart';
import 'on_device_download.dart';
import 'open_router_client.dart';
import 'open_router_palette_advisor.dart';
import 'palette_advisor.dart';
import 'platform_on_device_palette_advisor.dart';

/// Builds the [http.Client] the optional OpenRouter transport uses.
///
/// Injectable so tests can hand in a fake transport (for example
/// `package:http/testing.dart`) and the app never opens a real socket unless
/// the user turns the AI on.
typedef AiHttpClientFactory = http.Client Function();

http.Client _defaultClientFactory() => http.Client();

/// Wraps the pure, synchronous local engine as an async [PaletteAdvisor].
///
/// The local engine never fails asynchronously, so this always completes and is
/// the answer whenever the cloud provider is off, unconfigured or unusable.
final class LocalPaletteAdvisor implements PaletteAdvisor {
  const LocalPaletteAdvisor(this._local);

  final core.PaletteAdvisor _local;

  @override
  Future<PaletteAdvice> advise(core.PaletteAdvisorRequest request) async {
    final core.PaletteAdvice advice = _local.advise(request);
    return switch (advice) {
      core.PaletteAdviceSuccess(:final suggestions) => PaletteAdviceSuccess(
        suggestions,
      ),
      core.PaletteAdviceFailure(:final reason) => PaletteAdviceFailure(
        _mapCoreReason(reason),
      ),
    };
  }
}

/// The outcome of a "test connection" probe.
sealed class AiConnectionResult {
  const AiConnectionResult();
}

/// The provider answered the catalog request.
final class AiConnectionOk extends AiConnectionResult {
  const AiConnectionOk({required this.modelCount});

  /// How many models the provider reported, for a short, key-free status.
  final int modelCount;
}

/// The probe failed; [message] is always key-free and displayable.
final class AiConnectionFailure extends AiConnectionResult {
  AiConnectionFailure(this.reason, {String? message})
    : message = message ?? reason.userMessage;

  final PaletteFailureReason reason;
  final String message;
}

/// The outcome of asking the provider for its model catalog.
sealed class AiModelsResult {
  const AiModelsResult();
}

/// The catalog, already filtered by the caller's [AiModelFilter].
final class AiModelsSuccess extends AiModelsResult {
  AiModelsSuccess(List<AiModelDescriptor> models, {this.totalCount = 0})
    : models = List.unmodifiable(models);

  /// Suitable models (text in/out, no routers, enough context), sorted with
  /// the recommended and structured-output capable ones first.
  final List<AiModelDescriptor> models;

  /// Entries the catalog had before filtering out unsuitable models.
  final int totalCount;
}

/// The catalog could not be loaded; [message] is key-free and displayable.
final class AiModelsFailure extends AiModelsResult {
  AiModelsFailure(this.reason, {String? message})
    : message = message ?? reason.userMessage;

  final PaletteFailureReason reason;
  final String message;
}

/// Wires the optional AI advisor together from the persisted settings and the
/// stored key.
///
/// It owns no per-request state and holds no key: the key is read from
/// [SecretStore] on demand and only ever travels in the `Authorization` header
/// of an HTTPS request. The API key never appears in a returned result, a
/// message or this class's state.
final class AiService {
  AiService({
    required AiSettingsRepository aiSettings,
    required SecretStore secrets,
    core.PaletteAdvisor? localAdvisor,
    AiHttpClientFactory? clientFactory,
    OnDeviceAiPlatform? onDevice,
    Duration onDeviceNoProgressAfter = defaultNoProgressAfter,
  }) {
    _aiSettings = aiSettings;
    _secrets = secrets;
    _local = localAdvisor ?? const PaletteGenerator();
    _clientFactory = clientFactory ?? _defaultClientFactory;
    _onDevice = onDevice ?? defaultOnDeviceAiPlatform();
    onDeviceDownload = OnDeviceDownloadTracker(
      _onDevice,
      noProgressAfter: onDeviceNoProgressAfter,
    );
  }

  late final AiSettingsRepository _aiSettings;
  late final SecretStore _secrets;
  late final core.PaletteAdvisor _local;
  late final AiHttpClientFactory _clientFactory;
  late final OnDeviceAiPlatform _onDevice;

  /// The state of the on-device model on this phone. Never throws, and never
  /// touches the network: the platform answers locally.
  Future<OnDeviceStatus> onDeviceStatus() => _onDevice.status();

  /// The on-device model download, owned by the app rather than by a screen,
  /// so it keeps running when the settings are left.
  late final OnDeviceDownloadTracker onDeviceDownload;

  /// Starts the on-device model download and streams its progress.
  Stream<OnDeviceDownloadEvent> downloadOnDeviceModel() => _onDevice.download();

  /// Whether the cloud advisor is configured (enabled, OpenRouter, key stored).
  ///
  /// A missing or unreadable key is reported as `false` rather than thrown: the
  /// palette page uses this to decide whether to offer the AI button at all.
  ///
  /// With the on-device provider it is `true` once the model is downloaded; no
  /// key is read and nothing touches the network.
  Future<bool> isAiAvailable() async {
    final AiSettings settings = _aiSettings.value;
    if (!settings.enabled) return false;
    return switch (settings.provider) {
      AiProvider.openRouter => (await _readKey()) != null,
      AiProvider.onDevice =>
        (await _onDevice.status()) == OnDeviceStatus.available,
      AiProvider.local => false,
    };
  }

  /// The advisor to use for the current settings.
  ///
  /// Returns a [FallbackPaletteAdvisor] over the cloud model when the AI is
  /// enabled, the provider is OpenRouter and a key is stored; otherwise the
  /// local engine. The result never blocks the caller: the fallback advisor
  /// answers from the local engine when the cloud path fails.
  Future<PaletteAdvisor> buildAdvisor() async {
    final AiSettings settings = _aiSettings.value;
    if (settings.enabled && settings.provider == AiProvider.onDevice) {
      // On-device: no key, no HTTP client. Not ready means the local engine.
      final PlatformOnDevicePaletteAdvisor onDevice =
          PlatformOnDevicePaletteAdvisor(platform: _onDevice);
      if (!await onDevice.isAvailable()) return LocalPaletteAdvisor(_local);
      return FallbackPaletteAdvisor(primary: onDevice, local: _local);
    }
    if (!settings.enabled || settings.provider != AiProvider.openRouter) {
      return LocalPaletteAdvisor(_local);
    }
    if ((await _readKey()) == null) return LocalPaletteAdvisor(_local);

    return FallbackPaletteAdvisor(
      primary: OpenRouterPaletteAdvisor(
        client: OpenRouterClient(client: _clientFactory()),
        settings: () => _aiSettings.value,
        apiKey: ApiKeyProvider(_secrets).call,
      ),
      local: _local,
    );
  }

  /// Probes the provider with the stored key by listing its catalog.
  ///
  /// The returned result carries no key: failures are mapped to a typed
  /// [PaletteFailureReason] and a key-free message.
  Future<AiConnectionResult> testConnection() async {
    final String? key = await _readKey();
    if (key == null) {
      return AiConnectionFailure(PaletteFailureReason.missingKey);
    }
    try {
      final models = await _client().fetchModels(
        apiKey: key,
        filter: AiModelFilter.both,
      );
      return AiConnectionOk(modelCount: models.length);
    } catch (error) {
      return AiConnectionFailure(_mapError(error));
    }
  }

  /// Loads the provider catalog, filtered by [filter], for the model picker.
  ///
  /// Runs with the stored key; when none is stored it reports
  /// [PaletteFailureReason.missingKey] without touching the network.
  Future<AiModelsResult> loadModels([
    AiModelFilter filter = AiModelFilter.free,
  ]) async {
    final String? key = await _readKey();
    if (key == null) return AiModelsFailure(PaletteFailureReason.missingKey);
    try {
      final catalog = await _client().fetchModelCatalog(
        apiKey: key,
        filter: filter,
      );
      return AiModelsSuccess(catalog.models, totalCount: catalog.totalCount);
    } catch (error) {
      return AiModelsFailure(_mapError(error));
    }
  }

  OpenRouterClient _client() => OpenRouterClient(client: _clientFactory());

  /// Reads the stored key, treating an unreadable store as "no key" so a broken
  /// keystore can never crash the settings or palette pages.
  Future<String?> _readKey() async {
    try {
      return await ApiKeyProvider(_secrets)();
    } on SecretStoreException {
      return null;
    }
  }
}

PaletteFailureReason _mapError(Object error) {
  if (error is OpenRouterHttpException) {
    return switch (error.statusCode) {
      401 => PaletteFailureReason.unauthorized,
      402 => PaletteFailureReason.paymentRequired,
      429 => PaletteFailureReason.rateLimited,
      >= 500 && < 600 => PaletteFailureReason.serverError,
      _ => PaletteFailureReason.httpError,
    };
  }
  if (error is OpenRouterNetworkException) {
    return PaletteFailureReason.networkError;
  }
  if (error is OpenRouterFormatException) {
    return PaletteFailureReason.invalidJson;
  }
  return PaletteFailureReason.unknown;
}

PaletteFailureReason _mapCoreReason(core.PaletteFailureReason reason) =>
    switch (reason) {
      core.PaletteFailureReason.noAvailableColors =>
        PaletteFailureReason.noAvailableColors,
      core.PaletteFailureReason.noSuggestions =>
        PaletteFailureReason.noSuggestions,
      core.PaletteFailureReason.missingBaseColor ||
      core.PaletteFailureReason.invalidBaseColor =>
        PaletteFailureReason.noSuggestions,
    };
