import 'package:rive_dart_importer/src/generated/shapes/vertex_base.dart';
import 'package:rive_dart_importer/src/rive_core/bones/weight.dart';

export 'package:rive_dart_importer/src/generated/shapes/vertex_base.dart';

abstract class Vertex<T extends Weight> extends VertexBase {
  @override
  void update(int dirt) {}
}
