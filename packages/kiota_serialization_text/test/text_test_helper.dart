import 'package:test/test.dart';

final throwsNoStructuredDataError = throwsA(
  isA<UnsupportedError>().having(
        (e) => e.message,
    'message',
    equals('Text does not support structured data'),
  ),
);
