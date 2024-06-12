import 'package:rive_dart_importer/src/generated/animation/transition_value_condition_base.dart';
import 'package:rive_dart_importer/src/rive_core/animation/transition_condition.dart';

export 'package:rive_dart_importer/src/generated/animation/transition_value_condition_base.dart';

abstract class TransitionValueCondition extends TransitionValueConditionBase {
  TransitionConditionOp get op => TransitionConditionOp.values[opValue];

  @override
  void opValueChanged(int from, int to) {}
}
