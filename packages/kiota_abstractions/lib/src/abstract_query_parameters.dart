part of '../kiota_abstractions.dart';

/// Type definition for query parameters.
abstract class AbstractQueryParameters {
  ///Return a map representation of the query parameters for the request
  Map<String, dynamic> toMap();
}
