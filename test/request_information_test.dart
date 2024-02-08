// ignore_for_file: avoid_redundant_argument_values

import 'dart:typed_data';

import 'package:kiota_abstractions/kiota_abstractions.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';

import 'request_information_test.mocks.dart';

enum TestEnum { first, second }

@GenerateMocks([RequestOption])
void main() {
  test('empty RequestInformation constructor', () {
    final blank = RequestInformation();
    expect(blank.httpMethod, null);
    expect(blank.urlTemplate, null);
    expect(blank.pathParameters, <String, dynamic>{});
    expect(blank.queryParameters, <String, dynamic>{});
    expect(blank.headers, RequestHeaders());
    expect(
      blank.content,
      isA<Uint8List>().having((content) => content.length, 'length', equals(0)),
    );
    expect(blank.requestOptions, <RequestOption>[]);

    expect(() => blank.uri, throwsArgumentError);
  });

  test('SetUriExtractsQueryParameters', () {
    final example = RequestInformation(
      httpMethod: Method.get,
      urlTemplate: 'http://localhost/{path}/me?foo={foo}',
    );

    example.queryParameters['foo'] = 'bar';
    example.pathParameters['path'] = 'baz';

    expect(example.uri.toString(), 'http://localhost/baz/me?foo=bar');
    expect(example.queryParameters.isNotEmpty, isTrue);
    expect(example.queryParameters.keys.first, equals('foo'));
    expect(example.queryParameters.values.first, equals('bar'));
  });

  test('Adds and removes request options', () {
    // Arrange
    final testRequest = RequestInformation(
      httpMethod: Method.get,
    )..uri = Uri.parse('http://localhost');

    final testRequestOption = MockRequestOption();
    expect(testRequest.requestOptions.isEmpty, isTrue);

    // Act
    testRequest.addRequestOptions([testRequestOption]);

    // Assert
    expect(testRequest.requestOptions.isNotEmpty, isTrue);
    expect(testRequest.requestOptions.first, equals(testRequestOption));

    // Act by removing the option
    testRequest.removeRequestOptions([testRequestOption]);
    expect(testRequest.requestOptions.isEmpty, isTrue);
  });

  test('Sets path parameters of DateTime type', () {
    // Arrange as the request builders would
    final requestInfo = RequestInformation(
      httpMethod: Method.get,
      urlTemplate:
          "http://localhost/getDirectRoutingCalls(fromDateTime='{fromDateTime}',toDateTime='{toDateTime}')",
    );

    // Act
    final fromDateTime = DateTime(2022, 8, 1, 0, 0, 0, 0, 0);
    final toDateTime = DateTime(2022, 8, 2, 0, 0, 0, 0, 0);

    requestInfo.pathParameters['fromDateTime'] = fromDateTime;
    requestInfo.pathParameters['toDateTime'] = toDateTime;

    // Assert
    expect(
      requestInfo.uri.toString(),
      contains("fromDateTime='2022-08-01T00%3A00%3A00.000'"),
    );
    expect(
      requestInfo.uri.toString(),
      contains("toDateTime='2022-08-02T00%3A00%3A00.000'"),
    );
  });

  test('Sets path parameters of boolean type', () {
    // Arrange as the request builders would
    final requestInfo = RequestInformation(
      httpMethod: Method.get,
      urlTemplate: 'http://localhost/users{?%24count}',
    );

    // Act
    requestInfo.pathParameters['%24count'] = true;

    // Assert
    expect(requestInfo.uri.toString(), contains('%24count=true'));
  });

  test('Builds URL on provided base URL', () {
    // Arrange as the request builders would
    final requestInfo = RequestInformation(
      httpMethod: Method.get,
      urlTemplate: '{+baseurl}/users{?%24count}',
    );

    // Act
    requestInfo.pathParameters['baseurl'] = 'http://localhost';

    // Assert
    expect(requestInfo.uri.toString(), contains('http://localhost'));
  });

  test('Initialize with proxy base URL', () {
    const proxyUrl =
        'https://proxy.apisandbox.msdn.microsoft.com/svc?url=https://graph.microsoft.com/beta';

    // Arrange as the request builders would
    final requestInfo = RequestInformation(
      httpMethod: Method.get,
      urlTemplate: '{+baseurl}/users{?%24count}',
    )..pathParameters = <String, Object>{
        'baseurl': proxyUrl,
        '%24count': true,
      };

    // Assert we can build URLs based on a proxy-based base URL
    expect(
      requestInfo.uri.toString(),
      'https://proxy.apisandbox.msdn.microsoft.com/svc?url=https://graph.microsoft.com/beta/users?%24count=true',
    );
  });

  test('Get URI resolves parameters case-sensitive', () {
    // Arrange
    final testRequest = RequestInformation(
      httpMethod: Method.get,
      urlTemplate:
          'http://localhost/{URITemplate}/ParameterMapping?IsCaseSensitive={IsCaseSensitive}',
    );

    // Act
    testRequest.pathParameters['URITemplate'] = 'UriTemplate';
    testRequest.queryParameters['IsCaseSensitive'] = false;

    // Assert
    expect(
      testRequest.uri.toString(),
      'http://localhost/UriTemplate/ParameterMapping?IsCaseSensitive=false',
    );
  });

  test('Sets enum value in path parameters', () {
    // Arrange
    final testRequest = RequestInformation(
      httpMethod: Method.get,
      urlTemplate: 'http://localhost/{dataset}',
    );

    // Act
    testRequest.pathParameters['dataset'] = TestEnum.first;

    // Assert
    expect(testRequest.uri.toString(), 'http://localhost/first');
  });

  test('Sets multiple enum values in path parameters', () {
    // Arrange
    final testRequest = RequestInformation(
      httpMethod: Method.get,
      urlTemplate: 'http://localhost/{dataset}',
    );

    // Act
    testRequest.pathParameters['dataset'] = [TestEnum.first, TestEnum.second];

    // Assert
    expect(testRequest.uri.toString(), 'http://localhost/first,second');
  });
}
