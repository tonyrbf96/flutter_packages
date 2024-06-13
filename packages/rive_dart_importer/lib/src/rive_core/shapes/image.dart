import 'package:rive_dart_importer/src/generated/shapes/image_base.dart';
import 'package:rive_dart_importer/src/rive_core/assets/file_asset.dart';
import 'package:rive_dart_importer/src/rive_core/assets/image_asset.dart';
import 'package:rive_dart_importer/src/rive_core/bones/skinnable.dart';
import 'package:rive_dart_importer/src/rive_core/container_component.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/mesh.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/mesh_vertex.dart';

export 'package:rive_dart_importer/src/generated/shapes/image_base.dart';

class Image extends ImageBase
    with FileAssetReferencer<ImageAsset>, SkinnableProvider<MeshVertex> {
  Mesh? _mesh;
  Mesh? get mesh => _mesh;
  bool get hasMesh => _mesh != null;

  @override
  void assetIdChanged(int from, int to) {}

  @override
  int get assetIdPropertyKey => ImageBase.assetIdPropertyKey;

  @override
  bool import(ImportStack stack) {
    if (!registerWithImporter(stack)) {
      return false;
    }
    return super.import(stack);
  }

  @override
  Skinnable<MeshVertex>? get skinnable => _mesh;

  @override
  void originXChanged(double from, double to) => markTransformDirty();

  @override
  void originYChanged(double from, double to) => markTransformDirty();

  @override
  void blendModeValueChanged(int from, int to) {}

  @override
  void drawableFlagsChanged(int from, int to) {}
}
