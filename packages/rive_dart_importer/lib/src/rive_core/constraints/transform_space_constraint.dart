import 'package:rive_dart_importer/src/generated/constraints/transform_space_constraint_base.dart';
import 'package:rive_dart_importer/src/rive_core/enum_helper.dart';
import 'package:rive_dart_importer/src/rive_core/transform_space.dart';
export 'package:rive_dart_importer/src/generated/constraints/transform_space_constraint_base.dart';

abstract class TransformSpaceConstraint extends TransformSpaceConstraintBase {
  TransformSpace get destSpace => enumAt(TransformSpace.values, destSpaceValue);
  set destSpace(TransformSpace value) => destSpaceValue = value.index;

  TransformSpace get sourceSpace => TransformSpace.values[sourceSpaceValue];
  set sourceSpace(TransformSpace value) => sourceSpaceValue = value.index;

  @override
  void destSpaceValueChanged(int from, int to) => markConstraintDirty();

  @override
  void sourceSpaceValueChanged(int from, int to) => markConstraintDirty();
}
