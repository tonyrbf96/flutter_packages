import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/rive_core/artboard.dart';

/// An importer that will always resolve with the artboard importer.
abstract class ArtboardImportStackObject extends ImportStackObject {
  @override
  int get resolvesBefore => ArtboardBase.typeKey;
}
