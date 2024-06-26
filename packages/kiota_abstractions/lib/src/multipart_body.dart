part of '../kiota_abstractions.dart';

/// Represents a multipart body for a request or a response
class MultipartBody implements Parsable {
  /// Generates a random sequence of 32 latin lowercase characters to use as a
  /// boundary for the multipart body.
  static String _generateBoundary() {
    final random = Random();
    final codeUnits = List<int>.generate(32, (i) {
      final codeUnit = random.nextInt(26) + 97;
      return codeUnit;
    });

    return String.fromCharCodes(codeUnits);
  }

  /// The request adapter to use for serialization.
  RequestAdapter? requestAdapter;

  /// The boundary to use for the multipart body.
  final String boundary = _generateBoundary();

  final Map<String, (String, dynamic)> _parts = {};

  /// Adds or replaces a part in the multipart body.
  void addOrReplace<T>(String partName, String contentType, T partValue) {
    if (partName.isEmpty) {
      throw ArgumentError('partName cannot be empty');
    }

    if (contentType.isEmpty) {
      throw ArgumentError('contentType cannot be empty');
    }

    if (partValue == null) {
      throw ArgumentError('partValue cannot be null');
    }

    final value = (contentType, partValue);

    _parts.addOrReplace(partName, value);
  }

  /// Gets the value of a part in the multipart body.
  T? getPartValue<T>(String partName) {
    if (partName.isEmpty) {
      throw ArgumentError('partName cannot be empty');
    }

    if (!_parts.containsKey(partName)) {
      return null;
    }

    return _parts[partName]!.$2 as T;
  }

  /// Removes a part from the multipart body.
  bool removePart(String partName) {
    if (partName.isEmpty) {
      throw ArgumentError('partName cannot be empty');
    }

    return _parts.remove(partName) != null;
  }

  @override
  Map<String, void Function(ParseNode)> getFieldDeserializers() =>
      throw UnimplementedError();

  @override
  void serialize(SerializationWriter writer) {
    final writerFactory = requestAdapter?.serializationWriterFactory;
    if (writerFactory == null) {
      throw StateError(
        'RequestAdapter and SerializationWriterFactory must not be null',
      );
    }

    if (_parts.isEmpty) {
      throw StateError('Multipart body must have at least one part');
    }

    var first = true;
    for (final part in _parts.entries) {
      final partContentType = part.value.$1;
      final partKey = part.key;
      final partValue = part.value.$2;

      if (first) {
        first = false;
      } else {
        _addNewLine(writer);
      }

      writer
        ..writeStringValue(null, '--$boundary')
        ..writeStringValue('Content-Type', partContentType)
        ..writeStringValue('Content-Disposition', 'form-data; name="$partKey"');

      _addNewLine(writer);

      if (partValue is Parsable) {
        final partWriter = writerFactory.getSerializationWriter(partContentType)
          ..writeObjectValue(null, partValue);

        final partContent = partWriter.getSerializedContent();

        writer.writeByteArrayValue(null, partContent);
      } else if (partValue is String) {
        writer.writeStringValue(null, partValue);
      } else if (partValue is Uint8List) {
        writer.writeByteArrayValue(null, partValue);
      } else if (partValue is List<int>) {
        writer.writeByteArrayValue(null, Uint8List.fromList(partValue));
      } else {
        throw UnsupportedError(
          'Unsupported type ${partValue.runtimeType} for part $partKey',
        );
      }
    }

    _addNewLine(writer);

    writer.writeStringValue(null, '--$boundary--');
  }

  void _addNewLine(SerializationWriter writer) =>
      writer.writeStringValue(null, '');
}
