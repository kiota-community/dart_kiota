part of '../kiota_serialization_text.dart';

class TextParseNodeFactory implements ParseNodeFactory {
  @override
  ParseNode getRootParseNode(String contentType, Uint8List content) {
    if (contentType.toLowerCase() != validContentType) {
      throw ArgumentError('Invalid content type');
    }

    final text = utf8.decode(content);

    return TextParseNode(text);
  }

  @override
  String get validContentType => 'text/plain';
}
