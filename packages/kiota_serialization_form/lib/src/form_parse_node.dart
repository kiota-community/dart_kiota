part of '../kiota_serialization_form.dart';

class FormParseNode implements ParseNode {
  FormParseNode({required String value})
      : _rawValue = value,
        _fields = _parseFields(value);

  static Map<String, String> _parseFields(String value) {
    final fields = value.split('&');
    final result = CaseInsensitiveMap<String, List<String>>();

    for (final field in fields) {
      if (field.isEmpty) {
        continue;
      }

      final parts = field.split('=');
      if (parts.length != 2) {
        continue;
      }

      final key = _sanitizeKey(parts[0]);
      final value = _sanitizeValue(parts[1]);

      if (!result.containsKey(key)) {
        result[key] = [];
      }

      result[key]!.add(value);
    }

    return result.map((key, values) {
      return MapEntry(key, values.join(','));
    });
  }

  static String _sanitizeKey(String key) {
    return Uri.decodeQueryComponent(key.trim());
  }

  static String _sanitizeValue(String value) {
    return Uri.decodeQueryComponent(value.trim());
  }

  final String _rawValue;
  final Map<String, String> _fields;

  String get _decodedValue => Uri.decodeQueryComponent(_rawValue);

  @override
  ParsableHook? onAfterAssignFieldValues;

  @override
  ParsableHook? onBeforeAssignFieldValues;

  @override
  bool? getBoolValue() {
    final value = _decodedValue;
    if (value.isEmpty) {
      return null;
    }

    return bool.tryParse(value);
  }

  @override
  Uint8List? getByteArrayValue() {
    final value = _decodedValue;

    if (value.isEmpty) {
      return null;
    }

    return base64Decode(value);
  }

  @override
  ParseNode? getChildNode(String identifier) {
    final sanitizedIdentifier = _sanitizeKey(identifier);

    if (!_fields.containsKey(sanitizedIdentifier)) {
      return null;
    }

    return FormParseNode(value: _fields[sanitizedIdentifier]!);
  }

  @override
  Iterable<T> getCollectionOfEnumValues<T extends Enum>() sync* {
    final collection =
        _decodedValue.split(',').where((entry) => entry.isNotEmpty);

    for (final entry in collection) {
      final node = new FormParseNode(value: entry)
        ..onAfterAssignFieldValues = onAfterAssignFieldValues
        ..onBeforeAssignFieldValues = onBeforeAssignFieldValues;

      yield node.getEnumValue<T>()!;
    }
  }

  @override
  Iterable<T> getCollectionOfObjectValues<T extends Parsable>(
    ParsableFactory<T> factory,
  ) {
    throw UnsupportedError(
      'Collections are not supported with uri form encoding',
    );
  }

  @override
  Iterable<T> getCollectionOfPrimitiveValues<T>() sync* {
    final collection =
        _decodedValue.split(',').where((entry) => entry.isNotEmpty);

    final T Function(FormParseNode node) converter;
    switch (T) {
      case const (bool):
        converter = (node) => node.getBoolValue() as T;
        break;
      case const (int):
        converter = (node) => node.getIntValue() as T;
        break;
      case const (double):
        converter = (node) => node.getDoubleValue() as T;
        break;
      case const (String):
        converter = (node) => node.getStringValue() as T;
        break;
      case const (DateTime):
        converter = (node) => node.getDateTimeValue() as T;
        break;
      case const (DateOnly):
        converter = (node) => node.getDateOnlyValue() as T;
        break;
      case const (TimeOnly):
        converter = (node) => node.getTimeOnlyValue() as T;
        break;
      case const (Duration):
        converter = (node) => node.getDurationValue() as T;
        break;
      case const (UuidValue):
        converter = (node) => node.getGuidValue() as T;
        break;
      default:
        throw UnsupportedError('Unsupported primitive type $T');
    }

    for (final entry in collection) {
      final node = new FormParseNode(value: entry)
        ..onAfterAssignFieldValues = onAfterAssignFieldValues
        ..onBeforeAssignFieldValues = onBeforeAssignFieldValues;

      yield converter(node);
    }
  }

  @override
  DateOnly? getDateOnlyValue() {
    return DateOnly.fromDateTimeString(_decodedValue);
  }

  @override
  DateTime? getDateTimeValue() {
    return DateTime.tryParse(_decodedValue);
  }

  @override
  double? getDoubleValue() {
    return double.tryParse(_decodedValue);
  }

  @override
  Duration? getDurationValue() {
    // TODO(ricardoboss): Need this to be merged: https://github.com/ricardoboss/dart_kiota/blob/f6331f769fe9067d48bde075aaea1fd22e89a83a/packages/kiota_abstractions/lib/src/extensions/duration_extensions.dart
    throw UnsupportedError('Duration deserialization is not supported yet');
  }

  @override
  T? getEnumValue<T extends Enum>() {
    final value = _decodedValue;
    if (value.isEmpty) {
      return null;
    }

    return EnumRegistry.getCase<T>(value);
  }

  @override
  UuidValue? getGuidValue() {
    final value = _decodedValue;
    if (value.isEmpty) {
      return null;
    }

    return UuidValue.withValidation(value);
  }

  @override
  int? getIntValue() {
    return int.tryParse(_decodedValue);
  }

  @override
  T? getObjectValue<T extends Parsable>(ParsableFactory<T> factory) {
    // TODO: implement getObjectValue
    throw UnimplementedError();
  }

  @override
  String? getStringValue() {
    return _decodedValue;
  }

  @override
  TimeOnly? getTimeOnlyValue() {
    return TimeOnly.fromDateTimeString(_decodedValue);
  }
}
