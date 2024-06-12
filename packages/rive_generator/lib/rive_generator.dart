library rive_generator;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generator.dart';

Builder riveBuilder(BuilderOptions options) => SharedPartBuilder(
      const <Generator>[RiveGenerator()],
      'rive_generator',
    );
