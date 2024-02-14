part of '../../kiota_abstractions.dart';

/// Authenticates the application request.
abstract class AuthenticationProvider {
  /// Authenticates the give [request] with the given
  /// [additionalAuthenticationContext].
  Future<void> authenticateRequest(
    RequestInformation request, [
    Map<String, Object>? additionalAuthenticationContext,
  ]);
}
