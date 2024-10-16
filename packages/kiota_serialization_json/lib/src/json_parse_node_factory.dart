part of '../kiota_serialization_json.dart';


class JsonParseNodeFactory implements ParseNodeFactory {
  @override
  ParseNode getRootParseNode(String contentType, Uint8List content) {
    if (contentType.toLowerCase() != validContentType) {
      throw ArgumentError('Invalid content type');
    }

    final json = utf8.decode(content);
    return JsonParseNode(jsonDecode(json));
  }

  @override
  String get validContentType => 'application/json';
}
