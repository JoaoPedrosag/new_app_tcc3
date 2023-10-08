import 'dart:io';

import 'package:app_hospital/src/core/const/constantes.dart';
import 'package:app_hospital/src/core/data/dio_client.dart';
import 'package:app_hospital/src/modules/recording/domain/interfaces/i_record.dart';
import 'package:dio/dio.dart';

class SpeechImpl extends ISpeech {
  final DioClient dio;

  SpeechImpl({
    required this.dio,
  });

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

        if (response.statusCode == 200) {
          return true;
        }
        return false;
      } else {
        throw Exception("Arquivo não existe");
      }
    } catch (e) {
      throw Exception("Erro ao fazer upload do arquivo: ${e.toString()}");
    }
  }
}
