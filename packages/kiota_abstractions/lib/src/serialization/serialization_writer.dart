part of '../../kiota_abstractions.dart';

/// Defines the contract for serialization of objects to a [Uint8List].
abstract class SerializationWriter {
  /// Writes the specified string value to the buffer with an optional given
  /// [key].
  FutureOr<void> writeStringValue(String? key, String? value);

  /// Writes the specified int value to the buffer with an optional given
  /// [key].
  FutureOr<void> writeBoolValue(String? key, {bool? value});

  /// Writes the specified int value to the buffer with an optional given
  /// [key].
  FutureOr<void> writeIntValue(String? key, int? value);

  /// Writes the specified double value to the buffer with an optional given
  /// [key].
  FutureOr<void> writeDoubleValue(String? key, double? value);

  /// Writes the specified [DateTime] value to the buffer with an optional given
  /// [key].
  FutureOr<void> writeDateTimeValue(String? key, DateTime? value);

  /// Writes the specified collection of primitive values to the buffer with an
  /// optional given [key].
  FutureOr<void> writeCollectionOfPrimitiveValues<T>(
    String? key,
    Iterable<T>? values,
  );

  /// Writes the specified collection of [T] object values to the buffer with an
  /// optional given [key].
  FutureOr<void> writeCollectionOfObjectValues<T extends Parsable>(
    String? key,
    Iterable<T>? values,
  );

  /// Writes the specified collection of enum [T] values to the buffer with an
  /// optional given [key].
  FutureOr<void> writeCollectionOfEnumValues<T extends Enum>(
    String? key,
    Iterable<T>? values,
  );

  /// Writes the specified byte list as a base64 string to the buffer with an
  /// optional given [key].
  FutureOr<void> writeByteArrayValue(String? key, Uint8List? value);

  /// Writes the specified model object to the buffer with an optional given
  /// [key].
  /// The [additionalValuesToMerge] parameter is used to merge additional
  /// values to the main object when serializing an intersection wrapper.
  FutureOr<void> writeObjectValue<T extends Parsable>(
    String? key,
    T? value, [
    Iterable<Parsable>? additionalValuesToMerge,
  ]);

  /// Writes the specified enum value to the buffer with an optional given
  /// [key].
  FutureOr<void> writeEnumValue<T extends Enum>(String? key, T? value);

  /// Writes a null value for the specified [key].
  FutureOr<void> writeNullValue(String? key);

  /// Writes the specified additional data to the buffer.
  FutureOr<void> writeAdditionalData(Map<String, dynamic> value);

  /// Gets the value of the serialized content.
  FutureOr<Uint8List> getSerializedContent();

  /// Callback called before the serialization process starts.
  ParsableHook? onBeforeObjectSerialization;

  /// Callback called after the serialization process ends.
  ParsableHook? onAfterObjectSerialization;

  /// Callback called right after the serialization process starts.
  void Function(Parsable, SerializationWriter)? onStartObjectSerialization;
}
