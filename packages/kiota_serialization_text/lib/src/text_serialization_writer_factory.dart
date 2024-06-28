part of '../kiota_serialization_text.dart';

class TextSerializationWriterFactory implements SerializationWriterFactory {
  @override
  SerializationWriter getSerializationWriter(String contentType) {
    if (contentType.toLowerCase() != validContentType) {
      throw ArgumentError(
        'The provided content type is not supported by the TextSerializationWriterFactory',
      );
    }

    return TextSerializationWriter();
  }

  @override
  String get validContentType => 'text/plain';
}
