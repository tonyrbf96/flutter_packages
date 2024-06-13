import 'package:rive_dart_importer/src/generated/shapes/shape_base.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/paint/shape_paint_mutator.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/path.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/path_composer.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/shape_paint_container.dart';

export 'package:rive_dart_importer/src/generated/shapes/shape_base.dart';

class Shape extends ShapeBase with ShapePaintContainer {
  final Set<Path> paths = {};

  bool _wantWorldPath = false;
  bool _wantLocalPath = false;
  bool get wantWorldPath => _wantWorldPath;
  bool get wantLocalPath => _wantLocalPath;
  bool _fillInWorld = false;
  bool get fillInWorld => _fillInWorld;

  late PathComposer pathComposer;
  Shape() {
    pathComposer = PathComposer(this);
  }

  /// Let the shape know that any further call to get world/local bounds will
  /// need to rebuild the cached bounds.
  void markBoundsDirty() {}

  @override
  void onDirty(int mask) {
    pathComposer.syncCollapse();
    super.onDirty(mask);
  }

  @override
  void onFillsChanged() {}

  @override
  void onPaintMutatorChanged(ShapePaintMutator mutator) {}

  @override
  void onStrokesChanged() {}

  @override
  void blendModeValueChanged(int from, int to) {}

  @override
  void drawableFlagsChanged(int from, int to) {}
}
