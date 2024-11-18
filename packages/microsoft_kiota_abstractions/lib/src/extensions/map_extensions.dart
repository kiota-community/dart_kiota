part of '../../microsoft_kiota_abstractions.dart';

/// Extension methods for the [Map] class.
extension<K, V> on Map<K, V> {
  /// Adds or replaces a key-value pair in the map.
  ///
  /// Returns the old value if the key already exists, `null` otherwise.
  V? addOrReplace(K key, V value) {
    if (containsKey(key)) {
      final oldValue = this[key];
      this[key] = value;
      return oldValue;
    } else {
      this[key] = value;
      return null;
    }
  }
}
