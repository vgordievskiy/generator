library generator.test.builder_test;

import 'package:generator/src/builder.dart';

import 'package:test/test.dart';

void main() {
  group('GeneratedDartCode:', () {
    group('DartArray', () {
      test('can generate with an empty array', () {
        expect(new DartArray().toSource(), '[]');
      });

      test('can generate a const array', () {
        expect(new DartArray.constant().toSource(), 'const []');
      });

      test('can generate with items', () {
        expect(new DartArray([
          new DartIdentifier(1),
          new DartIdentifier(2),
          new DartIdentifier(3)
        ]).toSource(), '[1, 2, 3]');
      });
    });

    group('DartFile', () {
      test('can generate and format with the dart formatter', () {
        expect(new DartFile(imports: [
          new DartImport('package:foo/foo.dart', as: '          foo')
        ]).toSource(), 'import \'package:foo/foo.dart\' as foo;\n');
      });
    });

    group('DartImport', () {
      test('can generate without a namespace', () {
        expect(
            new DartImport('package:foo/foo.dart').toSource(),
            "import 'package:foo/foo.dart';");
      });

      test('can generate with a namespace', () {
        expect(
            new DartImport('package:foo/foo.dart', as: 'foo').toSource(),
            "import 'package:foo/foo.dart' as foo;");
      });
    });

    group('DartInvokeConstructor', () {
      test('can generate in the simplest case', () {
        expect(
            new DartInvokeConstructor('Foo').toSource(),
            'new Foo()');
      });

      test('can generate as a constant', () {
        expect(
            new DartInvokeConstructor('Foo', isConst: true).toSource(),
            'const Foo()');
      });

      test('can generate with positional arguments', () {
        expect(
            new DartInvokeConstructor('Foo', positionalArguments: [
              new DartIdentifier(1),
              new DartIdentifier(2),
              new DartIdentifier(3)
            ]).toSource(),
            'new Foo(1, 2, 3)');
      });
    });

    group('DartVariableDefinition', () {
      test('can generate a const', () {
        expect(
            new DartVariableDefinition(
                'foo',
                isConst: true,
                assignTo: new DartIdentifier(1)).toSource(),
            'const foo = 1;');
      });

      test('can generate a var', () {
        expect(
            new DartVariableDefinition(
                'foo',
                assignTo: new DartIdentifier(1)).toSource(),
            'var foo = 1;');
      });

      test('can generate a final', () {
        expect(
            new DartVariableDefinition(
                'foo',
                isFinal: true,
                assignTo: new DartIdentifier(1)).toSource(),
            'final foo = 1;');
      });
    });
  });
}
