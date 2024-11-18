part of '../microsoft_kiota_abstractions.dart';

/// Default response handler to access the native response object.
class NativeResponseHandler implements ResponseHandler {
  /// The native response object as returned by the core service.
  Object? value;

  /// The error mappings for the response to use when deserializing failed
  /// response bodies.
  ///
  /// See [ErrorMappings] for more information.
  ErrorMappings? errorMappings;

  @override
  Future<ModelType?>
      handleResponse<NativeResponseType, ModelType extends Parsable>(
    NativeResponseType response, [
    ErrorMappings? errorMapping,
  ]) {
    errorMappings = errorMapping;
    value = response;

    return Future<ModelType?>.value();
  }
}
