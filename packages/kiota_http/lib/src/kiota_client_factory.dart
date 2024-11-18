part of '../kiota_http.dart';

class KiotaClientFactory {
  KiotaClientFactory._();

  static http.Client createClient() {
    return retry.RetryClient(
      http.Client(),
      when: (response) {
        const retryCodes = {
          408, // Request Timeout
          429, // Too Many Requests
          500, // Internal Server Error
          502, // Bad Gateway
          503, // Service Unavailable
          504, // Gateway Timeout
        };

        return retryCodes.contains(response.statusCode);
      },
    );
  }
}
