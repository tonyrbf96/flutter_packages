import 'dart:math';

import 'package:rive_dart_importer/src/generated/shapes/polygon_base.dart';
import 'package:rive_dart_importer/src/rive_core/bones/weight.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/path_vertex.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/straight_vertex.dart';

export 'package:rive_dart_importer/src/generated/shapes/polygon_base.dart';

class Polygon extends PolygonBase {
  @override
  List<PathVertex<Weight>> get vertices {
    double ox = -originX * width + width / 2;
    double oy = -originY * height + height / 2;
    var vertexList = <PathVertex<Weight>>[];
    var halfWidth = width / 2;
    var halfHeight = height / 2;
    var angle = -pi / 2;
    var inc = 2 * pi / points;
    for (int i = 0; i < points; i++) {
      vertexList.add(StraightVertex.procedural()
        ..x = ox + cos(angle) * halfWidth
        ..y = oy + sin(angle) * halfHeight
        ..radius = cornerRadius);
      angle += inc;
    }
    return vertexList;
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
  void cornerRadiusChanged(double from, double to) {}

  @override
  void heightChanged(double from, double to) {}

  @override
  void originXChanged(double from, double to) {}

  @override
  void originYChanged(double from, double to) {}

  @override
  void pathFlagsChanged(int from, int to) {}

  @override
  void pointsChanged(int from, int to) {}

  @override
  void widthChanged(double from, double to) {}
}
