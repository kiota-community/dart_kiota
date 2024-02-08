part of '../../dart_kiota.dart';

/// Defines the contract for a factory that creates [SerializationWriter]
/// instances.
abstract class SerializationWriterFactory {
  /// Gets the content type this factory creates serialization writers for.
  String get validContentType;

  /// Creates a new [SerializationWriter] for the given content type.
  SerializationWriter getSerializationWriter(String contentType);
}
