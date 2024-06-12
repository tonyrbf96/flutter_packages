import 'package:rive_dart_importer/src/generated/constraints/scale_constraint_base.dart';
import 'package:rive_dart_importer/src/rive_core/transform_component.dart';

export 'package:rive_dart_importer/src/generated/constraints/scale_constraint_base.dart';

/// A constraint copies the scale from the target component to the
/// constrained component in world or local space and applies copy/min/max
/// rules.
class ScaleConstraint extends ScaleConstraintBase {
  @override
  void constrain(TransformComponent component) {}
}
