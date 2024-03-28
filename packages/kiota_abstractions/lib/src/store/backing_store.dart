part of '../../kiota_abstractions.dart';

/// Stores model information in a different location than the object properties.
///
/// Implementations can provide dirty tracking and caching capabilities or
/// integration with 3rd party stores.
abstract class BackingStore {
  /// Gets a value from the backing store based on its key. Returns `null` if
  /// the value hasn't changed and [returnOnlyChangedValues] is `true`.
  T? get<T>(String key);

  /// Sets or updates the stored value for the given key.
  ///
  /// Will trigger subscriptions callbacks.
  void set<T>(String key, T value);

  /// Iterates all the values stored in the backing store. Values will be
  /// filtered if [returnOnlyChangedValues] is `true`.
  Iterable<MapEntry<String, Object?>> iterate();

  /// Iterates the keys for all values that changed to `null`.
  Iterable<String> iterateKeysForValuesChangedToNull();

  /// Creates a subscription to any data change happening, optionally specifying
  /// a [subscriptionId] to be able to unsubscribe later.
  ///
  /// The given [callback] is invoked on data changes.
  String subscribe(
    BackingStoreSubscriptionCallback callback, [
    String? subscriptionId,
  ]);

  /// Unsubscribes a subscription by its [subscriptionId].
  void unsubscribe(String subscriptionId);

  /// Clears all the stored values. Doesn't trigger any subscription callbacks.
  void clear();

  /// Whether to return only values that have changed since the initialization
  /// of the object when calling [get] and [iterate] methods.
  abstract bool returnOnlyChangedValues;

  /// Whether the initialization of the object and/or the initial
  /// deserialization has been competed to track whether objects have changed.
  abstract bool initializationCompleted;
}
