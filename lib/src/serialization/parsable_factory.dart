part of '../../dart_kiota.dart';

/// Defines the factory for creating parsable objects. The [node] used to get
/// the discriminator value from the payload.
/// Returns the [Parsable] object.
typedef ParsableFactory<T extends Parsable> = T Function(ParseNode node);
