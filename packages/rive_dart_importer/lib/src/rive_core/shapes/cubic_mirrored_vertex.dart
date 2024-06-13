import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/shapes/cubic_mirrored_vertex_base.dart';
export 'package:rive_dart_importer/src/generated/shapes/cubic_mirrored_vertex_base.dart';

class CubicMirroredVertex extends CubicMirroredVertexBase {
  CubicMirroredVertex();

  /// Makes a vertex that is disconnected from core.
  CubicMirroredVertex.procedural() {
    InternalCoreHelper.markValid(this);
  }

  @override
  void distanceChanged(double from, double to) {}

  @override
  void rotationChanged(double from, double to) {}

  @override
  void xChanged(double from, double to) {}

  @override
  void yChanged(double from, double to) {}
}
