import 'package:rive_dart_importer/src/generated/animation/exit_state_base.dart';
import 'package:rive_dart_importer/src/rive_core/animation/state_instance.dart';

export 'package:rive_dart_importer/src/generated/animation/exit_state_base.dart';

class ExitState extends ExitStateBase {
  @override
  StateInstance makeInstance() => SystemStateInstance(this);
}
