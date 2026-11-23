import 'package:jaspr/jaspr.dart';
import 'package:jaspr_falkit/jaspr_falkit.dart';
import 'package:jaspr_test/server_test.dart';
import 'package:test/test.dart' as vm;

void main() {
  testServer('BlogSchema renders its DateTime fields as ISO strings', (
    tester,
  ) async {
    tester.pumpComponent(
      Document.head(
        children: [
          BlogSchema(name: 'B', dateCreated: DateTime.utc(2026, 1, 2)),
        ],
      ),
    );
    final response = await tester.request('/');

    expect(response.body, contains('"dateCreated":"2026-01-02T00:00:00.000Z"'));
  });

  testServer('SchemaListDataType(schemaList:) renders', (tester) async {
    tester.pumpComponent(
      Document.head(
        children: [
          PersonSchema(
            name: 'Q',
            knows: SchemaListDataType<PersonSchema>(
              schemaList: [PersonSchema(name: 'R')],
            ),
          ),
        ],
      ),
    );
    final response = await tester.request('/');

    expect(response.body, contains('"knows":[{'));
    expect(response.body, contains('"name":"R"'));
  });

  testServer('SchemaGroup accepts a const map member', (tester) async {
    tester.pumpComponent(
      Document.head(
        children: [
          SchemaGroup(
            schemas: const [
              GenericSchema(
                data: {'@context': 'https://schema.org', '@type': 'Thing'},
              ),
            ],
          ),
        ],
      ),
    );
    final response = await tester.request('/');

    expect(response.body, contains('"@graph":[{"@type":"Thing"}]'));
  });

  vm.test('SchemaGroup leaves its member schemaData untouched', () {
    final data = <String, dynamic>{'@context': 'c', '@type': 'T'};
    final member = GenericSchema(data: data);

    SchemaGroup(schemas: [member]);

    vm.expect(member.schemaData['@context'], 'c');
  });

  testServer('SoftwareApplicationSchema renders softwareRequirements', (
    tester,
  ) async {
    tester.pumpComponent(
      Document.head(
        children: [
          SoftwareApplicationSchema(
            name: 'App',
            softwareRequirements: const SchemaDataType(str: 'x'),
          ),
        ],
      ),
    );
    final response = await tester.request('/');

    expect(response.body, contains('"softwareRequirements":"x"'));
  });
}
