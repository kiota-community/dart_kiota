import 'package:kiota_abstractions/kiota_abstractions.dart';
import 'package:test/test.dart';

void main() {
  group('MultipartBody', () {
    test('Boundary is unique', () {
      final body1 = MultipartBody();
      final body2 = MultipartBody();

      expect(body1.boundary, isNot(equals(body2.boundary)));
    });
  });
}
