import 'package:rive_dart_importer/src/generated/animation/advanceable_state_base.dart';
export 'package:rive_dart_importer/src/generated/animation/advanceable_state_base.dart';

abstract class AdvanceableState extends AdvanceableStateBase {
  @override
  void speedChanged(double from, double to) {}
}
