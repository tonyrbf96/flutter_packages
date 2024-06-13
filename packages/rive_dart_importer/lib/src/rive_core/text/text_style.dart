import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/text/text_style_base.dart';
import 'package:rive_dart_importer/src/rive_core/artboard.dart';
import 'package:rive_dart_importer/src/rive_core/assets/file_asset.dart';
import 'package:rive_dart_importer/src/rive_core/assets/font_asset.dart';
import 'package:rive_dart_importer/src/rive_core/component.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/paint/shape_paint.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/paint/shape_paint_mutator.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/shape_paint_container.dart';
import 'package:rive_dart_importer/src/rive_core/text/text.dart';
import 'package:rive_dart_importer/src/rive_core/text/text_style_axis.dart';
import 'package:rive_dart_importer/src/rive_core/text/text_style_feature.dart';
import 'package:rive_dart_importer/src/rive_core/text/text_value_run.dart';
export 'package:rive_dart_importer/src/generated/text/text_style_base.dart';

class TextVariationHelper extends Component {
  final TextStyle style;
  @override
  Artboard? get artboard => style.artboard;

  TextVariationHelper(this.style) {
    style.markRebuildDependencies();
  }

  @override
  void update(int dirt) {}

  void dispose() {}

  @override
  void buildDependencies() {
    var text = style.text;
    if (text != null) {
      text.artboard?.addDependent(this);
      addDependent(text);
    }
  }
}

class TextStyle extends TextStyleBase
    with ShapePaintContainer, FileAssetReferencer<FontAsset> {
  final Set<TextValueRun> _referencers = {};
  Text? get text => parent as Text?;
  final Set<TextStyleAxis> _variations = {};
  final Set<TextStyleFeature> _features = {};
  Iterable<TextStyleAxis> get variations => _variations;
  Iterable<TextStyleFeature> get features => _features;

  List<ShapePaint> get shapePaints =>
      fills.cast<ShapePaint>().toList() + strokes.cast<ShapePaint>().toList();

  /// An identifier used by the shaper to remap style ids as text runs are
  /// converted to glyph runs.
  int shaperId = -1;

  @override
  void fontSizeChanged(double from, double to) {
    _markShapeDirty();
  }

  @override
  void letterSpacingChanged(double from, double to) {
    _markShapeDirty();
  }

  void _markShapeDirty() {
    for (final run in _referencers) {
      run.markShapeDirty();
    }
  }

  @override
  void update(int dirt) {}

  /// Let the style know that a run references it.
  void ref(TextValueRun run) {
    _referencers.add(run);
  }

  void deref(TextValueRun run) {
    _referencers.remove(run);
  }

  @override
  String toString() => 'TextStyle(id: $id, size: $fontSize'
      ')';

  @override
  void buildDependencies() {
    parent?.addDependent(this);
  }

  void removeVariations() => _variations.toSet().forEach(context.removeObject);

  @override
  set asset(FontAsset? value) {
    if (asset == value) {
      return;
    }

    super.asset = value;
  }

  @override
  void copy(covariant TextStyle source) {
    super.copy(source);
    asset = source.asset;
  }

  @override
  void fontAssetIdChanged(int from, int to) {
    asset = context.resolve(to);
  }

  @override
  void onDirty(int mask) {
    super.onDirty(mask);
  }

  @override
  void onFillsChanged() {}

  @override
  void onPaintMutatorChanged(ShapePaintMutator mutator) {}

  @override
  void onStrokesChanged() {}

  @override
  void childAdded(Component component) {
    super.childAdded(component);
  }

  @override
  void childRemoved(Component component) {}

  @override
  void onRemoved() {
    super.onRemoved();
  }

  @override
  int get assetId => fontAssetId;

  @override
  set assetId(int value) => fontAssetId = value;

  @override
  int get assetIdPropertyKey => TextStyleBase.fontAssetIdPropertyKey;

  @override
  bool import(ImportStack stack) {
    if (!registerWithImporter(stack)) {
      return false;
    }
    return super.import(stack);
  }

  @override
  void lineHeightChanged(double from, double to) {
    _markShapeDirty();
  }
}
