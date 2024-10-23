import 'package:kiota_abstractions/kiota_abstractions.dart';

class TestEntity implements Parsable, AdditionalDataHolder {
  TestEntity();

  String? id;

  String? officeLocation;

  DateOnly? birthDay;

  Iterable<String>? deviceNames = [];

  Duration? workDuration;

  TimeOnly? startWorkTime;

  TimeOnly? endWorkTime;

  DateTime? createdDateTime;

  @override
  Map<String, Object?> additionalData = {};

  @override
  Map<String, void Function(ParseNode parseNode)> getFieldDeserializers() {
    return <String, void Function(ParseNode node)>{
      'id': (node) => id = node.getStringValue(),
      'officeLocation': (node) => officeLocation = node.getStringValue(),
      'birthDay': (node) => birthDay = node.getDateOnlyValue(),
      'deviceNames': (node) => deviceNames = node.getCollectionOfPrimitiveValues<String>(),
      'workDuration': (node) => workDuration = node.getDurationValue(),
      'startWorkTime': (node) => startWorkTime = node.getTimeOnlyValue(),
      'endWorkTime': (node) => endWorkTime = node.getTimeOnlyValue(),
      'createdDateTime': (node) => createdDateTime = node.getDateTimeValue()
    };
  }

  @override
  void serialize(SerializationWriter writer) {
    writer
      ..writeStringValue('id', id)
      ..writeStringValue('officeLocation', officeLocation)
      ..writeDateOnlyValue('birthDay', birthDay)
      ..writeDurationValue('workDuration', workDuration)
      ..writeTimeOnlyValue('startWorkTime', startWorkTime)
      ..writeTimeOnlyValue('endWorkTime', endWorkTime)
      ..writeDateTimeValue('createdDateTime', createdDateTime)
      ..writeCollectionOfPrimitiveValues('deviceNames', deviceNames)
      ..writeAdditionalData(additionalData);
  }

  static TestEntity createFromDiscriminatorValue(ParseNode parseNode) {
    return TestEntity();
  }
}
