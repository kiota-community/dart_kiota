part of dart_kiota;

abstract class ResponseHandler {
  /// Callback method that is invoked when a response is received.
  /// The [response] is the native response object.
  /// The [errorMapping]s are used for the response when deserializing failed
  /// responses bodies. Where an error code like 401 applies specifically to
  /// that status code, a class code like 4XX applies to all status codes within
  /// the range if an the specific error code is not present.
  Future<ModelType?>
      handleResponse<NativeResponseType, ModelType extends Parsable>(
    NativeResponseType response, [
    Map<String, ParsableFactory<Parsable>>? errorMapping,
  ]);
}
