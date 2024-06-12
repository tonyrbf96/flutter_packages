// We really want this file to import core for the flutter runtime, so make the
// linter happy...

// ignore: unused_import
import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/animation/state_machine_layer_component_base.dart';
import 'package:rive_dart_importer/src/rive_core/animation/state_machine_fire_event.dart';

export 'package:rive_dart_importer/src/generated/animation/state_machine_layer_component_base.dart';

abstract class StateMachineLayerComponent
    extends StateMachineLayerComponentBase<RuntimeArtboard> {
  final LayerComponentEvents _events = LayerComponentEvents();
  LayerComponentEvents get events => _events;

  void internalAddFireEvent(StateMachineFireEvent event) {
    assert(!_events.contains(event), 'shouldn\'t already contain the event');
    _events.add(event);
  }

  Iterable<StateMachineFireEvent> eventsAt(
          StateMachineFireOccurance occurence) =>
      _events
          .where((fireEvent) => fireEvent.occurs == occurence)
          .whereNotNull();
}
