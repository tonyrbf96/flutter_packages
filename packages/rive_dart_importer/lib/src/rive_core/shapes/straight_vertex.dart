import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/shapes/straight_vertex_base.dart';
import 'package:rive_dart_importer/src/rive_core/bones/weight.dart';

export 'package:rive_dart_importer/src/generated/shapes/straight_vertex_base.dart';

class StraightVertex extends StraightVertexBase {
  /// Nullable because not all vertices have weight, they only have it when the
  /// shape they are in is bound to bones.
  Weight? _weight;

  StraightVertex();

  /// Makes a vertex that is disconnected from core.
  StraightVertex.procedural() {
    InternalCoreHelper.markValid(this);
  }

  @override
  String toString() => 'x[$x], y[$y], r[$radius]';

  @override
  void markGeometryDirty() {}

  @override
  void radiusChanged(double from, double to) {}

  @override
  void xChanged(double from, double to) {}

  @override
  void yChanged(double from, double to) {}
}
