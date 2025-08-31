import 'package:jaspr_falkit/lib.dart';

/// Base class for all Schema.org components
class SchemaDataType<T extends Schema> {
  const SchemaDataType({
    this.str,
    this.map,
    this.schema,
  });

  final String? str;
  final Map<String, dynamic>? map;
  final T? schema;

  dynamic get value {
    if (schema != null) {
      return schema!.schemaData;
    } else if (str != null) {
      return str;
    } else if (map != null) {
      return map;
    }
  }

  @override
  String toString() {
    if (schema?.schemaData != null) {
      return jsonEncode(schema?.schemaData);
    } else if (str != null) {
      return str!;
    } else {
      return jsonEncode(map);
    }
  }
}

class SchemaListDataType<T extends Schema> {
  const SchemaListDataType({
    this.strList,
    this.mapList,
    this.schemaList,
  });

  final List<String>? strList;
  final List<Map<String, dynamic>>? mapList;
  final List<T>? schemaList;

  dynamic get value {
    if (schemaList != null) {
      return schemaList!.map((e) => e.schemaData);
    } else if (strList != null) {
      return strList;
    } else if (mapList != null) {
      return mapList;
    }
  }

  @override
  String toString() {
    if (schemaList != null) {
      return jsonEncode(schemaList?.map((e) => e.schemaData).toList());
    } else if (strList != null) {
      return strList.toString();
    } else {
      return jsonEncode(mapList);
    }
  }
}

extension SchemaStringDataTypeExtension on String {
  SchemaDataType<T> toSchemaDataType<T extends Schema>() {
    return SchemaDataType<T>(str: this);
  }
}

extension SchemaMapDataTypeExtension on Map<String, dynamic> {
  SchemaDataType<T> toSchemaDataType<T extends Schema>() {
    return SchemaDataType<T>(map: this);
  }
}

extension SchemaDataTypeExtension on Schema {
  SchemaDataType toSchemaDataType() {
    return SchemaDataType(schema: this);
  }
}
