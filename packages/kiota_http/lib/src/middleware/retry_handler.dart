part of '../../kiota_http.dart';

class RetryHandler extends http.BaseClient {
  RetryHandler(
    this._inner, [
    RetryHandlerOption? option,
  ]) : _option = option ?? RetryHandlerOption();

  static const retryAfter = 'Retry-After';
  static const retryAttempt = 'Retry-Attempt';

  final http.Client _inner;
  final RetryHandlerOption _option;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = await _inner.send(request);

    if (_shouldRetry(response, 0)) {
      return _retry(request, response);
    }

    return response;
  }

  Future<http.StreamedResponse> _retry(
    http.BaseRequest request,
    http.StreamedResponse previousResponse,
  ) async {
    var retryCount = 0;
    var cumulativeDelay = Duration.zero;
    final exceptions = <ApiException>[];

    var response = previousResponse;
    while (retryCount < _option.maxRetries) {
      exceptions.add(_getException(response));

      final delay = _calculateDelay(response, retryCount);

      // check if the cumulative delay exceeds the time limit
      if (_option.retriesTimeLimit > Duration.zero &&
          cumulativeDelay + delay > _option.retriesTimeLimit) {
        return response;
      }

      cumulativeDelay += delay;

      await Future<void>.delayed(delay);

      final clonedRequest = _cloneRequest(response);
      if (clonedRequest == null) {
        // can't clone the request, so we can't retry
        return response;
      }

      retryCount++;

      clonedRequest.headers[retryAttempt] = retryCount.toString();

      response = await _inner.send(clonedRequest);

      if (!_shouldRetry(response, retryCount)) {
        return response;
      }
    }

    exceptions.add(_getException(previousResponse));

    throw ApiException(
      message: 'HTTP request failed after $retryCount retries',
      innerExceptions: exceptions,
    );
  }

  bool _shouldRetry(http.StreamedResponse response, int retryCount) {
    if (_option.maxRetries <= 0) {
      return false;
    }

    if (!_option.retryStatusCodes.contains(response.statusCode)) {
      return false;
    }

    return _option.shouldRetry(
      _option.retryDelay,
      retryCount,
      response,
    );
  }

  ApiException _getException(http.StreamedResponse response) {
    final message =
        'HTTP request failed with status code ${response.statusCode}';
    final headers = response.headers.map(
      (key, value) => MapEntry(
        key,
        [value],
      ),
    );

    return ApiException(
      statusCode: response.statusCode,
      message: message,
      responseHeaders: headers,
    );
  }

  Duration _calculateDelay(http.StreamedResponse response, int retryCount) {
    final retryAfterHeader = response.headers[retryAfter];
    final retryAfterDelay = retryAfterHeader != null
        ? Duration(seconds: int.tryParse(retryAfterHeader) ?? 0)
        : null;

    if (retryAfterDelay != null) {
      return retryAfterDelay;
    }

    // Exponential backoff
    final secondsDelay = pow(2, retryCount) * _option.retryDelay.inSeconds;

    return Duration(seconds: secondsDelay.round());
  }

  http.BaseRequest? _cloneRequest(http.StreamedResponse response) {
    final originalRequest = response.request;
    if (originalRequest == null) {
      return null;
    }

    http.BaseRequest clonedRequest;
    if (originalRequest is http.Request) {
      clonedRequest = http.Request(
        originalRequest.method,
        originalRequest.url,
      )..bodyBytes = originalRequest.bodyBytes;
    } else if (originalRequest is http.MultipartRequest) {
      clonedRequest = http.MultipartRequest(
        originalRequest.method,
        originalRequest.url,
      )
        ..fields.addAll(originalRequest.fields)
        ..files.addAll(originalRequest.files);
    } else {
      return null;
    }

    return clonedRequest
      ..followRedirects = originalRequest.followRedirects
      ..maxRedirects = originalRequest.maxRedirects
      ..contentLength = originalRequest.contentLength
      ..persistentConnection = originalRequest.persistentConnection
      ..headers.addAll(originalRequest.headers);
  }
}
