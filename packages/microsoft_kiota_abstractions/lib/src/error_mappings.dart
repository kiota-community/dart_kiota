part of '../microsoft_kiota_abstractions.dart';

/// The [ErrorMappings] are used for the response when deserializing failed
/// responses bodies. Where an error code like 401 applies specifically to
/// that status code, a class code like 4XX applies to all status codes within
/// the range if an the specific error code is not present.
typedef ErrorMappings = Map<String, ParsableFactory<Parsable>>;
