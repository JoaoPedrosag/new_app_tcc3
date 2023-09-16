import 'dart:io';

import 'package:app_hospital/src/core/repository/path_provider_impl.dart';
import 'package:app_hospital/src/modules/speech_to_text/repository/i_speech.dart';

class SpeechImpl extends ISpeech {
  final PathProviderImpl path;

  SpeechImpl({required this.path});
  @override
  Future<bool> saveFile(
      {required String text, required String nameFile}) async {
    try {
      final pathTemp = await path.getLocalPath();
      final directory = Directory(pathTemp);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      File file = File('$pathTemp/$nameFile.txt');
      await file.writeAsString(text);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> readFile({required String nameFile}) async {
    try {
      final pathTemp = await path.getLocalPath();
      File file = File('$pathTemp/$nameFile.txt');
      if (await file.exists()) {
        // O arquivo existe, então você pode lê-lo.
        return file.readAsString();
      } else {
        throw Exception(
            "O arquivo não foi encontrado no caminho especificado.");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
