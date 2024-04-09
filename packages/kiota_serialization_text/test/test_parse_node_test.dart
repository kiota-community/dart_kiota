import 'package:kiota_abstractions/kiota_abstractions.dart';
import 'package:kiota_serialization_text/kiota_serialization_text.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('TextParseNode', () {
    final throwsNoStructuredDataError = throwsA(
      isA<UnsupportedError>().having(
        (e) => e.message,
        'message',
        equals('Text does not support structured data'),
      ),
    );

    test('trims quotes', () {
      final node = TextParseNode('"value"');

      expect(node.getStringValue(), equals('value'));
    });

    test('leaves quotes if unbalanced', () {
      final preQuote = TextParseNode('"value');
      final postQuote = TextParseNode('value"');

      expect(preQuote.getStringValue(), equals('"value'));
      expect(postQuote.getStringValue(), equals('value"'));
    });

    test('getStringValue', () {
      final node = TextParseNode('value');

      expect(node.getStringValue(), equals('value'));
    });

    test('getBoolValue', () {
      final node = TextParseNode('true');

      expect(node.getBoolValue(), equals(true));
    });

    test('getByteArrayValue', () {
      final node = TextParseNode('dGVzdA==');

      expect(node.getByteArrayValue(), equals([116, 101, 115, 116]));
    });

    test('getDateOnlyValue', () {
      final node = TextParseNode('2021-01-01');

      expect(
        node.getDateOnlyValue(),
        equals(DateOnly.fromComponents(2021)),
      );
    });

    test('getDateTimeValue', () {
      final node = TextParseNode('2021-01-01T00:00:00Z');

      expect(
        node.getDateTimeValue(),
        equals(DateTime.utc(2021)),
      );
    });

    test('getDoubleValue', () {
      final node = TextParseNode('1.23');

      expect(node.getDoubleValue(), equals(1.23));
    });

    test('getDurationValue', () {
      final node = TextParseNode('P3DT4H5M6S');

      expect(
        node.getDurationValue(),
        equals(
          const Duration(
            days: 3,
            hours: 4,
            minutes: 5,
            seconds: 6,
          ),
        ),
      );
    });

    test('getGuidValue nil', () {
      final node = TextParseNode('00000000-0000-0000-0000-000000000000');

      expect(
        node.getGuidValue(),
        equals(UuidValue.nil),
      );
    });

    test('getGuidValue', () {
      final node = TextParseNode('1f8a1626-369d-41df-bcc4-af5c5adbbd0a');

      expect(
        node.getGuidValue(),
        equals(UuidValue.fromString('1f8a1626-369d-41df-bcc4-af5c5adbbd0a')),
      );
    });

    test('getIntValue', () {
      final node = TextParseNode('123');

      expect(node.getIntValue(), equals(123));
    });

    test('getTimeOnlyValue', () {
      final node = TextParseNode('12:34:56');

      expect(
        node.getTimeOnlyValue(),
        equals(
          TimeOnly.fromComponents(12, 34, 56),
        ),
      );
    });

    test('getEnumValue', () {
      final node = TextParseNode('value');

      expect(
        () => node.getEnumValue<HttpMethod>(),
        throwsA(
          isA<UnsupportedError>().having(
            (e) => e.message,
            'message',
            equals('Enum parsing is not supported yet'),
          ),
        ),
      );
    });

    test('getChildNode', () {
      final node = TextParseNode('value');

      expect(
        () => node.getChildNode('identifier'),
        throwsNoStructuredDataError,
      );
    });

    test('getCollectionOfObjectValues', () {
      final node = TextParseNode('value');

      expect(
        () => node.getCollectionOfObjectValues<MultipartBody>(
          (_) => MultipartBody(),
        ),
        throwsNoStructuredDataError,
      );
    });

    test('getCollectionOfPrimitiveValues', () {
      final node = TextParseNode('value');

      expect(
        () => node.getCollectionOfPrimitiveValues<int>(),
        throwsNoStructuredDataError,
      );
    });

    test('getCollectionOfEnumValues', () {
      final node = TextParseNode('value');

      expect(
        () => node.getCollectionOfEnumValues<HttpMethod>(),
        throwsNoStructuredDataError,
      );
    });

    test('getObjectValue', () {
      final node = TextParseNode('value');

      expect(
        () => node.getObjectValue<MultipartBody>(
          (_) => MultipartBody(),
        ),
        throwsNoStructuredDataError,
      );
    });
  });
}
