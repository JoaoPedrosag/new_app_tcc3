import 'package:app_hospital/src/modules/record/domain/entities/consults_request.dart';

abstract class IConsult {
  Future<List<ConsultsRequest>> getConsults({required int id});
}
