import 'package:rive_dart_importer/src/generated/shapes/paint/gradient_stop_base.dart';
import 'package:rive_dart_importer/src/rive_core/container_component.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/paint/linear_gradient.dart';

export 'package:rive_dart_importer/src/generated/shapes/paint/gradient_stop_base.dart';

class GradientStop extends GradientStopBase {
  LinearGradient? _gradient;
  LinearGradient? get gradient => _gradient;

  @override
  void positionChanged(double from, double to) {
    _gradient?.markStopsDirty();
  }

  @override
  void colorValueChanged(int from, int to) {
    _gradient?.markGradientDirty();
  }

  @override
  void update(int dirt) {}

  @override
  bool validate() => super.validate() && _gradient != null;

  @override
  void parentChanged(ContainerComponent? from, ContainerComponent? to) {
    super.parentChanged(from, to);
    if (parent is LinearGradient) {
      _gradient = parent as LinearGradient;
    } else {
      _gradient = null;
    }
  }
}
