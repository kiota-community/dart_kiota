part of '../kiota_abstractions.dart';

/// Interface for a date only object.
///
/// This interface provides an abstraction layer over date only objects.
/// It is used to represent date only values in a serialization format agnostic
/// way.
///
/// It can only be used to represent a date in the Gregorian calendar.
abstract class DateOnly {
  /// Extracts the date part of a [DateTime] and creates a new [DateOnlyImpl].
  factory DateOnly.fromDateTime(DateTime dateTime) {
    return DateOnlyImpl(
      day: dateTime.day,
      month: dateTime.month,
      year: dateTime.year,
    );
  }

  /// This factory uses the [DateTime.parse] method to create a new
  /// [DateOnlyImpl] instance from a string.
  factory DateOnly.fromDateTimeString(String dateTimeString) {
    final date = DateTime.parse(dateTimeString);

    return DateOnly.fromDateTime(date);
  }

  /// Creates a new [DateOnlyImpl] instance from the provided components.
  factory DateOnly.fromComponents(
    int year, [
    int month = 1,
    int day = 1,
  ]) {
    return DateOnlyImpl(
      day: day,
      month: month,
      year: year,
    );
  }

  /// Gets the year of the date.
  int get year;

  /// Gets the month of the date.
  int get month;

  /// Gets the day of the date.
  int get day;
}
