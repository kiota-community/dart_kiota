part of '../../microsoft_kiota_abstractions.dart';

/// A factory that creates a proxy for a [ParseNodeFactory] that allows for
/// hooks to be added before and after the parsing of a [Parsable] object.
abstract class ParseNodeProxyFactory implements ParseNodeFactory {
  /// Creates a new instance of the [ParseNodeProxyFactory] class.
  ParseNodeProxyFactory({
    required ParseNodeFactory concrete,
    ParsableHook? onBefore,
    ParsableHook? onAfter,
  })  : _concrete = concrete,
        _onBefore = onBefore,
        _onAfter = onAfter;

  final ParseNodeFactory _concrete;
  final ParsableHook? _onBefore;
  final ParsableHook? _onAfter;

  @override
  String get validContentType => _concrete.validContentType;

  @override
  ParseNode getRootParseNode(String contentType, Uint8List content) {
    final node = _concrete.getRootParseNode(contentType, content);

    final originalBefore = node.onBeforeAssignFieldValues;
    node.onBeforeAssignFieldValues = (parsable) {
      originalBefore?.call(parsable);
      _onBefore?.call(parsable);
    };

    final originalAfter = node.onAfterAssignFieldValues;
    node.onAfterAssignFieldValues = (parsable) {
      originalAfter?.call(parsable);
      _onAfter?.call(parsable);
    };

    return node;
  }
}
