import 'dart:typed_data';

import 'package:rive_dart_importer/src/generated/bones/skin_base.dart';
import 'package:rive_dart_importer/src/rive_core/bones/bone.dart';
import 'package:rive_dart_importer/src/rive_core/bones/skinnable.dart';
import 'package:rive_dart_importer/src/rive_core/bones/tendon.dart';
import 'package:rive_dart_importer/src/rive_core/component.dart';
import 'package:rive_dart_importer/src/rive_core/component_dirt.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/vertex.dart';
export 'package:rive_dart_importer/src/generated/bones/skin_base.dart';

/// Represents a skin deformation of either a Path or an Image Mesh connected to
/// a set of bones.
class Skin extends SkinBase {
  final List<Tendon> _tendons = [];
  List<Tendon> get tendons => _tendons;
  Float32List _boneTransforms = Float32List(0);

  @override
  void onDirty(int mask) {
    // When the skin is dirty the deformed skinnable will need to regenerate its
    // drawing commands.
    if (parent is Skinnable) {
      (parent as Skinnable).markSkinDirty();
    }
  }

  @override
  void update(int dirt) {}

  void deform(List<Vertex> vertices) {}

  @override
  void onAddedDirty() {}

  @override
  void onRemoved() {}

  @override
  void buildDependencies() {
    super.buildDependencies();
    // A skin depends on all its bones. N.B. that we don't depend on the parent
    // skinnable. The skinnable depends on us.
    for (final tendon in _tendons) {
      var bone = tendon.bone;
      if (bone == null) {
        continue;
      }
      bone.addDependent(this);
      if (bone is Bone) {
        for (final childConstraint in bone.peerConstraints) {
          childConstraint.constrainedComponent?.addDependent(this);
        }
      }
    }
  }

  @override
  void childAdded(Component child) {
    super.childAdded(child);
    switch (child.coreType) {
      case TendonBase.typeKey:
        _tendons.add(child as Tendon);
        // Add dirt to recompute stored _boneTransforms
        addDirt(ComponentDirt.worldTransform);
        markRebuildDependencies();
        if (parent is Skinnable) {
          parent!.markRebuildDependencies();
        }
        break;
    }
  }

  @override
  void childRemoved(Component child) {
    super.childRemoved(child);
    switch (child.coreType) {
      case TendonBase.typeKey:
        _tendons.remove(child as Tendon);
        if (_tendons.isEmpty) {
          remove();
        } else {
          // Add dirt to recompute stored _boneTransforms
          addDirt(ComponentDirt.worldTransform);
          markRebuildDependencies();
        }
        parent?.markRebuildDependencies();

        break;
    }
  }

  @override
  void txChanged(double from, double to) {}

  @override
  void tyChanged(double from, double to) {}

  @override
  void xxChanged(double from, double to) {}

  @override
  void xyChanged(double from, double to) {}

  @override
  void yxChanged(double from, double to) {}

  @override
  void yyChanged(double from, double to) {}
}
