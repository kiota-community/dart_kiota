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

  final http.Client? _client;
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

  Future<http.BaseRequest> _getRequestFromInfo(
    RequestInformation requestInfo,
  ) async {
    final request = http.Request(requestInfo.httpMethod!.name, requestInfo.uri);

    return request;
  }

  @override
  Future<T?> convertToNativeRequest<T>(RequestInformation requestInfo) async {
    await _authProvider.authenticateRequest(requestInfo);

    final request = await _getRequestFromInfo(requestInfo);
    if (request is T) {
      return request as T;
    }

    throw ArgumentError(
      'The request could not be converted to the desired type',
    );
  }

  @override
  Future<ModelType?> send<ModelType extends Parsable>(
    RequestInformation requestInfo,
    ParsableFactory<ModelType> factory, [
    Map<String, Parsable Function(ParseNode)>? errorMapping,
  ]) {
    // TODO: implement send
    throw UnimplementedError();
  }

  @override
  Future<Iterable<ModelType>?> sendCollection<ModelType extends Parsable>(
    RequestInformation requestInfo,
    ParsableFactory<ModelType> factory, [
    Map<String, Parsable Function(ParseNode)>? errorMapping,
  ]) {
    // TODO: implement sendCollection
    throw UnimplementedError();
  }

  @override
  Future<void> sendNoContent(
    RequestInformation requestInfo, [
    Map<String, Parsable Function(ParseNode)>? errorMapping,
  ]) {
    // TODO: implement sendNoContent
    throw UnimplementedError();
  }

  @override
  Future<ModelType?> sendPrimitive<ModelType>(
    RequestInformation requestInfo, [
    Map<String, Parsable Function(ParseNode)>? errorMapping,
  ]) {
    // TODO: implement sendPrimitive
    throw UnimplementedError();
  }

  @override
  Future<Iterable<ModelType>?> sendPrimitiveCollection<ModelType>(
    RequestInformation requestInfo, [
    Map<String, Parsable Function(ParseNode)>? errorMapping,
  ]) {
    // TODO: implement sendPrimitiveCollection
    throw UnimplementedError();
  }

  @override
  SerializationWriterFactory get serializationWriterFactory => _sWriterFactory;
}
