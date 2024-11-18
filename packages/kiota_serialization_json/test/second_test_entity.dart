import 'package:kiota_abstractions/kiota_abstractions.dart';

class SecondTestEntity extends Parsable implements AdditionalDataHolder {
  SecondTestEntity();

  factory SecondTestEntity.createFromDiscriminatorValue(ParseNode _) {
    return SecondTestEntity();
  }

  @override
  Map<String, Object?> additionalData = {};
  int? id;
  String? displayName;
  int? failureRate;

  @override
  Map<String, void Function(ParseNode parseNode)> getFieldDeserializers() {
    return <String, void Function(ParseNode node)>{
      'id': (node) => id = node.getIntValue(),
      'displayName': (node) => displayName = node.getStringValue(),
      'failureRate': (node) => failureRate = node.getIntValue(),
    };
  }

  @override
  void serialize(SerializationWriter writer) {
    writer
      ..writeStringValue('displayName', displayName)
      ..writeIntValue('id', id)
      ..writeIntValue('failureRate', failureRate)
      ..writeAdditionalData(additionalData);
  }
}
