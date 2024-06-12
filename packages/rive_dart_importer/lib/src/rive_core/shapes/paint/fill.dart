import 'package:rive_dart_importer/src/generated/shapes/paint/fill_base.dart';
import 'package:rive_dart_importer/src/rive_core/component_dirt.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/shape_paint_container.dart';

export 'package:rive_dart_importer/src/generated/shapes/paint/fill_base.dart';

/// A fill Shape painter.
class Fill extends FillBase {
  @override
  void fillRuleChanged(int from, int to) =>
      parent?.addDirt(ComponentDirt.paint);

  @override
  void update(int dirt) {
    // Intentionally empty, fill doesn't update.
    // Because Fill never adds dependencies, it'll also never get called.
  }

  @override
  void onAdded() {
    super.onAdded();
    if (parent is ShapePaintContainer) {
      (parent as ShapePaintContainer).addFill(this);
    }
  }
}
