part of '../kiota_abstractions.dart';

class _EnumRegistration {
  _EnumRegistration(this.enumType, this.cases);

  final Type enumType;
  final List<Enum> cases;
}

/// This is a helper class to register [Enum] cases so they can be used in
/// serialization and deserialization.
class EnumRegistry {
  EnumRegistry._();

  static final Map<Type, _EnumRegistration> _registrations = {};

  /// Registers the [cases] for the [Enum] type [T].
  static void register<T extends Enum>(List<T> cases) {
    _registrations[T] = _EnumRegistration(T, cases);
  }

  /// Removes the registration for the [Enum] type [T].
  static void unregister<T extends Enum>() {
    _registrations.remove(T);
  }

  /// Gets the string value of the [value] of the [Enum] type [T].
  ///
  /// Throws an [ArgumentError] if the [Enum] type [T] is not registered.
  static String? getCaseValue<T extends Enum>(T? value) {
    if (value == null) {
      return null;
    }

    final registration = EnumRegistry._registrations[T];
    if (registration == null) {
      throw ArgumentError('Enum type $T is not registered');
    }

    return value.name;
  }

  /// Gets the [Enum] case of the [value] of the type [T].
  ///
  /// Throws an [ArgumentError] if the [Enum] type [T] is not registered.
  static T? getCase<T extends Enum>(String? value) {
    if (value == null) {
      return null;
    }

    final registration = EnumRegistry._registrations[T];
    if (registration == null) {
      throw ArgumentError('Enum type $T is not registered');
    }

    final lowerCaseValue = value.toLowerCase();

    return registration.cases.cast<T?>().firstWhere(
          (x) => (x! as Enum).name.toLowerCase() == lowerCaseValue,
          orElse: () => null,
        );
  }
}
