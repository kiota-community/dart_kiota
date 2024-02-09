part of '../kiota_abstractions.dart';

/// Interface for a time only object that represents a time of day.
///
/// This interface provides an abstraction layer over time only objects.
/// It is used to represent time only values in a serialization format agnostic
/// way.
abstract class TimeOnly {
  /// Gets the hours of the time.
  int get hours;

  /// Gets the minutes of the time.
  int get minutes;

  /// Gets the seconds of the time.
  int get seconds;

  /// Gets the milliseconds of the time.
  int get milliseconds;
}
