import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:http/http.dart' as http;

import '../data/ai_settings.dart' show AiSettings;

final RegExp _controlOrBidi = RegExp(
  r'[\p{C}\u061C\u200E\u200F\u202A-\u202E\u2066-\u2069]',
  unicode: true,
);

/// Makes untrusted text safe to display: collapses whitespace, strips Unicode
/// control, format and bidi override/isolate characters, and caps the length
/// at [maxLength] characters.
String sanitizeDisplayText(String raw, int maxLength) {
  var text = raw.replaceAll(RegExp(r'\s+', unicode: true), ' ');
  text = text.replaceAll(_controlOrBidi, '').replaceAll(RegExp(r' {2,}'), ' ');
  text = text.trim();
  if (text.length > maxLength) {
    var end = maxLength;
    final last = text.codeUnitAt(end - 1);
    if (last >= 0xD800 && last <= 0xDBFF) end -= 1; // do not split a pair
    text = text.substring(0, end).trimRight();
  }
  return text;
}

/// Which slice of the OpenRouter catalog to return.
enum AiModelFilter {
  free,
  paid,
  both;

  /// Parses the free-text `AiSettings.catalogFilter` value.
  static AiModelFilter fromName(String? raw) {
    final value = raw?.trim().toLowerCase();
    if (value == 'paid') return AiModelFilter.paid;
    if (value == 'both') return AiModelFilter.both;
    return AiModelFilter.free;
  }

  bool matches({required bool isFree}) => switch (this) {
    AiModelFilter.free => isFree,
    AiModelFilter.paid => !isFree,
    AiModelFilter.both => true,
  };
}

/// A single OpenRouter model entry, reduced to what the app needs.
final class AiModelDescriptor {
  const AiModelDescriptor({
    required this.id,
    required this.name,
    required this.isFree,
    required this.supportsTextInput,
    required this.supportsImageInput,
    required this.supportsTextOutput,
    this.supportsResponseFormat = true,
    this.supportsStructuredOutputs = false,
    this.promptPricePerToken,
    this.completionPricePerToken,
    this.contextLength,
    this.outputsTextOnly = true,
    this.isRouter = false,
    this.isRecommended = false,
    this.declaresJsonSupport = false,
  });

  final String id;
  final String name;
  final bool isFree;
  final bool supportsTextInput;
  final bool supportsImageInput;
  final bool supportsTextOutput;
  final bool supportsResponseFormat;
  final bool supportsStructuredOutputs;
  final double? promptPricePerToken;
  final double? completionPricePerToken;

  /// Context window in tokens, or `null` when the catalog did not say.
  final int? contextLength;

  /// Whether the only output modality is text (no image or audio output).
  final bool outputsTextOnly;

  /// Whether this entry is a router or meta-model that picks another model.
  final bool isRouter;

  /// Whether this is one of the app's recommended default models.
  final bool isRecommended;

  /// Whether `supported_parameters` explicitly lists `response_format` or
  /// `structured_outputs` (unlike [supportsResponseFormat], an absent list is
  /// not assumed to support it).
  final bool declaresJsonSupport;

  /// Smallest context window (tokens) a model needs to be offered.
  static const int minContextLength = 8000;

  /// Whether the model can do this feature: text in, text only out, not a
  /// router, and a context window of at least [minContextLength] (an unknown
  /// window is given the benefit of the doubt).
  bool get isSuitable =>
      supportsTextInput &&
      outputsTextOnly &&
      !isRouter &&
      (contextLength == null || contextLength! >= minContextLength);

  /// Longest catalog id and display name kept after sanitising.
  static const int maxModelIdLength = 120;
  static const int maxNameLength = 80;

  static final RegExp _modelIdPattern = RegExp(r'^[\w.:/-]+$');

  /// Convenience alias for the vision capability flag.
  bool get supportsVision => supportsImageInput;

