part of '../../microsoft_kiota_abstractions.dart';

class UntypedString extends UntypedNode {
  const UntypedString(this.value);

  final String value;

  @override
  String? getValue() {
    return value;
  }
}
