import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/animation/listener_action_base.dart';
import 'package:rive_dart_importer/src/rive_core/animation/state_machine_listener.dart';

export 'package:rive_dart_importer/src/generated/animation/listener_action_base.dart';

abstract class ListenerAction extends ListenerActionBase {
  @override
  void onAdded() {}

  @override
  void onAddedDirty() {}

  @override
  bool import(ImportStack importStack) {
    var importer = importStack
        .latest<StateMachineListenerImporter>(StateMachineListenerBase.typeKey);
    if (importer == null) {
      return false;
    }
    importer.addAction(this);

    return super.import(importStack);
  }
}
