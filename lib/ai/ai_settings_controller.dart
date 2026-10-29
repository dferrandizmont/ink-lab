import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/ai_settings.dart';
import '../data/ai_settings_repository.dart';
import '../data/secret_store.dart';
import '../data/secure_secret_store.dart'
    show SecretStoreException, SecretStoreFailure;
import 'ai_service.dart';
import 'api_key_provider.dart';
import 'on_device_ai_platform.dart';
import 'on_device_download.dart';
import 'open_router_client.dart';
import 'palette_advisor.dart';

/// Why the last key operation failed, so the UI can pick a message.
///
/// None of these carry the key (or any part of it): the widget resolves them
/// to user-facing strings.
enum AiKeyError {
  /// The input does not look like an OpenRouter key.
  invalid,

  /// The stored key exists but the platform keystore could not decrypt it.
  unreadable,

  /// Any other secure-storage failure.
  storage,
}

/// Non-visual state and logic of the AI settings section.
///
/// The widget only reads this controller and forwards taps; every rule
/// (validation, masking, secure-storage failures, catalog loading, connection
/// probing) lives here and is unit-tested without a widget tree.
///
/// The API key is never stored as a field: [saveKey] consumes the value and
/// hands it straight to [ApiKeyProvider]. Only the masked form is kept.
final class AiSettingsController extends ChangeNotifier {
  AiSettingsController({
    required AiSettingsRepository settings,
    required SecretStore secrets,
    required AiService service,
    Stream<AiSettings>? changes,
  }) {
    _settings = settings;
    _secrets = secrets;
    _service = service;
    _value = settings.value;
    _subscription = (changes ?? settings.changes).listen(_onSettings);
    _download.addListener(_notify);
  }

  late final AiSettingsRepository _settings;
  late final SecretStore _secrets;
  late final AiService _service;
  late final StreamSubscription<AiSettings> _subscription;

  late final ApiKeyProvider _keys = ApiKeyProvider(_secrets);

  late AiSettings _value;
  bool _disposed = false;

  bool _hasStoredKey = false;
  String? _maskedKey;
  AiKeyError? _keyError;
  bool _keyJustSaved = false;

  bool _testingConnection = false;
  AiConnectionResult? _connection;

  bool _loadingModels = false;
  bool _modelsLoaded = false;
  List<AiModelDescriptor> _models = const <AiModelDescriptor>[];
  int _catalogTotal = 0;
  AiModelFilter _filter = AiModelFilter.free;
  PaletteFailureReason? _modelsError;

  OnDeviceStatus _onDeviceStatus = OnDeviceStatus.unavailable;
  late final OnDeviceDownloadTracker _download = _service.onDeviceDownload;

  // Non-secret settings, mirrored for convenient reads.
  AiSettings get value => _value;
  bool get enabled => _value.enabled;
  AiProvider get provider => _value.provider;

  /// The model in use: the chosen one, or the recommended default.
  String get textModel => _value.effectiveTextModel;

  /// The fallbacks in use: the chosen ones, or the recommended default.
  List<String> get textFallbacks => _value.effectiveTextFallbacks;

  /// Whether no text model has been chosen, so the defaults apply.
  bool get usingRecommendedDefaults => _value.textModel.trim().isEmpty;
  double get temperature => _value.temperature;
  int get maxTokens => _value.maxTokens;
  bool get autoFallback => _value.autoFallback;

  /// Whether a key is stored; the entry field is replaced by [maskedKey].
  bool get hasStoredKey => _hasStoredKey;

  /// The masked key to show once saved, or `null` when none is stored.
  String? get maskedKey => _maskedKey;

  AiKeyError? get keyError => _keyError;

  /// True after a successful save, until the next key operation.
  bool get keyJustSaved => _keyJustSaved;

  bool get testingConnection => _testingConnection;
  AiConnectionResult? get lastConnection => _connection;

  bool get loadingModels => _loadingModels;
  bool get modelsLoaded => _modelsLoaded;

