import 'package:kiota_abstractions/kiota_abstractions.dart';
import 'package:test/test.dart';

void main() {
  group('TimeOnly', () {
    test('fromDateTimeString and toRfc3339String', () {
      expect(
        TimeOnly.fromDateTimeString('12:34:56').toRfc3339String(),
        '12:34:56',
      );
      expect(
        TimeOnly.fromDateTimeString('12:34').toRfc3339String(),
        '12:34:00',
      );
      expect(TimeOnly.fromDateTimeString('12').toRfc3339String(), '12:00:00');
    });

    test('fromDateTime', () {
      expect(
        TimeOnly.fromDateTime(DateTime(2024, 1, 1, 12, 34, 56))
            .toRfc3339String(),
        '12:34:56',
      );
    });

    test('fromComponents', () {
      expect(
        TimeOnly.fromComponents(12, 34, 56, 789).toRfc3339String(),
        '12:34:56.789',
      );
      expect(TimeOnly.fromComponents(12, 34, 56).toRfc3339String(), '12:34:56');
      expect(TimeOnly.fromComponents(12, 34).toRfc3339String(), '12:34:00');
    });
  });
}
