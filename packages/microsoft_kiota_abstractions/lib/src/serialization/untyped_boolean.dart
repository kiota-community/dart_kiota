part of '../../microsoft_kiota_abstractions.dart';

class UntypedBoolean extends UntypedNode {
  const UntypedBoolean({required this.value});

  final bool value;

  @override
  bool? getValue() {
    return value;
  }
}
