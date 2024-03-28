import 'package:kiota_abstractions/kiota_abstractions.dart';
import 'package:test/test.dart';

void main() {
  group('ApiKeyAuthenticationProvider', () {
    test('Checks that the apiKey is not empty', () {
      expect(
        () => ApiKeyAuthenticationProvider(
          apiKey: '',
          parameterName: 'name',
          keyLocation: ApiKeyLocation.header,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('Checks that the parameterName is not empty', () {
      expect(
        () => ApiKeyAuthenticationProvider(
          apiKey: 'key',
          parameterName: '',
          keyLocation: ApiKeyLocation.header,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('Appends parameter to an existing query', () async {
      final provider = ApiKeyAuthenticationProvider(
        apiKey: 'apiKey',
        parameterName: 'parameterName',
        keyLocation: ApiKeyLocation.queryParameter,
      );

      final request = RequestInformation(
        urlTemplate:
            'https://user:pass@example.test:5000/account/me?format=json#test',
      );

      await provider.authenticateRequest(request);

      expect(
        request.uri.toString(),
        equals(
          'https://user:pass@example.test:5000/account/me?format=json&parameterName=apiKey#test',
        ),
      );
    });

    test('Overwrites existing query parameter', () async {
      final provider = ApiKeyAuthenticationProvider(
        apiKey: 'apiKey',
        parameterName: 'parameterName',
        keyLocation: ApiKeyLocation.queryParameter,
      );

      final request = RequestInformation(
        urlTemplate: 'https://example.test/resource?parameterName=foo',
      );

      await provider.authenticateRequest(request);

      expect(
        request.uri.toString(),
        equals('https://example.test/resource?parameterName=apiKey'),
      );
    });

    test('Adds header', () async {
      final provider = ApiKeyAuthenticationProvider(
        apiKey: 'apiKey',
        parameterName: 'parameterName',
        keyLocation: ApiKeyLocation.header,
      );

      final request = RequestInformation(
        urlTemplate: 'https://example.test/resource',
      );

      await provider.authenticateRequest(request);

      expect(request.headers['parameterName'], equals({'apiKey'}));
    });

    test('Overwrites existing header', () async {
      final provider = ApiKeyAuthenticationProvider(
        apiKey: 'apiKey',
        parameterName: 'parameterName',
        keyLocation: ApiKeyLocation.header,
      );

      final request = RequestInformation(
        urlTemplate: 'https://example.test/resource',
      );

      request.headers.put('parameterName', 'foo');

      await provider.authenticateRequest(request);

      expect(request.headers['parameterName'], equals({'apiKey'}));
    });

    test('Does not authenticate for invalid host', () async {
      final provider = ApiKeyAuthenticationProvider(
        apiKey: 'apiKey',
        parameterName: 'parameterName',
        keyLocation: ApiKeyLocation.queryParameter,
        allowedHosts: [
          'valid.test',
        ],
      );

      final request = RequestInformation(
        urlTemplate: 'https://invalid.test/resource',
      );

      await provider.authenticateRequest(request);

      expect(request.uri.toString(), equals('https://invalid.test/resource'));
    });

    test('Does authenticate for valid host', () async {
      final provider = ApiKeyAuthenticationProvider(
        apiKey: 'apiKey',
        parameterName: 'parameterName',
        keyLocation: ApiKeyLocation.queryParameter,
        allowedHosts: [
          'valid.test',
        ],
      );

      final request = RequestInformation(
        urlTemplate: 'https://valid.test/resource',
      );

      await provider.authenticateRequest(request);

      expect(
        request.uri.toString(),
        equals('https://valid.test/resource?parameterName=apiKey'),
      );
    });

    test('Throws for non-https requests', () async {
      final provider = ApiKeyAuthenticationProvider(
        apiKey: 'apiKey',
        parameterName: 'parameterName',
        keyLocation: ApiKeyLocation.queryParameter,
      );

      final request = RequestInformation(
        urlTemplate: 'http://example.test/resource',
      );

      expect(
        () => provider.authenticateRequest(request),
        throwsArgumentError,
      );
    });
  });
}
