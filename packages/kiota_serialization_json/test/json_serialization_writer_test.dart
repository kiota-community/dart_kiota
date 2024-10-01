import 'dart:convert';

import 'package:kiota_abstractions/kiota_abstractions.dart';
import 'package:kiota_serialization_json/kiota_serialization_json.dart';
import 'package:test/test.dart';
import 'microsoft_graph_user.dart';

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

     test('writeObject', () {
        final simpleUser = MicrosoftGraphUser()
        ..officeLocation='at the desk'
        ..workDuration=const Duration(hours: 40)
        ..birthDay=DateOnly.fromDateTime(DateTime.parse('2024-10-01 00:00:00'))
        ..heightInMetres=1.7
        ..additionalData={'a':'some value', 'b': 'some other value'};
  
      final writer = JsonSerializationWriter()
        ..writeObjectValue(
          null, simpleUser);

      expect(
        utf8.decode(writer.getSerializedContent()),
        equals('{"officeLocation":"at the desk","workDuration":"40:00:00.000000","birthDay":"2024-10-01","heightInMetres":"1.7","a":"some value","b":"some other value"}'),
      );
    });

  });
}
