// Core automatically generated
// lib/src/generated/animation/state_machine_bool_base.dart.
// Do not modify manually.

import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/animation/state_machine_component_base.dart';
import 'package:rive_dart_importer/src/rive_core/animation/state_machine_input.dart';

abstract class StateMachineBoolBase extends StateMachineInput {
  static const int typeKey = 59;
  @override
  int get coreType => StateMachineBoolBase.typeKey;
  @override
  Set<int> get coreTypes => {
        StateMachineBoolBase.typeKey,
        StateMachineInputBase.typeKey,
        StateMachineComponentBase.typeKey
      };

  /// --------------------------------------------------------------------------
  /// Value field with key 141.
  static const int valuePropertyKey = 141;
  static const bool valueInitialValue = false;
  bool _value = valueInitialValue;
  bool get value => _value;

  /// Change the [_value] field value.
  /// [valueChanged] will be invoked only if the field's value has changed.
  set value(bool value) {
    if (_value == value) {
      return;
    }
    bool from = _value;
    _value = value;
    if (hasValidated) {
      valueChanged(from, value);
    }
  }

  void valueChanged(bool from, bool to);

  @override
  void copy(Core source) {
    super.copy(source);
    if (source is StateMachineBoolBase) {
      _value = source._value;
    }
  }
}
