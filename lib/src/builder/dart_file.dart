library generator.src.builder.dart_file;

import 'package:generator/src/builder/dart_import.dart';
import 'package:generator/src/builder/dart_source.dart';

class DartFile extends DartSource {
  /// Imported files.
  final imports = new Set<DartImport>();

  /// Whether this is part of another library.
  final bool isPart;

  /// The library name.
  final String libraryName;

  DartFile.library(this.libraryName)
      : this.isPart = false;

  DartFile.part(this.libraryName)
      : this.isPart = true;

  @override
  void writeTo(StringBuffer buffer, [_]) {
    if (isPart) {
      buffer.writeln('part of $libraryName;');
    } else {
      buffer.writeln('library $libraryName;');
    }
    if (imports.isNotEmpty) {
      buffer.writeln();
      (imports
        .toList(growable: false)
        ..sort())
        .forEach((i) => i.writeTo(buffer));
    }
  }
}
