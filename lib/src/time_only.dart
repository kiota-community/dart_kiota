part of '../kiota_abstractions.dart';

/// Interface for a time only object that represents a time of day.
///
/// This interface provides an abstraction layer over time only objects.
/// It is used to represent time only values in a serialization format agnostic
/// way.
abstract class TimeOnly {
  /// Extracts the time part of a [DateTime] and creates a new [TimeOnlyImpl].
  factory TimeOnly.fromDateTime(DateTime dateTime) {
    return TimeOnlyImpl(
      hours: dateTime.hour,
      minutes: dateTime.minute,
      seconds: dateTime.second,
      milliseconds: dateTime.millisecond,
    );
  }

  /// This factory uses the [DateTime.parse] method to create a new
  /// [TimeOnlyImpl] instance from a string.
  factory TimeOnly.fromDateTimeString(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);

    return TimeOnly.fromDateTime(dateTime);
  }

  /// Constructs a new [TimeOnlyImpl] instance from the provided components.
  factory TimeOnly.fromComponents(
    int hours,
    int minutes, [
    int seconds = 0,
    int milliseconds = 0,
  ]) {
    return TimeOnlyImpl(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
    );
  }

  /// Gets the hours of the time.
  int get hours;

  /// Gets the minutes of the time.
  int get minutes;

  /// Gets the seconds of the time.
  int get seconds;

  /// Gets the milliseconds of the time.
  int get milliseconds;
}
