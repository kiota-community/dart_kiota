part of '../kiota_abstractions.dart';

/// Provides a builder for creating an ApiClient and register the default
/// serializers/deserializers.
class ApiClientBuilder {
  const ApiClientBuilder._();

  static void registerDefaultSerializer<T extends SerializationWriterFactory>(
    T Function() factoryCreator,
  ) {
    final factory = factoryCreator();

    SerializationWriterFactoryRegistry
        .defaultInstance.contentTypeAssociatedFactories
        .putIfAbsent(factory.validContentType, () => factory);
  }

  static void registerDefaultDeserializer<T extends ParseNodeFactory>(
    T Function() factoryCreator,
  ) {
    final factory = factoryCreator();

    ParseNodeFactoryRegistry.defaultInstance.contentTypeAssociatedFactories
        .putIfAbsent(factory.validContentType, () => factory);
  }
}
