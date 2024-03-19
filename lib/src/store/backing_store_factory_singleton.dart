part of '../../kiota_abstractions.dart';

/// This class is used to register the backing store factory.
class BackingStoreFactorySingleton {
  static final BackingStoreFactory _instance = InMemoryBackingStoreFactory();

  /// The backing store factory singleton instance.
  static BackingStoreFactory get instance => _instance;
}
