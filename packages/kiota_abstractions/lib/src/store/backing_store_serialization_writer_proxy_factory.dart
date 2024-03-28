part of '../../kiota_abstractions.dart';

/// Proxy implementation of [SerializationWriterFactory] for the [BackingStore]
/// that automatically sets the state of the backing store when serializing.
class BackingStoreSerializationWriterProxyFactory
    extends SerializationWriterProxyFactory {
  /// Creates a new instance of [BackingStoreSerializationWriterProxyFactory]
  /// with the provided concrete factory.
  BackingStoreSerializationWriterProxyFactory({
    required super.concrete,
  }) : super(
          onBefore: (p) {
            if (p is BackedModel) {
              final model = p as BackedModel;
              if (model.backingStore != null) {
                model.backingStore!.returnOnlyChangedValues = true;
              }
            }
          },
          onAfter: (p) {
            if (p is BackedModel) {
              final model = p as BackedModel;
              if (model.backingStore != null) {
                model.backingStore!.returnOnlyChangedValues = false;
                model.backingStore!.initializationCompleted = true;
              }
            }
          },
          onStart: (p, writer) {
            if (p is BackedModel) {
              final model = p as BackedModel;
              if (model.backingStore != null) {
                model.backingStore!
                    .iterateKeysForValuesChangedToNull()
                    .forEach((element) {
                  writer.writeNullValue(element);
                });
              }
            }
          },
        );
}
