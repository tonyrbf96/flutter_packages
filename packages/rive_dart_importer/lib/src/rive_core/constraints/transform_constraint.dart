
import 'package:rive_dart_importer/src/generated/constraints/transform_constraint_base.dart';
import 'package:rive_dart_importer/src/rive_core/transform_component.dart';
export 'package:rive_dart_importer/src/generated/constraints/transform_constraint_base.dart';

/// A constraint copies the transform from the target component to the
/// constrained component in world or local space.
class TransformConstraint extends TransformConstraintBase {
  @override
  void constrain(TransformComponent component) {}

  @override
  void originXChanged(double from, double to) =>
      constrainedComponent?.markTransformDirty();

  @override
  void originYChanged(double from, double to) =>
      constrainedComponent?.markTransformDirty();
}
