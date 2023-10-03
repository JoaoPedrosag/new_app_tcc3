import 'package:app_hospital/src/core/const/constantes.dart';
import 'package:app_hospital/src/core/data/dio_client.dart';
import 'package:app_hospital/src/modules/record/repository/i_consult.dart';
import 'package:app_hospital/src/modules/record/useCases/consults_request.dart';

class ConsultImpl extends IConsult {
  final DioClient dio;
  ConsultImpl({
    required this.dio,
  });
  @override
  Future<List<ConsultsRequest>> getConsults({required int id}) async {
    print('${Constants.endPoints.baseUrl}${Constants.endPoints.consults}$id/');
    try {
      var response = await dio.get(
          url:
              '${Constants.endPoints.baseUrl}${Constants.endPoints.consults}$id/');
      final List<ConsultsRequest> consults = response.data
          .map<ConsultsRequest>((e) => ConsultsRequest.fromJson(e))
          .toList();

      return consults;
    } on Exception {
      throw Exception('Erro ao buscar consultas');
    }
  }
}
