import 'package:kiota_abstractions/kiota_abstractions.dart';
import 'package:test/test.dart';

void main() {
  group('AllowedHostsValidator', () {
    test('Throws for hosts with scheme', () {
      expect(
        () => AllowedHostsValidator(['http://example.com']),
        throwsArgumentError,
      );
      expect(
        () => AllowedHostsValidator(['https://example.com']),
        throwsArgumentError,
      );
    });

    test('Is case insensitive', () {
      final validator = AllowedHostsValidator(['example.com']);

      expect(validator.isUrlHostValid(Uri.parse('http://example.com')), isTrue);
      expect(validator.isUrlHostValid(Uri.parse('http://EXAMPLE.com')), isTrue);
    });

    test('Only keeps a unique list of hosts', () {
      final validator = AllowedHostsValidator(['example.com', 'example.com', 'EXAMPLE.COM']);

      expect(validator.allowedHosts, equals(['example.com']));
    });
  });
}
