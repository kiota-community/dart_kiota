part of '../../kiota_http.dart';

/// Defines a function that determines whether a request should be redirected
/// based on the [response].
typedef ShouldRedirectHandler = bool Function(
  http.StreamedResponse response,
);

/// Options for the [RedirectHandler].
class RedirectHandlerOption implements RequestOption {
  /// Creates a new instance of [RedirectHandlerOption].
  const RedirectHandlerOption({
    this.maxRedirects = 5,
    this.shouldRedirect = _defaultShouldRedirect,
    this.allowRedirectOnSchemeChange = false,
  })  : assert(
          maxRedirects >= 0,
          'maxRedirects must be greater than or equal to 0',
        ),
        assert(
          maxRedirects < 20,
          'maxRedirects must be less than 20',
        );

  /// The maximum number of redirects.
  final int maxRedirects;

  /// The function that determines whether a request should be redirected.
  final ShouldRedirectHandler shouldRedirect;

  /// Whether to allow redirects on scheme changes (e.g. from HTTPS to HTTP).
  final bool allowRedirectOnSchemeChange;

  static bool _defaultShouldRedirect(http.StreamedResponse response) {
    return [301, 302, 303, 307, 308].contains(response.statusCode);
  }
}
