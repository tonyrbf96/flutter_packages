import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:flutter/foundation.dart';

class RiveGenerator extends Generator {
  const RiveGenerator();
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    return 'const foo = "Hello, Rive!";';
  }
}
