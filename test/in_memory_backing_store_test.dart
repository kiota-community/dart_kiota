import 'package:kiota_abstractions/kiota_abstractions.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';

import 'in_memory_backing_store_test.mocks.dart';

@GenerateMocks([BackedModel])
void main() {
  group('InMemoryBackingStore', () {
    test('stores values by key', () {
      final store = InMemoryBackingStore()..set('key', 'value');

      expect(store.get<String>('key'), 'value');
    });

    test('clears all values', () {
      final store = InMemoryBackingStore()
        ..set('key', 'value')
        ..set('key2', 'value2')
        ..clear();

      expect(store.get<String>('key'), null);
    });

    test('iterates over all values', () {
      final store = InMemoryBackingStore();

      expect(store.iterate(), isEmpty);

      store
        ..set('key', 'value')
        ..set('key2', 'value2');

      final entries = store.iterate().toList();

      expect(entries, hasLength(2));
      expect(
        entries.map((e) => e.key),
        containsAll(['key', 'key2']),
      );
      expect(
        entries.map((e) => e.value),
        containsAll(['value', 'value2']),
      );
    });

    test('iterates over all values that have changed to null', () {
      final store = InMemoryBackingStore()
        ..set('name', 'Peter Pan')
        ..set('email', 'peterpan@neverland.com')
        ..set('phone', null);

      final changedToNullEntries =
          store.iterateKeysForValuesChangedToNull().toList();
      final entries = store.iterate().toList();

      expect(entries, hasLength(3));
      expect(changedToNullEntries, hasLength(1));
      expect(changedToNullEntries, contains('phone'));
    });

    test('prevents duplicates in store', () {
      final store = InMemoryBackingStore();

      expect(store.iterate(), isEmpty);

      store
        ..set('key', 'value')
        ..set('key', 'value2');

      expect(store.iterate(), hasLength(1));
      expect(store.get<String>('key'), 'value2');
    });
  });
}
