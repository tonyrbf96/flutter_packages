
import 'package:rive_dart_importer/src/generated/layout_component_base.dart';
import 'package:rive_dart_importer/src/rive_core/artboard.dart';
import 'package:rive_dart_importer/src/rive_core/component.dart';
import 'package:rive_dart_importer/src/rive_core/container_component.dart';
import 'package:rive_dart_importer/src/rive_core/layout/layout_component_style.dart';
export 'package:rive_dart_importer/src/generated/layout_component_base.dart';

extension ComponentExtension on Component {
  LayoutComponent? get layoutParent {
    var p = parent;
    while (p != null) {
      if (p is LayoutComponent) {
        return p;
      }
      p = p.parent;
    }
    return artboard;
  }
}

class LayoutComponent extends LayoutComponentBase {
  LayoutComponentStyle? _style;
  LayoutComponentStyle? get style => _style;
  set style(LayoutComponentStyle? style) {
    _style = style;
    styleId = style?.id ?? Core.missingId;
    if (style != null) {
      setupStyle(style);
    }
  }

  void markLayoutNodeDirty() {
    artboard?.markLayoutDirty(this);
  }

  @override
  void changeArtboard(Artboard? value) {
    super.changeArtboard(value);
    artboard?.markLayoutDirty(this);
    if (parent is LayoutComponent) {
      (parent as LayoutComponent).syncLayoutChildren();
    }
  }

  @override
  void clipChanged(bool from, bool to) => markLayoutNodeDirty();

  @override
  void heightChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void widthChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void styleIdChanged(int from, int to) {
    style = context.resolve(to);
    markLayoutNodeDirty();
  }

  @override
  void update(int dirt) {}

  void syncStyle() {
    if (_style == null) {
      return;
    }
    _syncStyle(_style!);
  }

  void _syncStyle(LayoutComponentStyle style) {}

  void syncLayoutChildren() {}

  @override
  void onAdded() {
    super.onAdded();
    syncLayoutChildren();
  }

  @override
  void onAddedDirty() {
    super.onAddedDirty();
    style = context.resolve(styleId);
  }

  LayoutComponentStyle createLayoutStyle() {
    var newStyle = LayoutComponentStyle();
    context.addObject(newStyle);
    style = newStyle;
    return newStyle;
  }

  void setupStyle(LayoutComponentStyle style) {
    appendChild(style);
  }

  void propagateSize() {}

  void updateLayoutBounds() {}

  void styleValueChanged() {
    markLayoutNodeDirty();
  }

  void _removeLayoutNode() {
    var parent = this.parent;
    if (parent is LayoutComponent) {
      parent.markLayoutNodeDirty();
    }
  }

  @override
  void onRemoved() {
    _removeLayoutNode();
    super.onRemoved();
  }

  @override
  void buildDependencies() {
    super.buildDependencies();
    parent?.addDependent(this);
  }
}
