part of '../kiota_abstractions.dart';

/// This is a helper class to register [Enum] cases so they can be used in
/// serialization and deserialization.
class EnumRegistry {
  EnumRegistry._();

  static final Map<Type, List<Enum>> _enumCases = {};

  /// Registers the [cases] for the [Enum] type [T].
  static void register<T extends Enum>(List<T> cases) {
    _enumCases[T] = cases;
  }

  /// Gets the string value of the [value] of the [Enum] type [T].
  ///
  /// Throws an [ArgumentError] if the [Enum] type [T] is not registered.
  static String? getCaseValue<T extends Enum>(T? value) {
    if (value == null) {
      return null;
    }

    final cases = EnumRegistry._enumCases[T];
    if (cases == null) {
      throw ArgumentError('Enum type $T is not registered');
    }

    return cases
        .cast<T?>()
        .firstWhere((x) => x == value, orElse: () => null)
        ?.toString();
  }

  /// Gets the [Enum] case of the [value] of the type [T].
  ///
  /// Throws an [ArgumentError] if the [Enum] type [T] is not registered.
  static T? getCase<T extends Enum>(String? value) {
    if (value == null) {
      return null;
    }

    final cases = EnumRegistry._enumCases[T];
    if (cases == null) {
      throw ArgumentError('Enum type $T is not registered');
    }

    return cases.cast<T?>().firstWhere((x) => x == value, orElse: () => null);
  }
}
