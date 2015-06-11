library generator.src.generator;

import 'dart:async';

import 'package:generator/src/input.dart';

abstract class Generator<T> {
  Future<T> process(GeneratorInput input);
}
