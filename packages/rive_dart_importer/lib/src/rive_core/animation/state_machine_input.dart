// ignore_for_file: use_setters_to_change_properties

import 'dart:collection';

import 'package:rive_dart_importer/src/generated/animation/state_machine_input_base.dart';
import 'package:rive_dart_importer/src/rive_core/animation/state_machine.dart';
import 'package:rive_dart_importer/src/rive_core/animation/state_machine_component.dart';

export 'package:rive_dart_importer/src/generated/animation/state_machine_input_base.dart';

abstract class StateMachineInput extends StateMachineInputBase {
  static final StateMachineInput unknown = _StateMachineUnknownInput();

  @override
  ListBase<StateMachineComponent> machineComponentList(StateMachine machine) =>
      machine.inputs;

  bool isValidType<T>() => false;
}

class _StateMachineUnknownInput extends StateMachineInput {}
