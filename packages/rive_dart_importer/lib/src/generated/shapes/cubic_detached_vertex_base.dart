// Core automatically generated
// lib/src/generated/shapes/cubic_detached_vertex_base.dart.
// Do not modify manually.

import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/component_base.dart';
import 'package:rive_dart_importer/src/generated/container_component_base.dart';
import 'package:rive_dart_importer/src/generated/shapes/path_vertex_base.dart';
import 'package:rive_dart_importer/src/generated/shapes/vertex_base.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/cubic_vertex.dart';

abstract class CubicDetachedVertexBase extends CubicVertex {
  static const int typeKey = 6;
  @override
  int get coreType => CubicDetachedVertexBase.typeKey;
  @override
  Set<int> get coreTypes => {
        CubicDetachedVertexBase.typeKey,
        CubicVertexBase.typeKey,
        PathVertexBase.typeKey,
        VertexBase.typeKey,
        ContainerComponentBase.typeKey,
        ComponentBase.typeKey
      };

  /// --------------------------------------------------------------------------
  /// InRotation field with key 84.
  static const int inRotationPropertyKey = 84;
  static const double inRotationInitialValue = 0;
  double _inRotation = inRotationInitialValue;

  /// The in point's angle.
  double get inRotation => _inRotation;

  /// Change the [_inRotation] field value.
  /// [inRotationChanged] will be invoked only if the field's value has changed.
  set inRotation(double value) {
    if (_inRotation == value) {
      return;
    }
    double from = _inRotation;
    _inRotation = value;
    if (hasValidated) {
      inRotationChanged(from, value);
    }
  }

  void inRotationChanged(double from, double to);

  /// --------------------------------------------------------------------------
  /// InDistance field with key 85.
  static const int inDistancePropertyKey = 85;
  static const double inDistanceInitialValue = 0;
  double _inDistance = inDistanceInitialValue;

  /// The in point's distance from the translation of the point.
  double get inDistance => _inDistance;

  /// Change the [_inDistance] field value.
  /// [inDistanceChanged] will be invoked only if the field's value has changed.
  set inDistance(double value) {
    if (_inDistance == value) {
      return;
    }
    double from = _inDistance;
    _inDistance = value;
    if (hasValidated) {
      inDistanceChanged(from, value);
    }
  }

  void inDistanceChanged(double from, double to);

  /// --------------------------------------------------------------------------
  /// OutRotation field with key 86.
  static const int outRotationPropertyKey = 86;
  static const double outRotationInitialValue = 0;
  double _outRotation = outRotationInitialValue;

  /// The out point's angle.
  double get outRotation => _outRotation;

  /// Change the [_outRotation] field value.
  /// [outRotationChanged] will be invoked only if the field's value has
  /// changed.
  set outRotation(double value) {
    if (_outRotation == value) {
      return;
    }
    double from = _outRotation;
    _outRotation = value;
    if (hasValidated) {
      outRotationChanged(from, value);
    }
  }

  void outRotationChanged(double from, double to);

  /// --------------------------------------------------------------------------
  /// OutDistance field with key 87.
  static const int outDistancePropertyKey = 87;
  static const double outDistanceInitialValue = 0;
  double _outDistance = outDistanceInitialValue;

  /// The out point's distance from the translation of the point.
  double get outDistance => _outDistance;

  /// Change the [_outDistance] field value.
  /// [outDistanceChanged] will be invoked only if the field's value has
  /// changed.
  set outDistance(double value) {
    if (_outDistance == value) {
      return;
    }
    double from = _outDistance;
    _outDistance = value;
    if (hasValidated) {
      outDistanceChanged(from, value);
    }
  }

  void outDistanceChanged(double from, double to);

  @override
  void copy(Core source) {
    super.copy(source);
    if (source is CubicDetachedVertexBase) {
      _inRotation = source._inRotation;
      _inDistance = source._inDistance;
      _outRotation = source._outRotation;
      _outDistance = source._outDistance;
    }
  }
}
