// Core automatically generated lib/src/generated/shapes/mesh_base.dart.
// Do not modify manually.

import 'package:rive_dart_importer/src/generated/component_base.dart';
import 'package:rive_dart_importer/src/generated/container_component_base.dart';
import 'package:rive_dart_importer/src/rive_core/container_component.dart';
import 'package:rive_dart_importer/utilities.dart';

abstract class MeshBase extends ContainerComponent {
  static const int typeKey = 109;
  @override
  int get coreType => MeshBase.typeKey;
  @override
  Set<int> get coreTypes =>
      {MeshBase.typeKey, ContainerComponentBase.typeKey, ComponentBase.typeKey};

  /// --------------------------------------------------------------------------
  /// TriangleIndexBytes field with key 223.
  static const int triangleIndexBytesPropertyKey = 223;
  static final Uint8List triangleIndexBytesInitialValue = Uint8List(0);
  Uint8List _triangleIndexBytes = triangleIndexBytesInitialValue;

  /// Byte data for the triangle indices.
  Uint8List get triangleIndexBytes => _triangleIndexBytes;

  /// Change the [_triangleIndexBytes] field value.
  /// [triangleIndexBytesChanged] will be invoked only if the field's value has
  /// changed.
  set triangleIndexBytes(Uint8List value) {
    if (listEquals(_triangleIndexBytes, value)) {
      return;
    }
    Uint8List from = _triangleIndexBytes;
    _triangleIndexBytes = value;
    if (hasValidated) {
      triangleIndexBytesChanged(from, value);
    }
  }

  void triangleIndexBytesChanged(Uint8List from, Uint8List to);

  @override
  void copy(Core source) {
    super.copy(source);
    if (source is MeshBase) {
      _triangleIndexBytes = source._triangleIndexBytes;
    }
  }
}
