import 'dart:async';
import 'dart:convert';

import 'ai_settings.dart';
import 'data_exceptions.dart';
import 'key_value_store.dart';
import 'replay_stream.dart';

/// Loads and stores the non-secret [AiSettings].
///
/// There is intentionally no API-key accessor here: the key is out of scope
/// for this layer and belongs to `SecretStore`.
abstract class AiSettingsRepository {
  AiSettings get value;

  /// Emits the current settings immediately, then every change.
  Stream<AiSettings> get changes;

  Future<void> load();

  /// Replaces the whole configuration, as a backup restore or the settings UI
  /// does.
  Future<void> replace(AiSettings settings);

  Future<void> setEnabled(bool enabled);
  Future<void> setProvider(AiProvider provider);
  Future<void> setTextModel(String model);
  Future<void> setVisionModel(String model);
  Future<void> setTextFallbacks(List<String> models);
  Future<void> setVisionFallbacks(List<String> models);
  Future<void> setTemperature(double temperature);
  Future<void> setMaxTokens(int maxTokens);
  Future<void> setAutoFallback(bool autoFallback);
  Future<void> setCatalogFilter(String filter);
}

/// [AiSettingsRepository] on top of a [KeyValueStore], stored as a JSON object
/// under the single key `ai_settings`.
final class StoredAiSettingsRepository implements AiSettingsRepository {
  StoredAiSettingsRepository(this._store);

  static const String key = 'ai_settings';

  final KeyValueStore _store;
  final StreamController<AiSettings> _controller =
      StreamController<AiSettings>.broadcast();

  AiSettings _value = AiSettings();

  @override
  AiSettings get value => _value;

  @override
  Stream<AiSettings> get changes =>
      replayStream<AiSettings>(() => _value, _controller.stream);

  @override
  Future<void> load() async {
    final raw = await _store.getString(key);
    _value = _decode(raw);
    // An older build (or a hand-written backup) may have stored the provider
    // under another spelling: decode it, then rewrite it in the canonical form
    // so the selection survives updates instead of silently resetting.
    if (_providerNeedsMigration(raw)) {
      await _store.setString(key, jsonEncode(_value.toJson()));
    }
  }

  @override
  Future<void> replace(AiSettings settings) => _persist(settings);

  @override
  Future<void> setEnabled(bool enabled) =>
      _persist(_value.copyWith(enabled: enabled));

  @override
  Future<void> setProvider(AiProvider provider) =>
      _persist(_value.copyWith(provider: provider));

  @override
  Future<void> setTextModel(String model) =>
      _persist(_value.copyWith(textModel: model));

  @override
  Future<void> setVisionModel(String model) =>
      _persist(_value.copyWith(visionModel: model));

  @override
  Future<void> setTextFallbacks(List<String> models) =>
      _persist(_value.copyWith(textFallbacks: models));

  @override
  Future<void> setVisionFallbacks(List<String> models) =>
      _persist(_value.copyWith(visionFallbacks: models));

  @override
  Future<void> setTemperature(double temperature) =>
      _persist(_value.copyWith(temperature: temperature));

  @override
  Future<void> setMaxTokens(int maxTokens) =>
      _persist(_value.copyWith(maxTokens: maxTokens));

  @override
  Future<void> setAutoFallback(bool autoFallback) =>
      _persist(_value.copyWith(autoFallback: autoFallback));

  @override
  Future<void> setCatalogFilter(String filter) =>
      _persist(_value.copyWith(catalogFilter: filter));

  Future<void> _persist(AiSettings settings) async {
    _value = settings;
    await _store.setString(key, jsonEncode(settings.toJson()));
    _controller.add(_value);
  }

  bool _providerNeedsMigration(String? raw) {
    if (raw == null || raw.trim().isEmpty) return false;
    try {
      final decoded = jsonDecode(raw);
      return decoded is Map && AiProvider.needsMigration(decoded['provider']);
    } catch (_) {
      return false;
    }
  }

  AiSettings _decode(String? raw) {
    if (raw == null || raw.trim().isEmpty) return AiSettings();
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) {
        throw const DataStoreException(
          'expected a JSON object of AI settings',
          key: key,
        );
      }
      return AiSettings.fromJson(decoded.cast<String, dynamic>());
    } on DataStoreException {
      rethrow;
    } catch (error) {
      throw DataStoreException('could not parse AI settings: $error', key: key);
    }
  }
}
