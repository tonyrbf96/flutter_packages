import 'dart:typed_data';

import 'package:rive_dart_importer/src/generated/assets/audio_asset_base.dart';
export 'package:rive_dart_importer/src/generated/assets/audio_asset_base.dart';

enum AudioContainerFormat { unknown, wav, flac, mp3 }

class AudioAsset extends AudioAssetBase {
  Uint8List? _audioBytes;

  Uint8List? get audioBytes => _audioBytes;
  set audioBytes(Uint8List? bytes) {
    if (_audioBytes == bytes) {
      return;
    }
    _audioBytes = bytes;
  }

  @override
  Future<void> decode(Uint8List bytes) async {
    audioBytes = bytes;
  }

  static AudioContainerFormat containerFormatFromName(String name) {
    switch (name) {
      case 'flac':
        return AudioContainerFormat.flac;
      case 'mp3':
        return AudioContainerFormat.mp3;
      case 'wav':
        return AudioContainerFormat.wav;
    }
    return AudioContainerFormat.unknown;
  }

  // See comment in font_asset.dart
  @override
  String get fileExtension => 'wav';
}
