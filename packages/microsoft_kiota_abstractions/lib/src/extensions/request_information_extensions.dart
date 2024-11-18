part of '../../microsoft_kiota_abstractions.dart';

/// Adds extension methods to the [RequestInformation] class.
extension RequestInformationExtensions on RequestInformation {
  static const contentTypeHeader = 'Content-Type';

  /// Adds a request option to the request.
  void addRequestOption(RequestOption option) => addRequestOptions([option]);

  /// Removes a request option from the request.
  void removeRequestOption(RequestOption option) =>
      removeRequestOptions([option]);

  /// Vanity method to add headers to the request.
  void addHeaders(HttpHeaders headers) {
    this.headers.addAll(headers);
  }

  /// Vanity method to add query parameters to the request.
  void addQueryParameters(Map<String, dynamic> parameters) {
    queryParameters.addAll(parameters);
  }

  /// Adds a [ResponseHandler] as a [RequestOption] for the request.
  void setResponseHandler(ResponseHandler handler) {
    final option = ResponseHandlerOption()..responseHandler = handler;

    addRequestOption(option);
  }

  /// Sets the content of the request to the provided stream by converting it to
  /// a list of bytes first.
  Future<void> setStreamContent(
    Stream<int> content, [
    String contentType = 'application/octet-stream',
  ]) async {
    final bytes = await content.toList();

    this.content = Uint8List.fromList(bytes);

    headers.putIfAbsent(contentTypeHeader, () => {contentType});
  }

  /// Sets the content of the request to the provided collection of parsable
  /// objects.
  void setContentFromParsableCollection<T extends Parsable>(
    RequestAdapter requestAdapter,
    String contentType,
    Iterable<T> items,
  ) {
    final writer = _getSerializationWriter(requestAdapter, contentType, items)
      ..writeCollectionOfObjectValues(null, items);

    headers.putIfAbsent(contentTypeHeader, () => {contentType});

    content = writer.getSerializedContent();
  }

  /// Sets the content of the request to the provided parsable object.
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

    headers.putIfAbsent(contentTypeHeader, () => {writtenContentType});

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

  /// Sets the content of the request to the provided collection of scalar
  /// values.
  void setContentFromScalarCollection<T>(
    RequestAdapter requestAdapter,
    String contentType,
    Iterable<T> items,
  ) {
    final writer = _getSerializationWriter(requestAdapter, contentType, items)
      ..writeCollectionOfPrimitiveValues(null, items);

    headers.putIfAbsent(contentTypeHeader, () => {contentType});

    content = writer.getSerializedContent();
  }

  /// Sets the content of the request to the provided scalar value.
  void setContentFromScalar<T>(
    RequestAdapter requestAdapter,
    String contentType,
    T item,
  ) {
    final writer = _getSerializationWriter(requestAdapter, contentType, item);

    switch (item) {
      case final String s:
        writer.writeStringValue(null, s);
      case final bool b:
        writer.writeBoolValue(null, value: b);
      case final int i:
        writer.writeIntValue(null, i);
      case final double d:
        writer.writeDoubleValue(null, d);
      case final DateTime t:
        writer.writeDateTimeValue(null, t);
      case null:
        writer.writeNullValue(null);
      default:
        throw UnsupportedError(
          'Unsupported scalar value type: ${item.runtimeType}',
        );
    }

    headers.putIfAbsent(contentTypeHeader, () => {contentType});

    content = writer.getSerializedContent();
  }

  void configure<T extends AbstractQueryParameters>(
    void Function(RequestConfiguration<T>)? configurator,
    T Function()? createParameters,
  ) {
    if (configurator == null || createParameters == null) {
      return;
    }

    final config =
        RequestConfiguration<T>(HttpHeaders(), [], createParameters());
    configurator(config);

    addQueryParameters(config.queryParameters.toMap());
    addHeaders(config.headers);
    addRequestOptions(config.options);
  }
}
