import 'package:kiota_abstractions/kiota_abstractions.dart';

import 'derived_microsoft_graph_user.dart';
import 'test_enums.dart';

NamingEnum? _namingEnumFactory(String value) => NamingEnum.values
    .cast<NamingEnum?>()
    .firstWhere((e) => e!.value == value, orElse: () => null);

String? _namingEnumSerializer(NamingEnum? value) => value?.value;

class MicrosoftGraphUser extends Parsable implements AdditionalDataHolder {
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

  @override
  Map<String, Object?> additionalData = {};

  String? id;
  NamingEnum? namingEnum;
  DateOnly? birthDay;
  TimeOnly? startWorkTime;
  TimeOnly? endWorkTime;
  Duration? workDuration;
  DateTime? createdDateTime;
  double? heightInMetres;
  String? officeLocation;

  @override
  void serialize(SerializationWriter writer) {
    writer
      ..writeStringValue('id', id)
      ..writeEnumValue<NamingEnum>(
          'namingEnum', namingEnum, _namingEnumSerializer)
      ..writeDateTimeValue('createdDateTime', createdDateTime)
      ..writeStringValue('officeLocation', officeLocation)
      ..writeDurationValue('workDuration', workDuration)
      ..writeDateOnlyValue('birthDay', birthDay)
      ..writeDoubleValue('heightInMetres', heightInMetres)
      ..writeTimeOnlyValue('startWorkTime', startWorkTime)
      ..writeTimeOnlyValue('endWorkTime', endWorkTime)
      ..writeAdditionalData(additionalData);
  }

  @override
  Map<String, void Function(ParseNode)> getFieldDeserializers() {
    return <String, void Function(ParseNode node)>{
      'id': (node) => id = node.getStringValue(),
      'namingEnum': (node) =>
          namingEnum = node.getEnumValue<NamingEnum>(_namingEnumFactory),
      'createdDateTime': (node) => createdDateTime = node.getDateTimeValue(),
      'officeLocation': (node) => officeLocation = node.getStringValue(),
      'workDuration': (node) => workDuration = node.getDurationValue(),
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
      namingEnum: $namingEnum
      createdDateTime: $createdDateTime
      officeLocation: $officeLocation
      workDuration: $workDuration
      heightInMetres: $heightInMetres
      birthDay: ${birthDay?.year}-${birthDay?.month}-${birthDay?.day}
      startWorkTime: ${startWorkTime?.hours}:${startWorkTime?.minutes}
      endWorkTime: ${endWorkTime?.hours}:${endWorkTime?.minutes}
      additionalData: $additionalData
    ''';
  }
}
