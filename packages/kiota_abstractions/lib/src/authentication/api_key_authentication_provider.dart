part of '../../kiota_abstractions.dart';

/// This authentication provider authenticates requests using an API key.
class ApiKeyAuthenticationProvider implements AuthenticationProvider {
  /// Creates a new instance of [ApiKeyAuthenticationProvider].
  ///
  /// The [apiKey] and [parameterName] arguments must not be empty.
  ApiKeyAuthenticationProvider({
    required String apiKey,
    required String parameterName,
    required ApiKeyLocation keyLocation,
    Iterable<String> allowedHosts = const [],
  })  : assert(apiKey.isNotEmpty, 'apiKey cannot be empty'),
        assert(parameterName.isNotEmpty, 'parameterName cannot be empty'),
        _apiKey = apiKey,
        _parameterName = parameterName,
        _keyLocation = keyLocation,
        _allowedHostsValidator = AllowedHostsValidator(allowedHosts);

  final String _apiKey;
  final String _parameterName;
  final ApiKeyLocation _keyLocation;
  final AllowedHostsValidator _allowedHostsValidator;

  @override
  Future<void> authenticateRequest(
    RequestInformation request, [
    Map<String, Object>? additionalAuthenticationContext,
  ]) {
    final uri = request.uri;
    if (!_allowedHostsValidator.isUrlHostValid(uri)) {
      return Future<void>.value();
    }

    if (!uri.isScheme('https')) {
      throw ArgumentError.value(
        request,
        'request',
        'Only HTTPS request URIs are supported.',
      );
    }

    switch (_keyLocation) {
      case ApiKeyLocation.queryParameter:
        final newUri = Uri(
          scheme: uri.scheme,
          userInfo: uri.userInfo,
          host: uri.host,
          port: uri.port,
          path: uri.path,
          fragment: uri.hasFragment ? uri.fragment : null,
          queryParameters: Map<String, String>.from(uri.queryParameters)
            ..addOrReplace(_parameterName, _apiKey),
        );

        request.uri = newUri;
      case ApiKeyLocation.header:
        request.headers.put(_parameterName, _apiKey);
      default:
        throw UnimplementedError(
          'The API key location $_keyLocation is not implemented.',
        );
    }

    return Future<void>.value();
  }
}
