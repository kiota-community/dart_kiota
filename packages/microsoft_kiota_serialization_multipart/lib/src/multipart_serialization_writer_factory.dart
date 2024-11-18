part of '../microsoft_kiota_serialization_multipart.dart';

class MultipartSerializationWriterFactory
    implements SerializationWriterFactory {
  @override
  SerializationWriter getSerializationWriter(String contentType) {
    if (contentType.toLowerCase() != validContentType) {
      throw ArgumentError(
        'The provided content type is not supported by the MultipartSerializationWriterFactory',
      );
    }

    return MultipartSerializationWriter();
  }

  @override
  String get validContentType => 'multipart/form-data';
}
