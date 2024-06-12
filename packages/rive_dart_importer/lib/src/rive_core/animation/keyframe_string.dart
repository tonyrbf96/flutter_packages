import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/animation/keyframe_string_base.dart';

export 'package:rive_dart_importer/src/generated/animation/keyframe_id_base.dart';

class KeyFrameString extends KeyFrameStringBase {
  @override
  bool get canInterpolate => false;

  @override
  void apply(Core<CoreContext> object, int propertyKey, double mix) {
    RiveCoreContext.setString(object, propertyKey, value);
  }

  @override
  void applyInterpolation(Core<CoreContext> object, int propertyKey,
      double currentTime, KeyFrameString nextFrame, double mix) {
    RiveCoreContext.setString(object, propertyKey, value);
  }

  @override
  void valueChanged(String from, String to) {}
}
