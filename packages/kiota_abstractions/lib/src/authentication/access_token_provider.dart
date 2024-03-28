part of '../../kiota_abstractions.dart';

/// Defines a contract for obtaining an access token for a given url.
abstract class AccessTokenProvider {
  /// Gets an access token for the given url and additional authentication
  /// context.
  Future<String> getAuthorizationToken(
    Uri uri, [
    Map<String, Object>? additionalAuthenticationContext,
  ]);

  /// The [AllowedHostsValidator] to use when validating the host of the url.
  AllowedHostsValidator get allowedHostsValidator;
}
