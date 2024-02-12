part of '../kiota_abstractions.dart';

/// Implements the [DateOnly] interface.
class DateOnlyImpl implements DateOnly {
  /// Extracts the date part of a [DateTime] and creates a new [DateOnlyImpl].
  factory DateOnlyImpl.fromDateTime(DateTime dateTime) {
    return DateOnlyImpl._(
      day: dateTime.day,
      month: dateTime.month,
      year: dateTime.year,
    );
  }

  /// This factory uses the [DateTime.parse] method to create a new
  /// [DateOnlyImpl] instance from a string.
  factory DateOnlyImpl.fromDateTimeString(String dateString) {
    final date = DateTime.parse(dateString);

    return DateOnlyImpl._(
      day: date.day,
      month: date.month,
      year: date.year,
    );
  }

  /// Creates a new [DateOnlyImpl] instance from the provided components.
  factory DateOnlyImpl.fromComponents(
    int year, [
    int month = 1,
    int day = 1,
  ]) {
    return DateOnlyImpl._(
      day: day,
      month: month,
      year: year,
    );
  }

  DateOnlyImpl._({
    required this.day,
    required this.month,
    required this.year,
  });

  @override
  final int day;

  @override
  final int month;

  @override
  final int year;
}
