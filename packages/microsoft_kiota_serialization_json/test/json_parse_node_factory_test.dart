import 'dart:convert';

import 'package:microsoft_kiota_serialization_json/microsoft_kiota_serialization_json.dart';
import 'package:test/test.dart';

void main() {
  group('JsonParseNodeFactoryTest', () {
    test('getParseNodeForJsonContentType', () {
      final json = utf8.encode('{"key":"value"}');
      final factory = JsonParseNodeFactory();
      final jsonParseNode =
          factory.getRootParseNode(factory.validContentType, json);
      expect(jsonParseNode, isNotNull);
    });

    test('testThrowsExceptionForInvalidContentType', () {
      const streamContentType = 'application/octet-stream';
      final json = utf8.encode('{"key":"value"}');
      final factory = JsonParseNodeFactory();
      expect(
        () => factory.getRootParseNode(streamContentType, json),
        throwsArgumentError,
      );
    });
  });
}
