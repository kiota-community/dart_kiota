part of dart_kiota;

class RequestHeaders implements Map<String, String> {
  final Map<String, String> _headers = const {};

  const RequestHeaders();

  @override
  String? operator [](Object? key) => _headers[key];

  @override
  void operator []=(String key, String value) => _headers[key] = value;

  @override
  void addAll(Map<String, String> other) => _headers.addAll(other);

  @override
  void addEntries(Iterable<MapEntry<String, String>> newEntries) => _headers.addEntries(newEntries);

  @override
  Map<RK, RV> cast<RK, RV>() => _headers.cast<RK, RV>();

  @override
  void clear() => _headers.clear();

  @override
  bool containsKey(Object? key) => _headers.containsKey(key);

  @override
  bool containsValue(Object? value) => _headers.containsValue(value);

  @override
  Iterable<MapEntry<String, String>> get entries => _headers.entries;

  @override
  void forEach(void Function(String key, String value) action) => _headers.forEach(action);

  @override
  bool get isEmpty => _headers.isEmpty;

  @override
  bool get isNotEmpty => _headers.isNotEmpty;

  @override
  Iterable<String> get keys => _headers.keys;

  @override
  int get length => _headers.length;

  @override
  Map<K2, V2> map<K2, V2>(MapEntry<K2, V2> Function(String key, String value) convert) => _headers.map(convert);

  @override
  String putIfAbsent(String key, String Function() ifAbsent) => _headers.putIfAbsent(key, ifAbsent);

  @override
  String? remove(Object? key) => _headers.remove(key);

  @override
  void removeWhere(bool Function(String key, String value) test) => _headers.removeWhere(test);

  @override
  String update(String key, String Function(String value) update, {String Function()? ifAbsent}) => _headers.update(key, update, ifAbsent: ifAbsent);

  @override
  void updateAll(String Function(String key, String value) update) => _headers.updateAll(update);

  @override
  Iterable<String> get values => _headers.values;
}
