import 'package:kiota_abstractions/kiota_abstractions.dart';
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
      pathParameters,
    );
  }
}

@GenerateMocks([RequestAdapter])
void main() {
  test('BaseRequestBuilder.copyWith', () {
    final mockRequestAdapter = MockRequestAdapter();

    final requestBuilder = SampleRequestBuilder(
      1,
      mockRequestAdapter,
      'https://graph.microsoft.com/v1.0/users/{id}',
      {'id': '1'},
    );

    final anotherRequestAdapter = MockRequestAdapter();

    final newRequestBuilder = requestBuilder.copyWith(
      requestAdapter: anotherRequestAdapter,
      urlTemplate: 'https://graph.microsoft.com/v2.0/users/{id}',
      pathParameters: {'id': '2'},
    );

    expect(newRequestBuilder.id, equals(1));
    expect(newRequestBuilder.requestAdapter, equals(anotherRequestAdapter));
    expect(
      newRequestBuilder.urlTemplate,
      equals('https://graph.microsoft.com/v2.0/users/{id}'),
    );
    expect(newRequestBuilder.pathParameters, equals({'id': '2'}));
  });
}
