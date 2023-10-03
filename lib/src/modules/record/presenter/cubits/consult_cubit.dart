import 'package:app_hospital/src/modules/record/presenter/cubits/consult_state.dart';
import 'package:app_hospital/src/modules/record/repository/consult_impl.dart';
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
