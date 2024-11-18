// ignore_for_file: avoid_redundant_argument_values

import 'package:microsoft_kiota_abstractions/microsoft_kiota_abstractions.dart';
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
