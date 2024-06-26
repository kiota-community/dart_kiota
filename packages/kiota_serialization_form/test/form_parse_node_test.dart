import 'package:kiota_abstractions/kiota_abstractions.dart';
import 'package:kiota_serialization_form/kiota_serialization_form.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

import 'form_parse_node_test.mocks.dart';

@GenerateMocks([Parsable])
void main() {
  group('FormParseNode', () {
    setUp(() => EnumRegistry.register(HttpMethod.values));
    tearDown(() => EnumRegistry.unregister<HttpMethod>());

    test('leaves quotes if unbalanced', () {
      final preQuote = FormParseNode('"value');
      final postQuote = FormParseNode('value"');

      expect(preQuote.getStringValue(), equals('"value'));
      expect(postQuote.getStringValue(), equals('value"'));
    });

    test('getStringValue', () {
      final node = FormParseNode('value');

      expect(node.getStringValue(), equals('value'));
    });

    test('getBoolValue', () {
      final node = FormParseNode('true');

      expect(node.getBoolValue(), equals(true));
    });

    test('getByteArrayValue', () {
      final node = FormParseNode('dGVzdA==');

      expect(node.getByteArrayValue(), equals([116, 101, 115, 116]));
    });

    test('getDateOnlyValue', () {
      final node = FormParseNode('2021-01-01');

      expect(
        node.getDateOnlyValue(),
        equals(DateOnly.fromComponents(2021)),
      );
    });

    test('getDateTimeValue', () {
      final node = FormParseNode('2021-01-01T00:00:00Z');

      expect(
        node.getDateTimeValue(),
        equals(DateTime.utc(2021)),
      );
    });

    test('getDoubleValue', () {
      final node = FormParseNode('1.23');

      expect(node.getDoubleValue(), equals(1.23));
    });

    test('getDurationValue', () {
      final node = FormParseNode('P3DT4H5M6S');

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
      final node = FormParseNode('00000000-0000-0000-0000-000000000000');

      expect(
        node.getGuidValue(),
        equals(UuidValue.nil),
      );
    });

    test('getGuidValue', () {
      final node = FormParseNode('1f8a1626-369d-41df-bcc4-af5c5adbbd0a');

      expect(
        node.getGuidValue(),
        equals(UuidValue.fromString('1f8a1626-369d-41df-bcc4-af5c5adbbd0a')),
      );
    });

    test('getIntValue', () {
      final node = FormParseNode('123');

      expect(node.getIntValue(), equals(123));
    });

    test('getTimeOnlyValue', () {
      final node = FormParseNode('12:34:56');

      expect(
        node.getTimeOnlyValue(),
        equals(
          TimeOnly.fromComponents(12, 34, 56),
        ),
      );
    });

    test('getEnumValue', () {
      final node = FormParseNode('get');

      expect(node.getEnumValue<HttpMethod>(), equals(HttpMethod.get));
    });

    test('getChildNode', () {
      final node = FormParseNode('value');

      expect(node.getChildNode('identifier'), isNull);
    });

    test('getCollectionOfObjectValues', () {
      final node = FormParseNode('value');

      expect(
        () => node.getCollectionOfObjectValues<MultipartBody>(
          (_) => MultipartBody(),
        ),
        throwsA(
          isA<UnsupportedError>().having(
            (e) => e.message,
            'message',
            equals('Collections are not supported with uri form encoding'),
          ),
        ),
      );
    });

    test('getCollectionOfPrimitiveValues', () {
      final node = FormParseNode('false,123,null,456,true');

      expect(
        node.getCollectionOfPrimitiveValues<int>(),
        equals([123, 456]),
      );

      expect(
        node.getCollectionOfPrimitiveValues<bool>(),
        equals([false, true]),
      );
    });

    test('getCollectionOfEnumValues', () {
      final node = FormParseNode('Get,post');

      final values = node.getCollectionOfEnumValues<HttpMethod>();

      expect(values, equals([HttpMethod.get, HttpMethod.post]));
    });

    test('getObjectValue', () {
      final node = FormParseNode('filename=file.txt');

      final parsable = MockParsable();

      when(parsable.getFieldDeserializers()).thenReturn({
        'filename': (node) {
          final value = node.getStringValue();

          expect(value, equals('file.txt'));
        },
      });

      final value = node.getObjectValue<MockParsable>((_) => parsable);

      expect(value, isNotNull);
    });
  });
}
