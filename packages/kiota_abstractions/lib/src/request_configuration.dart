part of '../kiota_abstractions.dart';

/// Request configuration type for [BaseRequestBuilder]s.
class RequestConfiguration<T extends AbstractQueryParameters> {

  const RequestConfiguration(this.headers, this.options, {required this.queryParameters});
  /// The HTTP headers of the request.
  final HttpHeaders headers;

  /// The request options.
  final List<RequestOption> options;

  final T queryParameters;
}
