import 'dart:typed_data';

import 'package:rive_dart_importer/src/generated/shapes/mesh_base.dart';
import 'package:rive_dart_importer/src/rive_core/bones/skinnable.dart';
import 'package:rive_dart_importer/src/rive_core/component.dart';
import 'package:rive_dart_importer/src/rive_core/component_dirt.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/mesh_vertex.dart';

export 'package:rive_dart_importer/src/generated/shapes/mesh_base.dart';

class Mesh extends MeshBase with Skinnable<MeshVertex> {
  @override
  void childAdded(Component child) {
    super.childAdded(child);
  }

  void markDrawableDirty() => addDirt(ComponentDirt.vertices);

  @override
  void childRemoved(Component child) {
    super.childRemoved(child);
    if (child is MeshVertex) {}
  }

  @override
  void buildDependencies() {
    super.buildDependencies();
    parent?.addDependent(this);
    skin?.addDependent(this);
  }

  @override
  void markSkinDirty() {}

  @override
  void triangleIndexBytesChanged(Uint8List from, Uint8List to) {}

  @override
  void update(int dirt) {}
}
