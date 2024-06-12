import 'package:rive_dart_importer/src/generated/animation/nested_state_machine_base.dart';
import 'package:rive_dart_importer/src/rive_core/animation/nested_bool.dart';
import 'package:rive_dart_importer/src/rive_core/animation/nested_input.dart';
import 'package:rive_dart_importer/src/rive_core/animation/nested_number.dart';
import 'package:rive_dart_importer/src/rive_core/nested_artboard.dart';

export 'package:rive_dart_importer/src/generated/animation/nested_state_machine_base.dart';

abstract class NestedStateMachineInstance {
  bool get isActive;

  void apply(covariant MountedArtboard artboard, double elapsedSeconds);

  dynamic getInputValue(int id);
  void setInputValue(int id, dynamic value);
}

class NestedStateMachine extends NestedStateMachineBase {
  @override
  bool advance(double elapsedSeconds, MountedArtboard mountedArtboard) {
    _stateMachineInstance?.apply(mountedArtboard, elapsedSeconds);
    return isEnabled;
  }

  @override
  bool get isEnabled => _stateMachineInstance?.isActive ?? false;

  final Set<NestedInput> _nestedInputs = {};
  Set<NestedInput> get nestedInputs => _nestedInputs;

  NestedStateMachineInstance? _stateMachineInstance;
  NestedStateMachineInstance? get stateMachineInstance => _stateMachineInstance;
  set stateMachineInstance(NestedStateMachineInstance? value) {
    if (_stateMachineInstance == value) {
      return;
    }
    var from = _stateMachineInstance;
    _stateMachineInstance = value;
    stateMachineInstanceChanged(from, value);

    for (final input in nestedInputs) {
      if (input is NestedBool || input is NestedNumber) {
        input.updateValue();
      }
    }
  }

  void stateMachineInstanceChanged(
      NestedStateMachineInstance? from, NestedStateMachineInstance? to) {}

  dynamic getInputValue(int id) {
    int inputId = id;

    _stateMachineInstance?.getInputValue(inputId);
  }

  void setInputValue(int id, dynamic value) {
    int inputId = id;

    _stateMachineInstance?.setInputValue(inputId, value);
  }

  @override
  void onRemoved() {
    stateMachineInstance = null;
    super.onRemoved();
  }
}
