import 'package:kiota_abstractions/kiota_abstractions.dart';

class UntypedTestEntity extends Parsable implements AdditionalDataHolder {
  UntypedTestEntity();

  factory UntypedTestEntity.createFromDiscriminator(ParseNode parseNode) {
    final discriminatorValue = parseNode.getChildNode('@odata.type')?.getStringValue();
    return switch(discriminatorValue)
    {
      _ => UntypedTestEntity()
    };
  }

  /// Stores additional data not described in the OpenAPI description
  /// found when deserializing.
  /// Can be used for serialization as well.
  @override
  Map<String, Object?> additionalData = {};

  String? id;
  String? title;
  UntypedNode? location;
  UntypedNode? keywords;
  UntypedNode? detail;
  UntypedNode? table;

  @override
  Map<String, void Function(ParseNode)> getFieldDeserializers() {
    return <String, void Function(ParseNode node)> {
      'id': (node) => id = node.getStringValue(),
      'title': (node) => title = node.getStringValue(),
      'location': (node) => location = node.getObjectValue(UntypedNode.createFromDiscriminatorValue),
      'keywords': (node) => keywords = node.getObjectValue(UntypedNode.createFromDiscriminatorValue),
      'detail': (node) => detail = node.getObjectValue(UntypedNode.createFromDiscriminatorValue),
      'table': (node) => table = node.getObjectValue(UntypedNode.createFromDiscriminatorValue),
    };
  }

  @override
  void serialize(SerializationWriter writer) {
    writer
      ..writeStringValue('id', id)
      ..writeStringValue('title', title)
      ..writeObjectValue('location', location)
      ..writeObjectValue('keywords', keywords)
      ..writeObjectValue('detail', detail)
      ..writeObjectValue('table', table)
      ..writeAdditionalData(additionalData);
  }

}
