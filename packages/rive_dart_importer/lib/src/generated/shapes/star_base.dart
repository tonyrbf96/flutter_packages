// Core automatically generated lib/src/generated/shapes/star_base.dart.
// Do not modify manually.

import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/component_base.dart';
import 'package:rive_dart_importer/src/generated/container_component_base.dart';
import 'package:rive_dart_importer/src/generated/node_base.dart';
import 'package:rive_dart_importer/src/generated/shapes/parametric_path_base.dart';
import 'package:rive_dart_importer/src/generated/shapes/path_base.dart';
import 'package:rive_dart_importer/src/generated/transform_component_base.dart';
import 'package:rive_dart_importer/src/generated/world_transform_component_base.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/polygon.dart';

abstract class StarBase extends Polygon {
  static const int typeKey = 52;
  @override
  int get coreType => StarBase.typeKey;
  @override
  Set<int> get coreTypes => {
        StarBase.typeKey,
        PolygonBase.typeKey,
        ParametricPathBase.typeKey,
        PathBase.typeKey,
        NodeBase.typeKey,
        TransformComponentBase.typeKey,
        WorldTransformComponentBase.typeKey,
        ContainerComponentBase.typeKey,
        ComponentBase.typeKey
      };

  /// --------------------------------------------------------------------------
  /// InnerRadius field with key 127.
  static const int innerRadiusPropertyKey = 127;
  static const double innerRadiusInitialValue = 0.5;
  double _innerRadius = innerRadiusInitialValue;

  /// Percentage of width/height to project inner points of the star.
  double get innerRadius => _innerRadius;

  /// Change the [_innerRadius] field value.
  /// [innerRadiusChanged] will be invoked only if the field's value has
  /// changed.
  set innerRadius(double value) {
    if (_innerRadius == value) {
      return;
    }
    double from = _innerRadius;
    _innerRadius = value;
    if (hasValidated) {
      innerRadiusChanged(from, value);
    }
  }

  void innerRadiusChanged(double from, double to);

  @override
  void copy(Core source) {
    super.copy(source);
    if (source is StarBase) {
      _innerRadius = source._innerRadius;
    }
  }
}
