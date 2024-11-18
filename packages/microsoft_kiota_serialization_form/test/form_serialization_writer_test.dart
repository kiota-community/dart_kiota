import 'dart:convert';

import 'package:microsoft_kiota_abstractions/microsoft_kiota_abstractions.dart';
import 'package:microsoft_kiota_serialization_form/microsoft_kiota_serialization_form.dart';
import 'package:test/test.dart';

String? _httpMethodEnumSerializer(HttpMethod? value) => value?.name;

void main() {
  group('TextSerializationWriter', () {
    test('writeEnumValue', () {
      final writer = FormSerializationWriter()
        ..writeEnumValue('key', HttpMethod.get, _httpMethodEnumSerializer);

      expect(utf8.decode(writer.getSerializedContent()), equals('key=get'));
    });

    test('writeCollectionOfEnumValues', () {
      final writer = FormSerializationWriter()
        ..writeCollectionOfEnumValues(
          'key',
          [HttpMethod.get, HttpMethod.post],
          _httpMethodEnumSerializer,
        );

      expect(
        utf8.decode(writer.getSerializedContent()),
        equals('key=get%2Cpost'),
      );
    });
  });
}
