
import 'package:jaspr_falconx/lib.dart';

Codec<T, dynamic> riverpodCodec<T>(
  T Function(Map<String, dynamic> json) fromJson,
) => RiverpodCodec(fromJson);

Codec<Either<Failure, T>, dynamic> riverpodEitherCodec<T>(
  T Function(Map<String, dynamic> json) fromJson,
) => RiverpodEitherCodec(fromJson);

class RiverpodEncoder<T> extends Converter<T, dynamic> {
  @override
  dynamic convert(T input) => jsonEncode(input);
}

class RiverpodDecoder<T> extends Converter<dynamic, T> {
  const RiverpodDecoder(this.fromJson);

  final T Function(Map<String, dynamic> json) fromJson;

  @override
  T convert(dynamic input) =>
      fromJson(jsonDecode(input as String) as Map<String, dynamic>);
}

class RiverpodCodec<T> extends Codec<T, dynamic> {
  const RiverpodCodec(this.fromJson);

  final T Function(Map<String, dynamic> json) fromJson;

  @override
  Converter<T, dynamic> get encoder => RiverpodEncoder();

  @override
  Converter<dynamic, T> get decoder => RiverpodDecoder(fromJson);
}

class RiverpodEitherEncoder<T> extends Converter<Either<Failure, T>, dynamic> {
  @override
  dynamic convert(Either<Failure, T> input) {
    return jsonEncode({
      if (input.failureOrNull != null)
        'failure': {
          'code': input.failureOrNull?.code,
          'message': input.failureOrNull?.message,
          'developerMessage': input.failureOrNull?.developerMessage,
        },
      'data': input.dataOrNull,
    });
  }
}

class RiverpodEitherDecoder<T> extends Converter<dynamic, Either<Failure, T>> {
  const RiverpodEitherDecoder(this.fromJson);

  final T Function(Map<String, dynamic> json) fromJson;

  @override
  Either<Failure, T> convert(dynamic input) {
    final json = jsonDecode(input as String) as Map<String, dynamic>;
    final failureJson = json['failure'] as Map<String, dynamic>?;
    final dataJson = json['data'] as Map<String, dynamic>?;

    if (failureJson != null) {
      return Left(
        Failure(
          code: failureJson['code'] as String?,
          message: failureJson['message'] as String?,
          developerMessage: failureJson['developerMessage'] as String?,
        ),
      );
    } else if (dataJson != null) {
      return Right(fromJson(dataJson));
    }
    throw Exception('Invalid json');
  }
}

class RiverpodEitherCodec<T> extends Codec<Either<Failure, T>, dynamic> {
  const RiverpodEitherCodec(this.fromJson);

  final T Function(Map<String, dynamic> json) fromJson;

  @override
  Converter<Either<Failure, T>, dynamic> get encoder => RiverpodEitherEncoder();

  @override
  Converter<dynamic, Either<Failure, T>> get decoder =>
      RiverpodEitherDecoder(fromJson);
}
