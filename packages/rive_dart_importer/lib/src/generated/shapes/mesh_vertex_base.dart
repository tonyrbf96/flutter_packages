// Core automatically generated lib/src/generated/shapes/mesh_vertex_base.dart.
// Do not modify manually.

import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/component_base.dart';
import 'package:rive_dart_importer/src/generated/container_component_base.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/vertex.dart';

abstract class MeshVertexBase extends Vertex {
  static const int typeKey = 108;
  @override
  int get coreType => MeshVertexBase.typeKey;
  @override
  Set<int> get coreTypes => {
        MeshVertexBase.typeKey,
        VertexBase.typeKey,
        ContainerComponentBase.typeKey,
        ComponentBase.typeKey
      };

  /// --------------------------------------------------------------------------
  /// U field with key 215.
  static const int uPropertyKey = 215;
  static const double uInitialValue = 0;
  double _u = uInitialValue;

  /// U value for the texture coordinate of the vertex.
  double get u => _u;

  /// Change the [_u] field value.
  /// [uChanged] will be invoked only if the field's value has changed.
  set u(double value) {
    if (_u == value) {
      return;
    }
    double from = _u;
    _u = value;
    if (hasValidated) {
      uChanged(from, value);
    }
  }

  void uChanged(double from, double to);

  /// --------------------------------------------------------------------------
  /// V field with key 216.
  static const int vPropertyKey = 216;
  static const double vInitialValue = 0;
  double _v = vInitialValue;

  /// V value for the texture coordinate of the vertex.
  double get v => _v;

  /// Change the [_v] field value.
  /// [vChanged] will be invoked only if the field's value has changed.
  set v(double value) {
    if (_v == value) {
      return;
    }
    double from = _v;
    _v = value;
    if (hasValidated) {
      vChanged(from, value);
    }
  }

  void vChanged(double from, double to);

  @override
  void copy(Core source) {
    super.copy(source);
    if (source is MeshVertexBase) {
      _u = source._u;
      _v = source._v;
    }
  }
}
