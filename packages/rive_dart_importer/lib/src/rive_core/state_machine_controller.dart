library rive_core;

import 'dart:collection';
import 'dart:math';
import 'package:meta/meta.dart';
import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/rive_core/animation/animation_state_instance.dart';
import 'package:rive_dart_importer/src/rive_core/animation/any_state.dart';
import 'package:rive_dart_importer/src/rive_core/animation/keyed_object.dart';
import 'package:rive_dart_importer/src/rive_core/animation/layer_state.dart';
import 'package:rive_dart_importer/src/rive_core/animation/linear_animation.dart';
import 'package:rive_dart_importer/src/rive_core/animation/state_instance.dart';
import 'package:rive_dart_importer/src/rive_core/animation/state_machine.dart';
import 'package:rive_dart_importer/src/rive_core/animation/state_machine_fire_event.dart';
import 'package:rive_dart_importer/src/rive_core/animation/state_machine_layer.dart';
import 'package:rive_dart_importer/src/rive_core/animation/state_machine_listener.dart';
import 'package:rive_dart_importer/src/rive_core/animation/state_machine_trigger.dart';
import 'package:rive_dart_importer/src/rive_core/animation/state_transition.dart';
import 'package:rive_dart_importer/src/rive_core/artboard.dart';
import 'package:rive_dart_importer/src/rive_core/audio_player.dart';
import 'package:rive_dart_importer/src/rive_core/event.dart';
import 'package:rive_dart_importer/src/rive_core/layer_state_flags.dart';
import 'package:rive_dart_importer/src/rive_core/node.dart';
import 'package:rive_dart_importer/src/rive_core/rive_animation_controller.dart';
import 'package:rive_dart_importer/src/runtime_event.dart';

/// Callback signature for state machine state changes
typedef OnStateChange = void Function(
    String stateMachineName, String stateName);

/// Callback signature for nested input changes
typedef OnInputValueChange = void Function(int id, dynamic value);

/// Callback signature for layer state changes
typedef OnLayerStateChange = void Function(LayerState);

/// Callback signature for events firing.
typedef OnEvent = void Function(RiveEvent);

class LayerController {
  final StateMachineLayer layer;
  final StateInstance anyStateInstance;
  final CoreContext core;

  StateInstance? _currentState;
  StateInstance? _stateFrom;
  bool _holdAnimationFrom = false;
  StateTransition? _transition;
  bool _transitionCompleted = false;
  double _mix = 1.0;
  double _mixFrom = 1.0;

  /// Optional callback which is called when a state changes
  /// Takes the state machine name and state name
  final OnLayerStateChange? onLayerStateChange;

  final StateMachineController controller;

  LayerController(
    this.controller,
    this.layer, {
    required this.core,
    this.onLayerStateChange,
  })  : assert(layer.anyState != null),
        anyStateInstance = layer.anyState!.makeInstance() {
    _changeState(layer.entryState);
  }

  void _fireEvents(Iterable<StateMachineFireEvent> fireEvents) {
    for (final fireEvent in fireEvents) {
      var event = core.resolve(fireEvent.eventId);
      if (event != null) {
        controller.reportEvent(event);
      }
    }
  }

  bool _canChangeState(LayerState? state) {
    return state != _currentState?.state;
  }

  void _changeState(LayerState? state, {StateTransition? transition}) {
    assert(state is! AnyState,
        'We don\'t allow making the AnyState an active state.');
    assert(state != _currentState?.state, 'Cannot change to state to self.');
    var currentState = _currentState;
    if (currentState != null) {
      _fireEvents(currentState.state.eventsAt(StateMachineFireOccurance.atEnd));
      currentState.dispose();
    }
    var nextState = state;

    if (nextState != null) {
      _currentState = nextState.makeInstance();
      _fireEvents(nextState.eventsAt(StateMachineFireOccurance.atStart));
    } else {
      _currentState = null;
    }
  }

  void dispose() {
    _changeState(null);
    anyStateInstance.dispose();
  }

  bool get isTransitioning =>
      _transition != null &&
      _stateFrom != null &&
      _transition!.duration != 0 &&
      _mix != 1;

  void _updateMix(double elapsedSeconds) {
    var transition = _transition;
    if (transition != null && _stateFrom != null && transition.duration != 0) {
      _mix = (_mix + elapsedSeconds / transition.mixTime(_stateFrom!.state))
          .clamp(0, 1)
          .toDouble();

      if (_mix == 1 && !_transitionCompleted) {
        _transitionCompleted = true;
        _fireEvents(transition.eventsAt(StateMachineFireOccurance.atEnd));
      }
    } else {
      _mix = 1;
    }
  }

