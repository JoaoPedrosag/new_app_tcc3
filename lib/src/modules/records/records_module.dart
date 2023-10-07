import 'package:app_hospital/src/core/data/dio_client.dart';
import 'package:app_hospital/src/core/repository/path_provider_impl.dart';
import 'package:app_hospital/src/modules/records/domain/use_cases/consult_impl.dart';
import 'package:app_hospital/src/modules/records/presenter/cubits/consults/consult_cubit.dart';
import 'package:app_hospital/src/modules/records/presenter/cubits/player/player_cubit.dart';
import 'package:app_hospital/src/modules/records/presenter/pages/records_patients_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RecordsModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<ConsultCubit>(
      ConsultCubit.new,
      config: BindConfig(
        onDispose: (bloc) => bloc.close(),
      ),
    );
    i.addSingleton<PlayerCubit>(
      PlayerCubit.new,
      config: BindConfig(
        onDispose: (bloc) => bloc.close(),
      ),
    );
    i.add(PathProviderImpl.new);
    i.addSingleton(DioClient.new);
    i.addSingleton<ConsultImpl>(
      ConsultImpl.new,
    );
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const RecordsPatientPage(),
    );
  }
}
