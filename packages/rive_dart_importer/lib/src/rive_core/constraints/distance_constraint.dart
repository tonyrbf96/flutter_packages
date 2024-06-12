import 'package:rive_dart_importer/src/generated/constraints/distance_constraint_base.dart';
import 'package:rive_dart_importer/src/rive_core/enum_helper.dart';
import 'package:rive_dart_importer/src/rive_core/transform_component.dart';

export 'package:rive_dart_importer/src/generated/constraints/distance_constraint_base.dart';

/// [DistanceConstraint]'s logical distancing method.
enum DistanceConstraintMode { closer, further, exact }

/// A constraint which transaltes its constrained component in world space to a
/// certain distance from the [target] based on [mode].
class DistanceConstraint extends DistanceConstraintBase {
  @override
  void constrain(TransformComponent component) {}

  @override
  void distanceChanged(double from, double to) => markConstraintDirty();

  @override
  void modeValueChanged(int from, int to) => markConstraintDirty();

  DistanceConstraintMode get mode =>
      enumAt(DistanceConstraintMode.values, modeValue);
  set mode(DistanceConstraintMode value) => modeValue = value.index;
}
