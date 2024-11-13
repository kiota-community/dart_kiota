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

  static SerializationWriterFactory
      enableBackingStoreForSerializationWriterFactory(
          SerializationWriterFactory original) {
    var result = original;
    if (original is SerializationWriterFactoryRegistry) {
      _enableBackingStoreForSerializationRegistry(original);
      if (original != SerializationWriterFactoryRegistry.defaultInstance) {
        // if the registry is the default instance, we already enabled it above. No need to do it twice
        _enableBackingStoreForSerializationRegistry(
            SerializationWriterFactoryRegistry.defaultInstance);
      }
    }
    if (result is BackingStoreSerializationWriterProxyFactory) {
      //We are already enabled so use it.
      return result;
    } else {
      result = BackingStoreSerializationWriterProxyFactory(concrete: original);
    }

    return result;
  }

  static ParseNodeFactory enableBackingStoreForParseNodeFactory(
      ParseNodeFactory original) {
    var result = original;
    if (original is ParseNodeFactoryRegistry) {
      _enableBackingStoreForParseNodeRegistry(original);
      if (original != ParseNodeFactoryRegistry.defaultInstance) {
        // if the registry is the default instance, we already enabled it above. No need to do it twice
        _enableBackingStoreForParseNodeRegistry(
            ParseNodeFactoryRegistry.defaultInstance);
      }
    }
    if (result is BackingStoreParseNodeFactory) {
      //We are already enabled so use it.
      return result;
    } else {
      result = BackingStoreParseNodeFactory(concrete: original);
    }

    return result;
  }

  static void _enableBackingStoreForParseNodeRegistry(
      ParseNodeFactoryRegistry registry) {
    final keysToUpdate = <String>[];
    registry.contentTypeAssociatedFactories.forEach((key, value) {
      if (value is! BackingStoreParseNodeFactory) {
        keysToUpdate.add(key);
      }
    });

    keysToUpdate.forEach((key) {
      registry.contentTypeAssociatedFactories[key] =
          BackingStoreParseNodeFactory(
              concrete: registry.contentTypeAssociatedFactories[key]!);
    });
  }

  static void _enableBackingStoreForSerializationRegistry(
      SerializationWriterFactoryRegistry registry) {
    final keysToUpdate = <String>[];
    registry.contentTypeAssociatedFactories.forEach((key, value) {
      {
        if (value is! BackingStoreSerializationWriterProxyFactory) {
          keysToUpdate.add(key);
        }
      }
    });

    keysToUpdate.forEach((key) {
      registry.contentTypeAssociatedFactories[key] =
          BackingStoreSerializationWriterProxyFactory(
              concrete: registry.contentTypeAssociatedFactories[key]!);
    });
  }
}
