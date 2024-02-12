part of '../kiota_abstractions.dart';

/// Implements the [TimeOnly] interface.
class TimeOnlyImpl implements TimeOnly {
  TimeOnlyImpl({
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
