import 'package:meta/meta.dart';
import 'package:rive_dart_importer/src/rive_core/artboard.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/shape_paint_container.dart';

abstract class ShapePaintMutator {
  ShapePaintContainer? _shapePaintContainer;

  /// Getter for the component's artboard
  Artboard? get artboard;

  /// The container is usually either a Shape or an Artboard, basically any of
  /// the various ContainerComponents that can contain Fills or Strokes.
  ShapePaintContainer? get shapePaintContainer => _shapePaintContainer;

  double _renderOpacity = 1;
  double get renderOpacity => _renderOpacity;
  set renderOpacity(double value) {
    if (_renderOpacity != value) {
      _renderOpacity = value;
    }
  }
}
