part of '../dart_kiota.dart';

/// This class represents an abstract HTTP request.
class RequestInformation {
  /// Creates a new instance of [RequestInformation].
  RequestInformation({
    this.httpMethod,
    this.urlTemplate,
    Map<String, dynamic>? pathParameters,
  })  : queryParameters = LinkedHashMap(
          equals: (a, b) => a.toUpperCase() == b.toUpperCase(),
          hashCode: (a) => a.toUpperCase().hashCode,
        ),
        pathParameters = LinkedHashMap(
          equals: (a, b) => a.toUpperCase() == b.toUpperCase(),
          hashCode: (a) => a.toUpperCase().hashCode,
        ) {
    if (pathParameters != null) {
      this.pathParameters.addAll(pathParameters);
    }
  }

  static const rawUrlKey = 'request-raw-url';

  /// The URL template for the current request.
  String? urlTemplate;

  /// The path parameters to use for the URL template when generating the URI.
  Map<String, dynamic> pathParameters;

  /// The HTTP [Method] of the request.
  Method? httpMethod;

  /// The query parameters to use for the URL when generating the URI.
  Map<String, dynamic> queryParameters;

  final RequestHeaders _headers = RequestHeaders();

  /// The request headers.
  RequestHeaders get headers => _headers;

  /// The request body.
  Stream<int> content = const Stream.empty();

  final Map<String, RequestOption> _requestOptions = {};

  /// The request options.
  Iterable<RequestOption> get requestOptions => _requestOptions.values;

  Uri? _rawUri;

  /// The URI of the request.
  Uri get uri {
    if (_rawUri != null) {
      return _rawUri!;
    }

    if (pathParameters.containsKey(rawUrlKey) &&
        pathParameters[rawUrlKey] is String) {
      uri = Uri.parse(pathParameters[rawUrlKey] as String);

      return _rawUri!;
    }

    if (urlTemplate == null) {
      throw ArgumentError('urlTemplate');
    }

    final url = urlTemplate!;
    if (url.contains('{+baseurl}') && !pathParameters.containsKey('baseurl')) {
      throw ArgumentError(
        'pathParameters must contain a value for "baseurl" for the url to be built.',
      );
    }

    final substitutions = <String, dynamic>{};
    for (final urlTemplateParameter in pathParameters.entries) {
      substitutions[urlTemplateParameter.key] =
          _getSanitizedValue(urlTemplateParameter.value);
    }

    for (final queryStringParameter in queryParameters.entries) {
      if (queryStringParameter.value != null) {
        substitutions[queryStringParameter.key] =
            _getSanitizedValue(queryStringParameter.value);
      }
    }

    return Uri.parse(StdUriTemplate.expand(url, substitutions));
  }

  /// Sets the URI of the request.
  set uri(Uri value) {
    queryParameters.clear();
    pathParameters.clear();
    _rawUri = value;
  }

  static dynamic _getSanitizedValue(dynamic value) {
    if (value is bool) {
      return value.toString().toLowerCase();
    }

    if (value is DateTime) {
      return value.toIso8601String();
    }

    if (value is Enum) {
      return value.name;
    }

    if (value is List) {
      return value.map(_getSanitizedValue).toList(growable: false);
    }

    if (value is Map) {
      return value.map(
        (k, v) => MapEntry(_getSanitizedValue(k), _getSanitizedValue(v)),
      );
    }

    return value;
  }

  /// Adds a collection of request options to the request.
  void addRequestOptions(Iterable<RequestOption> options) {
    for (final option in options) {
      _requestOptions.addOrReplace(option.runtimeType.toString(), option);
    }
  }

  /// Removes a collection of request options from the request.
  void removeRequestOptions(Iterable<RequestOption> options) {
    for (final option in options) {
      _requestOptions.remove(option.runtimeType.toString());
    }
  }
}
