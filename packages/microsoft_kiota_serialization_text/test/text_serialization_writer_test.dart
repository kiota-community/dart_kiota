import 'dart:convert';

import 'package:microsoft_kiota_abstractions/microsoft_kiota_abstractions.dart';
import 'package:microsoft_kiota_serialization_text/microsoft_kiota_serialization_text.dart';
import 'package:test/test.dart';

import 'text_test_helper.dart';

String? _httpMethodEnumSerializer(HttpMethod? value) => value?.name;

void main() {
  group('TextSerializationWriter', () {
    test('writeEnumValue', () {
      final writer = TextSerializationWriter()
        ..writeEnumValue(null, HttpMethod.get, _httpMethodEnumSerializer);

      expect(utf8.decode(writer.getSerializedContent()), equals('get'));
    });

    test('writeCollectionOfEnumValues', () {
      final writer = TextSerializationWriter();

      expect(
        () => writer.writeCollectionOfEnumValues(
          null,
          [HttpMethod.get, HttpMethod.post],
          _httpMethodEnumSerializer,
        ),
        throwsNoStructuredDataError,
      );
    });
  });
}
