part of '../../kiota_abstractions.dart';

abstract class SerializationWriterProxyFactory
    implements SerializationWriterFactory {
  SerializationWriterProxyFactory({
    required SerializationWriterFactory concrete,
    ParsableHook? onBefore,
    ParsableHook? onAfter,
    void Function(Parsable, SerializationWriter)? onStart,
  })  : _concrete = concrete,
        _onBefore = onBefore,
        _onAfter = onAfter,
        _onStart = onStart;

  final SerializationWriterFactory _concrete;
  final ParsableHook? _onBefore;
  final ParsableHook? _onAfter;
  final void Function(Parsable, SerializationWriter)? _onStart;

  @override
  String get validContentType => _concrete.validContentType;

  @override
  SerializationWriter getSerializationWriter(String contentType) {
    final writer = _concrete.getSerializationWriter(contentType);

    final originalBefore = writer.onBeforeObjectSerialization;
    writer.onBeforeObjectSerialization = (p) {
      _onBefore?.call(p);
      originalBefore?.call(p);
    };

    final originalAfter = writer.onAfterObjectSerialization;
    writer.onAfterObjectSerialization = (p) {
      _onAfter?.call(p);
      originalAfter?.call(p);
    };

    final originalStart = writer.onStartObjectSerialization;
    writer.onStartObjectSerialization = (p, w) {
      _onStart?.call(p, w);
      originalStart?.call(p, w);
    };

    return writer;
  }
}
