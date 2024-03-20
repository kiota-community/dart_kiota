part of '../../kiota_abstractions.dart';

/// This class is used to register the backing store factory.
class BackingStoreFactorySingleton {
  /// The backing store factory singleton instance.
  static BackingStoreFactory instance = InMemoryBackingStoreFactory();
}
