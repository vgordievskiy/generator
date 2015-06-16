library generator.test.builder.dart_class_test;

import 'package:generator/src/builder/dart_class.dart';
import 'package:generator/src/builder/dart_type.dart';
import 'package:test/test.dart';

void main() {
  group('DartClass', () {
    DartClass clazz;

    test('in the simplest case', () {
      clazz = new DartClass('Foo');
      expect(
          clazz.toSource(),
          'class Foo {}\n');
    });

    test('as an abstract class', () {
      clazz = new DartClass('Foo', isAbstract: true);
      expect(
          clazz.toSource(),
          'abstract class Foo {}\n');
    });

    test('extending another class', () {
      clazz = new DartClass('Foo', extend: new DartType('Bar'));
      expect(
          clazz.toSource(),
          'class Foo extends Bar {}\n');
    });

    test('implements other classes', () {
      clazz = new DartClass(
          'Foo',
          implements: [new DartType('Bar'), new DartType('Baz')]);
      expect(
          clazz.toSource(),
          'class Foo implements Bar, Baz {}\n');
    });

    test('mixins other classes', () {
      clazz = new DartClass(
          'Foo',
          mixins: [new DartType('Bar'), new DartType('Baz')]);
      expect(
          clazz.toSource(),
          'class Foo extends Object with Bar, Baz {}\n');
    });
  });
}
