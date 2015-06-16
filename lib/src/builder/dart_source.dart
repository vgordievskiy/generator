library generator.src.builder.dart_source;

abstract class DartSource {
  void writeTo(StringBuffer buffer, [int indent]);

  String toSource() {
    var buffer = new StringBuffer();
    this.writeTo(buffer, 0);
    return buffer.toString();
  }
}
