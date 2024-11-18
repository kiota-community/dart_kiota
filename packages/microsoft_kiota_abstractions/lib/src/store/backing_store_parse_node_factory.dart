part of '../../microsoft_kiota_abstractions.dart';

/// Proxy implementation of [ParseNodeFactory] that allows for the
/// [BackingStore] that automatically sets the state of the [BackingStore]
/// when deserializing.
class BackingStoreParseNodeFactory extends ParseNodeProxyFactory {
  /// Creates a new instance of the [BackingStoreParseNodeFactory] class.
  BackingStoreParseNodeFactory({
    required super.concrete,
  }) : super(
          onBefore: (parsable) {
            if (parsable is BackedModel) {
              final model = parsable as BackedModel;
              if (model.backingStore != null) {
                model.backingStore!.initializationCompleted = false;
              }
            }
          },
          onAfter: (parsable) {
            if (parsable is BackedModel) {
              final model = parsable as BackedModel;
              if (model.backingStore != null) {
                model.backingStore!.initializationCompleted = true;
              }
            }
          },
        );
}
