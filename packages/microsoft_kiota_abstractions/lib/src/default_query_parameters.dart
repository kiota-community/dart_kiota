part of '../microsoft_kiota_abstractions.dart';

/// Type definition for query parameters.
class DefaultQueryParameters extends AbstractQueryParameters {
  Map<String, dynamic> queryParameters = {};

  @override
  Map<String, dynamic> toMap() {
    return queryParameters;
  }
}
