import 'package:microsoft_kiota_abstractions/microsoft_kiota_abstractions.dart';

import './microsoft_graph_user.dart';
import './second_test_entity.dart';

class UnionTypeMock extends Parsable implements AdditionalDataHolder {
  UnionTypeMock();

  factory UnionTypeMock.createFromDiscriminatorValue(
    ParseNode parseNode,
  ) {
    final result = UnionTypeMock();
    final discriminator =
        parseNode.getChildNode('@odata.type')?.getStringValue();
    if ('#microsoft.graph.testEntity' == discriminator) {
      result.composedType1 = MicrosoftGraphUser();
    } else if ('#microsoft.graph.secondTestEntity' == discriminator) {
      result.composedType2 = SecondTestEntity();
    } else if (parseNode.getStringValue() is String) {
      result.stringValue = parseNode.getStringValue();
    } else if (parseNode
        .getCollectionOfObjectValues<MicrosoftGraphUser>(
          MicrosoftGraphUser.createFromDiscriminator,
        )
        .isNotEmpty) {
      result.composedType3 =
          parseNode.getCollectionOfObjectValues<MicrosoftGraphUser>(
        MicrosoftGraphUser.createFromDiscriminator,
      );
    }
    return result;
  }

  MicrosoftGraphUser? composedType1;
  SecondTestEntity? composedType2;
  String? stringValue;
  Iterable<MicrosoftGraphUser>? composedType3;

  @override
  Map<String, Object?> additionalData = {};

  @override
  Map<String, void Function(ParseNode parseNode)> getFieldDeserializers() {
    if (composedType1 != null) {
      return composedType1!.getFieldDeserializers();
    }
    if (composedType2 != null) {
      return composedType2!.getFieldDeserializers();
    }
    return {};
  }

  @override
  void serialize(SerializationWriter writer) {
    if (composedType1 != null) {
      writer.writeObjectValue(null, composedType1);
    } else if (composedType2 != null) {
      writer.writeObjectValue(null, composedType2);
    } else if (stringValue != null) {
      writer.writeStringValue(null, stringValue);
    } else if (composedType3 != null) {
      writer.writeCollectionOfObjectValues(null, composedType3);
    }
  }
}