  /// Returns `null` for entries without a usable id.
  static AiModelDescriptor? fromOpenRouter(Map<dynamic, dynamic> json) {
    final rawId = (_string(json['id']) ?? '').trim();
    final id = sanitizeDisplayText(rawId, maxModelIdLength);
    // The id ends up in requests and settings: drop anything that is not a
    // plain model slug (or that sanitising had to alter or cut) rather than
    // trying to repair it.
    if (id.isEmpty || id != rawId || !_modelIdPattern.hasMatch(id)) return null;
    final name = sanitizeDisplayText(
      _string(json['name']) ?? '',
      maxNameLength,
    );
    final architecture = json['architecture'];
    final modalities = architecture is Map
        ? architecture
        : const <dynamic, dynamic>{};
    final modality = (_string(modalities['modality']) ?? '').toLowerCase();
    final inputModalities = _stringList(modalities['input_modalities']);
    final outputModalities = _stringList(modalities['output_modalities']);

    final supportsTextInput = inputModalities.isNotEmpty
        ? inputModalities.contains('text')
        : modality.isEmpty || modality.split('->').first.contains('text');
    final supportsImageInput =
        inputModalities.contains('image') || modality.contains('image');
    final supportsTextOutput =
        outputModalities.isEmpty ||
        outputModalities.contains('text') ||
        modality.endsWith('text');

    final pricing = json['pricing'];
    final pricingMap = pricing is Map ? pricing : const <dynamic, dynamic>{};
    final promptPrice = _double(pricingMap['prompt']);
    final completionPrice = _double(pricingMap['completion']);
    // Free means both prices are exactly zero. Routers publish a negative
    // price (-1) for "variable pricing", which must not read as free.
    final freeFromPricing =
        pricing is Map && promptPrice == 0 && completionPrice == 0;

    final supportedParameters = _stringList(json['supported_parameters']);
    final hasJsonParameter =
        supportedParameters.contains('response_format') ||
        supportedParameters.contains('structured_outputs');
    final supportsStructuredOutputs = supportedParameters.contains(
      'structured_outputs',
    );
    final supportsResponseFormat = supportedParameters.isEmpty
        ? true
        : hasJsonParameter;
    final outputsTextOnly = outputModalities.isNotEmpty
        ? outputModalities.every((m) => m == 'text')
        : (modality.contains('->')
              ? modality.split('->').last.trim() == 'text'
              : true);
    final nameLower = name.toLowerCase();
    final isRouter =
        id == 'openrouter/auto' ||
        id.endsWith('/auto') ||
        id.toLowerCase().contains('router') ||
        nameLower.contains('router') ||
        // Variable pricing (-1) is how the catalog marks a router.
        (promptPrice != null && promptPrice < 0) ||
        (completionPrice != null && completionPrice < 0);
    final contextRaw = json['context_length'];
    final contextLength = contextRaw is num
        ? contextRaw.toInt()
        : (contextRaw is String ? int.tryParse(contextRaw) : null);

    return AiModelDescriptor(
      id: id,
      name: name.isEmpty ? id : name,
      // Pricing alone decides: a `:free` suffix is only a naming convention.
      isFree: freeFromPricing,
      supportsTextInput: supportsTextInput,
      supportsImageInput: supportsImageInput,
      supportsTextOutput: supportsTextOutput,
      supportsResponseFormat: supportsResponseFormat,
      supportsStructuredOutputs: supportsStructuredOutputs,
      promptPricePerToken: promptPrice,
      completionPricePerToken: completionPrice,
      contextLength: contextLength,
      outputsTextOnly: outputsTextOnly,
      isRouter: isRouter,
      declaresJsonSupport: hasJsonParameter,
      isRecommended:
          id == AiSettings.recommendedTextModel ||
          AiSettings.recommendedTextFallbacks.contains(id),
    );
  }

  /// Picker order: recommended first, then models with explicit JSON support
  /// (`structured_outputs` / `response_format`), then by name.
  static int compareForPicker(AiModelDescriptor a, AiModelDescriptor b) {
    if (a.isRecommended != b.isRecommended) return a.isRecommended ? -1 : 1;
    if (a.declaresJsonSupport != b.declaresJsonSupport) {
      return a.declaresJsonSupport ? -1 : 1;
    }
    final byName = a.name.toLowerCase().compareTo(b.name.toLowerCase());
    return byName != 0 ? byName : a.id.compareTo(b.id);
  }
}

/// The OpenRouter catalog reduced to what suits this feature.
final class AiModelCatalog {
  AiModelCatalog({required List<AiModelDescriptor> models, this.totalCount = 0})
    : models = List.unmodifiable(models);

  /// Suitable models, already sorted for the picker.
  final List<AiModelDescriptor> models;

  /// How many entries the catalog had before filtering.
  final int totalCount;

  /// Suitable models that explicitly support structured JSON output.
  int get structuredCount => models.where((m) => m.declaresJsonSupport).length;
}

/// Base error for the OpenRouter transport.
///
/// Instances never carry the API key: callers get a redacted, displayable
/// [message].
class OpenRouterException implements Exception {
  const OpenRouterException(this.message);

  final String message;

