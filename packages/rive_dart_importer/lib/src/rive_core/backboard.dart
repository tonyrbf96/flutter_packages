import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/backboard_base.dart';
import 'package:rive_dart_importer/src/rive_core/assets/asset.dart';

export 'package:rive_dart_importer/src/generated/backboard_base.dart';

class Backboard extends BackboardBase {
  static final Backboard unknown = Backboard();

  final AssetList _assets = AssetList();
  AssetList get assets => _assets;

  bool internalAddAsset(Asset asset) {
    if (_assets.contains(asset)) {
      return false;
    }
    _assets.add(asset);

    return true;
  }

  bool internalRemoveAsset(Asset asset) {
    bool removed = _assets.remove(asset);

    return removed;
  }

  @override
  void onAdded() {}

  @override
  void onAddedDirty() {}
}
