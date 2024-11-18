part of '../../microsoft_kiota_http.dart';

class UserAgentClient extends http.BaseClient {
  UserAgentClient(
    this._inner, {
    required this.userAgent,
  });

  final http.Client _inner;
  final String userAgent;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['User-Agent'] = userAgent;

    return _inner.send(request);
  }
}
