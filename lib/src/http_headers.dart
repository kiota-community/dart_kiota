part of '../kiota_abstractions.dart';

/// Represents the headers of a request.
///
/// Internally, the keys are stored in lower case, but the original case is
/// preserved when iterating over the headers.
/// This effectively makes the keys case-insensitive.
class HttpHeaders extends CaseInsensitiveMap<String, Set<String>> {
  /// Creates a new instance of [HttpHeaders].
  HttpHeaders();

  static const List<String> singleValueHeaders = [
    'content-type',
    'content-encoding',
    'content-length',
  ];

  @override
  void operator []=(String key, Set<String> value) {
    final lowerCaseKey = key.toLowerCase();

    final Set<String> normalizedValue;
    if (singleValueHeaders.contains(lowerCaseKey)) {
      normalizedValue = {value.first};
    } else {
      normalizedValue = value;
    }

    super[key] = normalizedValue;
  }

  /// Sets the value of the header with the given [key] to a Set containing only
  /// [value].
  void put(String key, String value) {
    this[key] = {value};
  }
}
