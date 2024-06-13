import 'package:rive_dart_importer/src/generated/shapes/points_path_base.dart';
import 'package:rive_dart_importer/src/rive_core/bones/skinnable.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/path_vertex.dart';

export 'package:rive_dart_importer/src/generated/shapes/points_path_base.dart';

class PointsPath extends PointsPathBase with Skinnable<PathVertex> {
  final List<PathVertex> _vertices = [];

  PointsPath() {
    isClosed = false;
  }

  @override
  List<PathVertex> get vertices => _vertices;

  @override
  computeBounds(toParent) {
    throw UnimplementedError();
  }

  @override
  void markSkinDirty() {}

  @override
  void pathFlagsChanged(int from, int to) {}

  @override
  void isClosedChanged(bool from, bool to) {}
}
