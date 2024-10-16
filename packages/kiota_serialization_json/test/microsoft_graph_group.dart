import 'package:kiota_abstractions/kiota_abstractions.dart';
import 'microsoft_graph_user.dart';

class MicrosoftGraphGroup extends Parsable implements AdditionalDataHolder {
  MicrosoftGraphGroup();

  @override
  Map<String, Object?> additionalData = {};

  String? id;
  String? name;
  MicrosoftGraphUser? leader;
  Iterable<MicrosoftGraphUser> members = [];

  @override
  void serialize(SerializationWriter writer) {
    writer
      ..writeStringValue('id', id)
      ..writeStringValue('name', name)
      ..writeObjectValue('leader', leader)
      ..writeCollectionOfObjectValues('members', members)
      ..writeAdditionalData(additionalData);
  }

  @override
  Map<String, void Function(ParseNode)> getFieldDeserializers() {
    return <String, void Function(ParseNode node)>{
      'id': (node) => id = node.getStringValue(),
      'name': (node) =>
          name = node.getStringValue(),
      'leader': (node) => leader = node.getObjectValue(MicrosoftGraphUser.createFromDiscriminator),
      'members': (node) => members = node.getCollectionOfObjectValues(MicrosoftGraphUser.createFromDiscriminator),
    };
  }

  @override
  String toString() {
    return '''
      id: $id
      name: $name
      leader: $leader
      members: $members
      additionalData: $additionalData
    ''';
  }
}
