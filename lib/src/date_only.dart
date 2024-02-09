part of '../kiota_abstractions.dart';

/// Interface for a date only object.
///
/// This interface provides an abstraction layer over date only objects.
/// It is used to represent date only values in a serialization format agnostic
/// way.
///
/// It can only be used to represent a date in the Gregorian calendar.
abstract class DateOnly {
  /// Gets the year of the date.
  int get year;

  /// Gets the month of the date.
  int get month;

  /// Gets the day of the date.
  int get day;
}
