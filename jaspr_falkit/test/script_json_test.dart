import 'dart:convert';

import 'package:jaspr_falkit/jaspr_falkit.dart';
import 'package:jaspr_falkit/src/script_json.dart';
import 'package:test/test.dart';

void main() {
  test('escapes <, >, & in every string, nested too', () {
    final out = encodeScriptJson({
      'a': ['x</script><b>&'],
      'b': {'c': '<!--'},
    });

    expect(out, isNot(contains('<')));
    expect(out, isNot(contains('>')));
    expect(out, isNot(contains('&')));
    expect(jsonDecode(out), {
      'a': ['x</script><b>&'],
      'b': {'c': '<!--'},
    });
  });

  test('encodes a DateTime as ISO 8601 and a lazy Iterable as a list', () {
    final out = encodeScriptJson({
      'd': DateTime.utc(2026, 11, 23),
      'l': [1, 2].map((e) => e),
    });

    expect(jsonDecode(out), {
      'd': '2026-11-23T00:00:00.000Z',
      'l': [1, 2],
    });
  });

  test('encodes a toJson result through the same rules', () {
    expect(
      encodeScriptJson(_WithToJson()),
      '{"at":"2026-11-23T00:00:00.000Z"}',
    );
  });

  test('throws JsonUnsupportedObjectError for an object without toJson', () {
    expect(
      () => encodeScriptJson(Object()),
      throwsA(isA<JsonUnsupportedObjectError>()),
    );
  });

  test('unwraps SchemaDataType and SchemaListDataType', () {
    final out = encodeScriptJson({
      'str': const SchemaDataType(str: 'x'),
      'map': const SchemaDataType(map: {'a': 1}),
      'schema': SchemaDataType(schema: PersonSchema(name: 'P')),
      'strList': const SchemaListDataType(strList: ['a', 'b']),
      'schemaList': SchemaListDataType(schemaList: [PersonSchema(name: 'Q')]),
    });

    final decoded = jsonDecode(out) as Map<String, dynamic>;
    expect(decoded['str'], 'x');
    expect(decoded['map'], {'a': 1});
    expect((decoded['schema'] as Map)['name'], 'P');
    expect(decoded['strList'], ['a', 'b']);
    expect(((decoded['schemaList'] as List).single as Map)['name'], 'Q');
  });
}

class _WithToJson {
  Map<String, Object?> toJson() => {'at': DateTime.utc(2026, 11, 23)};
}
