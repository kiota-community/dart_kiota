import 'package:kiota_abstractions/kiota_abstractions.dart';

import 'derived_microsoft_graph_user.dart';

class MicrosoftGraphUser
    extends Parsable /* implements AdditionDataHolder */ {
  MicrosoftGraphUser();

  factory MicrosoftGraphUser.createFromDiscriminator(ParseNode parseNode) {
    final discriminatorValue =
        parseNode.getChildNode('@odata.type')?.getStringValue();
    return switch (discriminatorValue) {
      'microsoft.graph.user' => MicrosoftGraphUser(),
      'microsoft.graph.group' => MicrosoftGraphUser(),
      'microsoft.graph.student' => DerivedMicrosoftGraphUser(),
      _ => MicrosoftGraphUser(),
    };
  }

  // IDictionary<string, object> AdditionalData { get; set; }
  String? id;
  // TestEnum? Numbers { get; set; }
  // TestNamingEnum? TestNamingEnum { get; set; }
  // TimeSpan? WorkDuration { get; set; }
  DateOnly? birthDay;
  TimeOnly? startWorkTime;
  TimeOnly? endWorkTime;
  // DateTimeOffset? CreatedDateTime { get; set; }
  double? heightInMetres;
  String? officeLocation;

  @override
  void serialize(SerializationWriter writer) {
    writer
      ..writeStringValue('id', id)
      // writer.writeEnumValue<TestEnum>("numbers", Numbers);
      // writer.writeEnumValue<TestNamingEnum>("testNamingEnum", TestNamingEnum);
      // writer.writeDateTimeOffsetValue("createdDateTime", CreatedDateTime);
      ..writeStringValue('officeLocation', officeLocation)
      // writer.writeTimeSpanValue("workDuration", WorkDuration);
      ..writeDateOnlyValue('birthDay', birthDay)
      ..writeDoubleValue('heightInMetres', heightInMetres)
      ..writeTimeOnlyValue('startWorkTime', startWorkTime)
      ..writeTimeOnlyValue('endWorkTime', endWorkTime);
    // writer.writeAdditionalData(AdditionalData);
  }

  @override
  Map<String, void Function(ParseNode)> getFieldDeserializers() {
    return <String, void Function(ParseNode node)>{
      'id': (node) => id = node.getStringValue(),
      // 'numbers': (node) => numbers = node.getEnumValue<TestEnum>(),
      // 'testNamingEnum': (node) => testNamingEnum = node.getEnumValue<TestNamingEnum>(),
      // 'createdDateTime': (node) => createdDateTime = node.getDateTimeOffsetValue();
      'officeLocation': (node) => officeLocation = node.getStringValue(),
      // 'workDuration': (node) => workDuration = node.getTimeSpanValue(),
      'heightInMetres': (node) => heightInMetres = node.getDoubleValue(),
      'birthDay': (node) => birthDay = node.getDateOnlyValue(),
      'startWorkTime': (node) => startWorkTime = node.getTimeOnlyValue(),
      'endWorkTime': (node) => endWorkTime = node.getTimeOnlyValue(),
    };
  }

  @override
  String toString() {
    return '''
      id: $id
      birthDay: $birthDay
      officeLocation: $officeLocation
    ''';
  }
}
