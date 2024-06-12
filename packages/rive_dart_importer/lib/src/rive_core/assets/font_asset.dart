import 'dart:async';
import 'dart:typed_data';

import 'package:rive_dart_importer/src/generated/assets/font_asset_base.dart';

export 'package:rive_dart_importer/src/generated/assets/font_asset_base.dart';

class FontAsset extends FontAssetBase {
  /// Call [callback] when the font is ready. Set [notifyAlreadySet] to
  /// specify if you want to be called if the font is already set.
  bool setFontCallback({
    bool notifyAlreadySet = true,
  }) {
    return false;
  }

  @override
  Future<void> decode(Uint8List bytes) async {}

  @override
  void onRemoved() {
    super.onRemoved();
  }

  // 'otf' supported as well. This getter isn't being used for fontAssets so
  // fine just being ttf for now.
  @override
  String get fileExtension => 'ttf';
}
