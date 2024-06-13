import 'package:rive_dart_importer/src/generated/node_base.dart';

export 'package:rive_dart_importer/src/generated/node_base.dart';

class _UnknownNode extends Node {}

class Node extends NodeBase {
  static final Node unknown = _UnknownNode();

  @override
  void xChanged(double from, double to) {
    markTransformDirty();
  }

  @override
  void yChanged(double from, double to) {
    markTransformDirty();
  }
}
