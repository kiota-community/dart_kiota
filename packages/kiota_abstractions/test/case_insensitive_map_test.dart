// ignore_for_file: avoid_redundant_argument_values

import 'package:kiota_abstractions/kiota_abstractions.dart';
import 'package:test/test.dart';

void main() {
  group('CaseInsensitiveMap', () {
    test('putIfAbsent', () {
      final headers = HttpHeaders()
        ..putIfAbsent('key', () => {'value'})
        ..map((name, values) {
          return MapEntry(name, values.join(', '));
        });
      expect(
        headers['key'],
        {'value'},
      );
    });
  });
}
