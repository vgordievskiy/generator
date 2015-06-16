library generator.src.builder.dart_type;

import 'package:generator/src/builder/dart_source.dart';

class DartType implements DartSource {
  static const VOID = const DartType('void');
  static const DYNAMIC = const DartType('dynamic');
  static const BOOLEAN = const DartType('bool');
  static const INTEGER = const DartType('int');
  static const NUMBER = const DartType('num');
  static const DOUBLE = const DartType('double');
  static const STRING = const DartType('String');
  static const DATE_TIME = const DartType('DateTime');

  final String dartType;
  final String namespace;
  final List<DartType> parameters;

  const DartType(
      this.dartType, {
      this.namespace,
      this.parameters: const []});

  @override
  void writeTo(StringBuffer buffer, [int indent = 0]) {
    buffer.write(''.padLeft(indent));
    if (namespace != null) {
      buffer.write(namespace);
      buffer.write('.');
    }
    buffer.write(dartType);
    if (parameters.isNotEmpty) {
      buffer.write('<');
      buffer.write(parameters.map((p) => p.toSource()).join(', '));
      buffer.write('>');
    }
  }

  @override
  String toSource() {
    var buffer = new StringBuffer();
    writeTo(buffer);
    return buffer.toString();
  }
}
