part of '../../kiota_abstractions.dart';

/// Defines the contract for a factory that creates parse nodes.
abstract class ParseNodeFactory {
  /// Returns the content type this factory's parse nodes can deserialize.
  String get validContentType;

  /// Create a parse node from the given bytes and content type.
  ParseNode getRootParseNode(String contentType, Uint8List content);
}
