part of '../../kiota_abstractions.dart';

/// Defines a serializable model object
abstract class Parsable {
  /// Gets the deserialization information for this object.
  Map<String, void Function(ParseNode)> getFieldDeserializers();

  /// Writes the objects properties to the current writer.
  void serialize(SerializationWriter writer);
}
