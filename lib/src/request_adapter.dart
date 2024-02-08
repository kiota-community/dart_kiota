part of '../dart_kiota.dart';

/// Service responsible for translating abstract [RequestInformation] into
/// concrete native HTTP requests.
abstract class RequestAdapter {
  /// Enables the backing store proxies for the [SerializationWriter]s and
  /// [ParseNode]s in use.
  void enableBackingStore(BackingStoreFactory backingStoreFactory);

  /// Gets the [SerializationWriterFactory] currently in use for the HTTP core
  /// service.
  SerializationWriterFactory get serializationWriterFactory;

  /// Executes the HTTP request specified by the given [RequestInformation] and
  /// returns the deserialized response model.
  ///
  /// The [factory] is used to deserialize the response model.
  /// The error factories [errorMapping] is used in case of a failed request.
  Future<ModelType?> send<ModelType extends Parsable>(
    RequestInformation requestInfo,
    ParsableFactory<ModelType> factory, [
    Map<String, ParsableFactory<Parsable>>? errorMapping,
  ]);

  /// Executes the HTTP request specified by the given [RequestInformation] and
  /// returns the deserialized response model collection.
  ///
  /// The [factory] is used to deserialize the response models.
  /// The error factories [errorMapping] is used in case of a failed request.
  Future<Iterable<ModelType>?> sendCollection<ModelType extends Parsable>(
    RequestInformation requestInfo,
    ParsableFactory<ModelType> factory, [
    Map<String, ParsableFactory<Parsable>>? errorMapping,
  ]);

  /// Executes the HTTP request specified by the given [RequestInformation] and
  /// returns the deserialized primitive response model.
  ///
  /// The error factories [errorMapping] is used in case of a failed request.
  Future<ModelType?> sendPrimitive<ModelType>(
    RequestInformation requestInfo, [
    Map<String, ParsableFactory<Parsable>>? errorMapping,
  ]);

  /// Executes the HTTP request specified by the given [RequestInformation] and
  /// returns the deserialized primitive response model collection.
  ///
  /// The error factories [errorMapping] is used in case of a failed request.
  Future<Iterable<ModelType>?> sendPrimitiveCollection<ModelType>(
    RequestInformation requestInfo, [
    Map<String, ParsableFactory<Parsable>>? errorMapping,
  ]);

  /// Executes the HTTP request specified by the given [RequestInformation] with
  /// no return content.
  Future<void> sendNoContent(
    RequestInformation requestInfo, [
    Map<String, ParsableFactory<Parsable>>? errorMapping,
  ]);

  /// The base URL for every HTTP request.
  String? baseUrl;

  /// Converts the given [RequestInformation] into a native HTTP request used by
  /// the implementing adapter.
  /// [T] is the type of the native request.
  Future<T?> convertToNativeRequest<T>(RequestInformation requestInfo);
}
