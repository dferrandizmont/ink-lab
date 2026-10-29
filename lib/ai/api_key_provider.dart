import '../data/secret_store.dart';

/// Name under which the OpenRouter key is stored in the [SecretStore].
const String openRouterApiKeyName = 'openrouter_api_key';

/// Reads the OpenRouter key from the [SecretStore] on demand.
///
/// Pass the instance (it is callable) as the advisor's key provider so the key
/// is fetched per request and never cached in memory by this class.
final class ApiKeyProvider {
  const ApiKeyProvider(this._secrets);

  final SecretStore _secrets;

  /// The stored key, trimmed, or `null` when none is stored.
  Future<String?> call() async {
    final raw = await _secrets.read(openRouterApiKeyName);
    final key = raw?.trim();
    return (key == null || key.isEmpty) ? null : key;
  }

  /// Stores [key] after trimming. Throws [ArgumentError] (without the value)
  /// when it does not look like an OpenRouter key.
  Future<void> save(String key) async {
    final trimmed = key.trim();
    if (!looksLikeOpenRouterKey(trimmed)) {
      throw ArgumentError('Not a valid OpenRouter API key');
    }
    await _secrets.write(openRouterApiKeyName, trimmed);
  }

  Future<void> clear() => _secrets.delete(openRouterApiKeyName);

  @override
  String toString() => 'ApiKeyProvider()';
}

/// Shows only the last 4 characters, e.g. `••••••••abcd`. Values of 8
/// characters or fewer are fully masked so short values never leak.
String maskKey(String key) {
  if (key.isEmpty) return '';
  if (key.length <= 8) return '••••••••';
  return '••••••••${key.substring(key.length - 4)}';
}

const int _minKeyLength = 20;
const int _maxKeyLength = 256;
final RegExp _whitespace = RegExp(r'\s');

/// Cheap local sanity check: `sk-or-` prefix, plausible length, no whitespace.
/// Does not prove the key is valid with OpenRouter.
bool looksLikeOpenRouterKey(String key) =>
    key.startsWith('sk-or-') &&
    key.length >= _minKeyLength &&
    key.length <= _maxKeyLength &&
    !_whitespace.hasMatch(key);
