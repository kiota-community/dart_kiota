part of '../../kiota_http.dart';

class RedirectHandler extends http.BaseClient {
  RedirectHandler(
    this._inner, [
    this._option = const RedirectHandlerOption(),
  ]);

  final http.Client _inner;
  final RedirectHandlerOption _option;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    // TODO: implement send
    throw UnimplementedError();
  }
}
