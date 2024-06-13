import 'dart:io';
import 'dart:typed_data';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:rive_dart_importer/rive.dart';

class RiveGenerator extends Generator {
  const RiveGenerator();
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    File file = File('assets/walking_working.riv');
    if (!file.existsSync()) {
      throw Exception('File not found');
    }
    final bytes = file.readAsBytesSync();
    final length = bytes.length;
    try {
      final riveFile = RiveFile.import(ByteData.view(bytes.buffer));

      return '''// Rive file: ${file.path}
    
    const mainArtboard =  '${riveFile.mainArtboard.name}';
    const stateMachine = '${riveFile.mainArtboard.stateMachines.first.name}';
    const foo = "The file is $length bytes long.";
    ''';
    } on RiveFormatErrorException catch (e, stacktrace) {
      print(e.cause);
      // print trace
      print(stacktrace);
    } catch (e) {
      print('Error: $e');
    }

    return '';
  }
}
