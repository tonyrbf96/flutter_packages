// Core automatically generated
// lib/src/generated/animation/state_machine_listener_base.dart.
// Do not modify manually.

import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/rive_core/animation/state_machine_component.dart';

abstract class StateMachineListenerBase extends StateMachineComponent {
  static const int typeKey = 114;
  @override
  int get coreType => StateMachineListenerBase.typeKey;
  @override
  Set<int> get coreTypes =>
      {StateMachineListenerBase.typeKey, StateMachineComponentBase.typeKey};

  /// --------------------------------------------------------------------------
  /// TargetId field with key 224.
  static const int targetIdPropertyKey = 224;
  static const int targetIdInitialValue = 0;
  int _targetId = targetIdInitialValue;

  /// Identifier used to track the object use as a target for this listener.
  int get targetId => _targetId;

  /// Change the [_targetId] field value.
  /// [targetIdChanged] will be invoked only if the field's value has changed.
  set targetId(int value) {
    if (_targetId == value) {
      return;
    }
    int from = _targetId;
    _targetId = value;
    if (hasValidated) {
      targetIdChanged(from, value);
    }
  }

  void targetIdChanged(int from, int to);

  /// --------------------------------------------------------------------------
  /// ListenerTypeValue field with key 225.
  static const int listenerTypeValuePropertyKey = 225;
  static const int listenerTypeValueInitialValue = 0;
  int _listenerTypeValue = listenerTypeValueInitialValue;

  /// Listener type (hover, click, etc).
  int get listenerTypeValue => _listenerTypeValue;

  /// Change the [_listenerTypeValue] field value.
  /// [listenerTypeValueChanged] will be invoked only if the field's value has
  /// changed.
  set listenerTypeValue(int value) {
    if (_listenerTypeValue == value) {
      return;
    }
    int from = _listenerTypeValue;
    _listenerTypeValue = value;
    if (hasValidated) {
      listenerTypeValueChanged(from, value);
    }
  }

  void listenerTypeValueChanged(int from, int to);

  /// --------------------------------------------------------------------------
  /// EventId field with key 399.
  static const int eventIdPropertyKey = 399;
  static const int eventIdInitialValue = -1;
  int _eventId = eventIdInitialValue;

  /// Event id for the associated event, if listenerType is event
  int get eventId => _eventId;

  /// Change the [_eventId] field value.
  /// [eventIdChanged] will be invoked only if the field's value has changed.
  set eventId(int value) {
    if (_eventId == value) {
      return;
    }
    int from = _eventId;
    _eventId = value;
    if (hasValidated) {
      eventIdChanged(from, value);
    }
  }

  void eventIdChanged(int from, int to);

  @override
  void copy(Core source) {
    super.copy(source);
    if (source is StateMachineListenerBase) {
      _targetId = source._targetId;
      _listenerTypeValue = source._listenerTypeValue;
      _eventId = source._eventId;
    }
  }
}
