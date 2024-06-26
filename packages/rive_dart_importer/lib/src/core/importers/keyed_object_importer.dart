import 'package:rive_dart_importer/src/core/importers/artboard_import_stack_object.dart';
import 'package:rive_dart_importer/src/rive_core/animation/keyed_object.dart';
import 'package:rive_dart_importer/src/rive_core/animation/keyed_property.dart';

class KeyedObjectImporter extends ArtboardImportStackObject {
  final KeyedObject keyedObject;

  KeyedObjectImporter(this.keyedObject);

  void addKeyedProperty(KeyedProperty property) {
    keyedObject.context.addObject(property);
    keyedObject.internalAddKeyedProperty(property);
  }
}
