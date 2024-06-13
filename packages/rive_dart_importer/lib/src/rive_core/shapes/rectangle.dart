import 'package:rive_dart_importer/src/generated/shapes/rectangle_base.dart';

export 'package:rive_dart_importer/src/generated/shapes/rectangle_base.dart';

class Rectangle extends RectangleBase {
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
  void cornerRadiusBLChanged(double from, double to) {}

  @override
  void cornerRadiusBRChanged(double from, double to) {}

  @override
  void cornerRadiusTLChanged(double from, double to) {}

  @override
  void cornerRadiusTRChanged(double from, double to) {}

  @override
  void heightChanged(double from, double to) {}

  @override
  void linkCornerRadiusChanged(bool from, bool to) {}

  @override
  void originXChanged(double from, double to) {}

  @override
  void originYChanged(double from, double to) {}

  @override
  void pathFlagsChanged(int from, int to) {}

  @override
  void widthChanged(double from, double to) {}
}
