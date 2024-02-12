part of '../kiota_abstractions.dart';

/// Represents the headers of a request.
///
/// Internally, the keys are stored in lower case, but the original case is
/// preserved when iterating over the headers.
/// This effectively makes the keys case-insensitive.
class HttpHeaders implements Map<String, Set<String>> {
  /// Creates a new instance of [HttpHeaders].
  HttpHeaders();

  static const List<String> singleValueHeaders = [
    'content-type',
    'content-encoding',
    'content-length',
  ];

  final Map<String, Set<String>> _headers = {};
  final Map<String, String> _originalNames = {};

  @override
  Set<String>? operator [](Object? key) {
    if (key is String) {
      return _headers[key.toLowerCase()];
    }

    return null;
  }

  @override
  void operator []=(String key, Set<String> value) {
    final lowerCaseKey = key.toLowerCase();

    _originalNames[lowerCaseKey] = key;

    if (singleValueHeaders.contains(lowerCaseKey)) {
      _headers[lowerCaseKey] = {value.first};
    } else {
      _headers[lowerCaseKey] = value;
    }
  }

  /// Sets the value of the header with the given [key] to a Set containing only
  /// [value].
  void put(String key, String value) {
    this[key] = {value};
  }

  @override
  void addAll(Map<String, Set<String>> other) {
    other.forEach((key, value) {
      this[key] = value;
    });
  }

  @override
  void addEntries(Iterable<MapEntry<String, Set<String>>> newEntries) {
    newEntries.forEach((entry) {
      this[entry.key] = entry.value;
    });
  }

  @override
  Map<RK, RV> cast<RK, RV>() => _headers.cast<RK, RV>();

  @override
  void clear() {
    _headers.clear();
    _originalNames.clear();
  }

  @override
  bool containsKey(Object? key) {
    if (key is String) {
      return _headers.containsKey(key.toLowerCase());
    }

    return false;
  }

  @override
  bool containsValue(Object? value) => _headers.containsValue(value);

  @override
  Iterable<MapEntry<String, Set<String>>> get entries {
    return _headers.entries.map((entry) {
      return MapEntry(_originalNames[entry.key]!, entry.value);
    });
  }

  @override
  void forEach(void Function(String key, Set<String> value) action) {
    _headers.forEach((key, value) {
      action(_originalNames[key]!, value);
    });
  }

  @override
  bool get isEmpty => _headers.isEmpty;

  @override
  bool get isNotEmpty => _headers.isNotEmpty;

  @override
  Iterable<String> get keys => _headers.keys.map((key) => _originalNames[key]!);

  @override
  int get length => _headers.length;

  @override
  Map<K2, V2> map<K2, V2>(
    MapEntry<K2, V2> Function(String key, Set<String> value) convert,
  ) {
    final result = <K2, V2>{};

    _headers.forEach((key, value) {
      final entry = convert(_originalNames[key]!, value);
      result[entry.key] = entry.value;
    });

    return result;
  }

  @override
  Set<String> putIfAbsent(String key, Set<String> Function() ifAbsent) {
    return _headers.putIfAbsent(key.toLowerCase(), ifAbsent);
  }

  @override
  Set<String>? remove(Object? key) {
    if (key is String) {
      _originalNames.remove(key.toLowerCase());
      return _headers.remove(key.toLowerCase());
    }

    return null;
  }

  @override
  void removeWhere(bool Function(String key, Set<String> value) test) {
    final keys = _headers.keys.toList();

    for (final key in keys) {
      if (test(_originalNames[key]!, _headers[key]!)) {
        _originalNames.remove(key);
        _headers.remove(key);
      }
    }
  }

  @override
  Set<String> update(
    String key,
    Set<String> Function(Set<String> value) update, {
    Set<String> Function()? ifAbsent,
  }) {
    return _headers.update(key.toLowerCase(), update, ifAbsent: ifAbsent);
  }

  @override
  void updateAll(Set<String> Function(String key, Set<String> value) update) {
    final keys = _headers.keys.toList();

    for (final key in keys) {
      _headers[key] = update(_originalNames[key]!, _headers[key]!);
    }
  }

  @override
  Iterable<Set<String>> get values => _headers.values;
}
