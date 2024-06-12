import 'package:rive_dart_importer/src/core/field_types/core_field_type.dart';
import 'package:rive_dart_importer/src/utilities/utilities.dart';

class CoreBoolType extends CoreFieldType<bool> {
  @override
  bool deserialize(BinaryReader reader) => reader.readInt8() == 1;
}
