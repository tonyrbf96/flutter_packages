import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/nested_artboard_base.dart';
import 'package:rive_dart_importer/src/rive_core/animation/nested_remap_animation.dart';
import 'package:rive_dart_importer/src/rive_core/animation/nested_simple_animation.dart';
import 'package:rive_dart_importer/src/rive_core/animation/nested_state_machine.dart';
import 'package:rive_dart_importer/src/rive_core/backboard.dart';
import 'package:rive_dart_importer/src/rive_core/component.dart';
import 'package:rive_dart_importer/src/rive_core/component_dirt.dart';
import 'package:rive_dart_importer/src/rive_core/nested_animation.dart';

export 'package:rive_dart_importer/src/generated/nested_artboard_base.dart';

enum NestedArtboardFitType {
  // ignore: lines_longer_than_80_chars
  fill, // Default value - scales to fill available view without maintaining aspect ratio
  contain,
  cover,
  fitWidth,
  fitHeight,
  resizeArtboard,
  none,
}

enum NestedArtboardAlignmentType {
  center, // Default value
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

/// Represents the nested Artboard that'll actually be mounted and placed into
/// the [NestedArtboard] component.
abstract class MountedArtboard {
  double get renderOpacity;
  set renderOpacity(double value);
  bool advance(double seconds, {bool nested});
  set artboardWidth(double width);
  double get artboardWidth;
  set artboardHeight(double height);
  double get artboardHeight;
  double get originalArtboardWidth;
  double get originalArtboardHeight;
  void dispose();
}

class NestedArtboard extends NestedArtboardBase {
  /// [NestedAnimation]s applied to this [NestedArtboard].
  final List<NestedAnimation> _animations = [];
  Iterable<NestedAnimation> get animations => _animations;

  NestedArtboardFitType get fitType => NestedArtboardFitType.values[fit];
  NestedArtboardAlignmentType get alignmentType =>
      NestedArtboardAlignmentType.values[alignment];

  bool get hasNestedStateMachine =>
      _animations.any((animation) => animation is NestedStateMachine);

  List<NestedStateMachine> get nestedStateMachines =>
      _animations.whereType<NestedStateMachine>().toList(growable: false);

  /// Used by nested animations/state machines to let the nesting artboard know
  /// it needs to redraw/advance time.
  void markNeedsAdvance() => context.markNeedsAdvance();

  MountedArtboard? _mountedArtboard;
  MountedArtboard? get mountedArtboard => _mountedArtboard;
  set mountedArtboard(MountedArtboard? value) {
    if (value == _mountedArtboard) {
      return;
    }
    _mountedArtboard?.dispose();
    _mountedArtboard = value;

    _mountedArtboard?.renderOpacity = renderOpacity;
    _mountedArtboard?.advance(0);
    addDirt(ComponentDirt.paint);
  }

  @override
  void onRemoved() {
    super.onRemoved();
    _mountedArtboard?.dispose();
  }

  @override
  void artboardIdChanged(int from, int to) {}

  @override
  void childAdded(Component child) {
    super.childAdded(child);
    switch (child.coreType) {
      case NestedRemapAnimationBase.typeKey:
      case NestedSimpleAnimationBase.typeKey:
      case NestedStateMachineBase.typeKey:
        _animations.add(child as NestedAnimation);
        break;
    }
  }

  @override
  void childRemoved(Component child) {
    super.childRemoved(child);
    switch (child.coreType) {
      case NestedRemapAnimationBase.typeKey:
      case NestedSimpleAnimationBase.typeKey:
      case NestedStateMachineBase.typeKey:
        _animations.remove(child as NestedAnimation);

        break;
    }
  }

  @override
  void updateWorldTransform() {
    super.updateWorldTransform();
  }

  bool advance(double elapsedSeconds) {
    if (mountedArtboard == null || isCollapsed) {
      return false;
    }

    bool keepGoing = false;
    for (final animation in _animations) {
      if (animation.isEnabled) {
        if (animation.advance(elapsedSeconds, mountedArtboard!)) {
          keepGoing = true;
        }
      }
    }
    if (mountedArtboard!.advance(elapsedSeconds)) {
      keepGoing = true;
    }
    return keepGoing;
  }

  @override
  void update(int dirt) {
    super.update(dirt);
    // RenderOpacity gets updated with the worldTransform (accumulates through
    // hierarchy), so if we see worldTransform is dirty, update our internal
    // render opacities.
    if (dirt & ComponentDirt.worldTransform != 0) {
      mountedArtboard?.renderOpacity = renderOpacity;
    }
  }

  @override
  bool import(ImportStack stack) {
    var backboardImporter =
        stack.latest<BackboardImporter>(BackboardBase.typeKey);
    if (backboardImporter != null) {
      backboardImporter.addNestedArtboard(this);
    }

    return super.import(stack);
  }

  @override
  void alignmentChanged(int from, int to) {}

  @override
  void fitChanged(int from, int to) {}

  @override
  void blendModeValueChanged(int from, int to) {}

  @override
  void drawableFlagsChanged(int from, int to) {}
}
