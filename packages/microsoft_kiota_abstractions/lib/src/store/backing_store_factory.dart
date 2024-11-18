part of '../../microsoft_kiota_abstractions.dart';

/// Defines the contract for a factory that creates a [BackingStore].
abstract class BackingStoreFactory {
  /// Creates a new instance of the [BackingStore].
  BackingStore createBackingStore();
}
