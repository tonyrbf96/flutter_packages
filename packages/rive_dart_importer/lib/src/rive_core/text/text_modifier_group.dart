import 'package:rive_dart_importer/src/generated/text/text_modifier_group_base.dart';
import 'package:rive_dart_importer/src/rive_core/text/text.dart';

export 'package:rive_dart_importer/src/generated/text/text_modifier_group_base.dart';

class TextModifierFlags {
  static const int modifyOrigin = 1 << 0;
  static const int modifyTranslation = 1 << 2;
  static const int modifyRotation = 1 << 3;
  static const int modifyScale = 1 << 4;
  static const int modifyOpacity = 1 << 5;
  static const int invertOpacity = 1 << 6;
}

class TextModifierGroup extends TextModifierGroupBase {
  Text? get textComponent => parent as Text?;

  @override
  void update(int dirt) {}

  @override
  void modifierFlagsChanged(int from, int to) {}

  @override
  void opacityChanged(double from, double to) {}

  @override
  void originXChanged(double from, double to) {}

  @override
  void originYChanged(double from, double to) {}

  @override
  void rotationChanged(double from, double to) {}

  @override
  void scaleXChanged(double from, double to) {}

  @override
  void scaleYChanged(double from, double to) {}

  @override
  void xChanged(double from, double to) {}

  @override
  void yChanged(double from, double to) {}
}
