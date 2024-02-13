part of '../../kiota_abstractions.dart';

/// Extension methods for [TimeOnly].
extension TimeOnlyExtensions on TimeOnly {
  /// Converts the [TimeOnly] to a [DateTime].
  DateTime toDateTime(
    int year, [
    int month = 1,
    int day = 1,
  ]) =>
      DateTime(
        year,
        month,
        day,
        hours,
        minutes,
        seconds,
        milliseconds,
      );

  /// Combines the [TimeOnly] with the given [DateOnly].
  DateTime combine(DateOnly date) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      hours,
      minutes,
      seconds,
      milliseconds,
    );
  }

  /// Converts the [TimeOnly] to a string in the format `HH:mm:ss.SSS`.
  String toRfc3339String() {
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${milliseconds.toString().padLeft(3, '0')}';
  }
}
