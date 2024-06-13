import 'package:meta/meta.dart';
import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/artboard_base.dart';
import 'package:rive_dart_importer/src/rive_core/animation/animation.dart';
import 'package:rive_dart_importer/src/rive_core/animation/linear_animation.dart';
import 'package:rive_dart_importer/src/rive_core/animation/nested_bool.dart';
import 'package:rive_dart_importer/src/rive_core/animation/nested_number.dart';
import 'package:rive_dart_importer/src/rive_core/animation/nested_trigger.dart';
import 'package:rive_dart_importer/src/rive_core/animation/state_machine.dart';
import 'package:rive_dart_importer/src/rive_core/backboard.dart';
import 'package:rive_dart_importer/src/rive_core/component.dart';
import 'package:rive_dart_importer/src/rive_core/component_dirt.dart';
import 'package:rive_dart_importer/src/rive_core/draw_rules.dart';
import 'package:rive_dart_importer/src/rive_core/draw_target.dart';
import 'package:rive_dart_importer/src/rive_core/drawable.dart';
import 'package:rive_dart_importer/src/rive_core/event.dart';
import 'package:rive_dart_importer/src/rive_core/joystick.dart';
import 'package:rive_dart_importer/src/rive_core/layout_component.dart';
import 'package:rive_dart_importer/src/rive_core/nested_artboard.dart';
import 'package:rive_dart_importer/src/rive_core/rive_animation_controller.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/paint/shape_paint_mutator.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/shape_paint_container.dart';

export 'package:rive_dart_importer/src/generated/artboard_base.dart';

class Artboard extends ArtboardBase with ShapePaintContainer {
  final Set<LayoutComponent> _dirtyLayout = {};

  void markLayoutDirty(LayoutComponent layoutComponent) {
    _dirtyLayout.add(layoutComponent);
  }

  bool _frameOrigin = true;
  bool hasChangedDrawOrderInLastUpdate = false;

  /// Returns true when the artboard will shift the origin from the top left to
  /// the relative width/height of the artboard itself. This is what the editor
  /// does visually when you change the origin value to give context as to where
  /// the origin lies within the framed bounds.
  bool get frameOrigin => _frameOrigin;

  /// When composing multiple artboards together in a common world-space, it may
  /// be desireable to have them share the same space regardless of origin
  /// offset from the bounding artboard. Set frameOrigin to false to move the
  /// bounds relative to the origin instead of the origin relative to the
  /// bounds.
  set frameOrigin(bool value) {
    if (_frameOrigin == value) {
      return;
    }
    _frameOrigin = value;
    addDirt(ComponentDirt.paint);
  }

  /// Should antialiasing be used when drawing?
  bool _antialiasing = true;

  bool get antialiasing => _antialiasing;
  set antialiasing(bool value) {}

  /// Artboard are one of the few (only?) components that can be orphaned.
  @override
  bool get canBeOrphaned => true;

  List<Component> _dependencyOrder = [];
  final List<Drawable> _drawables = [];
  List<DrawTarget> _sortedDrawRules = [];

  final Set<Component> _components = {};

  List<Drawable> get drawables => _drawables;

  final AnimationList _animations = AnimationList();
  final EventList _events = EventList();

  /// List of animations and state machines in the artboard.
  AnimationList get animations => _animations;

  /// List of events in the artboard.
  EventList get events => _events;

  /// List of linear animations in the artboard.
  Iterable<LinearAnimation> get linearAnimations =>
      _animations.whereType<LinearAnimation>();

  /// List of state machines in the artboard.
  Iterable<StateMachine> get stateMachines =>
      _animations.whereType<StateMachine>();

  int _dirtDepth = 0;

  /// Iterate each component and call callback for it.
  void forEachComponent(void Function(Component) callback) =>
      _components.forEach(callback);

  /// Find a component of a specific type with a specific name.
  T? component<T>(String name) {
    return getComponentWhereOrNull((component) => component.name == name);
  }

  /// Find a component that matches the given predicate.
  T? getComponentWhereOrNull<T>(bool Function(Component) callback) {
    for (final component in _components) {
      if (component is T && callback(component)) {
        return component as T;
      }
    }
    return null;
  }

  @override
  Artboard get artboard => this;

  /// Walk the dependency tree and update components in order. Returns true if
  /// any component updated.
  bool updateComponents() {
    bool didUpdate = false;

    if ((dirt & ComponentDirt.drawOrder) != 0) {
      sortDrawOrder();
      dirt &= ~ComponentDirt.drawOrder;
      didUpdate = true;
    }
    if ((dirt & ComponentDirt.components) != 0) {
      const int maxSteps = 100;
      int step = 0;
      int count = _dependencyOrder.length;
      while ((dirt & ComponentDirt.components) != 0 && step < maxSteps) {
        dirt &= ~ComponentDirt.components;
        // Track dirt depth here so that if something else marks
        // dirty, we restart.
        for (int i = 0; i < count; i++) {
          Component component = _dependencyOrder[i];
          _dirtDepth = i;
          int d = component.dirt;

          if (d == 0 || (d & ComponentDirt.collapsed) != 0) {
            continue;
          }

          component.dirt &= ComponentDirt.collapsed;
          component.update(d);
          if (_dirtDepth < i) {
            break;
          }
        }
        step++;
      }
      return true;
    }
    return didUpdate;
  }

