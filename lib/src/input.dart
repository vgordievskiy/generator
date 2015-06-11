library generator.src.input;

import 'dart:mirrors';

import 'package:analysis/analysis.dart';
import 'package:analyzer/analyzer.dart';

/// Establishes the ASTs that will be read by a [Generator].
class GeneratorInput {
  final List<Type> _annotations;
  final List<Library> _sources;

  final bool _includeClasses;
  final bool _includeFunctions;

  /// Creates a new input target from [sources], looking for [annotations].
  ///
  /// Set [includeClasses] and [includeFunctions] to alter what is searched.
  factory GeneratorInput(
      Iterable<Library> sources,
      Iterable<Type> annotations, {
      bool includeClasses: true,
      bool includeFunctions: false}) {
    return new GeneratorInput._(
        annotations.toList(growable: false),
        sources.toList(growable: false),
        includeClasses,
        includeFunctions);
  }

  GeneratorInput._(
      this._annotations,
      this._sources,
      this._includeClasses,
      this._includeFunctions);

  /// Traverses all the sources and returns a [Map] of [AnnotatedNode] ASTs to
  /// the [Library] they were read from.
  Map<AnnotatedNode, Library> read() {
    final results = <AnnotatedNode, Library> {};
    for (final source in _sources) {
      for (final astUnit in source.astUnits()) {
        _visitAst(astUnit, source, results);
      }
    }
    return results;
  }

  void _visitAst(
      CompilationUnit astUnit,
      Library fromLibrary,
      Map<AnnotatedNode, Library> resultMap) {
    final visitor = new _AnnotationVisitor(
        _annotations,
        _includeClasses,
        _includeFunctions,
        fromLibrary,
        resultMap);
    astUnit.accept(visitor);
  }
}

/// An implementation of [GeneralizingAstVisitor] that finds annotated nodes.
class _AnnotationVisitor extends GeneralizingAstVisitor {
  final List<Type> _annotations;
  final Library _fromLibrary;
  final bool _includeFunctions;
  final bool _includeClasses;
  final Map<AnnotatedNode, Library> _resultMap;

  _AnnotationVisitor(
      this._annotations,
      this._includeClasses,
      this._includeFunctions,
      this._fromLibrary,
      this._resultMap);

  bool _hasAnnotation(AnnotatedNode astNode) {
    // TODO: Use actual resolved type check, not simple name.
    final annotationNames = _annotations.map((type) {
      return MirrorSystem.getName(reflectType(type).simpleName);
    }).toList(growable: false);
    for (final metadata in astNode.metadata) {
      if (annotationNames.contains(metadata.name.name)) {
        return true;
      }
    }
    return false;
  }

  @override
  visitAnnotatedNode(AnnotatedNode astNode) {
    if (_hasAnnotation(astNode)) {
      if (_includeClasses && astNode is ClassDeclaration) {
        _resultMap[astNode] = _fromLibrary;
      } else if (_includeFunctions) {
        if (astNode is MethodDeclaration || astNode is FunctionDeclaration) {
          _resultMap[astNode] = _fromLibrary;
        }
      }
    }
    super.visitAnnotatedNode(astNode);
  }
}
