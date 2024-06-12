import 'package:rive_dart_importer/src/generated/text/text_style_axis_base.dart';
import 'package:rive_dart_importer/src/rive_core/component_dirt.dart';
import 'package:rive_common/rive_text.dart';

export 'package:rive_dart_importer/src/generated/text/text_style_axis_base.dart';

class TextStyleAxis extends TextStyleAxisBase {
  String get tagName => FontTag.tagToName(tag);

  @override
  void update(int dirt) {}

  @override
  void axisValueChanged(double from, double to) {
    parent?.addDirt(ComponentDirt.textShape);
  }

  @override
  void tagChanged(int from, int to) => parent?.addDirt(ComponentDirt.textShape);
}
