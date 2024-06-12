import 'package:rive_dart_importer/src/generated/bones/tendon_base.dart';
import 'package:rive_dart_importer/src/rive_core/bones/skeletal_component.dart';

export 'package:rive_dart_importer/src/generated/bones/tendon_base.dart';

class Tendon extends TendonBase {
  SkeletalComponent? _bone;
  SkeletalComponent? get bone => _bone;

  @override
  void boneIdChanged(int from, int to) {
    // This never happens, or at least it should only happen prior to an
    // onAddedDirty call.
  }

  @override
  void onAddedDirty() {
    super.onAddedDirty();
    _bone = context.resolve(boneId);
  }

  @override
  void update(int dirt) {}

  @override
  void txChanged(double from, double to) {}

  @override
  void tyChanged(double from, double to) {}

  @override
  void xxChanged(double from, double to) {}

  @override
  void xyChanged(double from, double to) {}

  @override
  void yxChanged(double from, double to) {}

  @override
  void yyChanged(double from, double to) {}
}
