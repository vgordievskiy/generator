library generator.test.simple_integration_test;

import 'dart:async';

import 'package:analysis/analysis.dart';
import 'package:analyzer/src/generated/ast.dart';
import 'package:generator/src/input.dart';
import 'package:generator/src/generator.dart';
import 'package:generator/testing/library/annotation.dart';
import 'package:test/test.dart';

/// A simple generator that takes input files, and outputs classes that are
/// marked @Injectable, and outputs a list of their constructor names with
/// a listing of parameter names and their types.
class SimpleInjectableGenerator implements Generator<List<String>> {
  @override
  Future<List<String>> process(GeneratorInput input) {
    final injectables = <String> [];
    final result = input.read();
    result.forEach((ClassDeclaration astNode, Library library) {
      var finder = new _FindConstructorVisitor();
      astNode.accept(finder);
      var function = new FunctionDefinition.fromConstructor(
          finder.constructorAstNode);
      injectables.add(
        '${astNode.element.displayName}: '
            + function.positionalArguments.map((p) {
          return p.originLibraryName + '.' + p.typeName;
        }).join(', ')
      );
    });
    return new Future.value(injectables);
  }
}

void main() {
  group('SimpleIntegrationTest', () {
    final crawler = new SourceCrawler();
    final sourceUri = Uri.parse('package:generator/testing/library/code.dart');

    test('works as expected', () async {
      var sources = crawler.crawl(uri: sourceUri);
      var input = new GeneratorInput(sources, const [Injectable]);
      var output = await new SimpleInjectableGenerator().process(input);
      expect(output, [
        'Bar: generator.testing.library.code.Foo'
      ]);
    });
  });
}

class _FindConstructorVisitor extends GeneralizingAstVisitor {
  ConstructorDeclaration constructorAstNode;

  @override
  visitConstructorDeclaration(ConstructorDeclaration astNode) {
    constructorAstNode = astNode;
  }
}