  void _apply(CoreContext core) {
    if (_holdAnimation != null) {
      _holdAnimation!.apply(_holdTime, coreContext: core, mix: _mixFrom);
      _holdAnimation = null;
    }

    final interpolator = _transition?.interpolator;

    if (_stateFrom != null && _mix < 1) {
      final _applyMixFrom = interpolator?.transform(_mixFrom) ?? _mixFrom;
      _stateFrom!.apply(core, _applyMixFrom);
    }
    if (_currentState != null) {
      final _applyMix = interpolator?.transform(_mix) ?? _mix;
      _currentState!.apply(core, _applyMix);
    }
  }

  bool apply(CoreContext core, double elapsedSeconds) {
    if (_currentState != null) {
      _currentState!.advance(elapsedSeconds, controller);
    }

    _updateMix(elapsedSeconds);

    if (_stateFrom != null && _mix < 1) {
      // This didn't advance during our updateState, but it should now that we
      // realize we need to mix it in.
      if (!_holdAnimationFrom) {
        _stateFrom!.advance(elapsedSeconds, controller);
      }
    }
    _apply(core);

    for (int i = 0; updateState(i != 0); i++) {
      _apply(core);

      if (i == 100) {
        // Escape hatch, let the user know their logic is causing some kind of
        // recursive condition.
        print('StateMachineController.apply exceeded max iterations.');

        return false;
      }
    }

    // give the current state the oportunity to clear spilled time, so that we
    // do not carry this over into another iteration.
    _currentState?.clearSpilledTime();

    // We still need to mix in the current state if mix value is less than one
    // as it still contributes to the end result.
    // It may not need to advance but it does need to apply.
    return _mix != 1 || _waitingForExit || (_currentState?.keepGoing ?? false);
  }

  bool _waitingForExit = false;
  LinearAnimation? _holdAnimation;
  double _holdTime = 0;

  bool updateState(bool ignoreTriggers) {
    if (isTransitioning && _transition!.enableEarlyExit == false) {
      return false;
    }
    _waitingForExit = false;
    if (tryChangeState(anyStateInstance, ignoreTriggers)) {
      return true;
    }

    return tryChangeState(_currentState, ignoreTriggers);
  }

  StateTransition? _findRandomTransition(
      StateInstance stateFrom, bool ignoreTriggers) {
    double totalWeight = 0;
    final transitions = stateFrom.state.transitions;
    for (final transition in transitions) {
      var allowed = transition.allowed(
          stateFrom, controller._inputValues, ignoreTriggers);
      if (allowed == AllowTransition.yes &&
          _canChangeState(transition.stateTo)) {
        transition.evaluatedRandomWeight = transition.randomWeight;
        totalWeight += transition.randomWeight;
        // If random is not active we don't search for more candidates
      } else {
        transition.evaluatedRandomWeight = 0;
        if (allowed == AllowTransition.waitingForExit) {
          _waitingForExit = true;
        }
      }
    }
    if (totalWeight > 0) {
      final random = Random().nextDouble() * totalWeight;
      double currentWeight = 0;
      int index = 0;
      while (index < transitions.length) {
        final transitionWeight =
            transitions.elementAt(index).evaluatedRandomWeight;
        if (currentWeight + transitionWeight > random) {
          break;
        }
        currentWeight += transitionWeight;
        index += 1;
      }
      assert(index < transitions.length);
      final transition = transitions.elementAt(index);
      return transition;
    }
    return null;
  }

  StateTransition? _findAllowedTransition(
      StateInstance stateFrom, bool ignoreTriggers) {
    if (stateFrom.state.flags & LayerStateFlags.random ==
        LayerStateFlags.random) {
      return _findRandomTransition(stateFrom, ignoreTriggers);
    }
    final transitions = stateFrom.state.transitions;
    for (final transition in transitions) {
      var allowed = transition.allowed(
          stateFrom, controller._inputValues, ignoreTriggers);
      if (allowed == AllowTransition.yes &&
          _canChangeState(transition.stateTo)) {
        return transition;
      } else if (allowed == AllowTransition.waitingForExit) {
        _waitingForExit = true;
      }
    }
    return null;
  }

  bool tryChangeState(StateInstance? stateFrom, bool ignoreTriggers) {
    if (stateFrom == null) {
      return false;
    }

    var outState = _currentState;
    final transition = _findAllowedTransition(stateFrom, ignoreTriggers);
    if (transition != null) {
      _changeState(transition.stateTo, transition: transition);
      // Take transition
      _transition = transition;

      _fireEvents(transition.eventsAt(StateMachineFireOccurance.atStart));
      // Immediately fire end events if transition has no duration.
      if (transition.duration == 0) {
        _transitionCompleted = true;
        _fireEvents(transition.eventsAt(StateMachineFireOccurance.atEnd));
      } else {
        _transitionCompleted = false;
      }

      _stateFrom = outState;

      // If we had an exit time and wanted to pause on exit, make sure to hold
      // the exit time. Delegate this to the transition by telling it that it
      // was completed.
      if (outState != null && transition.applyExitCondition(outState)) {
        // Make sure we apply this state.
        var inst = (outState as AnimationStateInstance).animationInstance;
        _holdAnimation = inst.animation;
        _holdTime = inst.time;
      }
      _mixFrom = _mix;

      // Keep mixing last animation that was mixed in.
      if (_mix != 0) {
        _holdAnimationFrom = transition.pauseOnExit;
      }
      if (outState is AnimationStateInstance) {
        var spilledTime = outState.animationInstance.spilledTime;
        _currentState?.advance(spilledTime, controller);
      }

      _mix = 0;
      _updateMix(0);
      // Make sure to reset _waitingForExit to false if we succeed at taking a
      // transition.
      _waitingForExit = false;
      // State has changed, fire the callback if there's one
      if (_currentState != null) {
        onLayerStateChange?.call(_currentState!.state);
      }
      return true;
    }
    return false;
  }
}

