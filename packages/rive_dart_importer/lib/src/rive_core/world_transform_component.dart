import 'package:rive_dart_importer/src/generated/world_transform_component_base.dart';
import 'package:rive_dart_importer/src/rive_core/component_dirt.dart';

export 'package:rive_dart_importer/src/generated/world_transform_component_base.dart';

/// A Component with world transform.
abstract class WorldTransformComponent extends WorldTransformComponentBase {
  double get childOpacity => opacity;

  void markWorldTransformDirty() =>
      addDirt(ComponentDirt.worldTransform, recurse: true);

  @override
  void opacityChanged(double from, double to) {
    markWorldTransformDirty();
  }
}
