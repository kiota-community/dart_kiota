import 'package:kiota_abstractions/kiota_abstractions.dart';
import 'package:test/test.dart';

void main() {
  test('HttpHeader keys are case-insensitive', () {
    final headers = HttpHeaders()..['content-type'] = 'application/json';

    expect(headers.length, 1);
    expect(headers['content-type'], 'application/json');
    expect(headers['Content-Type'], 'application/json');

    headers['Content-Type'] = 'application/xml';

    expect(headers.length, 1);
    expect(headers['content-type'], 'application/xml');
    expect(headers['Content-Type'], 'application/xml');

    // should not get added as a new key
    headers.putIfAbsent('CONTENT-TYPE', () => 'application/json');

    expect(headers.length, 1);
    expect(headers['CONTENT-TYPE'], 'application/xml');
  });

  test('HttpHeader preserves original case', () {
    final headers = HttpHeaders();

    headers['Content-Type'] = 'application/json';

    expect(headers.keys.first, 'Content-Type');

    // This should overwrite the previous key
    headers['content-type'] = 'application/xml';

    expect(headers.keys.first, 'content-type');
  });
}
