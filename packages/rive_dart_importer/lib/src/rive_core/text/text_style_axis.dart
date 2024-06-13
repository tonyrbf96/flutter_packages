import 'package:rive_dart_importer/src/generated/text/text_style_axis_base.dart';
import 'package:rive_dart_importer/src/rive_core/component_dirt.dart';

export 'package:rive_dart_importer/src/generated/text/text_style_axis_base.dart';

class TextStyleAxis extends TextStyleAxisBase {
  @override
  void update(int dirt) {}

  @override
  void axisValueChanged(double from, double to) {
    parent?.addDirt(ComponentDirt.textShape);
  }

  @override
  void tagChanged(int from, int to) => parent?.addDirt(ComponentDirt.textShape);
}
