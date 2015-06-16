library generator.src.builder.dart_import;

import 'package:generator/src/builder/dart_source.dart';
import 'package:quiver/core.dart';

/// An encapsulation around an "import: " directive in dart source code.
class DartImport extends DartSource implements Comparable {
  /// Optional, the `as` namespace that will be emitted.
  final String namespace;

  /// The file or package URI.
  final Uri uri;

  DartImport(this.uri, {this.namespace});

  DartImport.parse(String uri, {this.namespace}) : this.uri = Uri.parse(uri);

  @override
  int compareTo(DartImport o) {
    if (o.uri == uri) {
      var otherNs = o.namespace != null ? o.namespace : '';
      return namespace.compareTo(otherNs);
    } else {
      return uri.toString().compareTo(o.uri.toString());
    }
  }

  @override
  bool operator==(o) {
    return o is DartImport &&
           o.uri == uri &&
           o.namespace == namespace;
  }

  @override
  int get hashCode => hash2(uri, namespace);

  @override
  void writeTo(StringBuffer buffer, [_]) {
    buffer.write("import '$uri'");
    if (namespace != null) {
      buffer.write(' as ');
      buffer.write(namespace);
    }
    buffer.writeln(';');
  }

  @override
  String toString() => 'DartImport ' + {
    'namespace': namespace,
    'uri': uri
  }.toString();
}
