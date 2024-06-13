// Core automatically generated lib/src/generated/shapes/points_path_base.dart.
// Do not modify manually.

import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/component_base.dart';
import 'package:rive_dart_importer/src/generated/container_component_base.dart';
import 'package:rive_dart_importer/src/generated/node_base.dart';
import 'package:rive_dart_importer/src/generated/transform_component_base.dart';
import 'package:rive_dart_importer/src/generated/world_transform_component_base.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/path.dart';

abstract class PointsPathBase extends Path {
  static const int typeKey = 16;
  @override
  int get coreType => PointsPathBase.typeKey;
  @override
  Set<int> get coreTypes => {
        PointsPathBase.typeKey,
        PathBase.typeKey,
        NodeBase.typeKey,
        TransformComponentBase.typeKey,
        WorldTransformComponentBase.typeKey,
        ContainerComponentBase.typeKey,
        ComponentBase.typeKey
      };

  /// --------------------------------------------------------------------------
  /// IsClosed field with key 32.
  static const int isClosedPropertyKey = 32;
  static const bool isClosedInitialValue = false;
  bool _isClosed = isClosedInitialValue;

  /// If the path should close back on its first vertex.
  bool get isClosed => _isClosed;

  /// Change the [_isClosed] field value.
  /// [isClosedChanged] will be invoked only if the field's value has changed.
  set isClosed(bool value) {
    if (_isClosed == value) {
      return;
    }
    bool from = _isClosed;
    _isClosed = value;
    if (hasValidated) {
      isClosedChanged(from, value);
    }
  }

  void isClosedChanged(bool from, bool to);

  @override
  void copy(Core source) {
    super.copy(source);
    if (source is PointsPathBase) {
      _isClosed = source._isClosed;
    }
  }
}
