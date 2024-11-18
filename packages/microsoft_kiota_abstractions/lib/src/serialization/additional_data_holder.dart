part of '../../microsoft_kiota_abstractions.dart';

/// Defines a contract for models that can hold additional data besides the
/// properties defined in the model.
abstract class AdditionalDataHolder {
  /// Additional data that is not part of the model's properties.
  Map<String, Object?> additionalData = {};
}
