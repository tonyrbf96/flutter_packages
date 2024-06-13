import 'package:meta/meta.dart';

/// Abstraction for receiving a per frame callback while isPlaying is true to
/// apply animation based on an elapsed amount of time.
abstract class RiveAnimationController<T> {
  @protected
  void onActivate() {}
  @protected
  void onDeactivate() {}

  /// Apply animation to objects registered in [core]. Note that a [core]
  /// context is specified as animations can be applied to instances.
  void apply(T core, double elapsedSeconds);

  bool init(T core) => true;
  void dispose() {}
}
