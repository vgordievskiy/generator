library generator.test.builder.dart_file;

import 'package:generator/src/builder/dart_file.dart';
import 'package:generator/src/builder/dart_import.dart';
import 'package:test/test.dart';

void main() {
  group('DartFile', () {
    DartFile file;

    test('supports outputting as a library', () {
      file = new DartFile.library('foo');
      expect(
          file.toSource(),
          'library foo;\n');
    });

    test('supports outputting as a part', () {
      file = new DartFile.part('foo');
      expect(
          file.toSource(),
          'part of foo;\n');
    });

    test('inlines imports', () {
      file = new DartFile.library('foo');
      file.imports.add(new DartImport.parse('package:bar/bar.dart'));
      expect(
          file.toSource(),
          'library foo;\n'
          '\n'
          "import 'package:bar/bar.dart';\n");
    });
  });
}
