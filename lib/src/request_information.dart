part of dart_kiota;

/// This class represents an abstract HTTP request.
class RequestInformation {
  /// The URL template for the current request.
  String? urlTemplate;

  /// The path parameters to use for the URL template when generating the URI.
  /// TODO: the keys are case-sensitive. They should be case-insensitive.
  Map<String, dynamic> pathParameters = {};

  /// The HTTP [Method] of the request.
  Method? httpMethod;

  /// The query parameters to use for the URL when generating the URI.
  /// TODO: the keys are case-sensitive. They should be case-insensitive.
  Map<String, dynamic> queryParameters = {};

  RequestInformation({
    this.httpMethod,
  });
}
