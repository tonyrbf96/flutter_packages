import 'dart:collection';

import 'package:rive_dart_importer/src/generated/animation/transition_trigger_condition_base.dart';
import 'package:rive_dart_importer/src/rive_core/animation/state_machine_trigger.dart';

export 'package:rive_dart_importer/src/generated/animation/transition_trigger_condition_base.dart';

class TransitionTriggerCondition extends TransitionTriggerConditionBase {
  @override
  bool validate() => super.validate() && (input is StateMachineTrigger);

  @override
  bool evaluate(HashMap<int, dynamic> values) {
    if (input is! StateMachineTrigger) {
      return true;
    }
    dynamic providedValue = values[input.id];
    if (providedValue is bool && providedValue) {
      return true;
    }
    return false;
  }
}
