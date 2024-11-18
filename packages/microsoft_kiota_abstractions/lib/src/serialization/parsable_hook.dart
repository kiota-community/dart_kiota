part of '../../microsoft_kiota_abstractions.dart';

/// A hook that can be added before or after the parsing of a [Parsable] object.
///
/// See [ParseNode] or [ParseNodeProxyFactory] for abilities to add hooks to the
/// parsing of a [Parsable] object.
typedef ParsableHook = void Function(Parsable);
