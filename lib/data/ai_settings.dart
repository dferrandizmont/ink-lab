import '../core/json_value.dart';

/// Which advisor a suggestion request is routed to.
enum AiProvider {
  local('local'),
  onDevice('onDevice'),
  openRouter('openRouter');

  const AiProvider(this.wireId);
  final String wireId;

  String toJson() => wireId;

  /// Parses a stored provider, tolerating the spellings older builds or hand
  /// edited backups may hold (`on_device`, `On-device`, `OpenRouter`,
  /// `colourTheory`...). Returns `null` when [json] names no provider.
  static AiProvider? tryParse(Object? json) {
    if (json is! String) return null;
    for (final value in values) {
      if (value.wireId == json) return value;
    }
    // Case, spaces, dashes and underscores do not matter.
    final key = json.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    return switch (key) {
      'local' || 'colourtheory' || 'colortheory' || 'builtin' => local,
      'ondevice' || 'device' || 'gemininano' || 'nano' => onDevice,
      'openrouter' || 'cloud' || 'remote' => openRouter,
      _ => null,
    };
  }

  /// Whether [json] is a provider spelling that is not the canonical wire id,
  /// so the stored settings should be rewritten with [toJson].
  static bool needsMigration(Object? json) {
    final parsed = tryParse(json);
    return parsed != null && parsed.wireId != json;
  }

  /// Unknown or missing providers fall back to [AiProvider.local], the default
  /// advisor, so an old or hand-written backup still imports.
  static AiProvider fromJson(Object? json) =>
      tryParse(json) ?? AiProvider.local;
}

/// Non-secret AI settings.
///
/// This is the *entire* persisted AI configuration in scope. The API key is
/// deliberately absent: it is never stored, read, logged or exported here, and
/// it lives only behind `SecretStore` (a secure implementation is added by the
/// lead). [fromJson] therefore ignores any secret-looking key it finds.
final class AiSettings with JsonValue {
  AiSettings({
    this.enabled = false,
    this.provider = AiProvider.local,
    this.textModel = '',
    this.visionModel = '',
    List<String> textFallbacks = const [],
    List<String> visionFallbacks = const [],
    this.temperature = 0.7,
    this.maxTokens = 1200,
    this.autoFallback = true,
    this.catalogFilter = '',
  }) : textFallbacks = List.unmodifiable(textFallbacks),
       visionFallbacks = List.unmodifiable(visionFallbacks);

  /// Master switch for cloud/on-device suggestions.
  final bool enabled;
  final AiProvider provider;

  /// Model ids used for text-only and image requests.
  final String textModel;
  final String visionModel;

  /// Ordered model ids tried when the selected model fails.
  final List<String> textFallbacks;
  final List<String> visionFallbacks;

  final double temperature;
  final int maxTokens;

  /// Whether to silently fall back to the local advisor.
  final bool autoFallback;

  /// Provider catalog filter (for example a free/paid or capability filter).
  final String catalogFilter;

  /// Reliable, inexpensive model used when no text model has been chosen.
  static const String recommendedTextModel = 'google/gemini-2.5-flash-lite';

  /// Fallbacks used together with [recommendedTextModel].
  static const List<String> recommendedTextFallbacks = ['openai/gpt-4o-mini'];

  /// The text model actually used: [textModel], or the recommended one when
  /// none is set.
  String get effectiveTextModel =>
      textModel.trim().isEmpty ? recommendedTextModel : textModel;

  /// The fallbacks actually used. When no text model is set and no fallback was
  /// chosen, the recommended fallbacks apply.
  List<String> get effectiveTextFallbacks =>
      textModel.trim().isEmpty && textFallbacks.isEmpty
      ? recommendedTextFallbacks
      : textFallbacks;

  static const int maxFallbacks = 5;
  static const int maxModelIdLength = 100;
  static const int maxMaxTokens = 4096;

  /// Keys that must never be imported, even if present in a backup file.
  static const Set<String> forbiddenKeys = {
    'apiKey',
    'api_key',
    'apikey',
    'key',
    'secret',
    'token',
    'password',
  };

  factory AiSettings.fromJson(Map<String, dynamic> json) => AiSettings(
    enabled: json['enabled'] == true,
    provider: AiProvider.fromJson(json['provider']),
    textModel: _modelId(json['textModel']) ?? '',
    visionModel: _modelId(json['visionModel']) ?? '',
    textFallbacks: _modelIds(json['textFallbacks']),
    visionFallbacks: _modelIds(json['visionFallbacks']),
    temperature: _clampTemperature(_double(json['temperature'])),
    maxTokens: (_int(json['maxTokens']) ?? 1200).clamp(1, maxMaxTokens),
    autoFallback: json.containsKey('autoFallback')
        ? json['autoFallback'] == true
        : true,
    catalogFilter: _string(json['catalogFilter']) ?? '',
  );

  AiSettings copyWith({
    bool? enabled,
    AiProvider? provider,
    String? textModel,
    String? visionModel,
    List<String>? textFallbacks,
    List<String>? visionFallbacks,
    double? temperature,
    int? maxTokens,
    bool? autoFallback,
    String? catalogFilter,
  }) => AiSettings(
    enabled: enabled ?? this.enabled,
    provider: provider ?? this.provider,
    textModel: textModel ?? this.textModel,
    visionModel: visionModel ?? this.visionModel,
    textFallbacks: textFallbacks ?? this.textFallbacks,
    visionFallbacks: visionFallbacks ?? this.visionFallbacks,
    temperature: temperature ?? this.temperature,
    maxTokens: maxTokens ?? this.maxTokens,
    autoFallback: autoFallback ?? this.autoFallback,
    catalogFilter: catalogFilter ?? this.catalogFilter,
  );

  /// Wire shape, matching the Kotlin field names. Contains no secret key, by
  /// construction.
  @override
  Map<String, dynamic> toJson() => {
    'enabled': enabled,
    'provider': provider.toJson(),
    'textModel': textModel,
    'visionModel': visionModel,
    'textFallbacks': textFallbacks,
    'visionFallbacks': visionFallbacks,
    'temperature': temperature,
    'maxTokens': maxTokens,
    'autoFallback': autoFallback,
    'catalogFilter': catalogFilter,
  };
}

String? _string(Object? value) => value is String ? value : null;

double? _double(Object? value) => value is num ? value.toDouble() : null;

int? _int(Object? value) => value is int ? value : null;

final RegExp _modelIdPattern = RegExp(r'^[!-~]+$');

/// A model id is printable ASCII without whitespace, at most 100 chars;
/// anything else is dropped.
String? _modelId(Object? value) {
  if (value is! String) return null;
  final id = value.trim();
  if (id.isEmpty ||
      id.length > AiSettings.maxModelIdLength ||
      !_modelIdPattern.hasMatch(id)) {
    return null;
  }
  return id;
}

List<String> _modelIds(Object? value) {
  if (value is! List) return const [];
  final result = <String>[];
  for (final item in value) {
    final id = _modelId(item);
    if (id == null || result.contains(id)) continue;
    result.add(id);
    if (result.length >= AiSettings.maxFallbacks) break;
  }
  return result;
}

double _clampTemperature(double? value) {
  if (value == null || value.isNaN) return 0.7;
  return value.clamp(0.0, 1.0);
}
