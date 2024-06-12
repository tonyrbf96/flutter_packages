import 'package:rive_dart_importer/src/generated/text/text_style_feature_base.dart';
import 'package:rive_dart_importer/src/rive_core/component_dirt.dart';
import 'package:rive_common/rive_text.dart';

export 'package:rive_dart_importer/src/generated/text/text_style_feature_base.dart';

class TextStyleFeature extends TextStyleFeatureBase {
  String get tagName => FontTag.tagToName(tag);

  @override
  void update(int dirt) {}

  @override
  void featureValueChanged(int from, int to) {
    parent?.addDirt(ComponentDirt.textShape);
  }

  @override
  void tagChanged(int from, int to) => parent?.addDirt(ComponentDirt.textShape);
}
