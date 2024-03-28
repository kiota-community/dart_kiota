part of '../../kiota_abstractions.dart';

/// Provides a base class for implementing [AuthenticationProvider] for Bearer
/// token schemes.
class BaseBearerTokenAuthenticationProvider implements AuthenticationProvider {
  BaseBearerTokenAuthenticationProvider(this.accessTokenProvider);

  static const _authorizationHeaderKey = 'Authorization';
  static const _claimsKey = 'claims';

  /// The [AccessTokenProvider] to use for getting the access token.
  final AccessTokenProvider accessTokenProvider;

  @override
  Future<void> authenticateRequest(
    RequestInformation request, [
    Map<String, Object>? additionalAuthenticationContext,
  ]) async {
    if (additionalAuthenticationContext != null &&
        additionalAuthenticationContext.containsKey(_claimsKey) &&
        request.headers.containsKey(_authorizationHeaderKey)) {
      request.headers.remove(_authorizationHeaderKey);
    }

    if (request.headers.containsKey(_authorizationHeaderKey)) {
      return;
    }

    final token = await accessTokenProvider.getAuthorizationToken(
      request.uri,
      additionalAuthenticationContext,
    );

    if (token.isEmpty) {
      return;
    }

    request.headers.put(_authorizationHeaderKey, 'Bearer $token');
  }
}
