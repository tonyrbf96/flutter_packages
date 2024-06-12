import 'package:rive_dart_importer/src/generated/bones/weight_base.dart';

export 'package:rive_dart_importer/src/generated/bones/weight_base.dart';

class Weight extends WeightBase {
  @override
  void indicesChanged(int from, int to) {}

  @override
  void update(int dirt) {
    // Intentionally empty. Weights don't update.
  }

  @override
  void valuesChanged(int from, int to) {}

  static int encodedWeightValue(int index, int data) {
    return (data >> (index * 8)) & 0xFF;
  }
}
