// Core automatically generated
// lib/src/generated/animation/nested_trigger_base.dart.
// Do not modify manually.

import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/component_base.dart';
import 'package:rive_dart_importer/src/rive_core/animation/nested_input.dart';

abstract class NestedTriggerBase extends NestedInput {
  static const int typeKey = 122;
  @override
  int get coreType => NestedTriggerBase.typeKey;
  @override
  Set<int> get coreTypes => {
        NestedTriggerBase.typeKey,
        NestedInputBase.typeKey,
        ComponentBase.typeKey
      };

  /// --------------------------------------------------------------------------
  /// Fire field with key 401.
  static const int firePropertyKey = 401;
  void fire(CallbackData value);
}
