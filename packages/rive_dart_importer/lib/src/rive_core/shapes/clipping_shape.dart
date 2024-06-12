import 'package:rive_dart_importer/src/generated/shapes/clipping_shape_base.dart';
import 'package:rive_dart_importer/src/rive_core/component_dirt.dart';
import 'package:rive_dart_importer/src/rive_core/node.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/shape.dart';

export 'package:rive_dart_importer/src/generated/shapes/clipping_shape_base.dart';

class ClippingShape extends ClippingShapeBase {
  final List<Shape> _shapes = [];
  Node _source = Node.unknown;
  Node get source => _source;
  set source(Node value) {
    if (_source == value) {
      return;
    }

    _source = value;
    sourceId = value.id;
  }

  @override
  void fillRuleChanged(int from, int to) {
    // In the future, if clipOp can change at runtime (animation), we may want
    // the shapes that use this as a clipping source to make them depend on this
    // clipping shape so we can add dirt to them directly.
    parent?.addDirt(ComponentDirt.clip, recurse: true);

    addDirt(ComponentDirt.path);
  }

  @override
  void sourceIdChanged(int from, int to) {
    source = context.resolveWithDefault(to, Node.unknown);
  }

  @override
  void onAddedDirty() {
    super.onAddedDirty();
    source = context.resolveWithDefault(sourceId, Node.unknown);
  }

  @override
  void buildDependencies() {
    super.buildDependencies();
    _shapes.clear();
    _source.forAll((component) {
      if (component is Shape) {
        _shapes.add(component);
        //component.addDependent(this);
        component.pathComposer.addDependent(this);
      }
      return true;
    });

    // make sure we rebuild the clipping path.
    addDirt(ComponentDirt.path);
  }

  @override
  void onRemoved() {
    super.onRemoved();
    _shapes.clear();
  }

  @override
  void update(int dirt) {
    if (dirt & (ComponentDirt.worldTransform | ComponentDirt.path) != 0) {}
  }

  @override
  void isVisibleChanged(bool from, bool to) {
    // Redraw
    _source.addDirt(ComponentDirt.paint);
  }
}
