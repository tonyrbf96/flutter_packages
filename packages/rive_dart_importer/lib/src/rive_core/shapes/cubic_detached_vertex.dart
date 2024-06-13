import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/shapes/cubic_detached_vertex_base.dart';

export 'package:rive_dart_importer/src/generated/shapes/cubic_detached_vertex_base.dart';

class CubicDetachedVertex extends CubicDetachedVertexBase {
  CubicDetachedVertex();
  CubicDetachedVertex.fromValues({
    required double x,
    required double y,
    double? inX,
    double? inY,
    double? outX,
    double? outY,
  }) {
    InternalCoreHelper.markValid(this);
    this.x = x;
    this.y = y;
  }

  @override
  void inDistanceChanged(double from, double to) {}

  @override
  void inRotationChanged(double from, double to) {}

  @override
  void outDistanceChanged(double from, double to) {}

  @override
  void outRotationChanged(double from, double to) {}

  @override
  void xChanged(double from, double to) {}

  @override
  void yChanged(double from, double to) {}
}
