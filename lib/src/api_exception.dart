part of '../dart_kiota.dart';

/// Parent type for exceptions thrown by the client when receiving failed
/// responses to its requests.
class ApiException implements Exception {
  /// Creates an instance of [ApiException] with the given parameters.
  ApiException({
    this.statusCode,
    this.message,
    this.responseHeaders,
  });

  /// The HTTP status code of the response.
  final int? statusCode;

  /// An optional message that describes the error.
  final String? message;

  /// The headers of the response.
  final Map<String, List<String>>? responseHeaders;

  @override
  String toString() {
    return 'ApiException{statusCode: $statusCode, message: $message, headers: $responseHeaders}';
  }
}
