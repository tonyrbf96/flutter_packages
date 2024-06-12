// Core automatically generated lib/src/generated/assets/audio_asset_base.dart.
// Do not modify manually.

import 'package:rive_dart_importer/src/generated/assets/asset_base.dart';
import 'package:rive_dart_importer/src/generated/assets/file_asset_base.dart';
import 'package:rive_dart_importer/src/rive_core/assets/export_audio.dart';

abstract class AudioAssetBase extends ExportAudio {
  static const int typeKey = 406;
  @override
  int get coreType => AudioAssetBase.typeKey;
  @override
  Set<int> get coreTypes => {
        AudioAssetBase.typeKey,
        ExportAudioBase.typeKey,
        FileAssetBase.typeKey,
        AssetBase.typeKey
      };
}
