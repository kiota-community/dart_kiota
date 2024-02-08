part of '../../dart_kiota.dart';

/// Extension methods for the [Map] class.
extension<K, V> on Map<K, V> {
  /// Adds a new key-value pair to the map if the key does not exist.
  ///
  /// Returns `true` if the key was added, `false` otherwise.
  bool tryAdd(K key, V value) {
    if (containsKey(key)) {
      return false;
    }

    this[key] = value;

    return true;
  }

  /// Adds or replaces a key-value pair in the map.
  ///
  /// Returns the old value if the key already exists, `null` otherwise.
  V? addOrReplace(K key, V value) {
    if (!tryAdd(key, value)) {
      final oldValue = this[key];

      this[key] = value;

      return oldValue;
    }

    return null;
  }
}
