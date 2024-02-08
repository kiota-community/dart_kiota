part of '../kiota_abstractions.dart';

/// Defines the [RequestOption] for holding a [ResponseHandler].
class ResponseHandlerOption implements RequestOption {
  /// The [ResponseHandler] to use for a request.
  ResponseHandler? responseHandler;
}
