part of dart_kiota;

/// Provides a builder for creating an [ApiClient] and register the default
/// serializers/deserializers.
class ApiClientBuilder {
  const ApiClientBuilder._();

  static void registerDefaultSerializer<T extends SerializationWriterFactory>(
    T Function() factoryCreator,
  ) {
    final factory = factoryCreator();

    SerializationWriterFactoryRegistry
        .defaultInstance.contentTypeAssociatedFactories
        .tryAdd(factory.validContentType, factory);
  }

  static void registerDefaultDeserializer<T extends ParseNodeFactory>(
    T Function() factoryCreator,
  ) {
    final factory = factoryCreator();

    ParseNodeFactoryRegistry.defaultInstance.contentTypeAssociatedFactories
        .tryAdd(factory.validContentType, factory);
  }
}
