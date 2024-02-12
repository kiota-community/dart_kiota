part of '../kiota_abstractions.dart';

/// Implements the [DateOnly] interface.
class DateOnlyImpl implements DateOnly {
  DateOnlyImpl({
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
