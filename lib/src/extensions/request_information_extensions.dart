part of '../../dart_kiota.dart';

extension RequestInformationExtensions on RequestInformation {
  /// Adds a request option to the request.
  void addRequestOption(RequestOption option) => addRequestOptions([option]);

  /// Removes a request option from the request.
  void removeRequestOption(RequestOption option) =>
      removeRequestOptions([option]);

  /// Vanity method to add headers to the request.
  void addHeaders(RequestHeaders headers) {
    headers.addAll(headers);
  }

  /// Adds a [ResponseHandler] as a [RequestOption] for the request.
  void setResponseHandler(ResponseHandler handler) {
    final option = ResponseHandlerOption()..responseHandler = handler;

    addRequestOption(option);
  }

  /// Sets the content of the request including the content type header.
  void setStreamContent(
    Stream<int> content, [
    String contentType = 'application/octet-stream',
  ]) {
    this.content = content;

    headers.tryAdd('Content-Type', contentType);
  }
}
