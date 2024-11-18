import 'package:microsoft_kiota_abstractions/microsoft_kiota_abstractions.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'base_bearer_token_authentication_provider_test.mocks.dart';

@GenerateMocks([AccessTokenProvider])
void main() {
  group('BaseBearerTokenAuthenticationProvider', () {
    test('Adds an Authorization header', () async {
      final tokenProvider = MockAccessTokenProvider();

      when(
        tokenProvider.getAuthorizationToken(
          Uri.parse('https://example.com/resource'),
        ),
      ).thenAnswer((_) async => 'token');

      final provider = BaseBearerTokenAuthenticationProvider(tokenProvider);

      final request = RequestInformation(
        urlTemplate: 'https://example.com/resource',
      );

      await provider.authenticateRequest(request);

      expect(request.headers.containsKey('Authorization'), isTrue);
      expect(request.headers['Authorization'], equals({'Bearer token'}));
    });

    test('Doesnt overwrite existing authorization header', () async {
      final tokenProvider = MockAccessTokenProvider();

      when(
        tokenProvider.getAuthorizationToken(
          Uri.parse('https://example.com/resource'),
        ),
      ).thenAnswer((_) async => 'token');

      final provider = BaseBearerTokenAuthenticationProvider(tokenProvider);

      final request = RequestInformation(
        urlTemplate: 'https://example.com/resource',
      );

      request.headers.put('Authorization', 'foo');

      await provider.authenticateRequest(request);

      expect(request.headers.containsKey('Authorization'), isTrue);
      expect(request.headers['Authorization'], equals({'foo'}));
    });

    test('Doesnt write empty token', () async {
      final tokenProvider = MockAccessTokenProvider();

      when(
        tokenProvider.getAuthorizationToken(
          Uri.parse('https://example.com/resource'),
        ),
      ).thenAnswer((_) async => '');

      final provider = BaseBearerTokenAuthenticationProvider(tokenProvider);

      final request = RequestInformation(
        urlTemplate: 'https://example.com/resource',
      );

      await provider.authenticateRequest(request);

      expect(request.headers.containsKey('Authorization'), isFalse);
    });

    test(
        'Removes previous authorization header if claims are present in context',
        () async {
      final tokenProvider = MockAccessTokenProvider();

      when(
        tokenProvider.getAuthorizationToken(
          Uri.parse('https://example.com/resource'),
          {'claims': 'claims'},
        ),
      ).thenAnswer((_) async => 'token');

      final provider = BaseBearerTokenAuthenticationProvider(tokenProvider);

      final request = RequestInformation(
        urlTemplate: 'https://example.com/resource',
      );

      request.headers.put('Authorization', 'foo');

      await provider.authenticateRequest(request, {'claims': 'claims'});

      expect(request.headers.containsKey('Authorization'), isTrue);
      expect(request.headers['Authorization'], equals({'Bearer token'}));
    });
  });
}
