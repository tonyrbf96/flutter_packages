import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/animation/keyframe_color_base.dart';
export 'package:rive_dart_importer/src/generated/animation/keyframe_color_base.dart';

class KeyFrameColor extends KeyFrameColorBase {
  @override
  void apply(Core<CoreContext> object, int propertyKey, double mix) {}

  @override
  void applyInterpolation(Core<CoreContext> object, int propertyKey,
      double currentTime, KeyFrameColor nextFrame, double mix) {
    var f = (currentTime - seconds) / (nextFrame.seconds - seconds);

    if (interpolator != null) {
      f = interpolator!.transform(f);
    }
  }

  @override
  void valueChanged(int from, int to) {}
}
