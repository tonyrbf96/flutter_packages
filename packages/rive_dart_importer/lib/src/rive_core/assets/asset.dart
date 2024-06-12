import 'package:rive_dart_importer/src/generated/assets/asset_base.dart';

export 'package:rive_dart_importer/src/generated/assets/asset_base.dart';

abstract class Asset extends AssetBase {
  @override
  void nameChanged(String from, String to) {}

  @override
  void onAdded() {}

  @override
  void onAddedDirty() {}
}