  /// The loaded catalog, filtered by [modelFilter].
  List<AiModelDescriptor> get availableModels => _filter == AiModelFilter.both
      ? _models
      : <AiModelDescriptor>[
          for (final AiModelDescriptor model in _models)
            if (_filter.matches(isFree: model.isFree)) model,
        ];

  /// The suitable models, free and paid.
  List<AiModelDescriptor> get allModels => _models;

  /// How many suitable models the catalog has ("showing N suitable models"
  /// uses [availableModels]`.length` for the active free/paid filter).
  int get suitableModelCount => _models.length;

  /// How many entries the provider catalog had before unsuitable models
  /// (image/audio, routers, tiny context) were dropped.
  int get catalogTotalCount => _catalogTotal;

  /// How many of the suitable models declare structured-output support.
  int get structuredModelCount =>
      _models.where((m) => m.declaresJsonSupport).length;

  AiModelFilter get modelFilter => _filter;
  PaletteFailureReason? get modelsError => _modelsError;

  /// State of the on-device model. The provider is offered in the UI only
  /// while this is not [OnDeviceStatus.unavailable].
  OnDeviceStatus get onDeviceStatus => _onDeviceStatus;

  /// Whether the on-device provider should be shown at all.
  bool get onDeviceSupported => _onDeviceStatus.supported;

  /// Bytes of the on-device model downloaded so far.
  int get onDeviceBytes => _download.bytes;

  /// Size of the on-device model, or 0 when the platform did not report it.
  int get onDeviceTotalBytes => _download.totalBytes;

  /// Whether the platform has reported any download progress yet.
  bool get onDeviceHasProgress => _download.hasProgress;

  /// Whether the download request has been silent for a while (Android often
  /// waits for Wi-Fi and charging), so the UI should explain the wait.
  bool get onDeviceStalled => _download.stalled;

  /// Whether this app has a download request running (as opposed to one it
  /// only knows about from the operating system status).
  bool get onDeviceDownloadRunning => _download.active;

  /// Whether the last on-device model download failed.
  bool get onDeviceDownloadFailed => _download.failed;

  /// Reads the stored key so the masked form can be shown, and asks the
  /// platform whether an on-device model exists.
  Future<void> initialize() async {
    await Future.wait(<Future<void>>[refreshKey(), refreshOnDevice()]);
    // A download requested before this screen was built is still running.
    if (!_disposed && _download.active) {
      _onDeviceStatus = OnDeviceStatus.downloading;
      _notify();
      unawaited(_download.done.then((_) => refreshOnDevice()));
    }
  }

  /// Re-reads the on-device model state. Never throws.
  Future<void> refreshOnDevice() async {
    OnDeviceStatus status;
    try {
      status = await _service.onDeviceStatus();
    } catch (_) {
      status = OnDeviceStatus.unavailable;
    }
    if (_disposed) return;
    _onDeviceStatus = status;
    _notify();
  }

  /// Starts the on-device model download. It is owned by the app, not by this
  /// controller: leaving the screen does not cancel it. Progress is read from
  /// the tracker; the state is re-read when it finishes either way.
  Future<void> downloadOnDevice() async {
    if (_download.active) return;
    _onDeviceStatus = OnDeviceStatus.downloading;
    _download.start();
    _notify();
    await _download.done;
    await refreshOnDevice();
  }

  Future<void> refreshKey() async {
    try {
      final String? key = await _keys();
      _applyKey(key);
      _keyError = null;
    } on SecretStoreException catch (error) {
      _applyKey(null);
      if (error.failure == SecretStoreFailure.unreadable) {
        _keyError = AiKeyError.unreadable;
      }
    } catch (_) {
      _applyKey(null);
    }
    _notify();
  }

