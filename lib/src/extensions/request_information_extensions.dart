part of '../../kiota_abstractions.dart';

extension RequestInformationExtensions on RequestInformation {
  static const contentTypeHeader = 'Content-Type';

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
  Future<void> setStreamContent(
    Stream<int> content, [
    String contentType = 'application/octet-stream',
  ]) async {
    final bytes = await content.toList();

    this.content = Uint8List.fromList(bytes);

    headers.tryAdd(contentTypeHeader, contentType);
  }

  void setContentFromParsableCollection<T extends Parsable>(
    RequestAdapter requestAdapter,
    String contentType,
    Iterable<T> items,
  ) {
    final writer = _getSerializationWriter(requestAdapter, contentType, items)
      ..writeCollectionOfObjectValues(null, items);

    headers.tryAdd(contentTypeHeader, contentType);

    content = writer.getSerializedContent();
  }

  void setContentFromParsable<T extends Parsable>(
    RequestAdapter requestAdapter,
    String contentType,
    T item,
  ) {
    final writer = _getSerializationWriter(requestAdapter, contentType, item);

    var writtenContentType = contentType;
    if (item is MultipartBody) {
      writtenContentType += '; boundary=${item.boundary}';
      item.requestAdapter = requestAdapter;
    }

    writer.writeObjectValue(null, item);

    headers.tryAdd(contentTypeHeader, writtenContentType);

    content = writer.getSerializedContent();
  }

  SerializationWriter _getSerializationWriter<T>(
    RequestAdapter adapter,
    String contentType,
    T item,
  ) {
    if (contentType.isEmpty) {
      throw ArgumentError('Content type cannot be empty');
    }

    return adapter.serializationWriterFactory
        .getSerializationWriter(contentType);
  }

  void setContentFromScalarCollection<T>(
    RequestAdapter requestAdapter,
    String contentType,
    Iterable<T> items,
  ) {
    final writer = _getSerializationWriter(requestAdapter, contentType, items)
      ..writeCollectionOfPrimitiveValues(null, items);

    headers.tryAdd(contentTypeHeader, contentType);

    content = writer.getSerializedContent();
  }

  void setContentFromScalar<T>(
    RequestAdapter requestAdapter,
    String contentType,
    T item,
  ) {
    final writer = _getSerializationWriter(requestAdapter, contentType, item);

    switch (item) {
      case final String string:
        writer.writeStringValue(null, string);
      case final bool bool:
        writer.writeBoolValue(null, value: bool);
      case final int int:
        writer.writeIntValue(null, int);
      case final double double:
        writer.writeDoubleValue(null, double);
      case final DateTime dateTime:
        writer.writeDateTimeValue(null, dateTime);
      case null:
        writer.writeNullValue(null);
      default:
        throw UnsupportedError(
            'Unsupported scalar value type: ${item.runtimeType}');
    }

    headers.tryAdd(contentTypeHeader, contentType);

    content = writer.getSerializedContent();
  }
}
