part of '../kiota_http.dart';

class HttpClientRequestAdapter implements RequestAdapter {
  HttpClientRequestAdapter({
    required http.Client client,
    required AuthenticationProvider authProvider,
    required ParseNodeFactory pNodeFactory,
    required SerializationWriterFactory sWriterFactory,
  })  : _client = client,
        _authProvider = authProvider,
        _pNodeFactory = pNodeFactory,
        _sWriterFactory = sWriterFactory;

  static const String _claimsKey = 'claims';

  final http.Client _client;
  final AuthenticationProvider _authProvider;
  ParseNodeFactory _pNodeFactory;
  SerializationWriterFactory _sWriterFactory;
  String? _baseUrl;

  @override
  String? get baseUrl => _baseUrl;

  @override
  set baseUrl(String? value) {
    if (value?.endsWith('/') ?? false) {
      _baseUrl = value?.substring(0, value.length - 1);
    } else {
      _baseUrl = value;
    }
  }

  Future<http.BaseRequest> _getMessageFromInfo(
    RequestInformation requestInfo,
  ) async {
    final request = http.Request(
      requestInfo.httpMethod!.value,
      requestInfo.uri,
    );

    if (requestInfo.headers.isNotEmpty) {
      final flattenedHeaders = requestInfo.headers.map((name, values) {
        // according to https://stackoverflow.com/a/3097052/5107884 it is
        // possible to concatenate multiple header values for the same name with
        // a comma
        return MapEntry(name, values.join(', '));
      });

      request.headers.addAll(flattenedHeaders);
    }

    if (requestInfo.content case final Uint8List content) {
      request.bodyBytes = content;
    }

    return request;
  }

  Future<http.StreamedResponse> _getResponse(
    RequestInformation requestInfo, [
    String? claims,
  ]) async {
    _setBaseUrl(requestInfo);

    Map<String, Object>? additionalAuthContext;
    if (claims != null) {
      additionalAuthContext = {_claimsKey: claims};
    }

    await _authProvider.authenticateRequest(requestInfo, additionalAuthContext);

    final message = await _getMessageFromInfo(requestInfo);

    return _client.send(message);
  }

  void _setBaseUrl(RequestInformation requestInfo) {
    requestInfo.pathParameters['baseUrl'] = baseUrl;
  }

  ResponseHandler? _getResponseHandler(RequestInformation requestInfo) {
    final option = requestInfo.getRequestOption<ResponseHandlerOption>();

    return option?.responseHandler;
  }

  Future<void> _throwIfFailedResponse(
    http.StreamedResponse response,
    ErrorMappings? errorMapping,
  ) async {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }

    final statusCodeInt = response.statusCode;
    final statusCodeString = response.statusCode.toString();
    final headers = response.headersSplitValues;

    final ParsableFactory? errorFactory;
    if (errorMapping == null) {
      errorFactory = null;
    } else if (errorMapping.containsKey(statusCodeString)) {
      errorFactory = errorMapping[statusCodeString];
    } else if (statusCodeInt >= 400 &&
        statusCodeInt < 500 &&
        errorMapping.containsKey('4XX')) {
      errorFactory = errorMapping['4XX'];
    } else if (statusCodeInt >= 500 &&
        statusCodeInt < 600 &&
        errorMapping.containsKey('5XX')) {
      errorFactory = errorMapping['5XX'];
    } else {
      errorFactory = errorMapping['XXX'];
    }

    if (errorFactory == null) {
      throw ApiException(
        statusCode: statusCodeInt,
        message:
            'The server returned an unexpected status code and no error factory is registered for this code: $statusCodeString',
        responseHeaders: headers,
      );
    }

    final rootNode = await _getRootParseNode(response);
    final result = rootNode?.getObjectValue(errorFactory);

    if (result case Exception exception) {
      if (exception case final ApiException apiException) {
        exception = apiException.copyWith(
          statusCode: statusCodeInt,
          responseHeaders: headers,
        );
      }

      throw exception;
    }

