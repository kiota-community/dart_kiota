part of dart_kiota;

/// Defines a serializable model object
abstract class Parsable {
  /// Gets the deserialization information for this object.
  Map<String, ParseNode Function()> getFieldDeserializers();

  /// Writes the objects properties to the current writer.
  void serialize(SerializationWriter writer);
}
