import 'package:jaspr_falconx/src/states/riverpod_codec.dart';
import 'package:jaspr_falmodel/jaspr_falmodel.dart';
import 'package:test/test.dart';

class _Data {
  new(this.v);
  factory fromJson(dynamic json) => _Data((json as Map)['v'] as int);
  final int v;
  Map<String, dynamic> toJson() => {'v': v};
}

void main() {
  group('riverpodResultCodec', () {
    final codec = riverpodResultCodec<_Data>(_Data.fromJson);

    test('encodes and decodes a success result', () {
      final encoded = codec.encode(Result.success(_Data(42)));
      final decoded = codec.decode(encoded);
      expect(decoded.isSuccess, true);
      expect(decoded.value.v, 42);
    });

    test('encodes and decodes a failure result preserving type enum', () {
      final encoded = codec.encode(
        Result<_Data>.failure(
          const CommonException(
            type: BusinessErrorType.notFound,
            userMessage: 'missing',
            developerMessage: 'dev',
          ),
        ),
      );
      final decoded = codec.decode(encoded);
      expect(decoded.isFailure, true);
      expect(decoded.exception.type, BusinessErrorType.notFound);
      expect(decoded.exception.userMessage, 'missing');
      expect(decoded.exception.developerMessage, 'dev');
    });

    test('round-trips a type from every DefaultErrorType enum', () {
      const types = <DefaultErrorType>[
        SystemErrorType.concurrency,
        InputErrorType.outOfRange,
        TimeoutErrorType.deadline,
        StorageErrorType.fileSystem,
        ConnectivityErrorType.tls,
        AsyncErrorType.isolate,
        AccessErrorType.unauthorized,
        ExternalErrorType.serviceUnavailable,
        BusinessErrorType.conflict,
      ];
      for (final type in types) {
        final encoded = codec.encode(
          Result<_Data>.failure(CommonException(type: type)),
        );
        expect(codec.decode(encoded).exception.type, type);
      }
    });

    test(
      'decoder falls back to SystemErrorType.unknown for unknown type name',
      () {
        const bad = '{"exception":{"type":"nope","userMessage":"x"}}';
        final decoded = codec.decoder.convert(bad);
        expect(decoded.isFailure, true);
        expect(decoded.exception.type, SystemErrorType.unknown);
        expect(decoded.exception.userMessage, 'x');
      },
    );

    test('decoder falls back to SystemErrorType.unknown for missing type', () {
      const bad = '{"exception":{"userMessage":"x"}}';
      final decoded = codec.decoder.convert(bad);
      expect(decoded.exception.type, SystemErrorType.unknown);
    });
  });
}
