part of '../kiota_serialization_json.dart';

class JsonSerializationWriter implements SerializationWriter {
  final List<String> _buffer = [];

  final openingObject = '{';
  final closingObject = '}';
  final openingArray = '[';
  final closingArray = ']';
  final separator = ',';

  @override
  ParsableHook? onAfterObjectSerialization;

  @override
  ParsableHook? onBeforeObjectSerialization;

  @override
  void Function(Parsable p, SerializationWriter w)? onStartObjectSerialization;

  @override
  Uint8List getSerializedContent() {
    removeSeparator();
    return utf8.encode(_buffer.join());
  }

  @override
  void writeAdditionalData(Map<String, dynamic> value) {
    //TODO
  }

  @override
  void writeBoolValue(String? key, {bool? value}) {
    writeStringValue(key, value?.toString());
  }

  @override
  void writeByteArrayValue(String? key, Uint8List? value) {
    writeStringValue(key, value == null ? null : base64Encode(value));
  }

  @override
  void writeCollectionOfEnumValues<T extends Enum>(
    String? key,
    Iterable<T>? values,
    EnumSerializer<T> serializer,
  ) {
    //TODO
  }

  @override
  void writeCollectionOfObjectValues<T extends Parsable>(
    String? key,
    Iterable<T>? values,
  ) {
    if(values == null || values.isEmpty){
      return;
    }
    else{
    _buffer.add('"$key":$openingArray');
    var first = true;
      for (final value in values)
        { 
          if(!first){
            _buffer.add(separator);
          }
          first = false;
          _buffer.add(openingObject);
          value.serialize(this);
          removeSeparator();
          _buffer.add(closingObject);
        }  
    _buffer..add(closingArray)
    ..add(separator);
  }}

  @override
  void writeCollectionOfPrimitiveValues<T>(String? key, Iterable<T>? values) {
    //TODO
  }

  @override
  void writeDateTimeValue(String? key, DateTime? value) {
    writeStringValue(key, value?.toIso8601String());
  }

  @override
  void writeDoubleValue(String? key, double? value) {
    writeStringValue(key, value?.toString());
  }

  @override
  void writeEnumValue<T extends Enum>(
    String? key,
    T? value,
    EnumSerializer<T> serializer,
  ) {
    writeStringValue(key, serializer(value));
  }

  @override
  void writeIntValue(String? key, int? value) {
    writeStringValue(key, value?.toString());
  }

  @override
  void writeNullValue(String? key) {
    writeStringValue(key, 'null');
  }

  @override
  void writeObjectValue<T extends Parsable>(
    String? key,
    T? value, [
    Iterable<Parsable>? additionalValuesToMerge,
  ]) {
    if(value == null){
      return;
    }
    else if(key == null){
      _buffer.add(openingObject);
      value.serialize(this);
      removeSeparator();
      _buffer..add(closingObject)
      ..add(separator);
    }
    else
    {
      _buffer.add('"$key":$openingObject');
      value.serialize(this);
      removeSeparator();
      _buffer..add(closingObject)
      ..add(separator);
    }
  }

  @override
  void writeStringValue(String? key, String? value) {
  if (key?.isEmpty ?? true) {
      return;
    }
    // if the value is null or empty, we don't write anything
    if (value?.isEmpty ?? true) {
      return;
    }
    _buffer..add('"$key":"$value"')
    ..add(separator);
  }

  @override
  void writeDateOnlyValue(String? key, DateOnly? value) {
    writeStringValue(key, value?.toRfc3339String());
  }

  @override
  void writeDurationValue(String? key, Duration? value) {
    writeStringValue(key, value?.toString());
  }

  @override
  void writeTimeOnlyValue(String? key, TimeOnly? value) {
    writeStringValue(key, value?.toRfc3339String());
  }

  @override
  void writeUuidValue(String? key, UuidValue? value) {
    writeStringValue(key, value?.uuid);
  }

  void removeSeparator(){
    if(_buffer.last == separator){
      _buffer.removeLast();
    }
  }
}
