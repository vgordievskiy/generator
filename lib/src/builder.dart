library generator.src.builder;

import 'package:dart_style/dart_style.dart';

abstract class GeneratedDartCode {
  String toSource();
}

class DartArray implements GeneratedDartCode {
  final bool isConst;
  final List<GeneratedDartCode> values;

  DartArray([this.values = const [], this.isConst = false]);

  DartArray.constant([this.values = const []]) : isConst = true;

  @override
  String toSource() {
    var output = '[' + values.map((v) => v.toSource()).join(', ') + ']';
    if (isConst) {
      output = 'const ${output}';
    }
    return output;
  }
}

class DartIdentifier implements GeneratedDartCode {
  final String identifier;

  DartIdentifier(identifier) : this.identifier = identifier.toString();

  factory DartIdentifier.nullIdentifier() => new DartIdentifier('null');

  @override
  String toSource() => identifier;
}

class DartFile implements GeneratedDartCode {
  final List<DartImport> imports;
  final List<GeneratedDartCode> lines;

  DartFile({this.imports: const [], this.lines: const []});

  @override
  String toSource({bool format: true}) {
    var buffer = new StringBuffer();
    imports.forEach((i) => buffer.writeln(i.toSource()));
    lines.forEach((i) => buffer.writeln(i.toSource()));
    var output = buffer.toString();
    if (format) {
      output = new DartFormatter().format(output);
    }
    return output;
  }
}

class DartImport implements GeneratedDartCode {
  final String as;
  final String uri;

  DartImport(this.uri, {this.as});

  bool get hasAsDefined => as != null;

  @override
  String toSource() {
    var buffer = new StringBuffer();
    buffer.write('import \'${uri}\'');
    if (hasAsDefined) {
      buffer.write(' as $as');
    }
    buffer.write(';');
    return buffer.toString();
  }
}

class DartInvokeConstructor implements GeneratedDartCode {
  final String constructor;
  final bool isConst;
  final List<GeneratedDartCode> positionalArguments;

  DartInvokeConstructor(
      this.constructor, {
      this.isConst: false,
      this.positionalArguments: const []});

  @override
  String toSource() {
    var buffer = new StringBuffer();
    if (isConst) {
      buffer.write('const');
    } else {
      buffer.write('new');
    }
    buffer.write(' $constructor(');
    buffer.write(positionalArguments.map((a) => a.toSource()).join(', '));
    buffer.write(')');
    return buffer.toString();
  }
}

class DartVariableDefinition implements GeneratedDartCode {
  final GeneratedDartCode assignTo;
  final bool isConst;
  final bool isFinal;
  final String name;

  DartVariableDefinition(
      this.name, {
      this.assignTo,
      this.isConst: false,
      this.isFinal: false});

  @override
  String toSource() {
    var buffer = new StringBuffer();
    if (isConst) {
      buffer.write('const ');
    } else if (isFinal) {
      buffer.write('final ');
    } else {
      buffer.write('var ');
    }
    buffer.write(name);
    buffer.write(' = ');
    buffer.write(assignTo.toSource());
    buffer.write(';');
    return buffer.toString();
  }
}
