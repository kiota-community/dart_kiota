import 'package:microsoft_kiota_abstractions/microsoft_kiota_abstractions.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';

import 'request_builder_test.mocks.dart';

class SampleRequestBuilder extends BaseRequestBuilder<SampleRequestBuilder> {
  SampleRequestBuilder(
    this.id,
    super.requestAdapter,
    super.urlTemplate,
    super.pathParameters,
  );

  final int id;

  @override
  SampleRequestBuilder clone() {
    return SampleRequestBuilder(
      id,
      requestAdapter,
      urlTemplate,
      {...pathParameters},
    );
  }
}

@GenerateMocks([RequestAdapter])
void main() {
  test('BaseRequestBuilder.withUrl', () {
    final mockRequestAdapter = MockRequestAdapter();

    final requestBuilder = SampleRequestBuilder(
      1,
      mockRequestAdapter,
      'https://graph.microsoft.com/v1.0/users/{id}',
      {'id': '1'},
    );

    final newRequestBuilder =
        requestBuilder.withUrl('https://graph.microsoft.com/v2.0/users/123');

    expect(newRequestBuilder.id, equals(1));
    expect(
      newRequestBuilder.pathParameters,
      equals({
        'id': '1',
        'request-raw-url': 'https://graph.microsoft.com/v2.0/users/123',
      }),
    );

    // make sure the original requestBuilder is not modified
    expect(
      requestBuilder.pathParameters,
      equals({'id': '1'}),
    );
  });
}
