library generator.src.builder.dart_definition;

import 'package:generator/src/builder/dart_source.dart';

abstract class DartDefinition extends DartSource {
  final String name;

  DartDefinition(this.name);
}
