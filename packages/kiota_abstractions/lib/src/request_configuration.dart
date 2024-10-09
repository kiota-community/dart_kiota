part of '../kiota_abstractions.dart';

/// Request configuration type for [BaseRequestBuilder]s.
class RequestConfiguration<T extends AbstractQueryParameters> {

  RequestConfiguration({required this.queryParameters});
  /// The HTTP headers of the request.
  HttpHeaders headers = HttpHeaders();

  /// The request options.
  List<RequestOption> options = [];

  T queryParameters;
}
