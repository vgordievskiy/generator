library generator.test.builder.dart_type_test;

import 'package:generator/src/builder/dart_type.dart';
import 'package:test/test.dart';

void main() {
  group('DartType', () {
    group('predefined types', () {
      test('void', () {
        expect(DartType.VOID.toSource(), 'void');
      });

      test('dynamic', () {
        expect(DartType.DYNAMIC.toSource(), 'dynamic');
      });

      test('boolean', () {
        expect(DartType.BOOLEAN.toSource(), 'bool');
      });

      test('integer', () {
        expect(DartType.INTEGER.toSource(), 'int');
      });

      test('number', () {
        expect(DartType.NUMBER.toSource(), 'num');
      });

      test('double', () {
        expect(DartType.DOUBLE.toSource(), 'double');
      });

      test('String', () {
        expect(DartType.STRING.toSource(), 'String');
      });
    });

    test('with a custom type', () {
      expect(const DartType('Foo').toSource(), 'Foo');
    });

    test('with a namepace', () {
      expect(const DartType('Foo', namespace: 'foo').toSource(), 'foo.Foo');
    });

    test('with generics', () {
      expect(
          const DartType('Map', parameters: const [
            DartType.STRING,
            DartType.DYNAMIC
          ]).toSource(),
          'Map<String, dynamic>');
    });

    test('with nested generics', () {
      expect(
          const DartType('Map', parameters: const [
            DartType.STRING,
            const DartType('List', parameters: const [DartType.INTEGER])
          ]).toSource(),
          'Map<String, List<int>>');
    });
  });
}
