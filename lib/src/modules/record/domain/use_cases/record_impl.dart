import 'dart:io';

import 'package:app_hospital/src/core/const/constantes.dart';
import 'package:app_hospital/src/core/data/dio_client.dart';
import 'package:app_hospital/src/core/repository/path_provider_impl.dart';
import 'package:app_hospital/src/modules/record/domain/interfaces/i_record.dart';
import 'package:dio/dio.dart';

class SpeechImpl extends ISpeech {
  final PathProviderImpl path;
  final DioClient dio;

  SpeechImpl({
    required this.path,
    required this.dio,
  });
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

  @override
  Future<bool> uploadFile(
      {required String path, required String nameFile}) async {
    try {
      File file = File(path);
      if (await file.exists()) {
        final formData = {
          'file': await MultipartFile.fromFile(path, filename: nameFile),
          'name': 'joao',
          'id': 2
        };

        final response = await dio.postFormData(
            url: Constants.endPoints.baseUrl + Constants.endPoints.upload,
            data: formData);
        print(response);
        if (response.statusCode == 200) {
          print(response.data['converted_text']);
          return true;
        }
        return false;
      } else {
        throw Exception(
            "O arquivo não foi encontrado no caminho especificado.");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
