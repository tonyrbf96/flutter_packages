import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/shapes/cubic_asymmetric_vertex_base.dart';

export 'package:rive_dart_importer/src/generated/shapes/cubic_asymmetric_vertex_base.dart';

class CubicAsymmetricVertex extends CubicAsymmetricVertexBase {
  CubicAsymmetricVertex();
  CubicAsymmetricVertex.procedural() {
    InternalCoreHelper.markValid(this);
  }

  CubicAsymmetricVertex.fromValues({
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
  var inPoint;

  @override
  var outPoint;

  @override
  void inDistanceChanged(double from, double to) {}

  @override
  void outDistanceChanged(double from, double to) {}

  @override
  void rotationChanged(double from, double to) {}

  @override
  void markGeometryDirty() {}

  @override
  void xChanged(double from, double to) {}

  @override
  void yChanged(double from, double to) {}
}