  @override
  String toString() => 'OpenRouterException: $message';
}

/// A non-2xx response. [message] is already redacted.
final class OpenRouterHttpException extends OpenRouterException {
  const OpenRouterHttpException(this.statusCode, super.message);

  final int statusCode;

  @override
  String toString() => 'OpenRouterHttpException($statusCode): $message';
}

/// The request never reached, or never finished at, the provider.
final class OpenRouterNetworkException extends OpenRouterException {
  const OpenRouterNetworkException(super.message);
}

/// The provider responded with something that is not the expected JSON shape.
final class OpenRouterFormatException extends OpenRouterException {
  const OpenRouterFormatException(super.message);
}

/// Removes anything secret-looking from a string so it is safe to surface or
/// throw. Redacts the exact supplied secret, `Bearer <token>` pairs and
/// `sk-...` style keys.
String redactSecret(String text, String? secret) {
  var result = text;
  final trimmed = secret?.trim() ?? '';
  if (trimmed.isNotEmpty) {
    result = result.replaceAll(trimmed, '[redacted]');
  }
  result = result.replaceAll(
    RegExp(r'[Bb]earer\s+[A-Za-z0-9._\-]+'),
    'Bearer [redacted]',
  );
  result = result.replaceAll(RegExp(r'sk-[A-Za-z0-9._\-]{6,}'), '[redacted]');
  return result;
}

/// Thin, stateless transport over the OpenRouter REST API.
///
/// The client is constructed once and reused. It holds no credentials: the key
/// is passed per call and is only ever placed in the `Authorization` header of
/// an HTTPS request.
final class OpenRouterClient {
  OpenRouterClient({
    required this.client,
    String baseUrl = defaultBaseUrl,
    this.connectTimeout = const Duration(seconds: 15),
    this.totalTimeout = const Duration(seconds: 45),
    @visibleForTesting String? allowedHostForTesting,
  }) : _base = _validateBaseUrl(baseUrl, allowedHostForTesting),
       baseUrl = _normalize(baseUrl);

  /// Response size caps, in bytes.
  static const int maxChatResponseBytes = 2 * 1024 * 1024;
  static const int maxModelsResponseBytes = 8 * 1024 * 1024;

  static const String _pinnedHost = 'openrouter.ai';

  static const String defaultBaseUrl = 'https://openrouter.ai/api/v1';

  final http.Client client;
  final String baseUrl;
  final Duration connectTimeout;
  final Duration totalTimeout;
  final Uri _base;

  static String _normalize(String value) =>
      value.endsWith('/') ? value.substring(0, value.length - 1) : value;

  static Uri _validateBaseUrl(String value, String? allowedHost) {
    final uri = Uri.tryParse(value);
    final host = (allowedHost ?? _pinnedHost).toLowerCase();
    final valid =
        uri != null &&
        uri.scheme.toLowerCase() == 'https' &&
        uri.host.toLowerCase() == host &&
        uri.userInfo.isEmpty &&
        !uri.hasQuery &&
        !uri.hasFragment &&
        (allowedHost != null || !uri.hasPort || uri.port == 443);
    if (!valid) {
      throw ArgumentError.value(
        'redacted',
        'baseUrl',
        'OpenRouter base URL must be https://$_pinnedHost without '
            'credentials, query or fragment',
      );
    }
    return uri;
  }

  Uri _endpoint(String path) => _base.replace(
    pathSegments: [
      ..._base.pathSegments.where((segment) => segment.isNotEmpty),
      ...path.split('/'),
    ],
  );

  /// Lists the models suited to this feature, keeping only entries allowed by
  /// [filter], recommended first (see [fetchModelCatalog]).
  Future<List<AiModelDescriptor>> fetchModels({
    String? apiKey,
    AiModelFilter filter = AiModelFilter.free,
  }) async => (await fetchModelCatalog(apiKey: apiKey, filter: filter)).models;