  final Set<NestedArtboard> _activeNestedArtboards = {};
  Iterable<NestedArtboard> get activeNestedArtboards => _activeNestedArtboards;

  final List<Joystick> _joysticks = [];
  Iterable<Joystick> get joysticks => _joysticks;

  bool canPreApplyJoysticks() {
    if (_joysticks.isEmpty) {
      return false;
    }
    if (_joysticks.any((joystick) => joystick.isComplex)) {
      return false;
    }
    return true;
  }

  bool applyJoysticks() {
    if (_joysticks.isEmpty) {
      return false;
    }
    for (final joystick in _joysticks) {
      if (joystick.isComplex) {
        updateComponents();
      }
      joystick.apply(context);
    }
    return true;
  }

  /// Update any dirty components in this artboard.
  bool advance(double elapsedSeconds, {bool nested = false}) {
    return true;
  }

  @override
  void heightChanged(double from, double to) {
    addDirt(ComponentDirt.worldTransform);
    invalidateStrokeEffects();
    super.heightChanged(from, to);
  }

  void onComponentDirty(Component component) {
    if ((dirt & ComponentDirt.components) == 0) {
      context.markNeedsAdvance();
      dirt |= ComponentDirt.components;
    }

    /// If the order of the component is less than the current dirt depth,
    /// update the dirt depth so that the update loop can break out early and
    /// re-run (something up the tree is dirty).
    if (component.graphOrder < _dirtDepth) {
      _dirtDepth = component.graphOrder;
    }
  }

  @override
  bool resolveArtboard() => true;

  /// Sort the DAG for resolution in order of dependencies such that dependent
  /// components process after their dependencies.
  void sortDependencies() {}

  @override
  void update(int dirt) {}

  @override
  void widthChanged(double from, double to) {
    addDirt(ComponentDirt.worldTransform);
    invalidateStrokeEffects();
    super.widthChanged(from, to);
  }

  @override
  void xChanged(double from, double to) {
    addDirt(ComponentDirt.worldTransform);
  }

  @override
  void yChanged(double from, double to) {
    addDirt(ComponentDirt.worldTransform);
  }

  /// Adds a component to the artboard. Good place for the artboard to check for
  /// components it'll later need to do stuff with (like draw them or sort them
  /// when the draw order changes).
  void addComponent(Component component) {
    if (!_components.add(component)) {
      return;
    }
    switch (component.coreType) {
      case NestedArtboardBase.typeKey:
        addNestedArtboard(component as NestedArtboard);
        break;
      case NestedBoolBase.typeKey:
      case NestedNumberBase.typeKey:
      case NestedTriggerBase.typeKey:
        break;
      case JoystickBase.typeKey:
        _joysticks.add(component as Joystick);
        break;
    }
  }

  /// Remove a component from the artboard and its various tracked lists of
  /// components.
  void removeComponent(Component component) {
    _components.remove(component);
    switch (component.coreType) {
      case NestedArtboardBase.typeKey:
        removeNestedArtboard(component as NestedArtboard);
        break;
      case NestedBoolBase.typeKey:
      case NestedNumberBase.typeKey:
      case NestedTriggerBase.typeKey:
        break;
      case JoystickBase.typeKey:
        _joysticks.remove(component as Joystick);
        break;
    }
  }

  void addNestedArtboard(NestedArtboard artboard) {
    _activeNestedArtboards.add(artboard);
  }

  void removeNestedArtboard(NestedArtboard artboard) {
    _activeNestedArtboards.remove(artboard);
  }

  /// Let the artboard know that the drawables need to be resorted before
  /// drawing next.
  void markDrawOrderDirty() {
    if ((dirt & ComponentDirt.drawOrder) == 0) {
      context.markNeedsAdvance();
      dirt |= ComponentDirt.drawOrder;
    }
  }

  @override
  void originXChanged(double from, double to) {
    addDirt(ComponentDirt.worldTransform);
  }

  @override
  void originYChanged(double from, double to) {
    addDirt(ComponentDirt.worldTransform);
  }

  /// Called by rive_core to add an Animation to an Artboard. This should be
  /// @internal when it's supported.
  bool internalAddAnimation(Animation animation) {
    if (_animations.contains(animation)) {
      return false;
    }
    _animations.add(animation);

    return true;
  }

  /// Called by rive_core to remove an Animation from an Artboard. This should
  /// be @internal when it's supported.
  bool internalRemoveAnimation(Animation animation) {
    bool removed = _animations.remove(animation);

    return removed;
  }

