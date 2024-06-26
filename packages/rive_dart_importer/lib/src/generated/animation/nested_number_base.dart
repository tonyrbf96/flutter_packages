// Core automatically generated
// lib/src/generated/animation/nested_number_base.dart.
// Do not modify manually.

import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/component_base.dart';
import 'package:rive_dart_importer/src/rive_core/animation/nested_input.dart';

abstract class NestedNumberBase extends NestedInput {
  static const int typeKey = 124;
  @override
  int get coreType => NestedNumberBase.typeKey;
  @override
  Set<int> get coreTypes => {
        NestedNumberBase.typeKey,
        NestedInputBase.typeKey,
        ComponentBase.typeKey
      };

  /// --------------------------------------------------------------------------
  /// NestedValue field with key 239.
  static const int nestedValuePropertyKey = 239;
  static const double nestedValueInitialValue = 0;
  double _nestedValue = nestedValueInitialValue;
  double get nestedValue => _nestedValue;

  /// Change the [_nestedValue] field value.
  /// [nestedValueChanged] will be invoked only if the field's value has
  /// changed.
  set nestedValue(double value) {
    if (_nestedValue == value) {
      return;
    }
    double from = _nestedValue;
    _nestedValue = value;
    if (hasValidated) {
      nestedValueChanged(from, value);
    }
  }

  void nestedValueChanged(double from, double to);

  @override
  void copy(Core source) {
    super.copy(source);
    if (source is NestedNumberBase) {
      _nestedValue = source._nestedValue;
    }
  }
}
