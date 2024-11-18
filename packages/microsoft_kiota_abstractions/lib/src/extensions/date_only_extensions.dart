part of '../../microsoft_kiota_abstractions.dart';

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

  /// Converts the [DateOnly] to a string in the format `yyyy-MM-dd`.
  String toRfc3339String() {
    return '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }
}
