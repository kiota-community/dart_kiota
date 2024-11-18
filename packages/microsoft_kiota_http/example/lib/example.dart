// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:typed_data';

import 'package:microsoft_kiota_abstractions/microsoft_kiota_abstractions.dart';
import 'package:microsoft_kiota_http/microsoft_kiota_http.dart';

Future<void> main() async {
  // Setup
  ParseNodeFactoryRegistry
          .defaultInstance.contentTypeAssociatedFactories['application/json'] =
      _CatFactsParseNodeFactory();
  final client = KiotaClientFactory.createClient();
  final authProvider = AnonymousAuthenticationProvider();

  // Create the adapter
  final adapter = HttpClientRequestAdapter(
    client: client,
    authProvider: authProvider,
    pNodeFactory: ParseNodeFactoryRegistry.defaultInstance,
    sWriterFactory: SerializationWriterFactoryRegistry.defaultInstance,
  );

  // Send a request
  final response = await adapter.sendPrimitive<String>(
    RequestInformation(
      httpMethod: HttpMethod.get,
      urlTemplate: 'https://catfact.ninja/fact{?max_length}',
      pathParameters: {
        'max_length': 50,
      },
    ),
  );

  print(response);
}

class _CatFactsParseNodeFactory implements ParseNodeFactory {
  @override
  ParseNode getRootParseNode(String contentType, Uint8List content) {
    final text = utf8.decode(content);
    final json = jsonDecode(text) as Map<String, dynamic>;

    return _CatFactsParseNode(json);
  }

  @override
  final validContentType = 'application/json';
}

class _CatFactsParseNode implements ParseNode {
  _CatFactsParseNode(this.json);

  final Map<String, dynamic> json;

  @override
  String? getStringValue() => json['fact'] as String?;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
