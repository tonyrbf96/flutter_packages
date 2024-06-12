import 'package:rive_dart_importer/src/core/importers/artboard_import_stack_object.dart';
import 'package:rive_dart_importer/src/rive_core/animation/keyed_property.dart';
import 'package:rive_dart_importer/src/rive_core/animation/keyframe.dart';
import 'package:rive_dart_importer/src/rive_core/animation/linear_animation.dart';

class KeyedPropertyImporter extends ArtboardImportStackObject {
  final KeyedProperty keyedProperty;
  final LinearAnimation animation;

  KeyedPropertyImporter(this.keyedProperty, this.animation);

  void addKeyFrame(KeyFrame keyFrame) {
    keyedProperty.context.addObject(keyFrame);
    keyedProperty.internalAddKeyFrame(keyFrame);
    keyFrame.computeSeconds(animation);
  }
}
