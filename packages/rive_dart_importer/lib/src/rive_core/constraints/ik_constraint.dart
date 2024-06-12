import 'package:rive_dart_importer/src/generated/constraints/ik_constraint_base.dart';
import 'package:rive_dart_importer/src/rive_core/bones/bone.dart';
import 'package:rive_dart_importer/src/rive_core/transform_component.dart';
export 'package:rive_dart_importer/src/generated/constraints/ik_constraint_base.dart';

/// A constraint which rotates its constrained bone and the parentBoneCount
/// bones above it in order to move the tip of the constrained bone towards the
/// target.
class IKConstraint extends IKConstraintBase {
  @override
  void invertDirectionChanged(bool from, bool to) => markConstraintDirty();

  @override
  void parentBoneCountChanged(int from, int to) {}

  @override
  void markConstraintDirty() {
    super.markConstraintDirty();
  }

  @override
  void onAdded() {
    super.onAdded();
  }

  @override
  void onRemoved() {
    super.onRemoved();
  }

  @override
  void buildDependencies() {
    super.buildDependencies();
  }

  @override
  bool validate() => super.validate() && parent is Bone;

  @override
  void constrain(TransformComponent component) {}
}