  /// Called by rive_core to add an Event to an Artboard. This should be
  /// @internal when it's supported.
  bool internalAddEvent(Event event) {
    if (_events.contains(event)) {
      return false;
    }
    _events.add(event);

    return true;
  }

  /// Called by rive_core to remove an Event from an Artboard. This should
  /// be @internal when it's supported.
  bool internalRemoveEvent(Event event) {
    bool removed = _events.remove(event);

    return removed;
  }

  /// The animation controllers that are called back whenever the artboard
  /// advances.
  final Set<RiveAnimationController> _animationControllers = {};

  /// Access a read-only iterator of currently applied animation controllers.
  Iterable<RiveAnimationController> get animationControllers =>
      _animationControllers;

  /// Add an animation controller to this artboard. Playing will be scheduled if
  /// it's already playing.
  bool addController(RiveAnimationController controller) {
    return true;
  }

  /// Remove an animation controller form this artboard.
  bool removeController(RiveAnimationController controller) {
    return true;
  }

  @override
  void onFillsChanged() {}

  @override
  void onPaintMutatorChanged(ShapePaintMutator mutator) {}

  @override
  void onStrokesChanged() {}

  @mustBeOverridden
  void play() {}

  @mustBeOverridden
  void pause() {}

  @mustBeOverridden
  bool get isPlaying => true;

  Drawable? firstDrawable;

  void computeDrawOrder() {}

  void sortDrawOrder() {
    hasChangedDrawOrderInLastUpdate = true;
    // Clear out rule first/last items.
    for (final rule in _sortedDrawRules) {
      rule.first = rule.last = null;
    }

    firstDrawable = null;
    Drawable? lastDrawable;
    for (final drawable in _drawables) {
      var rules = drawable.flattenedDrawRules;

      var target = rules?.activeTarget;
      if (target != null) {
        if (target.first == null) {
          target.first = target.last = drawable;
          drawable.prev = drawable.next = null;
        } else {
          target.last?.next = drawable;
          drawable.prev = target.last;
          target.last = drawable;
          drawable.next = null;
        }
      } else {
        drawable.prev = lastDrawable;
        drawable.next = null;
        if (lastDrawable == null) {
          lastDrawable = firstDrawable = drawable;
        } else {
          lastDrawable.next = drawable;
          lastDrawable = drawable;
        }
      }
    }

    for (final rule in _sortedDrawRules) {
      if (rule.first == null) {
        continue;
      }
      switch (rule.placement) {
        case DrawTargetPlacement.before:
          if (rule.drawable?.prev != null) {
            rule.drawable!.prev?.next = rule.first;
            rule.first?.prev = rule.drawable!.prev;
          }
          if (rule.drawable == firstDrawable) {
            firstDrawable = rule.first;
          }
          rule.drawable?.prev = rule.last;
          rule.last?.next = rule.drawable;
          break;
        case DrawTargetPlacement.after:
          if (rule.drawable?.next != null) {
            rule.drawable!.next!.prev = rule.last;
            rule.last?.next = rule.drawable?.next;
          }
          if (rule.drawable == lastDrawable) {
            lastDrawable = rule.last;
          }
          rule.drawable?.next = rule.first;
          rule.first?.prev = rule.drawable;
          break;
      }
    }

    firstDrawable = lastDrawable;
  }

  // Make an instance of the artboard, clones internal objects and properties.
  Artboard instance() {
    /// Intentionally not implemented in the editor, must be overridden in
    /// runtime version of the artboard.
    throw UnsupportedError(
        'Instancing the artboard in the editor isn\'t supported');
  }

  @override
  void clipChanged(bool from, bool to) {
    addDirt(ComponentDirt.paint);
  }

  @override
  bool import(ImportStack stack) {
    var backboardImporter =
        stack.latest<BackboardImporter>(BackboardBase.typeKey);
    if (backboardImporter != null) {
      // Backboard isn't strictly required (editor doesn't always export a
      // backboard when serializing for the clipboard, for example).
      backboardImporter.addArtboard(this);
    }

    return super.import(stack);
  }

  StateMachine? _defaultStateMachine;
  StateMachine? get defaultStateMachine => _defaultStateMachine;
  set defaultStateMachine(StateMachine? value) {
    if (_defaultStateMachine == value) {
      return;
    }

    _defaultStateMachine = value;
    defaultStateMachineId = value?.id ?? Core.missingId;
  }

  @override
  void onAddedDirty() {
    super.onAddedDirty();
    defaultStateMachine = defaultStateMachineId == Core.missingId
        ? null
        : context.resolve(defaultStateMachineId);
  }

  @override
  void defaultStateMachineIdChanged(int from, int to) {
    defaultStateMachine = to == Core.missingId ? null : context.resolve(to);
  }
}
