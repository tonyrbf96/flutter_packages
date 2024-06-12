import 'package:meta/meta.dart';
import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/animation/keyframe_interpolator_base.dart';
import 'package:rive_dart_importer/src/rive_core/animation/interpolator.dart';
import 'package:rive_dart_importer/src/rive_core/artboard.dart';

export 'package:rive_dart_importer/src/generated/animation/keyframe_interpolator_base.dart';

abstract class KeyFrameInterpolator extends KeyFrameInterpolatorBase
    implements Interpolator {
  @override
  void onAdded() => updateInterpolator();

  @protected
  void updateInterpolator() {}

  @override
  bool import(ImportStack stack) {
    var artboardHelper = stack.latest<ArtboardImporter>(ArtboardBase.typeKey);
    if (artboardHelper == null) {
      return false;
    }
    artboardHelper.addComponent(this);

    return super.import(stack);
  }
}
