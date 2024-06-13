import 'package:rive_dart_importer/src/rive_core/assets/audio_asset.dart';

class AudioPlayer {
  double get engineTimeInSeconds {
    return 0;
  }

  void playBuffered({
    Duration startTime = Duration.zero,
    Duration? endTime,
    double volume = 1,
  }) {}

  bool playSource(AudioAsset? audio) {
    return true;
  }

  void stop() {}

  void dispose() {}
}
