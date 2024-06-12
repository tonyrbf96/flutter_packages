import 'package:rive_dart_importer/src/generated/shapes/paint/linear_gradient_base.dart';
import 'package:rive_dart_importer/src/rive_core/component.dart';
import 'package:rive_dart_importer/src/rive_core/component_dirt.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/paint/gradient_stop.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/paint/shape_paint_mutator.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/shape.dart';
export 'package:rive_dart_importer/src/generated/shapes/paint/linear_gradient_base.dart';

/// A core linear gradient. Can be added as a child to a [Shape]'s [Fill] or
/// [Stroke] to paint that Fill or Stroke with a gradient. This is the
/// foundation for the RadialGradient which is very similar but also has a
/// radius value.
class LinearGradient extends LinearGradientBase with ShapePaintMutator {
  /// Stored list of core gradient stops are in the hierarchy as children of
  /// this container.
  final List<GradientStop> gradientStops = [];

  bool _paintsInWorldSpace = false;
  bool get paintsInWorldSpace => _paintsInWorldSpace;
  set paintsInWorldSpace(bool value) {
    if (_paintsInWorldSpace == value) {
      return;
    }
    _paintsInWorldSpace = value;
    addDirt(ComponentDirt.paint);
  }

  /// Gradients depends on their shape.
  @override
  void buildDependencies() {
    super.buildDependencies();
    shapePaintContainer?.addDependent(this);
  }

  @override
  void childAdded(Component child) {
    super.childAdded(child);
    if (child is GradientStop && !gradientStops.contains(child)) {
      gradientStops.add(child);

      markStopsDirty();
    }
  }

  @override
  void childRemoved(Component child) {
    super.childRemoved(child);
    if (child is GradientStop && gradientStops.contains(child)) {
      gradientStops.remove(child);

      markStopsDirty();
    }
  }

  /// Mark the gradient stops as changed. This will re-sort the stops and
  /// rebuild the necessary gradients in the next update cycle.
  void markStopsDirty() {
    addDirt(ComponentDirt.stops | ComponentDirt.paint);
    markPaintDirty();
  }

  /// Mark the gradient as needing to be rebuilt. This is a more efficient
  /// version of markStopsDirty as it won't re-sort the stops.
  void markGradientDirty() {
    addDirt(ComponentDirt.paint);
    markPaintDirty();
  }

  @override
  void update(int dirt) {}

  @override
  void startXChanged(double from, double to) {
    addDirt(ComponentDirt.transform);
    markPaintDirty();
  }

  @override
  void startYChanged(double from, double to) {
    addDirt(ComponentDirt.transform);
    markPaintDirty();
  }

  @override
  void endXChanged(double from, double to) {
    addDirt(ComponentDirt.transform);
    markPaintDirty();
  }

  @override
  void endYChanged(double from, double to) {
    addDirt(ComponentDirt.transform);
    markPaintDirty();
  }

  void markPaintDirty() => shapePaintContainer?.addDirt(ComponentDirt.paint);

  @override
  void onAdded() {
    super.onAdded();
  }

  @override
  void opacityChanged(double from, double to) {
    // We don't need to rebuild anything, just let our shape know we should
    // repaint.
    markPaintDirty();
  }

  @override
  bool validate() => super.validate() && shapePaintContainer != null;
}
