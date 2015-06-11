library generator.test.input_test;

import 'package:analysis/analysis.dart';
import 'package:analyzer/analyzer.dart';
import 'package:generator/src/input.dart';
import 'package:generator/testing/library/annotation.dart';
import 'package:test/test.dart';

void main() {
  group('GeneratorInput', () {
    final crawler = new SourceCrawler();
    final sourceUri = Uri.parse('package:generator/testing/library/code.dart');

    test('can read classes that are annotated', () {
      var sources = crawler.crawl(uri: sourceUri);
      var input = new GeneratorInput(sources, const [Injectable]);
      var result = input.read();
      ClassDeclaration clazz = result.keys.first;
      expect(clazz.name.name, 'Bar');
      expect(result[clazz].name, 'generator.testing.library.code');
    });

    test('can read functions that are annotated', () {
      var sources = crawler.crawl(uri: sourceUri);
      var input = new GeneratorInput(
          sources,
          const [Optimize],
          includeFunctions: true);
      var result = input.read();
      MethodDeclaration method = result.keys.first;
      expect(method.name.name, 'baz');
      expect(result[method].name, 'generator.testing.library.code');
    });
  });
}
