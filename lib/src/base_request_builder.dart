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

  /// Clones the current request builder.
  T clone();

  /// Clones the current request builder using [clone] and applies the provided
  /// parameters.
  T copyWith({
    RequestAdapter? requestAdapter,
    String? urlTemplate,
    Map<String, dynamic>? pathParameters,
  }) {
    final clone = this.clone();

    if (requestAdapter != null) {
      clone.requestAdapter = requestAdapter;
    }

    if (urlTemplate != null) {
      clone.urlTemplate = urlTemplate;
    }

    if (pathParameters != null) {
      clone.pathParameters = pathParameters;
    }

    return clone;
  }
}
