part of '../../microsoft_kiota_abstractions.dart';

/// Base class for untyped node.
class UntypedNode implements Parsable {
  const UntypedNode();

  /// Creates a new [UntypedNode] instance.
  factory UntypedNode.createFromDiscriminatorValue(ParseNode _) {
    return const UntypedNode();
  }

  /// The deserialization information for the current model.
  /// Returns a map of serializer methods for this object.
  @override
  Map<String, void Function(ParseNode)> getFieldDeserializers() {
    return {};
  }

  /// Serializes the current object
  @override
  void serialize(SerializationWriter writer) {
    // no properties to serialize. This is handled by custom serialization logic.
  }

  /// Gets the value assigned to untyped node.
  Object? getValue() {
    throw Exception('getValue is implemented for derived types of UntypedNode');
  }
}
