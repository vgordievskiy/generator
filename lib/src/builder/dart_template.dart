library generator.src.builder.dart_template;

import 'package:generator/src/builder/dart_source.dart';
import 'package:mustache/mustache.dart';

class DartTemplate extends DartSource {
  final context;
  final Template template;

  DartTemplate(String template, [this.context = const {}])
      : this.template = new Template(template);

  @override
  void writeTo(StringBuffer buffer, [int indent = 0]) {
    template.render(context, buffer);
  }
}
