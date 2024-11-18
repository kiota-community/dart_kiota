part of '../../microsoft_kiota_abstractions.dart';

/// This class is used to create instances of [InMemoryBackingStore].
class InMemoryBackingStoreFactory implements BackingStoreFactory {
  @override
  BackingStore createBackingStore() => InMemoryBackingStore();
}
