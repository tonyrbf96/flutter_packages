import 'package:rive_dart_importer/src/generated/constraints/constraint_base.dart';
import 'package:rive_dart_importer/src/rive_core/component.dart';
import 'package:rive_dart_importer/src/rive_core/transform_component.dart';
export 'package:rive_dart_importer/src/generated/constraints/constraint_base.dart';

/// A specialized [Component] which can be parented to any [TransformComponent]
/// providing rules for how to constrain its transform space.
abstract class Constraint extends ConstraintBase {
  /// Returns the [TransformComponent] which this [Constraint] is applied to.
  TransformComponent? get constrainedComponent =>
      parent is TransformComponent ? parent as TransformComponent : null;

  @override
  void strengthChanged(double from, double to) =>
      constrainedComponent?.markTransformDirty();

  @override
  bool validate() => super.validate() && parent is TransformComponent;

  void constrain(TransformComponent component);

  @override
  void buildDependencies() {
    super.buildDependencies();

    parent!.addDependent(this);
  }

  @override
  void update(int dirt) {}

  void markConstraintDirty() => constrainedComponent?.markTransformDirty();

  @override
  void onDirty(int mask) => markConstraintDirty();
}
