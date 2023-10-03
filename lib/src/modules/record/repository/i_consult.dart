import 'package:app_hospital/src/modules/record/useCases/consults_request.dart';

abstract class IConsult {
  Future<List<ConsultsRequest>> getConsults({required int id});
}
