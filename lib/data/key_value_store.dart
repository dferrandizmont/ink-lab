import 'package:shared_preferences/shared_preferences.dart';

/// Asynchronous key/value seam for the local storage layer.
///
/// Every repository depends on this interface only. The app wires the
/// platform-backed implementation ([SharedPreferencesStore] or
/// [SharedPreferencesAsyncStore]); tests wire either [InMemoryKeyValueStore]
/// or a [SharedPreferences] instance prepared with
/// `SharedPreferences.setMockInitialValues`.
///
/// The surface mirrors the subset of `shared_preferences` the data layer uses,
/// so swapping the platform implementation never changes repository code.
abstract interface class KeyValueStore {
  Future<String?> getString(String key);
  Future<void> setString(String key, String value);

  Future<bool?> getBool(String key);
  Future<void> setBool(String key, bool value);

  Future<int?> getInt(String key);
  Future<void> setInt(String key, int value);

  Future<double?> getDouble(String key);
  Future<void> setDouble(String key, double value);

  Future<List<String>?> getStringList(String key);
  Future<void> setStringList(String key, List<String> value);

  Future<bool> containsKey(String key);
  Future<void> remove(String key);
  Future<Set<String>> keys();
}

/// [KeyValueStore] on top of the legacy `SharedPreferences` API.
///
/// This is the default production store and the one tests can prepare with
/// `SharedPreferences.setMockInitialValues`.
final class SharedPreferencesStore implements KeyValueStore {
  SharedPreferencesStore(this._preferences);

  final SharedPreferences _preferences;

  /// Opens the platform store, returning the shared [SharedPreferences]
  /// singleton.
  static Future<SharedPreferencesStore> open() async =>
      SharedPreferencesStore(await SharedPreferences.getInstance());

  @override
  Future<String?> getString(String key) async => _preferences.getString(key);

  @override
  Future<void> setString(String key, String value) async =>
      _preferences.setString(key, value);

  @override
  Future<bool?> getBool(String key) async => _preferences.getBool(key);

  @override
  Future<void> setBool(String key, bool value) async =>
      _preferences.setBool(key, value);

  @override
  Future<int?> getInt(String key) async => _preferences.getInt(key);

  @override
  Future<void> setInt(String key, int value) async =>
      _preferences.setInt(key, value);

  @override
  Future<double?> getDouble(String key) async => _preferences.getDouble(key);

  @override
  Future<void> setDouble(String key, double value) async =>
      _preferences.setDouble(key, value);

  @override
  Future<List<String>?> getStringList(String key) async =>
      _preferences.getStringList(key);

  @override
  Future<void> setStringList(String key, List<String> value) async =>
      _preferences.setStringList(key, value);

  @override
  Future<bool> containsKey(String key) async => _preferences.containsKey(key);

  @override
  Future<void> remove(String key) async => _preferences.remove(key);

  @override
  Future<Set<String>> keys() async => _preferences.getKeys();
}

/// [KeyValueStore] on top of the newer `SharedPreferencesAsync` API.
///
/// Provided so the app can migrate to the async API without changing any
/// repository. It shares the same backing store as [SharedPreferencesStore].
final class SharedPreferencesAsyncStore implements KeyValueStore {
  SharedPreferencesAsyncStore([SharedPreferencesAsync? preferences])
    : _preferences = preferences ?? SharedPreferencesAsync();

  final SharedPreferencesAsync _preferences;

  @override
  Future<String?> getString(String key) => _preferences.getString(key);

  @override
  Future<void> setString(String key, String value) =>
      _preferences.setString(key, value);

  @override
  Future<bool?> getBool(String key) => _preferences.getBool(key);

  @override
  Future<void> setBool(String key, bool value) =>
      _preferences.setBool(key, value);

  @override
  Future<int?> getInt(String key) => _preferences.getInt(key);

  @override
  Future<void> setInt(String key, int value) => _preferences.setInt(key, value);

  @override
  Future<double?> getDouble(String key) => _preferences.getDouble(key);

  @override
  Future<void> setDouble(String key, double value) =>
      _preferences.setDouble(key, value);

  @override
  Future<List<String>?> getStringList(String key) =>
      _preferences.getStringList(key);

  @override
  Future<void> setStringList(String key, List<String> value) =>
      _preferences.setStringList(key, value);

  @override
  Future<bool> containsKey(String key) => _preferences.containsKey(key);

  @override
  Future<void> remove(String key) => _preferences.remove(key);

  @override
  Future<Set<String>> keys() => _preferences.getKeys();
}

/// In-memory [KeyValueStore] for tests and for building backups without I/O.
///
/// Values keep the same types as the platform stores (`String`, `bool`, `int`,
/// `double`, `List<String>`), so a mismatch throws exactly like the real store.
final class InMemoryKeyValueStore implements KeyValueStore {
  InMemoryKeyValueStore([Map<String, Object>? initial])
    : _values = {...?initial};

  final Map<String, Object> _values;

  @override
  Future<String?> getString(String key) async => _values[key] as String?;

  @override
  Future<void> setString(String key, String value) async {
    _values[key] = value;
  }

  @override
  Future<bool?> getBool(String key) async => _values[key] as bool?;

  @override
  Future<void> setBool(String key, bool value) async {
    _values[key] = value;
  }

  @override
  Future<int?> getInt(String key) async => _values[key] as int?;

  @override
  Future<void> setInt(String key, int value) async {
    _values[key] = value;
  }

  @override
  Future<double?> getDouble(String key) async => _values[key] as double?;

  @override
  Future<void> setDouble(String key, double value) async {
    _values[key] = value;
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    final value = _values[key];
    return value == null ? null : List<String>.from(value as List);
  }

  @override
  Future<void> setStringList(String key, List<String> value) async {
    _values[key] = List<String>.of(value);
  }

  @override
  Future<bool> containsKey(String key) async => _values.containsKey(key);

  @override
  Future<void> remove(String key) async {
    _values.remove(key);
  }

  @override
  Future<Set<String>> keys() async => _values.keys.toSet();
}
