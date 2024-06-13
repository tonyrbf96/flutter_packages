import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/text/text_modifier_range_base.dart';
import 'package:rive_dart_importer/src/rive_core/animation/cubic_interpolator_component.dart';
import 'package:rive_dart_importer/src/rive_core/animation/interpolator.dart';
import 'package:rive_dart_importer/src/rive_core/text/text_modifier_group.dart';
import 'package:rive_dart_importer/src/rive_core/text/text_value_run.dart';

export 'package:rive_dart_importer/src/generated/text/text_modifier_range_base.dart';

enum TextRangeUnits { characters, charactersExcludingSpaces, words, lines }

enum TextRangeMode { add, subtract, multiply, min, max, difference }

enum TextRangeType { percentage, unitIndex }

enum TextRangeInterpolator { linear, cubic }

class TextModifierRange extends TextModifierRangeBase {
  TextModifierGroup? get modifierGroup =>
      parent is TextModifierGroup ? parent as TextModifierGroup : null;

  @override
  void modifyToChanged(double from, double to) => false;

  TextRangeInterpolator get interpolatorType =>
      _interpolator is CubicInterpolatorComponent
          ? TextRangeInterpolator.cubic
          : TextRangeInterpolator.linear;

  Interpolator? _interpolator;
  Interpolator? get interpolator => _interpolator;

  @override
  void update(int dirt) {}

  @override
  void onAddedDirty() {
    run = context.resolve(runId);
    super.onAddedDirty();
  }

  TextValueRun? _run;

  TextValueRun? get run => _run;

  set run(TextValueRun? value) {
    if (_run == value) {
      return;
    }

    _run = value;
  }

  @override
  void clampChanged(bool from, bool to) {}

  @override
  void falloffFromChanged(double from, double to) {}

  @override
  void falloffToChanged(double from, double to) {}

  @override
  void modeValueChanged(int from, int to) {}

  @override
  void modifyFromChanged(double from, double to) {}

  @override
  void offsetChanged(double from, double to) {}

  @override
  void runIdChanged(int from, int to) {}

  @override
  void strengthChanged(double from, double to) {}

  @override
  void typeValueChanged(int from, int to) {}

  @override
  void unitsValueChanged(int from, int to) {}
}

// See word indices and word lengths implementation above, we basically want the
// same thing but for different range types (Glyphs, Characters without spaces,
// lines, etc).
class RangeMapper {
  /// Each item in this list represents the index (in unicode codepoints) of the
  /// selectable element. Always has length 1+unitLengths.length as it's
  /// expected to always include the final index with 0 length.
  final Uint32List unitIndices;

  /// Each item in this list represents the length of the matching element at
  /// the same index in the _unitIndices list.
  final Uint32List unitLengths;

  int get unitCount => unitLengths.length;

  RangeMapper(List<int> indices, List<int> lengths)
      : assert(indices.length == lengths.length + 1),
        unitIndices = Uint32List.fromList(indices),
        unitLengths = Uint32List.fromList(lengths);

  double unitToCharacterRange(double word) {
    if (unitIndices.isEmpty) {
      return 0;
    }
    var clampedUnit = word.clamp(0, unitIndices.length - 1);
    var intUnit = clampedUnit.floor();
    double characters = unitIndices[intUnit].toDouble();
    if (intUnit < unitLengths.length) {
      var fraction = clampedUnit - intUnit;
      characters += unitLengths[intUnit] * fraction;
    }
    return characters;
  }
}