  /// Validates and stores [input], returning whether it was saved.
  ///
  /// The value is never put in a field, a log or an error: a rejected input
  /// only yields [AiKeyError.invalid].
  Future<bool> saveKey(String input) async {
    final String trimmed = input.trim();
    _keyJustSaved = false;
    _keyError = null;
    if (!looksLikeOpenRouterKey(trimmed)) {
      _keyError = AiKeyError.invalid;
      _notify();
      return false;
    }
    try {
      await _keys.save(trimmed);
    } on ArgumentError {
      _keyError = AiKeyError.invalid;
      _notify();
      return false;
    } on SecretStoreException catch (error) {
      _keyError = error.failure == SecretStoreFailure.unreadable
          ? AiKeyError.unreadable
          : AiKeyError.storage;
      _notify();
      return false;
    } catch (_) {
      _keyError = AiKeyError.storage;
      _notify();
      return false;
    }
    await refreshKey();
    _keyError = null;
    _keyJustSaved = true;
    _notify();
    return true;
  }

  /// Deletes the stored key. The caller asks for confirmation first.
  Future<void> removeKey() async {
    _keyJustSaved = false;
    _keyError = null;
    try {
      await _keys.clear();
    } on SecretStoreException catch (error) {
      _keyError = error.failure == SecretStoreFailure.unreadable
          ? AiKeyError.unreadable
          : AiKeyError.storage;
    } catch (_) {
      _keyError = AiKeyError.storage;
    }
    await refreshKey();
  }

  /// Probes the provider with the stored key; returns the typed result.
  Future<AiConnectionResult> testConnection() async {
    _testingConnection = true;
    _connection = null;
    _notify();
    final AiConnectionResult result = await _service.testConnection();
    _connection = result;
    _testingConnection = false;
    _notify();
    return result;
  }

  /// Loads the whole catalog; [availableModels] applies [modelFilter] on top,
  /// so changing the filter never needs another request.
  Future<void> loadModels() async {
    _loadingModels = true;
    _modelsError = null;
    _notify();
    final AiModelsResult result = await _service.loadModels(AiModelFilter.both);
    switch (result) {
      case AiModelsSuccess(:final models, :final totalCount):
        _models = models;
        _catalogTotal = totalCount;
        _modelsError = null;
      case AiModelsFailure(:final reason):
        _models = const <AiModelDescriptor>[];
        _catalogTotal = 0;
        _modelsError = reason;
    }
    _loadingModels = false;
    _modelsLoaded = true;
    _notify();
  }

  void setModelFilter(AiModelFilter filter) {
    if (_filter == filter) return;
    _filter = filter;
    _notify();
  }

  Future<void> setEnabled(bool enabled) => _settings.setEnabled(enabled);

  Future<void> setProvider(AiProvider provider) =>
      _settings.setProvider(provider);

  Future<void> setTextModel(String model) => _settings.setTextModel(model);

  Future<void> setTemperature(double value) => _settings.setTemperature(value);

  Future<void> setMaxTokens(int value) => _settings.setMaxTokens(value);

  Future<void> setAutoFallback(bool value) => _settings.setAutoFallback(value);

  /// Selects [id] as the primary text model.
  Future<void> selectPrimaryModel(String id) => _settings.setTextModel(id);

  /// Adds or removes [id] from the ordered fallback list, capped like settings.
  Future<void> toggleFallback(String id) async {
    // Read the repository, not the mirror, which lags one event behind.
    final AiSettings stored = _settings.value;
    final List<String> current = <String>[...stored.effectiveTextFallbacks];
    if (stored.textModel.trim().isEmpty) {
      // Keep the model that is shown as selected once the user edits the list.
      await _settings.setTextModel(stored.effectiveTextModel);
    }
    if (current.contains(id)) {
      current.remove(id);
    } else {
      if (current.length >= AiSettings.maxFallbacks) return;
      current.add(id);
    }
    await _settings.setTextFallbacks(current);
  }

  void _applyKey(String? key) {
    _hasStoredKey = key != null;
    _maskedKey = key == null ? null : maskKey(key);
  }

  void _onSettings(AiSettings value) {
    _value = value;
    _notify();
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _subscription.cancel();
    // Only stop watching: the download itself must outlive this screen.
    _download.removeListener(_notify);
    super.dispose();
  }
}
