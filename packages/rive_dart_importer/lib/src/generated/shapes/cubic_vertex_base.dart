// Core automatically generated
// lib/src/generated/shapes/cubic_vertex_base.dart.
// Do not modify manually.

import 'package:rive_dart_importer/src/generated/component_base.dart';
import 'package:rive_dart_importer/src/generated/container_component_base.dart';
import 'package:rive_dart_importer/src/generated/shapes/vertex_base.dart';
import 'package:rive_dart_importer/src/rive_core/bones/cubic_weight.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/path_vertex.dart';

abstract class CubicVertexBase extends PathVertex<CubicWeight> {
  static const int typeKey = 36;
  @override
  int get coreType => CubicVertexBase.typeKey;
  @override
  Set<int> get coreTypes => {
        CubicVertexBase.typeKey,
        PathVertexBase.typeKey,
        VertexBase.typeKey,
        ContainerComponentBase.typeKey,
        ComponentBase.typeKey
      };
}
