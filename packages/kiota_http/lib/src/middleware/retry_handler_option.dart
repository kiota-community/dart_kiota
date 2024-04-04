part of '../../kiota_http.dart';

/// Defines a function that determines whether a request should be retried
/// based on the [delay] between retries, the [retryCount], and the previous
/// [response].
typedef ShouldRetryHandler = bool Function(
  Duration delay,
  int retryCount,
  http.StreamedResponse response,
);

/// Options for the [RetryHandler].
class RetryHandlerOption implements RequestOption {
  /// Creates a new instance of [RetryHandlerOption].
  ///
  /// The [maxRetries] must be greater than or equal to 0 and less than 10.
  /// The [retryDelay] must be greater than or equal to 0.
  /// The [shouldRetry] function can be used to customize the retry logic.
  /// The [retryStatusCodes] are the status codes that will trigger a retry.
  /// The default status codes are 408, 429, 500, 502, 503, and 504.
  RetryHandlerOption({
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 3),
    this.retriesTimeLimit = const Duration(seconds: 60),
    ShouldRetryHandler? shouldRetry,
    this.retryStatusCodes = const {
      408, // Request Timeout
      429, // Too Many Requests
      500, // Internal Server Error
      502, // Bad Gateway
      503, // Service Unavailable
      504, // Gateway Timeout
    },
  })  : assert(
          maxRetries >= 0,
          'maxRetries must be greater than or equal to 0',
        ),
        assert(
          maxRetries < 10,
          'maxRetries must be less than 10',
        ),
        assert(
          retryDelay.inSeconds >= 0,
          'retryDelay must be greater than or equal to 0',
        ),
        shouldRetry = shouldRetry ?? _defaultShouldRetry;

  /// The maximum number of retries.
  final int maxRetries;

  /// The delay between retries.
  final Duration retryDelay;

  /// The time limit for all retries.
  final Duration retriesTimeLimit;

  /// The function that determines whether a request should be retried.
  final ShouldRetryHandler shouldRetry;

  /// The status codes that will trigger a retry.
  final Set<int> retryStatusCodes;

  static bool _defaultShouldRetry(
    Duration delay,
    int retryCount,
    http.StreamedResponse response,
  ) {
    return true;
  }
}
