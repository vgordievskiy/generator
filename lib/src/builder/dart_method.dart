library generator.src.builder.dart_method;

import 'package:generator/src/builder/dart_definition.dart';
import 'package:generator/src/builder/dart_template.dart';
import 'package:generator/src/builder/dart_type.dart';

class DartMethod extends DartDefinition {
  final DartTemplate body;
  final List<DartType> positionalArguments;
  final List<DartType> optionalArguments;
  final Map<String, DartType> namedArguments;
  final bool isAbstract;
  final bool isPrivate;
  final DartType returnType;

  DartMethod(
      String name, {
      this.body,
      this.positionalArguments: const [],
      this.optionalArguments: const [],
      this.namedArguments: const {},
      this.isAbstract: false,
      this.isPrivate: false,
      this.returnType}) : super(name);

  @override
  void writeTo(StringBuffer buffer, [int indent = 0]) {
    buffer.write(''.padLeft(indent));
    if (returnType != null) {
      returnType.writeTo(buffer);
    }
    if (isPrivate) {
      buffer.write('_');
    }
    buffer.write(name);
    buffer.write('(');
    if (positionalArguments.isNotEmpty) {
      buffer.write(positionalArguments.map((a) => a.toSource()).join(', '));
    }
    if (optionalArguments.isNotEmpty) {
      if (positionalArguments.isNotEmpty) {
        buffer.write(', ');
      }
      buffer.write('[');
      buffer.write(optionalArguments.map((a) => a.toSource()).join(', '));
      buffer.write(']');
    }
    if (namedArguments.isNotEmpty) {
      throw new UnimplementedError();
    }
    buffer.write(')');
    if (!isAbstract) {
      buffer.writeln(' {');
      body.writeTo(buffer, indent + 2);
      buffer.write(''.padLeft(indent));
      buffer.writeln('}');
    }
  }
}
