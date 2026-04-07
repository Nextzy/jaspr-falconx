import 'package:jaspr_falconx/lib.dart';

Codec<T, Object?> riverpodCodec<T>(
  T Function(dynamic json) fromJson,
) => RiverpodCodec(fromJson);

Codec<Either<Failure, T>, Object?> riverpodEitherCodec<T>(
  T Function(dynamic json) fromJson,
) => RiverpodEitherCodec(fromJson);

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

class RiverpodEitherEncoder<T> extends Converter<Either<Failure, T>, Object?> {
  @override
  Object? convert(Either<Failure, T> input) {
    return jsonEncode({
      if (input.failureOrNull != null)
        'failure': {
          'message': input.failureOrNull?.message,
          'level': input.failureOrNull?.level.name,
        },
      'data': input.dataOrNull,
    });
  }
}

class RiverpodEitherDecoder<T> extends Converter<Object?, Either<Failure, T>> {
  const RiverpodEitherDecoder(this.fromJson);

  final T Function(dynamic json) fromJson;

  @override
  Either<Failure, T> convert(Object? input) {
    final json = jsonDecode(input as String) as Map<String, dynamic>;
    final failureJson = json['failure'] as Map<String, dynamic>?;
    final dataJson = json['data'];

    if (failureJson != null) {
      return Left(
        Failure(
          message: failureJson['message'] as String?,
          level: FeedbackLevel.values.byName(
            failureJson['level'] as String? ?? 'medium',
          ),
        ),
      );
    } else if (dataJson != null) {
      return Right(fromJson(dataJson));
    }
    throw Exception('Invalid json');
  }
}

class RiverpodEitherCodec<T> extends Codec<Either<Failure, T>, Object?> {
  const RiverpodEitherCodec(this.fromJson);

  final T Function(dynamic json) fromJson;

  @override
  Converter<Either<Failure, T>, Object?> get encoder => RiverpodEitherEncoder();

  @override
  Converter<Object?, Either<Failure, T>> get decoder =>
      RiverpodEitherDecoder(fromJson);
}