  /// Lists the catalog reduced to models that can do this feature: text in,
  /// text only out, not a router or meta-model, and a context window of at
  /// least [AiModelDescriptor.minContextLength]. Entries are sorted
  /// recommended first, then those declaring `response_format` or
  /// `structured_outputs`, then by name. [AiModelCatalog.totalCount] is the
  /// size of the catalog before filtering.
  Future<AiModelCatalog> fetchModelCatalog({
    String? apiKey,
    AiModelFilter filter = AiModelFilter.free,
  }) async {
    final key = apiKey?.trim();
    final request = http.Request('GET', _endpoint('models'))
      ..followRedirects = false
      ..headers['Accept'] = 'application/json';
    if (key != null && key.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $key';
    }

    final response = await _send(
      request,
      apiKey: key,
      maxBytes: maxModelsResponseBytes,
    );
    _throwForStatus(response.statusCode, response.body, key);

    final root = _tryDecode(response.body);
    final data = root is Map ? root['data'] : null;
    if (data is! List) {
      throw const OpenRouterFormatException('Unexpected models response');
    }

    final models = <AiModelDescriptor>[];
    for (final entry in data) {
      if (entry is! Map) continue;
      final descriptor = AiModelDescriptor.fromOpenRouter(entry);
      if (descriptor == null || !descriptor.isSuitable) continue;
      if (filter.matches(isFree: descriptor.isFree)) models.add(descriptor);
    }
    models.sort(AiModelDescriptor.compareForPicker);
    return AiModelCatalog(models: models, totalCount: data.length);
  }

  /// Sends one chat completion and returns the assistant's text content.
  ///
  /// The request asks for a JSON object response; if the model rejects
  /// `response_format` (HTTP 400 or 422 whose message mentions
  /// `response_format`, structured outputs or JSON), it is retried once
  /// without it. Any other error is returned as is.
  Future<String> completeJson({
    required String apiKey,
    required String model,
    required double temperature,
    required int maxTokens,
    required String systemPrompt,
    required String userPrompt,
    String? imageDataUrl,
  }) async {
    Future<String> attempt({required bool jsonFormat}) async {
      final payload = <String, dynamic>{
        'model': model,
        'temperature': temperature.clamp(0, 1),
        'max_tokens': maxTokens.clamp(1, 4096),
        if (jsonFormat) 'response_format': {'type': 'json_object'},
        'messages': [
          {'role': 'system', 'content': systemPrompt},
          {'role': 'user', 'content': _userContent(userPrompt, imageDataUrl)},
        ],
      };

      final request = http.Request('POST', _endpoint('chat/completions'))
        ..followRedirects = false
        ..headers['Authorization'] = 'Bearer ${apiKey.trim()}'
        ..headers['Content-Type'] = 'application/json'
        ..headers['Accept'] = 'application/json'
        ..headers['X-Title'] = 'Ink Lab'
        ..body = jsonEncode(payload);

      final response = await _send(
        request,
        apiKey: apiKey,
        maxBytes: maxChatResponseBytes,
      );
      _throwForStatus(response.statusCode, response.body, apiKey);
      return _extractAssistantContent(response.body);
    }

    try {
      return await attempt(jsonFormat: true);
    } on OpenRouterHttpException catch (error) {
      // Many models and routed providers reject `response_format`; one retry
      // without it is cheap and never repeats. Other 400/422 errors (bad
      // model id, bad parameters) would fail again, so they are not retried.
      if ((error.statusCode == 400 || error.statusCode == 422) &&
          _mentionsResponseFormat(error.message)) {
        return attempt(jsonFormat: false);
      }
      rethrow;
    }
  }

  Future<({int statusCode, String body})> _send(
    http.Request request, {
    String? apiKey,
    required int maxBytes,
  }) async {
    final http.StreamedResponse streamed;
    try {
      streamed = await client.send(request).timeout(connectTimeout);
    } on TimeoutException {
      throw const OpenRouterNetworkException('Connection timed out');
    } on http.ClientException catch (error) {
      throw OpenRouterNetworkException(redactSecret(error.message, apiKey));
    } catch (_) {
      throw const OpenRouterNetworkException('Network error');
    }

    if (streamed.statusCode >= 300 && streamed.statusCode < 400) {
      // Never follow or echo a redirect: it could leak the Authorization header.
      unawaited(streamed.stream.listen((_) {}).cancel());
      throw OpenRouterHttpException(
        streamed.statusCode,
        'Unexpected redirect from OpenRouter',
      );
    }
    final declared = streamed.contentLength;
    if (declared != null && declared > maxBytes) {
      unawaited(streamed.stream.listen((_) {}).cancel());
      throw const OpenRouterFormatException('Response too large');
    }

    try {
      final bytes = await _readCapped(
        streamed.stream,
        maxBytes,
      ).timeout(totalTimeout);
      return (
        statusCode: streamed.statusCode,
        body: utf8.decode(bytes, allowMalformed: true),
      );
    } on TimeoutException {
      throw const OpenRouterNetworkException('Request timed out');
    }
  }

