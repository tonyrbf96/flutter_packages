// Core automatically generated
// lib/src/generated/shapes/contour_mesh_vertex_base.dart.
// Do not modify manually.

import 'package:rive_dart_importer/src/generated/component_base.dart';
import 'package:rive_dart_importer/src/generated/container_component_base.dart';
import 'package:rive_dart_importer/src/generated/shapes/vertex_base.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/mesh_vertex.dart';

abstract class ContourMeshVertexBase extends MeshVertex {
  static const int typeKey = 111;
  @override
  int get coreType => ContourMeshVertexBase.typeKey;
  @override
  Set<int> get coreTypes => {
        ContourMeshVertexBase.typeKey,
        MeshVertexBase.typeKey,
        VertexBase.typeKey,
        ContainerComponentBase.typeKey,
        ComponentBase.typeKey
      };
}
