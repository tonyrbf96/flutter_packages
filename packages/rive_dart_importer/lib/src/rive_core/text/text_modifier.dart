import 'package:rive_dart_importer/src/generated/text/text_modifier_base.dart';
import 'package:rive_dart_importer/src/rive_core/text/text_modifier_group.dart';

export 'package:rive_dart_importer/src/generated/text/text_modifier_base.dart';

abstract class TextModifier extends TextModifierBase {
  TextModifierGroup? get modifierGroup => parent as TextModifierGroup?;
}
