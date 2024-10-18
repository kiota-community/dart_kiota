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
    for (final entry in value.entries) {
      if (entry.value is bool || entry.value is int || entry.value is double) {
        _buffer.add('"${entry.key}":${entry.value}');
      } else {
        _buffer.add('"${entry.key}":"${_getAnyValue(entry.value as Object)}"');
      }
      _buffer.add(separator);
    }
  }

  @override
  void writeBoolValue(String? key, {bool? value}) {
    writeUnquotedValue(key, value);
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
    if (values == null || values.isEmpty) {
      return;
    } else {
      final writeAsObject = _buffer.isEmpty;
      final opening = writeAsObject ? openingObject : '';
      _buffer.add('$opening"$key":$openingArray');
      var first = true;
      for (final value in values) {
        if (!first) {
          _buffer.add(separator);
        }
        first = false;
        _buffer.add('"${serializer(value)}"');
      }
      _buffer.add(closingArray);
      if (writeAsObject) {
        _buffer.add(closingObject);
      }
      _buffer.add(separator);
    }
  }

  @override
  void writeCollectionOfObjectValues<T extends Parsable>(
    String? key,
    Iterable<T>? values,
  ) {
    if (values == null || values.isEmpty) {
      return;
    } else {
      if (key?.isEmpty ?? true) {
        _buffer.add(openingArray);
      } else {
        _buffer.add('"$key":$openingArray');
      }
      var first = true;
      for (final value in values) {
        if (!first) {
          _buffer.add(separator);
        }
        first = false;
        _buffer.add(openingObject);
        value.serialize(this);
        removeSeparator();
        _buffer.add(closingObject);
      }
      _buffer
        ..add(closingArray)
        ..add(separator);
    }
  }

  @override
  void writeCollectionOfPrimitiveValues<T>(String? key, Iterable<T>? values) {
    if (values == null || values.isEmpty) {
      return;
    } else {
      final writeAsObject = _buffer.isEmpty;
      final opening = writeAsObject ? openingObject : '';
      _buffer.add('$opening"$key":$openingArray');
      var first = true;
      for (final value in values) {
        if (!first) {
          _buffer.add(separator);
        }
        first = false;
        if (value is bool || value is int || value is double) {
          _buffer.add('$value');
        } else {
          _buffer.add('"${_getAnyValue(value!)}"');
        }
      }
      _buffer.add(closingArray);
      if (writeAsObject) {
        _buffer.add(closingObject);
      }
      _buffer.add(separator);
    }
  }

  @override
  void writeDateTimeValue(String? key, DateTime? value) {
    writeStringValue(key, value?.toIso8601String());
  }

  @override
  void writeDoubleValue(String? key, double? value) {
    writeUnquotedValue(key, value);
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
    writeUnquotedValue(key, value);
  }

  @override
  void writeNullValue(String? key) {
    writeStringValue(key, 'null');
  }

  @override
  void writeObjectValue<T extends Parsable>(
    String? key,
    T? value, [
    Iterable<Parsable?>? additionalValuesToMerge,
  ]) {
    if (value == null && additionalValuesToMerge == null) {
      return;
    }
    if (value != null) {
      onBeforeObjectSerialization?.call(value);
    }

    if (key == null) {
      _buffer.add(openingObject);
    } else {
      _buffer.add('"$key":$openingObject');
    }
    if (value != null) {
      onStartObjectSerialization?.call(value, this);
      value.serialize(this);
    }
    if (additionalValuesToMerge != null) {
      for (final additionalValue in additionalValuesToMerge) {
        if (additionalValue != null) {
          onBeforeObjectSerialization?.call(additionalValue);
          onStartObjectSerialization?.call(additionalValue, this);

          additionalValue.serialize(this);

          onAfterObjectSerialization?.call(additionalValue);
        }
      }
    }
    removeSeparator();
    _buffer.add(closingObject);
    if (value != null) {
      onAfterObjectSerialization?.call(value);
    }
    _buffer.add(separator);
  }

  @override
  void writeStringValue(String? key, String? value) {
    // if the value is null or empty, we don't write anything
    if (value?.isEmpty ?? true) {
      return;
    }
    if (key?.isEmpty ?? true) {
      _buffer
        ..add('"$value"')
        ..add(separator);
    } else {
      _buffer
        ..add('"$key":"$value"')
        ..add(separator);
    }
  }

  void writeUnquotedValue(String? key, Object? value) {
    if (key?.isEmpty ?? true) {
      return;
    }
    // if the value is null or empty, we don't write anything
    if (value == null) {
      return;
    }
    _buffer
      ..add('"$key":$value')
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

  void removeSeparator() {
    if (_buffer.last == separator) {
      _buffer.removeLast();
    }
  }

  String _getAnyValue(Object value) {
    switch (value) {
      case final String s:
        return s;
      case final UuidValue u:
        return u.uuid;
      case final DateTime d:
        return d.toIso8601String();
      case final DateOnly d:
        return d.toRfc3339String();
      case final TimeOnly t:
        return t.toRfc3339String();
      default:
        return value.toString();
    }
  }
}
