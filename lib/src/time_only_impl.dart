part of '../kiota_abstractions.dart';

/// Implements the [TimeOnly] interface.
class TimeOnlyImpl implements TimeOnly {
  /// Extracts the time part of a [DateTime] and creates a new [TimeOnlyImpl].
  factory TimeOnlyImpl.fromDateTime(DateTime dateTime) {
    return TimeOnlyImpl._(
      hours: dateTime.hour,
      minutes: dateTime.minute,
      seconds: dateTime.second,
      milliseconds: dateTime.millisecond,
    );
  }

  /// This factory uses the [DateTime.parse] method to create a new
  /// [TimeOnlyImpl] instance from a string.
  factory TimeOnlyImpl.fromDateTimeString(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);

    return TimeOnlyImpl.fromDateTime(dateTime);
  }

  /// Constructs a new [TimeOnlyImpl] instance from the provided components.
  factory TimeOnlyImpl.fromComponents(
    int hours,
    int minutes, [
    int seconds = 0,
    int milliseconds = 0,
  ]) {
    return TimeOnlyImpl._(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
    );
  }

  TimeOnlyImpl._({
    required this.hours,
    required this.minutes,
    required this.seconds,
    required this.milliseconds,
  });

  @override
  final int hours;

  @override
  final int minutes;

  @override
  final int seconds;

  @override
  final int milliseconds;
}
