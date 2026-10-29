/// Storage seam for secrets, kept deliberately separate from the settings
/// store.
///
/// Only the *secret* values (currently just the bring-your-own-key API key)
/// live behind this interface, so the plain settings/backup path can never
/// read or export them. The production, security-reviewed implementation (for
/// example the platform keystore) is provided by the lead; the data layer only
/// knows this contract.
abstract interface class SecretStore {
  Future<String?> read(String name);
  Future<void> write(String name, String value);
  Future<void> delete(String name);
}

/// Volatile [SecretStore] used by tests.
///
/// It keeps secrets in a plain map in memory; it must never be used as the
/// production store.
final class InMemorySecretStore implements SecretStore {
  InMemorySecretStore([Map<String, String>? initial]) : _values = {...?initial};

  final Map<String, String> _values;

  @override
  Future<String?> read(String name) async => _values[name];

  @override
  Future<void> write(String name, String value) async {
    _values[name] = value;
  }

  @override
  Future<void> delete(String name) async {
    _values.remove(name);
  }
}
