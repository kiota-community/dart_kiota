import 'dart:convert';

import 'package:kiota_abstractions/kiota_abstractions.dart';
import 'package:kiota_serialization_json/kiota_serialization_json.dart';
import 'package:test/test.dart';

String? _httpMethodEnumSerializer(HttpMethod? value) => value?.name;

void main() {
  group('JsonSerializationWriter', () {
    test('writeCollectionOfEnumValues', () {
      final writer = JsonSerializationWriter()
        ..writeCollectionOfEnumValues(
          'key',
          [HttpMethod.get, HttpMethod.post, HttpMethod.patch],
          _httpMethodEnumSerializer,
        );

      expect(
        utf8.decode(writer.getSerializedContent()),
        equals('{"key":["get","post","patch"]}'),
      );
    });
     test('writeCollectionOfPrimitiveValues', () {
      final writer = JsonSerializationWriter()
        ..writeCollectionOfPrimitiveValues(
          'intlist',
          [1,2,3],);

      expect(
        utf8.decode(writer.getSerializedContent()),
        equals('{"intlist":["1","2","3"]}'),
      );
    });
  });
}
