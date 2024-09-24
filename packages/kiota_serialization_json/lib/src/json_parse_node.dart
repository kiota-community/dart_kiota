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
        return JsonParseNode(childNode)
          ..onBeforeAssignFieldValues = onBeforeAssignFieldValues
          ..onAfterAssignFieldValues = onAfterAssignFieldValues;
      }
    }

    return null;
  }

  @override
  Iterable<T> getCollectionOfEnumValues<T extends Enum>(EnumFactory<T> factory) {
        final result = <T>[];
    if (_node is List) {
        for (final value in _node)
        { 
          final enumValue = factory(value.toString());
          if(enumValue != null) {
            result.add(enumValue);
          }
        }
    }
    return result;
  }

  @override
  Iterable<T> getCollectionOfObjectValues<T extends Parsable>(
    ParsableFactory<T> factory,
  ) {
    final result = <T>[];
    if (_node is List) {
       for (final value in _node)
        { 
          final node = JsonParseNode(value)
          ..onAfterAssignFieldValues = onAfterAssignFieldValues
          ..onBeforeAssignFieldValues = onBeforeAssignFieldValues;
          final objectValue = node.getObjectValue(factory);
          if(objectValue != null){
            result.add(objectValue);
            }
        }
    }
    return result;
  }

  @override
  Iterable<T> getCollectionOfPrimitiveValues<T>() {
    final result = <T>[];
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
    if (_node is Map) {
      onBeforeAssignFieldValues?.call(item);

      final itemAdditionalData = item is AdditionalDataHolder
          ? (item as AdditionalDataHolder).additionalData
          : null;

      final fieldDeserializers = item.getFieldDeserializers();

      for (final entry in _node.entries) {
        if (fieldDeserializers.containsKey(entry.key)) {
          final fieldDeserializer = fieldDeserializers[entry.key];
          if (fieldDeserializer != null) {
            final itemNode = JsonParseNode(entry.value)
              ..onBeforeAssignFieldValues = onBeforeAssignFieldValues
              ..onAfterAssignFieldValues = onAfterAssignFieldValues;
            fieldDeserializer.call(itemNode);
          }
        } else {
          itemAdditionalData?[entry.key as String] = entry.value;
        }
      }
      onAfterAssignFieldValues?.call(item);
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
