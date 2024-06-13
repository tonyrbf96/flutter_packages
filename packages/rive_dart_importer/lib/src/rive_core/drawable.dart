import 'package:rive_dart_importer/src/generated/drawable_base.dart';
import 'package:rive_dart_importer/src/rive_core/component_dirt.dart';
import 'package:rive_dart_importer/src/rive_core/component_flags.dart';
import 'package:rive_dart_importer/src/rive_core/container_component.dart';
import 'package:rive_dart_importer/src/rive_core/draw_rules.dart';

export 'package:rive_dart_importer/src/generated/drawable_base.dart';

abstract class Drawable extends DrawableBase {
  /// Flattened rules inherited from parents (or self) so we don't have to look
  /// up the tree when re-sorting.
  DrawRules? flattenedDrawRules;

  /// The previous drawable in the draw order.
  Drawable? prev;

  /// The next drawable in the draw order.
  Drawable? next;

  @override
  void buildDrawOrder(
      List<Drawable> drawables, DrawRules? rules, List<DrawRules> allRules) {
    flattenedDrawRules = drawRules ?? rules;

    drawables.add(this);

    super.buildDrawOrder(drawables, rules, allRules);
  }

  @override
  void parentChanged(ContainerComponent? from, ContainerComponent? to) {
    super.parentChanged(from, to);
    // Make sure we re-compute clipping shapes when we change parents. Issue
    // #1586
    addDirt(ComponentDirt.clip);
  }

  bool get isHidden =>
      (drawableFlags & ComponentFlags.hidden) != 0 ||
      (dirt & ComponentDirt.collapsed) != 0;

  bool get isTargetOpaque {
    return (drawableFlags & ComponentFlags.opaque) != 0;
  }
}
