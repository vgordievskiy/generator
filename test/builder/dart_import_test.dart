library generator.test.builder.dart_import;

import 'package:generator/src/builder/dart_import.dart';
import 'package:test/test.dart';

void main() {
  group('DartImport', () {
    DartImport import;

    test('can generate source for a URI', () {
      import = new DartImport(Uri.parse('package:foo/foo.dart'));
      expect(import.toSource(), "import 'package:foo/foo.dart';");
    });

    test('can generate source for a URI with a namespace', () {
      import = new DartImport(
          Uri.parse('package:foo/foo.dart'),
          namespace: 'foo');
      expect(import.toSource(), "import 'package:foo/foo.dart' as foo;");
    });
  });
}
