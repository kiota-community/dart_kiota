part of '../../kiota_abstractions.dart';

class UntypedNull extends UntypedNode {
  const UntypedNull();

  @override
  Object? getValue() {
    return null;
  }
}
