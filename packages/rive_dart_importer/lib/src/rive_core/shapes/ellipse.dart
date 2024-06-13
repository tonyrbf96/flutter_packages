import 'package:rive_dart_importer/src/generated/shapes/ellipse_base.dart';
export 'package:rive_dart_importer/src/generated/shapes/ellipse_base.dart';

class Ellipse extends EllipseBase {
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
