import 'dart:async';
import 'dart:typed_data';
import 'package:rive_dart_importer/src/generated/assets/image_asset_base.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/image.dart';

export 'package:rive_dart_importer/src/generated/assets/image_asset_base.dart';

class ImageAsset extends ImageAssetBase {
  ImageAsset();

  @override
  Future<void> decode(Uint8List bytes) async {}

  Image getDefaultObject() => Image()
    ..asset = this
    ..name = name;

  static final imageExtensions = ['png', 'webp', 'jpeg'];

  @override
  String get fileExtension => imageExtensions[format];

  int get format => 0;
}
