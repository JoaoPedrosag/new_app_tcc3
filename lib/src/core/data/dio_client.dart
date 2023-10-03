import 'package:dio/dio.dart';

abstract class IDioClient {
  Future get({required String url});
  Future post({required String url, required Map<String, dynamic> data});
  Future postFormData(
      {required String url, required Map<String, dynamic> data});
}

class DioClient implements IDioClient {
  final dio = Dio();

  @override
  Future post({required String url, required Map<String, dynamic> data}) async {
    return dio.post(url, data: data);
  }

  @override
  Future get({required String url}) async {
    return dio.get(url);
  }

  @override
  Future postFormData(
      {required String url, required Map<String, dynamic> data}) {
    FormData formData = FormData.fromMap(data);
    return dio.post(url, data: formData);
  }
}
