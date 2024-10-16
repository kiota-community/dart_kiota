part of '../../kiota_abstractions.dart';

/// Represents an untyped node with object value.
class UntypedObject extends UntypedNode {
  UntypedObject(this.properties);

  Map<String, UntypedNode> properties;
}
