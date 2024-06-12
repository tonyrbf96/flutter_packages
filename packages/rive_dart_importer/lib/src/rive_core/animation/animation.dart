import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/animation/animation_base.dart';
import 'package:rive_dart_importer/src/rive_core/artboard.dart';

export 'package:rive_dart_importer/src/generated/animation/animation_base.dart';

class Animation extends AnimationBase<RuntimeArtboard> {
  Artboard? _artboard;

  Artboard? get artboard => _artboard;
  set artboard(Artboard? value) {
    if (_artboard == value) {
      return;
    }

    _artboard?.internalRemoveAnimation(this);
    _artboard = value;
    _artboard?.internalAddAnimation(this);
  }

  @override
  void onAddedDirty() {}

  @override
  void onAdded() {}

  @override
  bool validate() => super.validate() && _artboard != null;

  @override
  void nameChanged(String from, String to) {}
}
