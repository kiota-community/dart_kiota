import 'package:kiota_abstractions/kiota_abstractions.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
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

    test('propagates initialization completed to backed models', () {
      final aModel = MockBackedModel();
      final aStore = InMemoryBackingStore();

      when(aModel.backingStore).thenReturn(aStore);

      final bStore = InMemoryBackingStore();

      expect(aStore.initializationCompleted, isTrue);
      expect(bStore.initializationCompleted, isTrue);

      bStore
        ..set('aModel', aModel)
        ..initializationCompleted = false;

      expect(aStore.initializationCompleted, isFalse);
      expect(bStore.initializationCompleted, isFalse);

      bStore.initializationCompleted = true;

      expect(aStore.initializationCompleted, isTrue);
      expect(bStore.initializationCompleted, isTrue);

      final cModel = MockBackedModel();
      final cStore = InMemoryBackingStore();
      when(cModel.backingStore).thenReturn(cStore);

      bStore.set('cModel', cModel);
    });

    test('subscriptions get notified', () {
      final store = InMemoryBackingStore();

      String? key;
      Object? oldValue;
      Object? newValue;
      final subscriptionId = store.subscribe((k, a, b) {
        key = k;
        oldValue = a;
        newValue = b;
      });

      store.set('name', 'Peter');

      expect(key, 'name');
      expect(oldValue, null);
      expect(newValue, 'Peter');
      expect(subscriptionId, isNotNull);
    });
  });
}
