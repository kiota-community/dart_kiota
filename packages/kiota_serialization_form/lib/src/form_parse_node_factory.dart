part of '../kiota_serialization_form.dart';

/// The [ParseNodeFactory] implementation for form content types
class FormParseNodeFactory implements ParseNodeFactory {
  @override
  ParseNode getRootParseNode(String contentType, Uint8List content) {
    if (contentType != validContentType) {
      throw ArgumentError('Invalid content type');
    }

    final text = utf8.decode(content);

    return FormParseNode(text);
  }

  @override
  String get validContentType => 'application/x-www-form-urlencoded';
}
