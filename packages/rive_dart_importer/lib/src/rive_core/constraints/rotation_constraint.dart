
import 'package:rive_dart_importer/src/generated/constraints/rotation_constraint_base.dart';
import 'package:rive_dart_importer/src/rive_core/transform_component.dart';
export 'package:rive_dart_importer/src/generated/constraints/rotation_constraint_base.dart';

/// A constraint copies the rotation from the target component to the
/// constrained component in world or local space and applies copy/min/max
/// rules.
class RotationConstraint extends RotationConstraintBase {
  @override
  void constrain(TransformComponent component) {}
}
