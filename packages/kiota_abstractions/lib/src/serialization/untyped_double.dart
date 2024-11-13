part of '../../kiota_abstractions.dart';

class UntypedDouble extends UntypedNode {
  const UntypedDouble(this.value);

  final double value;

  @override
  double? getValue() {
    return value;
  }
}
