/// Structural value semantics for immutable JSON-backed data classes.
abstract mixin class JsonValue {
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JsonValue &&
          runtimeType == other.runtimeType &&
          _equal(toJson(), other.toJson());

  @override
  int get hashCode => Object.hash(runtimeType, _hash(toJson()));
}

bool _equal(Object? a, Object? b) {
  if (a is List && b is List) {
    return a.length == b.length &&
        Iterable<int>.generate(a.length).every((i) => _equal(a[i], b[i]));
  }
  if (a is Map && b is Map) {
    return a.length == b.length &&
        a.keys.every((key) => b.containsKey(key) && _equal(a[key], b[key]));
  }
  return a == b;
}

int _hash(Object? value) {
  if (value is List) return Object.hashAll(value.map(_hash));
  if (value is Map) {
    return Object.hashAllUnordered(
      value.entries.map((entry) => Object.hash(entry.key, _hash(entry.value))),
    );
  }
  return value.hashCode;
}

/// Kotlin enum spellings are retained on the wire.
T decodeEnum<T extends Enum>(List<T> values, Object? json) {
  for (final value in values) {
    if (enumJson(value) == json) return value;
  }
  throw FormatException('Unknown enum value: $json');
}

String enumJson(Enum value) =>
    '${value.name[0].toUpperCase()}${value.name.substring(1)}';

/// Missing keys use Kotlin defaults; explicit null for a non-null field fails.
T jsonDefault<T>(Map<String, dynamic> json, String key, T fallback) =>
    json.containsKey(key) ? json[key] as T : fallback;
