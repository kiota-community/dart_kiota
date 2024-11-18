part of '../microsoft_kiota_serialization_json.dart';

class JsonSerializationWriterFactory implements SerializationWriterFactory {
  @override
  SerializationWriter getSerializationWriter(String contentType) {
    if (contentType.toLowerCase() != validContentType) {
      throw ArgumentError(
        'The provided content type is not supported by the JsonSerializationWriterFactory',
      );
    }

    return JsonSerializationWriter();
  }

  @override
  String get validContentType => 'application/json';
}
