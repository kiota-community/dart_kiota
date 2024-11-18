part of '../../microsoft_kiota_abstractions.dart';

/// Defines the factory for creating enum objects from a string value.
typedef EnumFactory<T extends Enum> = T? Function(String value);