    throw ApiException(
      statusCode: statusCodeInt,
      message:
          'The server returned an unexpected status code and the error registered for this code failed to deserialize: $statusCodeString',
      responseHeaders: headers,
    );
  }

  bool _shouldReturnNull(http.StreamedResponse response) {
    return response.statusCode == 204 || response.contentLength == 0;
  }

  Future<ParseNode?> _getRootParseNode(http.StreamedResponse response) async {
    final responseContentType = response.headers['content-type'];
    if (responseContentType == null || responseContentType.isEmpty) {
      return null;
    }

    final content = await response.stream.toBytes();

    return _pNodeFactory.getRootParseNode(responseContentType, content);
  }

  @override
  Future<T?> convertToNativeRequest<T>(RequestInformation requestInfo) async {
    await _authProvider.authenticateRequest(requestInfo);

    final request = await _getMessageFromInfo(requestInfo);
    if (request is T) {
      return request as T;
    }

    throw ArgumentError(
      'The request could not be converted to the desired type $T',
    );
  }

  Future<ParseNode?> _sendRequestAndHandleResponse(
    RequestInformation requestInfo,
    ErrorMappings? errorMapping,
  ) async {
    final response = await _getResponse(requestInfo);

    final handler = _getResponseHandler(requestInfo);
    if (handler != null) {
      return handler.handleResponse(response, errorMapping);
    }

    await _throwIfFailedResponse(response, errorMapping);

    if (_shouldReturnNull(response)) {
      return null;
    }

    return _getRootParseNode(response);
  }

  @override
  Future<ModelType?> send<ModelType extends Parsable>(
    RequestInformation requestInfo,
    ParsableFactory<ModelType> factory, [
    ErrorMappings? errorMapping,
  ]) async {
    final rootNode =
        await _sendRequestAndHandleResponse(requestInfo, errorMapping);

    return rootNode?.getObjectValue<ModelType>(factory);
  }

  @override
  Future<Iterable<ModelType>?> sendCollection<ModelType extends Parsable>(
    RequestInformation requestInfo,
    ParsableFactory<ModelType> factory, [
    ErrorMappings? errorMapping,
  ]) async {
    final rootNode =
        await _sendRequestAndHandleResponse(requestInfo, errorMapping);

    return rootNode?.getCollectionOfObjectValues<ModelType>(factory);
  }

  @override
  Future<void> sendNoContent(
    RequestInformation requestInfo, [
    ErrorMappings? errorMapping,
  ]) async {
    final response = await _getResponse(requestInfo);

    final handler = _getResponseHandler(requestInfo);
    if (handler != null) {
      await handler.handleResponse(response, errorMapping);

      return;
    }

    await _throwIfFailedResponse(response, errorMapping);
  }

  @override
  Future<ModelType?> sendPrimitive<ModelType>(
    RequestInformation requestInfo, [
    ErrorMappings? errorMapping,
  ]) async {
    final rootNode =
        await _sendRequestAndHandleResponse(requestInfo, errorMapping);

    if (rootNode == null) {
      return null;
    }

    switch (ModelType) {
      case const (bool):
        return rootNode.getBoolValue() as ModelType;
      case const (int):
        return rootNode.getIntValue() as ModelType;
      case const (double):
        return rootNode.getDoubleValue() as ModelType;
      case const (String):
        return rootNode.getStringValue() as ModelType;
      case const (DateTime):
        return rootNode.getDateTimeValue() as ModelType;
      case const (DateOnly):
        return rootNode.getDateOnlyValue() as ModelType;
      case const (TimeOnly):
        return rootNode.getTimeOnlyValue() as ModelType;
      case const (Duration):
        return rootNode.getDurationValue() as ModelType;
      case const (UuidValue):
        return rootNode.getGuidValue() as ModelType;
      default:
        throw ArgumentError(
          'The type $ModelType is not supported for primitive deserialization',
        );
    }
  }

  @override
  Future<Iterable<ModelType>?> sendPrimitiveCollection<ModelType>(
    RequestInformation requestInfo, [
    ErrorMappings? errorMapping,
  ]) async {
    final rootNode =
        await _sendRequestAndHandleResponse(requestInfo, errorMapping);

    return rootNode?.getCollectionOfPrimitiveValues<ModelType>();
  }

  @override
  SerializationWriterFactory get serializationWriterFactory => _sWriterFactory;
}
