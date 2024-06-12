import 'package:rive_dart_importer/src/generated/shapes/paint/trim_path_base.dart';
import 'package:rive_dart_importer/src/rive_core/component_dirt.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/paint/stroke.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/paint/stroke_effect.dart';
export 'package:rive_dart_importer/src/generated/shapes/paint/trim_path_base.dart';

enum TrimPathMode {
  none,
  sequential,
  synchronized,
}

class TrimPath extends TrimPathBase implements StrokeEffect {
  Stroke? get stroke => parent as Stroke?;

  TrimPathMode get mode => TrimPathMode.values[modeValue];
  set mode(TrimPathMode value) => modeValue = value.index;

  @override
  void invalidateEffect() {
    stroke?.shapePaintContainer?.addDirt(ComponentDirt.paint);
  }

  @override
  void endChanged(double from, double to) => invalidateEffect();

  @override
  void modeValueChanged(int from, int to) => invalidateEffect();

  @override
  void offsetChanged(double from, double to) => invalidateEffect();

  @override
  void startChanged(double from, double to) => invalidateEffect();

  @override
  void update(int dirt) {}

  @override
  void onAdded() {
    super.onAdded();
    stroke?.addStrokeEffect(this);
  }

  @override
  void onRemoved() {
    stroke?.removeStrokeEffect(this);

    super.onRemoved();
  }
}
