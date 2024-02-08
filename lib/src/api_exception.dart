part of '../dart_kiota.dart';

class ApiException implements Exception {
  ApiException({
    this.statusCode,
    this.message,
    this.responseHeaders,
  });

  final int? statusCode;
  final String? message;
  final Map<String, List<String>>? responseHeaders;

  @override
  String toString() {
    return 'ApiException{statusCode: $statusCode, message: $message, headers: $responseHeaders}';
  }
}
