import 'package:rive_dart_importer/src/generated/shapes/path_base.dart';
export 'package:rive_dart_importer/src/generated/shapes/path_base.dart';

enum Axis { horizontal, vertical }

/// An abstract low level path that gets implemented by parametric and point
/// based paths.
abstract class Path extends PathBase {}
