part of '../kiota_abstractions.dart';

/// Parent type for exceptions thrown by the client when receiving failed
/// responses to its requests.
class ApiException implements Exception {
  /// Creates an instance of [ApiException] with the given parameters.
  ApiException({
    this.statusCode,
    this.message,
    this.responseHeaders,
    this.innerExceptions,
  });

  /// The HTTP status code of the response.
  final int? statusCode;

  /// An optional message that describes the error.
  final String? message;

  /// The headers of the response.
  final Map<String, List<String>>? responseHeaders;

  /// The inner exceptions that caused this exception.
  final Iterable<Object?>? innerExceptions;

  @override
  String toString() {
    return 'ApiException{statusCode: $statusCode, message: $message, headers: $responseHeaders, innerExceptions: $innerExceptions}';
  }

  /// Creates a new instance of [ApiException] with the given parameters.
  ApiException copyWith({
    int? statusCode,
    String? message,
    Map<String, List<String>>? responseHeaders,
    Iterable<Object?>? innerExceptions,
  }) {
    return ApiException(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      responseHeaders: responseHeaders ?? this.responseHeaders,
      innerExceptions: innerExceptions ?? this.innerExceptions,
    );
  }
}
