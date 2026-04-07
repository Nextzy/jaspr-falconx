import 'package:jaspr_falconx/lib.dart';

Codec<T, Object?> riverpodCodec<T>(
  T Function(dynamic json) fromJson,
) => RiverpodCodec(fromJson);

Codec<Result<T>, Object?> riverpodResultCodec<T>(
  T Function(dynamic json) fromJson,
) => RiverpodResultCodec(fromJson);

class RiverpodEncoder<T> extends Converter<T, Object?> {
  @override
  Object? convert(T input) => jsonEncode(input);
}

class RiverpodDecoder<T> extends Converter<Object?, T> {
  const RiverpodDecoder(this.fromJson);

  final T Function(Map<String, dynamic> json) fromJson;

  @override
  T convert(Object? input) =>
      fromJson(jsonDecode(input as String) as Map<String, dynamic>);
}

class RiverpodCodec<T> extends Codec<T, Object?> {
  const RiverpodCodec(this.fromJson);

  final T Function(Map<String, dynamic> json) fromJson;

  @override
  Converter<T, Object?> get encoder => RiverpodEncoder();

  @override
  Converter<Object?, T> get decoder => RiverpodDecoder(fromJson);
}

class RiverpodResultEncoder<T> extends Converter<Result<T>, Object?> {
  @override
  Object? convert(Result<T> input) {
    final ex = input.exceptionOrNull;
    return jsonEncode({
      if (ex != null)
        'exception': {
          'type': ex.type is Enum ? (ex.type as Enum).name : ex.type.toString(),
          'userMessage': ex.userMessage,
          'developerMessage': ex.developerMessage,
        },
      'data': input.valueOrNull,
    });
  }
}

class RiverpodResultDecoder<T> extends Converter<Object?, Result<T>> {
  const RiverpodResultDecoder(this.fromJson);

  final T Function(dynamic json) fromJson;

  @override
  Result<T> convert(Object? input) {
    final json = jsonDecode(input! as String) as Map<String, dynamic>;
    final exJson = json['exception'] as Map<String, dynamic>?;
    final dataJson = json['data'];

    if (exJson != null) {
      return Result.failure(
        CommonException(
          type: _parseErrorType(exJson['type'] as String?),
          userMessage: exJson['userMessage'] as String?,
          developerMessage: exJson['developerMessage'] as String?,
        ),
      );
    } else if (dataJson != null) {
      return Result.success(fromJson(dataJson));
    }
    throw Exception('Invalid json');
  }

  ErrorType _parseErrorType(String? name) {
    if (name == null) return ErrorType.unknown;
    try {
      return ErrorType.values.byName(name);
    } catch (_) {
      return ErrorType.unknown;
    }
  }
}

class RiverpodResultCodec<T> extends Codec<Result<T>, Object?> {
  const RiverpodResultCodec(this.fromJson);

  final T Function(dynamic json) fromJson;

  @override
  Converter<Result<T>, Object?> get encoder => RiverpodResultEncoder();

  @override
  Converter<Object?, Result<T>> get decoder => RiverpodResultDecoder(fromJson);
}
