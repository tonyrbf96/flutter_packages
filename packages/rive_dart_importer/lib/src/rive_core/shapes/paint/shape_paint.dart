import 'package:rive_dart_importer/src/generated/shapes/paint/shape_paint_base.dart';
import 'package:rive_dart_importer/src/rive_core/component.dart';
import 'package:rive_dart_importer/src/rive_core/component_dirt.dart';
import 'package:rive_dart_importer/src/rive_core/container_component.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/paint/shape_paint_mutator.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/shape.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/shape_paint_container.dart';

export 'package:rive_dart_importer/src/generated/shapes/paint/shape_paint_base.dart';

/// Generic ShapePaint that abstracts Stroke and Fill. Automatically hooks up
/// parent [Shape] to child [ShapePaintMutator]s.
abstract class ShapePaint extends ShapePaintBase {
  ShapePaintMutator? _paintMutator;
  ShapePaintContainer? get shapePaintContainer =>
      parent is ShapePaintContainer ? parent as ShapePaintContainer : null;

  ShapePaint() {}

  double get renderOpacity => _paintMutator!.renderOpacity;
  set renderOpacity(double value) => _paintMutator!.renderOpacity = value;

  ShapePaintMutator? get paintMutator => _paintMutator;

  @override
  void childAdded(Component child) {
    super.childAdded(child);
  }

  @override
  void parentChanged(ContainerComponent? from, ContainerComponent? to) {
    super.parentChanged(from, to);
    if (shapePaintContainer != null) {}
  }

  @override
  bool validate() =>
      super.validate() &&
      parent is ShapePaintContainer &&
      _paintMutator != null;

  @override
  void isVisibleChanged(bool from, bool to) {
    shapePaintContainer?.addDirt(ComponentDirt.paint);
  }

  @override
  void childRemoved(Component child) {
    super.childRemoved(child);
  }
}
