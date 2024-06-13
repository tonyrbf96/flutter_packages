import 'package:rive_dart_importer/src/controllers/state_machine_controller.dart';
import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/rive_core/event.dart';
import 'package:rive_dart_importer/src/rive_core/nested_artboard.dart';

/// Callback signature for events firing.
typedef OnRuntimeEvent = void Function(Event);

abstract class RuntimeEventReporter {
  void addRuntimeEventListener(OnRuntimeEvent callback);
  void removeRuntimeEventListener(OnRuntimeEvent callback);
}

class RuntimeMountedArtboard extends MountedArtboard {
  NestedArtboard nestedArtboard;
  final RuntimeArtboard artboardInstance;
  final Set<RuntimeEventReporter> _runtimeEventListeners = {};

  Set<StateMachineController> get controllers =>
      _runtimeEventListeners.whereType<StateMachineController>().toSet();

  // The callback used for bubbling events up from nested artboards
  Function(Event, NestedArtboard)? eventCallback;

  RuntimeMountedArtboard(this.artboardInstance, this.nestedArtboard) {
    artboardInstance.frameOrigin = false;
    artboardInstance.advance(0, nested: true);
  }

  @override
  void dispose() {
    _runtimeEventListeners.clear();
    eventCallback = null;
  }

  @override
  double get renderOpacity => artboardInstance.opacity;

  @override
  double get artboardWidth => artboardInstance.width;

  @override
  set artboardWidth(double width) {
    artboardInstance.width = width;
  }

  @override
  double get artboardHeight => artboardInstance.height;

  @override
  set artboardHeight(double height) {
    artboardInstance.height = height;
  }

  @override
  set renderOpacity(double value) {
    artboardInstance.opacity = value;
  }

  @override
  bool advance(double seconds, {bool nested = true}) =>
      artboardInstance.advance(seconds, nested: nested);

  void addEventListener(RuntimeEventReporter listener) {
    _runtimeEventListeners.add(listener);
    listener.addRuntimeEventListener(_handleRuntimeEvent);
    // Pass an event callback into the child nested artboard's
    // mounted artboard so we get an event bubbled up to us
    artboardInstance.activeNestedArtboards.forEach((artboard) {
      if (artboard.mountedArtboard is RuntimeMountedArtboard) {
        (artboard.mountedArtboard as RuntimeMountedArtboard).eventCallback =
            _handleNestedEvent;
      }
    });
  }

  void removeEventListeners() {
    _runtimeEventListeners.forEach(
        (listener) => listener.removeRuntimeEventListener(_handleRuntimeEvent));
    _runtimeEventListeners.clear();
  }

  void _handleRuntimeEvent(Event event) {
    if (eventCallback != null) {
      eventCallback!(event, nestedArtboard);
    }
  }

  void _handleNestedEvent(Event event, NestedArtboard target) {
    _runtimeEventListeners.forEach((listener) {
      if (listener is StateMachineController &&
          listener.hasListenerWithTarget(target)) {
        listener.reportNestedEvent(event, target);
      }
    });
  }

  @override
  double get originalArtboardHeight => throw UnimplementedError();

  @override
  double get originalArtboardWidth => throw UnimplementedError();
}