class StateMachineController extends RiveAnimationController<CoreContext>
    implements KeyedCallbackReporter {
  final StateMachine stateMachine;
  final _inputValues = HashMap<int, dynamic>();
  final layerControllers = <LayerController>[];
  final _reportedEvents = <Event>[];
  // Keep a seperate list of nested events because we also need to store
  // the source of the nested event in order to compare to listener target
  final Map<int, List<Event>> _reportedNestedEvents = {};

  /// Optional callback for state changes
  final OnStateChange? onStateChange;

  /// Optional callback for input value changes
  OnInputValueChange? onInputValueChange;

  final _eventListeners = <OnEvent>{};
  AudioPlayer? _audioPlayer;

  AudioPlayer get audioPlayer => (_audioPlayer)!;

  AudioPlayer? get peekAudioPlayer => _audioPlayer;

  List<Event> get reportedEvents => _reportedEvents;

  /// Constructor that takes a state machine and optional state change callback
  StateMachineController(
    this.stateMachine, {
    @Deprecated('Use `addEventListener` instead.') this.onStateChange,
  });

  /// Adds a Rive event listener to this controller.
  ///
  /// Documentation: https://help.rive.app/runtimes/rive-events
  void addEventListener(OnEvent callback) => _eventListeners.add(callback);

  /// Removes listener from this controller.
  void removeEventListener(OnEvent callback) =>
      _eventListeners.remove(callback);

  void reportEvent(Event event) {}

  void reportNestedEvent(Event event, Node source) {
    if (_reportedNestedEvents[source.id] == null) {
      _reportedNestedEvents[source.id] = [];
    }
    _reportedNestedEvents[source.id]!.add(event);
  }

  bool hasListenerWithTarget(Node target) {
    var listeners = stateMachine.listeners.whereType<StateMachineListener>();
    for (final listener in listeners) {
      var listenerTarget = artboard?.context.resolve(listener.targetId);
      if (listenerTarget == target) {
        return true;
      }
    }
    return false;
  }

  void _clearLayerControllers() {
    for (final layer in layerControllers) {
      layer.dispose();
    }
    layerControllers.clear();
  }

  Artboard? _artboard;

  /// The artboard that this state machine controller is manipulating.
  Artboard? get artboard => _artboard;

  late CoreContext core;

  @override
  bool init(CoreContext core) {
    this.core = core;

    _clearLayerControllers();

    for (final layer in stateMachine.layers) {
      layerControllers.add(LayerController(
        this,
        layer,
        core: core,
      ));
    }

    // Make sure triggers are all reset.
    advanceInputs();

    return super.init(core);
  }

  @override
  void dispose() {
    _clearLayerControllers();
    super.dispose();

    _audioPlayer?.dispose();
    _audioPlayer = null;
  }

  @protected
  void advanceInputs() {
    for (final input in stateMachine.inputs) {
      if (input is StateMachineTrigger) {
        _inputValues[input.id] = false;
      }
    }
  }

  dynamic getInputValue(int id) => _inputValues[id];
  void setInputValue(int id, dynamic value) {
    _inputValues[id] = value;

    if (onInputValueChange != null) {
      onInputValueChange!(id, value);
    }
  }

  @override
  void apply(CoreContext core, double elapsedSeconds) {
    if (artboard?.hasChangedDrawOrderInLastUpdate ?? false) {}

    bool keepGoing = false;
    for (final layerController in layerControllers) {
      if (layerController.apply(core, elapsedSeconds)) {
        keepGoing = true;
      }
    }
    advanceInputs();

    applyEvents();
  }

  void applyEvents() {}

  /// Implementation of interface that reports which time based events have
  /// elapsed on a timeline within this state machine.
  @override
  void reportKeyedCallback(
      int objectId, int propertyKey, double elapsedSeconds) {
    var coreObject = core.resolve(objectId);
    if (coreObject != null) {
      RiveCoreContext.setCallback(
        coreObject,
        propertyKey,
        CallbackData(this, delay: elapsedSeconds),
      );
    }
  }
}
