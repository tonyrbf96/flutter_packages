import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/shapes/straight_vertex_base.dart';

export 'package:rive_dart_importer/src/generated/shapes/straight_vertex_base.dart';

class StraightVertex extends StraightVertexBase {
  StraightVertex();

  /// Makes a vertex that is disconnected from core.
  StraightVertex.procedural() {
    InternalCoreHelper.markValid(this);
  }

  @override
  String toString() => 'x[$x], y[$y], r[$radius]';

  @override
  void radiusChanged(double from, double to) {}

  @override
  void xChanged(double from, double to) {}

  @override
  void yChanged(double from, double to) {}
}
