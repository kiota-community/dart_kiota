part of '../microsoft_kiota_bundle.dart';

/// The [RequestAdapter] implementation that is derived from
/// [HttpClientRequestAdapter] with default serializers and deserializers
/// registered.
class DefaultRequestAdapter extends HttpClientRequestAdapter {
  /// Creates a new [DefaultRequestAdapter] instance with the given [client],
  /// [authProvider], [pNodeFactory] and [sWriterFactory].
  ///
  /// Implicitly registers the following default serializers:
  /// - [JsonSerializationWriterFactory]
  /// - [TextSerializationWriterFactory]
  /// - [FormSerializationWriterFactory]
  /// - [MultipartSerializationWriterFactory]
  ///
  /// Implicitly registers the following default deserializers:
  /// - [JsonParseNodeFactory]
  /// - [TextParseNodeFactory]
  /// - [FormParseNodeFactory]
  DefaultRequestAdapter({
    required super.client,
    required super.authProvider,
    required super.pNodeFactory,
    required super.sWriterFactory,
  }) {
    _setupDefaults();
  }

  static void _setupDefaults() {
    ApiClientBuilder.registerDefaultSerializer(
      JsonSerializationWriterFactory.new,
    );
    ApiClientBuilder.registerDefaultSerializer(
      TextSerializationWriterFactory.new,
    );
    ApiClientBuilder.registerDefaultSerializer(
      FormSerializationWriterFactory.new,
    );
    ApiClientBuilder.registerDefaultSerializer(
      MultipartSerializationWriterFactory.new,
    );
    ApiClientBuilder.registerDefaultDeserializer(JsonParseNodeFactory.new);
    ApiClientBuilder.registerDefaultDeserializer(TextParseNodeFactory.new);
    ApiClientBuilder.registerDefaultDeserializer(FormParseNodeFactory.new);
  }
}
