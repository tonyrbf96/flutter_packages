import 'dart:typed_data';

import 'package:rive_dart_importer/src/core/field_types/core_field_type.dart';
import 'package:rive_dart_importer/src/utilities/utilities.dart';

class CoreBytesType extends CoreFieldType<Uint8List> {
  @override
  Uint8List deserialize(BinaryReader reader) {
    var length = reader.readVarUint();
    return reader.read(length);
  }
}
