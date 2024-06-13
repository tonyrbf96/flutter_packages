import 'package:rive_dart_importer/src/generated/text/text_base.dart';
import 'package:rive_dart_importer/src/rive_core/enum_helper.dart';
import 'package:rive_dart_importer/src/rive_core/text/text_modifier_group.dart';
import 'package:rive_dart_importer/src/rive_core/text/text_style.dart' as rive;
import 'package:rive_dart_importer/src/rive_core/text/text_style_container.dart';
import 'package:rive_dart_importer/src/rive_core/text/text_value_run.dart';
export 'package:rive_dart_importer/src/generated/text/text_base.dart';

enum TextSizing {
  autoWidth,
  autoHeight,
  fixed,
}

enum TextOverflow {
  visible,
  hidden,
  clipped,
  ellipsis,
}

enum TextOrigin {
  top,
  baseline,
}

class Text extends TextBase with TextStyleContainer {
  double? _layoutWidth;
  double? _layoutHeight;

  double get effectiveWidth => _layoutWidth ?? super.width;
  double get effectiveHeight => _layoutHeight ?? super.height;

  List<TextModifierGroup> _modifierGroups = [];
  Iterable<TextModifierGroup> get modifierGroups => _modifierGroups;

  bool get isEmpty => runs.isEmpty;

  final List<rive.TextStyle> auxStyles = [];

  String get text {
    final buffer = StringBuffer();
    for (final run in runs) {
      buffer.write(run.text);
    }
    return buffer.toString();
  }

  rive.TextStyle? styleFromShaperId(int id) => runFromShaperId(id)?.style;
  TextValueRun? runFromShaperId(int id) => id < _runs.length ? _runs[id] : null;

  List<TextValueRun> _runs = [];
  Iterable<TextValueRun> get runs => _runs;

  void _syncRuns() {
    _runs = children.whereType<TextValueRun>().toList(growable: false);
    _modifierGroups =
        children.whereType<TextModifierGroup>().toList(growable: false);

    updateStyles();
  }

  @override
  void onAdded() {
    super.onAdded();
    _syncRuns();
  }

  TextSizing get sizing => TextSizing.values[sizingValue];
  TextSizing get effectiveSizing =>
      _layoutHeight != null ? TextSizing.fixed : TextSizing.values[sizingValue];

  set sizing(TextSizing value) => sizingValue = value.index;
  TextOverflow get overflow {
    return enumAt(TextOverflow.values, overflowValue);
  }

  set overflow(TextOverflow value) => overflowValue = value.index;

  @override
  void blendModeValueChanged(int from, int to) {}

  @override
  void drawableFlagsChanged(int from, int to) {}

  @override
  void alignValueChanged(int from, int to) {}

  @override
  void heightChanged(double from, double to) {}

  @override
  void originValueChanged(int from, int to) {}

  @override
  void originXChanged(double from, double to) {}

  @override
  void originYChanged(double from, double to) {}

  @override
  void overflowValueChanged(int from, int to) {}

  @override
  void paragraphSpacingChanged(double from, double to) {}

  @override
  void sizingValueChanged(int from, int to) {}

  @override
  void widthChanged(double from, double to) {}
}
