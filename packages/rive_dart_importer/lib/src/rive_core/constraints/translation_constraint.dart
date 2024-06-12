import 'package:rive_dart_importer/src/generated/constraints/translation_constraint_base.dart';
import 'package:rive_dart_importer/src/rive_core/transform_component.dart';
export 'package:rive_dart_importer/src/generated/constraints/translation_constraint_base.dart';

/// A constraint copies the translation from the target component to the
/// constrained component in world or local space and applies copy/min/max
/// rules.
class TranslationConstraint extends TranslationConstraintBase {
  @override
  void constrain(TransformComponent component) {}
}
