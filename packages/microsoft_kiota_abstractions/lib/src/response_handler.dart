part of '../microsoft_kiota_abstractions.dart';

// ignore: one_member_abstracts
/// Defines the contract for a response handler.
abstract class ResponseHandler {
  /// Callback method that is invoked when a response is received.
  ///
  /// The [response] is the native response object.
  Future<ModelType?>
      handleResponse<NativeResponseType, ModelType extends Parsable>(
    NativeResponseType response, [
    ErrorMappings? errorMapping,
  ]);
}
