part of '../kiota_serialization_json.dart';

class JsonParseNode implements ParseNode {
  JsonParseNode(this._node);

  final dynamic _node;

  @override
  ParsableHook? onAfterAssignFieldValues;

  @override
  ParsableHook? onBeforeAssignFieldValues;

  @override
  bool? getBoolValue() {
    return _node == null ? null : bool.tryParse(_node.toString());
  }

  @override
  Uint8List? getByteArrayValue() {
    return _node == null ? null : base64Decode(_node.toString());
  }

  @override
  ParseNode? getChildNode(String identifier) {
    if (_node is Map) {
      final childNode = _node[identifier];
      if (childNode != null) {
        final result = JsonParseNode(childNode);
        // TODO(Kees): Call on... events
        // result.onBeforeAssignFieldValues((f) => onBeforeAssignFieldValues);
        // result.onAfterAssignFieldValues(onAfterAssignFieldValues);
        return result;
      }
      
      return null;
    }
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
    final result = <T> [];
    if (_node is List) {
      _node.forEach((value) => result.add(value as T));
    }
        
    return result;
  }

  @override
  DateOnly? getDateOnlyValue() {
    return _node == null ? null : DateOnly.fromDateTimeString(_node.toString());
  }

  @override
  DateTime? getDateTimeValue() {
    return _node == null ? null : DateTime.tryParse(_node.toString());
  }

  @override
  double? getDoubleValue() {
    return _node == null ? null : double.tryParse(_node.toString());
  }

  @override
  Duration? getDurationValue() {
    return _node == null ? null : DurationExtensions.tryParse(_node.toString());
  }

  @override
  T? getEnumValue<T extends Enum>(EnumFactory<T> parser) {
    return _node == null ? null : parser(_node.toString());
  }

  @override
  UuidValue? getGuidValue() {
    return _node == null ? null : UuidValue.withValidation(_node.toString());
  }

  @override
  int? getIntValue() {
    return _node == null ? null : int.tryParse(_node.toString());
  }

  @override
  T? getObjectValue<T extends Parsable>(ParsableFactory<T> factory) {
    // TODO(Kees): Handle getting untyped value
    final item = factory(this);
    onBeforeAssignFieldValues?.call(item);
    _assignFieldValues(item);
    onAfterAssignFieldValues?.call(item);

    return item;
  }

  void _assignFieldValues<T extends Parsable>(T item) {
    final fieldDeserializers = item.getFieldDeserializers();

    if (_node is Map) {
      for (final entry in _node.entries) {
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
    final result = _node.toString();
    return result == 'null' ? null : result;
  }

  @override
  TimeOnly? getTimeOnlyValue() {
    return _node == null ? null : TimeOnly.fromDateTimeString(_node.toString());
  }
}
