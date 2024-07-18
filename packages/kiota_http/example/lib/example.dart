import 'dart:convert';
import 'dart:typed_data';

import 'package:kiota_abstractions/kiota_abstractions.dart';
import 'package:kiota_http/kiota_http.dart';

Future<void> main() async {
  // Setup
  ParseNodeFactoryRegistry
          .defaultInstance.contentTypeAssociatedFactories['application/json'] =
      _CatFactsParseNodeFactory();
  var client = KiotaClientFactory.createClient();
  var authProvider = AnonymousAuthenticationProvider();

  // Create the adapter
  var adapter = HttpClientRequestAdapter(
    client: client,
    authProvider: authProvider,
    pNodeFactory: ParseNodeFactoryRegistry.defaultInstance,
    sWriterFactory: SerializationWriterFactoryRegistry.defaultInstance,
  );

  // Send a request
  final response = await adapter.sendPrimitive<String>(RequestInformation(
    httpMethod: HttpMethod.get,
    urlTemplate: 'https://catfact.ninja/fact{?max_length}',
    pathParameters: {
      'max_length': 50,
    },
  ));

  print(response);
}

class _CatFactsParseNodeFactory implements ParseNodeFactory {
  @override
  ParseNode getRootParseNode(String contentType, Uint8List content) {
    final text = utf8.decode(content);
    final json = jsonDecode(text);

    return _CatFactsParseNode(json);
  }

  @override
  final validContentType = 'application/json';
}

class _CatFactsParseNode implements ParseNode {
  _CatFactsParseNode(this.json);

  final Map<String, dynamic> json;

  String? getStringValue() => json['fact'] as String?;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
