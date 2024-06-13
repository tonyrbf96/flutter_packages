import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/animation/nested_trigger_base.dart';

export 'package:rive_dart_importer/src/generated/animation/nested_trigger_base.dart';

class NestedTrigger extends NestedTriggerBase {
  @override
  void fire(CallbackData data) {
    updateValue();
  }

  @override
  void updateValue() => nestedStateMachine?.setInputValue(inputId, true);
}
