part of '../kiota_abstractions.dart';

/// Request configuration type for [BaseRequestBuilder]s.
class RequestConfiguration<T extends AbstractQueryParameters> {
  /// The HTTP headers of the request.
  HttpHeaders headers = HttpHeaders();

  /// The request options.
  List<RequestOption> options = [];

  /// The request query parameters.
 late T queryParameters;
}
