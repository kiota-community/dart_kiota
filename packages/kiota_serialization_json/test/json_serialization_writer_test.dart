import 'dart:convert';
import 'package:kiota_abstractions/kiota_abstractions.dart';
import 'package:kiota_serialization_json/kiota_serialization_json.dart';
import 'package:test/test.dart';

import 'microsoft_graph_group.dart';
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
          [1, 2, 3],
        );

      expect(
        utf8.decode(writer.getSerializedContent()),
        equals('{"intlist":[1,2,3]}'),
      );
    });

    test('writeObject', () {
      final simpleUser = MicrosoftGraphUser()
        ..id = 'abc'
        ..createdDateTime = DateTime(2023, 12, 1, 15, 15)
        ..officeLocation = 'at the desk'
        ..workDuration = const Duration(hours: 40)
        ..birthDay =
            DateOnly.fromDateTime(DateTime.parse('2024-10-01 00:00:00'))
        ..heightInMetres = 1.7
        ..startWorkTime = TimeOnly.fromDateTimeString('06:00')
        ..active = true
        ..numbers = [2, 3, 5]
        ..additionalData = {'a': 'some value', 'b': 12, 'c': false};

      final writer = JsonSerializationWriter()
        ..writeObjectValue(
          null,
          simpleUser,
        );

      expect(
        utf8.decode(writer.getSerializedContent()),
        equals(
          '{"id":"abc","createdDateTime":"2023-12-01T15:15:00.000","officeLocation":"at the desk","workDuration":"40:00:00.000000","birthDay":"2024-10-01","heightInMetres":1.7,"startWorkTime":"06:00:00","active":true,"numbers":[2,3,5],"a":"some value","b":12,"c":false}',
        ),
      );
    });

    test('writeSecondObject', () {
      final user1 = MicrosoftGraphUser()
        ..officeLocation = 'on a chair'
        ..workDuration = const Duration(hours: 2)
        ..additionalData = {'a': '#1 coworker'};
      final user2 = MicrosoftGraphUser()
        ..workDuration = const Duration(hours: 12)
        ..active = true;
      final user3 = MicrosoftGraphUser()
        ..heightInMetres = 1.9
        ..endWorkTime = TimeOnly.fromDateTimeString('17:00');
      final group = MicrosoftGraphGroup()
        ..name = 'a group'
        ..leader = user3
        ..members = [user1, user2];

      final writer = JsonSerializationWriter()
        ..writeObjectValue(
          null,
          group,
        );

      expect(
        utf8.decode(writer.getSerializedContent()),
        equals(
          '{"name":"a group","leader":{"heightInMetres":1.9,"endWorkTime":"17:00:00"},"members":[{"officeLocation":"on a chair","workDuration":"2:00:00.000000","a":"#1 coworker"},{"workDuration":"12:00:00.000000","active":true}]}',
        ),
      );
    });
  });
}
