import 'dart:convert';

/// Codec for use with `FutureProvider<T?>.syncWith(id, codec: ...)`.
///
/// Encode: `T?` → JSON-serializable `Object?` (null passes through; non-null
/// is serialized via [jsonEncode], which calls `toJson()` on the model).
/// Decode: `Object?` → `T?` (null passes through; non-null is parsed via
/// [jsonDecode] then [fromJson]).
///
/// Null-safe by design: detail providers may legitimately return null
/// (record absent after a successful API call) and that null must roundtrip
/// through `syncWith`.
Codec<T?, Object?> jsonCodec<T>(T Function(dynamic json) fromJson) =>
    _NullableJsonCodec<T>(fromJson);

/// List variant — for providers that return `List<T>` (typically list pages).
/// `null` is not a valid value for list providers; absent data is `const []`.
Codec<List<T>, Object?> jsonListCodec<T>(T Function(dynamic json) fromJson) =>
    _ListJsonCodec<T>(fromJson);

class _NullableJsonCodec<T> extends Codec<T?, Object?> {
  const _NullableJsonCodec(this._fromJson);
  final T Function(dynamic) _fromJson;

  @override
  Converter<T?, Object?> get encoder => _NullableJsonEncoder<T>();
  @override
  Converter<Object?, T?> get decoder => _NullableJsonDecoder<T>(_fromJson);
}

class _NullableJsonEncoder<T> extends Converter<T?, Object?> {
  @override
  Object? convert(T? input) => input == null ? null : jsonEncode(input);
}

class _NullableJsonDecoder<T> extends Converter<Object?, T?> {
  const _NullableJsonDecoder(this._fromJson);
  final T Function(dynamic) _fromJson;

  @override
  T? convert(Object? input) =>
      input == null ? null : _fromJson(jsonDecode(input as String));
}

class _ListJsonCodec<T> extends Codec<List<T>, Object?> {
  const _ListJsonCodec(this._fromJson);
  final T Function(dynamic) _fromJson;

  @override
  Converter<List<T>, Object?> get encoder => _ListJsonEncoder<T>();
  @override
  Converter<Object?, List<T>> get decoder => _ListJsonDecoder<T>(_fromJson);
}

class _ListJsonEncoder<T> extends Converter<List<T>, Object?> {
  @override
  Object? convert(List<T> input) => jsonEncode(input);
}

class _ListJsonDecoder<T> extends Converter<Object?, List<T>> {
  const _ListJsonDecoder(this._fromJson);
  final T Function(dynamic) _fromJson;

  @override
  List<T> convert(Object? input) {
    if (input == null) return const [];
    final list = jsonDecode(input as String) as List;
    return list.map(_fromJson).toList(growable: false);
  }
}
