import 'dart:collection';

import 'package:rive_dart_importer/src/generated/text/text_shape_modifier_base.dart';
import 'package:rive_dart_importer/src/rive_core/text/text.dart';
import 'package:rive_common/rive_text.dart';

export 'package:rive_dart_importer/src/generated/text/text_shape_modifier_base.dart';

abstract class TextShapeModifier extends TextShapeModifierBase {
  double modify(Text text, Font font, HashMap<int, double> variations,
      double fontSize, double strength);
}
