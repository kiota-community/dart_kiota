part of '../kiota_abstractions.dart';

/// Base class for all request builders.
abstract class BaseRequestBuilder<T extends BaseRequestBuilder<T>> {
  BaseRequestBuilder(
    this.requestAdapter,
    this.urlTemplate,
    this.pathParameters,
  );

  /// The path parameters of the request.
  Map<String, dynamic> pathParameters;

  /// The request adapter to use to execute the request.
  RequestAdapter requestAdapter;

  /// Url template to use to build the URL for the current request builder.
  String urlTemplate;

  /// Returns the request builder with the provided URL.
  T withUrl(String rawUrl);
}
