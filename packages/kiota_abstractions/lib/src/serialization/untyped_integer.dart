part of '../../kiota_abstractions.dart';

class UntypedInteger extends UntypedNode {
  const UntypedInteger(this.value);

  final int value;

  @override
  int? getValue() {
    return value;
  }
}
