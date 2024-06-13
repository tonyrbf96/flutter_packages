import 'package:rive_dart_importer/src/generated/shapes/triangle_base.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/path_vertex.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/straight_vertex.dart';

/// Export the Base class for external use (e.g. rive.dart)
export 'package:rive_dart_importer/src/generated/shapes/triangle_base.dart';

class Triangle extends TriangleBase {
  @override
  List<PathVertex> get vertices {
    double ox = -originX * width;
    double oy = -originY * height;

    return [
      StraightVertex.procedural()
        ..x = ox + width / 2
        ..y = oy,
      StraightVertex.procedural()
        ..x = ox + width
        ..y = oy + height,
      StraightVertex.procedural()
        ..x = ox
        ..y = oy + height
    ];
  }

  @override
  computeBounds(toParent) {
    throw UnimplementedError();
  }

  @override
  computeIntrinsicSize(min, max) {
    throw UnimplementedError();
  }

  @override
  void controlSize(size) {}

  @override
  void heightChanged(double from, double to) {}

  @override
  void originXChanged(double from, double to) {}

  @override
  void originYChanged(double from, double to) {}

  @override
  void pathFlagsChanged(int from, int to) {}

  @override
  void widthChanged(double from, double to) {}
}
