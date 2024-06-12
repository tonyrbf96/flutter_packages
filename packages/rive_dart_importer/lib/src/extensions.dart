/// Extensions to the runtime core classes
import 'package:collection/collection.dart';
import 'package:rive_dart_importer/src/controllers/linear_animation_controller.dart';
import 'package:rive_dart_importer/src/controllers/state_machine_controller.dart';
import 'package:rive_dart_importer/src/rive_core/animation/linear_animation.dart';
import 'package:rive_dart_importer/src/rive_core/artboard.dart';
import 'package:rive_dart_importer/src/rive_core/state_machine_controller.dart'
    as core;

/// Artboard extensions
extension ArtboardAdditions on Artboard {
  /// Returns an animation with the given name, or null if no animation with
  /// that name exists in the artboard
  LinearAnimationInstance? animationByName(String name) {
    final animation = animations.firstWhereOrNull(
        (animation) => animation is LinearAnimation && animation.name == name);
    if (animation != null) {
      return LinearAnimationInstance(animation as LinearAnimation);
    }
    return null;
  }

  /// Returns a StateMachine with the given name, or null if no state machine
  /// with that name exists in the artboard
  StateMachineController? stateMachineByName(String name,
          {core.OnStateChange? onChange}) =>
      StateMachineController.fromArtboard(this, name, onStateChange: onChange);
}
