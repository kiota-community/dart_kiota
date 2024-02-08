part of dart_kiota;

/// Base class for all request builders.
abstract class BaseRequestBuilder {
  /// The path parameters of the request.
  Map<String, dynamic> pathParameters;

  /// The request adapter to use to execute the request.
  RequestAdapter requestAdapter;

  /// Url template to use to build the URL for the current request builder.
  String urlTemplate;

  BaseRequestBuilder(this.requestAdapter, this.urlTemplate, this.pathParameters);
}
