import 'package:rive_dart_importer/src/generated/shapes/paint/stroke_base.dart';
import 'package:rive_dart_importer/src/rive_core/component_dirt.dart';
import 'package:rive_dart_importer/src/rive_core/enum_helper.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/paint/stroke_effect.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/shape.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/shape_paint_container.dart';

export 'package:rive_dart_importer/src/generated/shapes/paint/stroke_base.dart';

/// A stroke Shape painter.
class Stroke extends StrokeBase {
  StrokeEffect? _effect;
  StrokeEffect? get effect => _effect;

  // Should be @internal when supported.
  // ignore: use_setters_to_change_properties
  void addStrokeEffect(StrokeEffect effect) {
    _effect = effect;
  }

  void removeStrokeEffect(StrokeEffect effect) {
    if (effect == _effect) {
      _effect = null;
    }
  }

  @override
  void capChanged(int from, int to) {}

  @override
  void joinChanged(int from, int to) {}

  @override
  void thicknessChanged(double from, double to) {}

  @override
  void transformAffectsStrokeChanged(bool from, bool to) {
    var parentShape = parent;
    if (parentShape is Shape) {
      parentShape.paintChanged();
    }
  }

  @override
  void update(int dirt) {
    // Intentionally empty, fill doesn't update.
    // Because Fill never adds dependencies, it'll also never get called.
  }

  @override
  void onAdded() {
    super.onAdded();
    if (parent is ShapePaintContainer) {
      (parent as ShapePaintContainer).addStroke(this);
    }
  }

  void invalidateEffects() => _effect?.invalidateEffect();
}
