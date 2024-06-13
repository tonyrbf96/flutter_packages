import 'package:rive_dart_importer/src/generated/shapes/paint/solid_color_base.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/paint/shape_paint.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/paint/shape_paint_mutator.dart';

export 'package:rive_dart_importer/src/generated/shapes/paint/solid_color_base.dart';

/// A solid color painter for a shape. Works for both Fill and Stroke.
class SolidColor extends SolidColorBase with ShapePaintMutator {
  @override
  void colorValueChanged(int from, int to) {}

  @override
  void update(int dirt) {
    // Intentionally empty. SolidColor doesn't need an update cycle and doesn't
    // depend on anything.
  }

  @override
  bool validate() => super.validate() && parent is ShapePaint;

  @override
  void onAdded() {
    super.onAdded();
  }
}
