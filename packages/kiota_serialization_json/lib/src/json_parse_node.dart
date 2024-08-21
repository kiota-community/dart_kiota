part of '../kiota_serialization_json.dart';

class JsonParseNode implements ParseNode {
  JsonParseNode(this._json);

  final dynamic _json;

  @override
  ParsableHook? onAfterAssignFieldValues;

  @override
  ParsableHook? onBeforeAssignFieldValues;

  @override
  bool? getBoolValue() {
    return _json == null ? null : bool.tryParse(_json.toString());
  }

  @override
  Uint8List? getByteArrayValue() {
    return _json == null ? null : base64Decode(_json.toString());
  }

  @override
  ParseNode? getChildNode(String identifier) {
    return null;
  }

  @override
  Iterable<T> getCollectionOfEnumValues<T extends Enum>(EnumFactory<T> parser) {
    return [];
  }

  @override
  Iterable<T> getCollectionOfObjectValues<T extends Parsable>(
    ParsableFactory<T> factory,
  ) {
    return [];
  }

  @override
  Iterable<T> getCollectionOfPrimitiveValues<T>() {
    return [];
  }

  @override
  DateOnly? getDateOnlyValue() {
    return _json == null ? null : DateOnly.fromDateTimeString(_json.toString());
  }

  @override
  DateTime? getDateTimeValue() {
    return _json == null ? null : DateTime.tryParse(_json.toString());
  }

  @override
  double? getDoubleValue() {
    return _json == null ? null : double.tryParse(_json.toString());
  }

  @override
  Duration? getDurationValue() {
    return _json == null ? null : DurationExtensions.tryParse(_json.toString());
  }

  @override
  T? getEnumValue<T extends Enum>(EnumFactory<T> parser) {
    // if (_json == null || _json.isEmpty) {
    //   return null;
    // }
    // TODO(kees): Restore original code above
    return parser(_json.toString());
  }

  @override
  UuidValue? getGuidValue() {
    return _json == null ? null : UuidValue.withValidation(_json.toString());
  }

  @override
  int? getIntValue() {
    return _json == null ? null : int.tryParse(_json.toString());
  }

  @override
  T? getObjectValue<T extends Parsable>(ParsableFactory<T> factory) {
    // TODO(Kees): Needs a proper implementation
    final item = factory(this);
    // OnBeforeAssignFieldValues?.Invoke(item);
    _assignFieldValues(item);
    // OnAfterAssignFieldValues?.Invoke(item);
    return item;
  }

  void _assignFieldValues<T extends Parsable>(T item) {
    final fieldDeserializers = item.getFieldDeserializers();

    if (_json is Map) {
      for (final entry in _json.entries) {
        if (fieldDeserializers.containsKey(entry.key)) {
          print('Found property: ${entry.key} to deserialize');

          final fieldDeserializer = fieldDeserializers[entry.key];
          fieldDeserializer!.call(JsonParseNode(entry.value));
        }
      }
    }
  }

  @override
  String? getStringValue() {
    final result = _json.toString();
    return result == 'null' ? null : result;
  }

  @override
  TimeOnly? getTimeOnlyValue() {
    return _json == null ? null : TimeOnly.fromDateTimeString(_json.toString());
  }
}
