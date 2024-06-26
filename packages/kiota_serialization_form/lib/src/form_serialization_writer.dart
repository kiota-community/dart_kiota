part of '../kiota_serialization_form.dart';

/// Represents a serialization writer that can be used to write a form url
/// encoded string.
class FormSerializationWriter implements SerializationWriter {
  final StringBuffer _buffer = StringBuffer();
  int depth = 0;

  @override
  ParsableHook? onAfterObjectSerialization;

  @override
  ParsableHook? onBeforeObjectSerialization;

  @override
  void Function(Parsable p, SerializationWriter w)? onStartObjectSerialization;

  @override
  Uint8List getSerializedContent() {
    return utf8.encode(_buffer.toString());
  }

  @override
  void writeAdditionalData(Map<String, dynamic> value) {
    for (final entry in value.entries) {
      _writeAnyValue(entry.key, entry.value);
    }
  }

  void _writeAnyValue(String key, Object? value) {
    switch (value) {
      case null:
        writeNullValue(key);
      case final bool b:
        writeBoolValue(key, value: b);
      case final int i:
        writeIntValue(key, i);
      case final double d:
        writeDoubleValue(key, d);
      case final String s:
        writeStringValue(key, s);
      case final DateTime d:
        writeDateTimeValue(key, d);
      case final DateOnly d:
        writeDateOnlyValue(key, d);
      case final TimeOnly t:
        writeTimeOnlyValue(key, t);
      case final Duration d:
        writeDurationValue(key, d);
      case final UuidValue u:
        writeUuidValue(key, u);
      default:
        writeStringValue(key, value.toString());
    }
  }

  @override
  void writeBoolValue(String? key, {bool? value}) {
    if (value != null) {
      writeStringValue(key, value.toString().toLowerCase());
    }
  }

  @override
  void writeByteArrayValue(String? key, Uint8List? value) {
    if (value != null) {
      writeStringValue(key, base64Encode(value));
    }
  }

  @override
  void writeCollectionOfEnumValues<T extends Enum>(
    String? key,
    Iterable<T>? values,
  ) {
    // TODO: implement writeCollectionOfEnumValues
  }

  @override
  void writeCollectionOfObjectValues<T extends Parsable>(
    String? key,
    Iterable<T>? values,
  ) {
    // TODO: implement writeCollectionOfObjectValues
  }

  @override
  void writeCollectionOfPrimitiveValues<T>(String? key, Iterable<T>? values) {
    // TODO: implement writeCollectionOfPrimitiveValues
  }

  @override
  void writeDateTimeValue(String? key, DateTime? value) {
    if (value != null) {
      writeStringValue(key, value.toIso8601String());
    }
  }

  @override
  void writeDoubleValue(String? key, double? value) {
    if (value != null) {
      writeStringValue(key, value.toString());
    }
  }

  @override
  void writeEnumValue<T extends Enum>(String? key, T? value) {
    // TODO: implement writeEnumValue
  }

  @override
  void writeIntValue(String? key, int? value) {
    if (value != null) {
      writeStringValue(key, value.toString());
    }
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
    // TODO: implement writeObjectValue
  }

  @override
  void writeStringValue(String? key, String? value) {
    if (key == null || value == null) {
      return;
    }

    if (_buffer.isNotEmpty) {
      _buffer.write('&');
    }

    _buffer
      ..write(Uri.encodeQueryComponent(key))
      ..write('=')
      ..write(Uri.encodeQueryComponent(value));
  }

  @override
  void writeDateOnlyValue(String? key, DateOnly? value) {
    if (value != null) {
      writeStringValue(key, value.toRfc3339String());
    }
  }

  @override
  void writeDurationValue(String? key, Duration? value) {
    if (value != null) {
      writeStringValue(key, value.toString());
    }
  }

  @override
  void writeTimeOnlyValue(String? key, TimeOnly? value) {
    if (value != null) {
      writeStringValue(key, value.toRfc3339String());
    }
  }

  @override
  void writeUuidValue(String? key, UuidValue? value) {
    if (value != null) {
      writeStringValue(key, value.uuid);
    }
  }
}
