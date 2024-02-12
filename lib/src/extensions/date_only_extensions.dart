part of '../../kiota_abstractions.dart';

/// Extension methods for [DateOnly].
extension DateOnlyExtensions on DateOnly {
  /// Converts the [DateOnly] to a [DateTime].
  DateTime toDateTime() => DateTime(year, month, day);

  /// Combines the [DateOnly] with the given [TimeOnly].
  DateTime combine(TimeOnly time) {
    return DateTime(
      year,
      month,
      day,
      time.hours,
      time.minutes,
      time.seconds,
      time.milliseconds,
    );
  }
}
