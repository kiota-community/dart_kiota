import 'package:microsoft_kiota_abstractions/microsoft_kiota_abstractions.dart';

import 'microsoft_graph_user.dart';

class DerivedMicrosoftGraphUser extends MicrosoftGraphUser {
  DerivedMicrosoftGraphUser();

  DateOnly? enrolmentDate;

  @override
  void serialize(SerializationWriter writer) {
    super.serialize(writer);
    writer.writeDateOnlyValue('enrolmentDate', enrolmentDate);
  }

  @override
  Map<String, void Function(ParseNode)> getFieldDeserializers() {
    final parentDeserializers = super.getFieldDeserializers();
    parentDeserializers['enrolmentDate'] =
        (node) => enrolmentDate = node.getDateOnlyValue();
    return parentDeserializers;
  }
}
