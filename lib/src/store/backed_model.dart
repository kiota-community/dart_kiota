part of '../../kiota_abstractions.dart';

/// Defines the contract for a model that is backed by a store.
abstract class BackedModel {
  /// Gets the store that is backing the model.
  BackingStore? get backingStore;
}
