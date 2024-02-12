part of '../../kiota_abstractions.dart';

class InMemoryBackingStore implements BackingStore {
  final Map<String, (bool, Object?)> _store = {};
  final Map<String, BackingStoreSubscriptionCallback> _subscriptions = {};

  bool _initializationCompleted = true;

  bool get initializationCompleted => _initializationCompleted;

  set initializationCompleted(bool value) {
    _initializationCompleted = value;

    for (final key in _store.keys) {
      final tuple = _store[key]!;
      final obj = tuple.$2;

      if (obj is BackedModel) {
        obj.backingStore?.initializationCompleted = value;
      }

      ensureCollectionPropertyIsConsistent(key, obj);

      _store[key] = (!value, obj);
    }
  }

  void ensureCollectionPropertyIsConsistent(String key, Object? value) {
    // TODO(rbo): Implement this method.
  }

  @override
  bool returnOnlyChangedValues = false;

  @override
  void clear() => _store.clear();

  @override
  T? get<T>(String key) {
    if (key.isEmpty) {
      throw ArgumentError('The key cannot be empty.');
    }

    if (!_store.containsKey(key)) {
      return null;
    }

    final value = _store[key];
  }

  @override
  Iterable<MapEntry<String, Object?>> iterate() {
    // TODO: implement iterate
    throw UnimplementedError();
  }

  @override
  Iterable<String> iterateKeysForValuesChangedToNull() {
    // TODO: implement iterateKeysForValuesChangedToNull
    throw UnimplementedError();
  }

  @override
  void set<T>(String key, T value) {
    // TODO: implement set
  }

  @override
  String subscribe(BackingStoreSubscriptionCallback callback,
      [String? subscriptionId]) {
    // TODO: implement subscribe
    throw UnimplementedError();
  }

  @override
  void unsubscribe(String subscriptionId) {
    // TODO: implement unsubscribe
  }
}