  Future<Uint8List> _readCapped(Stream<List<int>> stream, int maxBytes) async {
    final builder = BytesBuilder(copy: false);
    await for (final chunk in stream) {
      if (builder.length + chunk.length > maxBytes) {
        throw const OpenRouterFormatException('Response too large');
      }
      builder.add(chunk);
    }
    return builder.takeBytes();
  }

  void _throwForStatus(int status, String body, String? apiKey) {
    if (status >= 200 && status < 300) return;
    final detail = _extractErrorMessage(body) ?? 'OpenRouter request failed';
    throw OpenRouterHttpException(status, redactSecret(detail, apiKey));
  }

  String _extractAssistantContent(String body) {
    final root = _tryDecode(body);
    if (root is! Map) {
      throw const OpenRouterFormatException('Model did not return valid JSON');
    }
    final choices = root['choices'];
    if (choices is! List || choices.isEmpty) {
      throw const OpenRouterFormatException('Model returned no choices');
    }
    final first = choices.first;
    if (first is! Map) {
      throw const OpenRouterFormatException('Model returned no choices');
    }
    final message = first['message'];
    if (message is! Map) {
      throw const OpenRouterFormatException(
        'Model response is missing a message',
      );
    }

    // Free models often put the answer in `reasoning` or leave `content`
    // empty or prose-only. Prefer the first field that looks like it carries
    // JSON, then the first non-empty one; the caller parses and validates.
    final candidates = <String>[
      for (final field in const ['content', 'reasoning', 'reasoning_content'])
        if (_contentToText(message[field]) case final text?)
          if (text.trim().isNotEmpty) text,
      ?_reasoningDetailsText(message['reasoning_details']),
    ];
    for (final text in candidates) {
      if (text.contains('{') || text.contains('[')) return text;
    }
    if (candidates.isNotEmpty) return candidates.first;

    final finishReason = _string(first['finish_reason'])?.toLowerCase();
    if (finishReason == 'length') {
      throw const OpenRouterFormatException('Model output was truncated');
    }
    throw const OpenRouterFormatException('Model returned empty content');
  }

  String? _extractErrorMessage(String body) {
    final root = _tryDecode(body);
    if (root is! Map) return null;
    final error = root['error'];
    if (error is String && error.trim().isNotEmpty) return error.trim();
    if (error is Map) {
      final parts = <String>[];
      final message = _string(error['message']);
      if (message != null && message.trim().isNotEmpty) {
        parts.add(message.trim());
      }
      final metadata = error['metadata'];
      if (metadata is Map) {
        final raw = _string(metadata['raw']);
        if (raw != null && raw.trim().isNotEmpty) parts.add(raw.trim());
      }
      if (parts.isNotEmpty) return parts.join(' - ');
    }
    return null;
  }
}

bool _mentionsResponseFormat(String message) {
  final text = message.toLowerCase();
  return text.contains('response_format') ||
      text.contains('response format') ||
      text.contains('structured') ||
      text.contains('json');
}

Object? _tryDecode(String body) {
  try {
    return jsonDecode(body);
  } on FormatException {
    return null;
  }
}

Object? _userContent(String userPrompt, String? imageDataUrl) {
  final image = imageDataUrl?.trim() ?? '';
  if (image.isEmpty) return userPrompt;
  return [
    {'type': 'text', 'text': userPrompt},
    {
      'type': 'image_url',
      'image_url': {'url': image},
    },
  ];
}

String? _contentToText(Object? content) {
  if (content is String) return content;
  if (content is Map) {
    return _string(content['text']) ??
        _string(content['content']) ??
        _string(content['value']);
  }
  if (content is List) {
    final parts = <String>[];
    for (final entry in content) {
      final text = _contentToText(entry);
      if (text != null && text.isNotEmpty) parts.add(text);
    }
    final joined = parts.join('\n');
    return joined.isEmpty ? null : joined;
  }
  return null;
}

String? _reasoningDetailsText(Object? details) {
  if (details is! List) return null;
  final parts = <String>[];
  for (final entry in details) {
    if (entry is! Map) continue;
    final text = _string(entry['text']) ?? _string(entry['summary']);
    if (text != null && text.isNotEmpty) parts.add(text);
  }
  return parts.isEmpty ? null : parts.join('\n');
}

String? _string(Object? value) =>
    value is String && value.toLowerCase() != 'null' ? value : null;

double? _double(Object? value) {
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

List<String> _stringList(Object? value) {
  if (value is! List) return const [];
  return [
    for (final item in value)
      if (item is String) item.toLowerCase(),
  ];
}
