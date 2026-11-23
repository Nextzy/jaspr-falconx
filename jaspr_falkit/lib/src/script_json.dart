import 'dart:convert';

import 'package:jaspr_falkit/components/seo/schema/schema_data_type.dart';

/// Encodes [value] as JSON that is safe inside a `<script>` element.
///
/// Replaces `<`, `>`, and `&` with `\uXXXX` escapes, so a string value cannot
/// close the tag or open a comment. `jsonDecode` returns the original value.
///
/// A [DateTime] becomes its ISO 8601 string, any other [Iterable] a list, and a
/// [SchemaDataType] or [SchemaListDataType] its `value`; an object with a
/// `toJson` method keeps encoding as `jsonEncode` does.
String encodeScriptJson(Object? value) =>
    jsonEncode(value, toEncodable: _toEncodable).replaceAllMapped(
      _htmlSensitive,
      (match) =>
          '\\u${match[0]!.codeUnitAt(0).toRadixString(16).padLeft(4, '0')}',
    );

Object? _toEncodable(Object? object) => switch (object) {
  DateTime() => object.toIso8601String(),
  SchemaDataType() => object.value,
  SchemaListDataType() => switch (object.value) {
    final Iterable<Object?> list => list.toList(),
    final other => other,
  },
  Iterable() => object.toList(),
  // Dynamic call mirrors the SDK default; a missing toJson surfaces as
  // JsonUnsupportedObjectError.
  _ => (object as dynamic).toJson(),
};

final _htmlSensitive = RegExp('[<>&]');
