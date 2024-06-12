import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/animation/state_machine_base.dart';
import 'package:rive_dart_importer/src/rive_core/animation/state_machine_component.dart';
import 'package:rive_dart_importer/src/rive_core/animation/state_machine_layer.dart';
import 'package:rive_dart_importer/src/rive_core/artboard.dart';

export 'package:rive_dart_importer/src/generated/animation/state_machine_base.dart';

class StateMachine extends StateMachineBase {
  final StateMachineComponents<StateMachineComponent> inputs =
      StateMachineComponents<StateMachineComponent>();
  final StateMachineComponents<StateMachineLayer> layers =
      StateMachineComponents<StateMachineLayer>();
  final StateMachineComponents<StateMachineComponent> listeners =
      StateMachineComponents<StateMachineComponent>();

  @override
  bool import(ImportStack stack) {
    var artboardImporter = stack.latest<ArtboardImporter>(ArtboardBase.typeKey);
    if (artboardImporter == null) {
      return false;
    }
    artboardImporter.addStateMachine(this);

    return super.import(stack);
  }
}
