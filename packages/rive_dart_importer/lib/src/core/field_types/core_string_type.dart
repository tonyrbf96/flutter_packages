import 'package:rive_dart_importer/src/core/field_types/core_field_type.dart';
import 'package:rive_dart_importer/src/utilities/utilities.dart';

class CoreStringType extends CoreFieldType<String> {
  @override
  String deserialize(BinaryReader reader) =>
      reader.readString(explicitLength: true);

  void read(BinaryReader reader) {
    var length = reader.readVarUint();
    reader.read(length);
  }
}
