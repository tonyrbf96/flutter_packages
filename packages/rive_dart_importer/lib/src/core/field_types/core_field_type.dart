import 'package:rive_dart_importer/src/utilities/utilities.dart';

// ignore: one_member_abstracts
abstract class CoreFieldType<T extends Object> {
  T deserialize(BinaryReader reader);
  void skip(BinaryReader reader) => deserialize(reader);
}
