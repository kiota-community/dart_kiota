part of '../kiota_abstractions.dart';

/// Type definition for request callback.
typedef RequestCallback<T> = Future<T> Function(
  QueryParameters Function()?,
  HttpHeaders Function()?,
  Iterable<RequestOption>?,
  ResponseHandler,
);

/// Type definition for request callback with body.
typedef RequestWithBodyCallback<TBody, TResponse> = Future<TResponse> Function(
  TBody,
  QueryParameters Function()?,
  HttpHeaders Function()?,
  Iterable<RequestOption>?,
  ResponseHandler,
);

/// This class can be used to wrap a request using the fluent API and get the
/// native response object in return.
class NativeResponseWrapper {
  NativeResponseWrapper._();

  /// Makes a request with the given parameters and returns the native response
  /// object.
  static Future<NativeResponseType?>
      callAndGetNativeType<ModelType, NativeResponseType>(
    RequestCallback<ModelType> callback, [
    QueryParameters Function()? query,
    HttpHeaders Function()? headers,
    Iterable<RequestOption>? options,
  ]) async {
    final handler = NativeResponseHandler();

    // ignore result
    await callback(query, headers, options, handler);

    return handler.value as NativeResponseType?;
  }

  /// Makes a request with the given parameters and request body and then
  /// returns the native response object.
  static Future<NativeResponseType?>
      callAndGetNativeTypeWithBody<TBody, TResponse, NativeResponseType>(
    RequestWithBodyCallback<TBody, TResponse> callback,
    TBody body, [
    QueryParameters Function()? query,
    HttpHeaders Function()? headers,
    Iterable<RequestOption>? options,
  ]) async {
    final handler = NativeResponseHandler();

    // ignore result
    await callback(body, query, headers, options, handler);

    return handler.value as NativeResponseType?;
  }
}
