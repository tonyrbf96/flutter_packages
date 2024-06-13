import 'package:rive_dart_importer/src/generated/layout/layout_component_style_base.dart';

export 'package:rive_dart_importer/src/generated/layout/layout_component_style_base.dart';

class LayoutComponentStyle extends LayoutComponentStyleBase {
  void markLayoutNodeDirty() {}

  @override
  void buildDependencies() {
    super.buildDependencies();
    parent?.addDependent(this);
  }

  @override
  void onAdded() {}

  @override
  void onAddedDirty() {}

  @override
  void layoutFlags0Changed(int from, int to) {
    markLayoutNodeDirty();
  }

  @override
  void layoutFlags1Changed(int from, int to) {
    markLayoutNodeDirty();
  }

  @override
  void layoutFlags2Changed(int from, int to) {
    markLayoutNodeDirty();
  }

  @override
  void flexChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void flexGrowChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void flexShrinkChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void flexBasisChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void aspectRatioChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void minWidthChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void maxWidthChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void minHeightChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void maxHeightChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void gapHorizontalChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void gapVerticalChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void borderLeftChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void borderTopChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void borderRightChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void borderBottomChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void marginLeftChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void marginTopChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void marginRightChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void marginBottomChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void paddingLeftChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void paddingTopChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void paddingRightChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void paddingBottomChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void positionLeftChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void positionTopChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void positionRightChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void positionBottomChanged(double from, double to) => markLayoutNodeDirty();

  @override
  void update(int dirt) {}
}
