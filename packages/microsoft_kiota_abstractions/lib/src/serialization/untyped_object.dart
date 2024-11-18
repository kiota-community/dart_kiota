part of '../../microsoft_kiota_abstractions.dart';

/// Represents an untyped node with object value.
class UntypedObject extends UntypedNode {
  const UntypedObject(this.properties);

  final Map<String, UntypedNode> properties;
}
