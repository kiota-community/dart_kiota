part of '../../microsoft_kiota_abstractions.dart';

/// Defines the contract for a callback that is invoked when a value in the
/// [BackingStore] changes.
typedef BackingStoreSubscriptionCallback = void Function(
  String dataKey,
  Object? previousValue,
  Object? newValue,
);
