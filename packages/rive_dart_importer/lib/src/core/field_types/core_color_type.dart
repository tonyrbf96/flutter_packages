import 'package:rive_dart_importer/src/core/field_types/core_field_type.dart';
import 'package:rive_dart_importer/src/utilities/utilities.dart';

class CoreColorType extends CoreFieldType<int> {
  @override
  int deserialize(BinaryReader reader) => reader.readUint32();
}
