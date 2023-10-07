import 'package:app_hospital/src/modules/records/domain/use_cases/consult_impl.dart';
import 'package:app_hospital/src/modules/records/presenter/cubits/consults/consult_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConsultCubit extends Cubit<ConsultState> {
  ConsultCubit() : super(ConsultInitial());

  final consultRepository = Modular.get<ConsultImpl>();

  Future<void> getConsults() async {
    emit(ConsultLoading());
    try {
      final consults = await consultRepository.getConsults(id: 2);
      emit(ConsultSuccess(consults: consults));
    } catch (e) {
      emit(ConsultFailure(message: e.toString()));
    }
  }
}
