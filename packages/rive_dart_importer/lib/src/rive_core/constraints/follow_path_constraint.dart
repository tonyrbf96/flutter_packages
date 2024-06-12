import 'package:rive_dart_importer/src/generated/constraints/follow_path_constraint_base.dart';
import 'package:rive_dart_importer/src/rive_core/component.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/path.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/shape.dart';
import 'package:rive_dart_importer/src/rive_core/transform_component.dart';

export 'package:rive_dart_importer/src/generated/constraints/follow_path_constraint_base.dart';

/// A constraint which transforms its constrained TransformComponent to the
/// targeted path.
class FollowPathConstraint extends FollowPathConstraintBase {
  @override
  void constrain(TransformComponent component) {}

  @override
  void buildDependencies() {
    if (target is Shape) {
      var shape = target as Shape;
      // Follow path should update after the target's path composer
      shape.pathComposer.addDependent(this);
    } else if (target is Path) {
      var path = target as Path;
      path.addDependent(this);
    }

    if (constrainedComponent != null) {
      // The constrained component should update after follow path
      addDependent(constrainedComponent!, via: this);
    }
  }

  @override
  void update(int dirt) {}

  @override
  Component? get targetDependencyParent => target is Shape
      ? (target as Shape)
      : target is Path
          ? (target as Path)
          : null;

  @override
  void distanceChanged(double from, double to) => markConstraintDirty();

  @override
  void orientChanged(bool from, bool to) => markConstraintDirty();

  @override
  void offsetChanged(bool from, bool to) => markConstraintDirty();

  @override
  bool validate() =>
      super.validate() && (target == null || target is Shape || target is Path);
}
