import 'dart:convert';

import 'package:kiota_abstractions/kiota_abstractions.dart';
import 'package:kiota_serialization_form/kiota_serialization_form.dart';
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

      expect(utf8.decode(writer.getSerializedContent()), equals('key=get%2Cpost'));
    });
  });
}
