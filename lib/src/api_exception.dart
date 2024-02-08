part of dart_kiota;

class ApiException implements Exception {
  final int? statusCode;
  final String? message;
  final Map<String, List<String>>? responseHeaders;

  ApiException({
    this.statusCode,
    this.message,
    this.responseHeaders,
  });

  @override
  String toString() {
    return 'ApiException{statusCode: $statusCode, message: $message, headers: $responseHeaders}';
  }
}
