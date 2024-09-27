part of '../../kiota_abstractions.dart';

/// Represents an untyped node with a collection of other untyped nodes.
class UntypedArray extends UntypedNode {

  /// Constructs an instance from the supplied [collection]
  UntypedArray(this.collection);

  Iterable<UntypedNode> collection;

  @override
  Iterable<UntypedNode> getValue() {
    return collection;
  }
}
