library generator.src.builder.dart_class;

import 'package:generator/src/builder/dart_source.dart';
import 'package:generator/src/builder/dart_type.dart';

class DartClass extends DartSource {
  final String name;

  final constructors = [];
  final fields = [];
  final methods = [];

  final DartType extend;
  final List<DartType> implements;
  final List<DartType> mixins;

  final bool isAbstract;

  DartClass(
      this.name, {
      this.isAbstract: false,
      this.extend,
      this.implements: const [],
      this.mixins: const []});

  @override
  void writeTo(StringBuffer buffer, [_]) {
    if (isAbstract) {
      buffer.write('abstract ');
    }
    buffer.write('class ');
    buffer.write(name);
    buffer.write(' ');
    if (extend == null && mixins.isNotEmpty) {
      buffer.write('extends Object ');
    } else if (extend != null) {
      buffer.write('extends ');
      extend.writeTo(buffer);
      buffer.write(' ');
    }
    if (mixins.isNotEmpty) {
      buffer.write('with ');
      buffer.write(mixins.map((m) => m.toSource()).join(', '));
      buffer.write(' ');
    }
    if (implements.isNotEmpty) {
      buffer.write('implements ');
      buffer.write(implements.map((i) => i.toSource()).join(', '));
      buffer.write(' ');
    }
    buffer.writeln('{}');
  }
}
