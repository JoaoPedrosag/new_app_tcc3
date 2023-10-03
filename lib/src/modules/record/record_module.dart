import 'package:app_hospital/src/core/data/dio_client.dart';
import 'package:app_hospital/src/core/repository/path_provider_impl.dart';
import 'package:app_hospital/src/modules/record/domain/use_cases/consult_impl.dart';
import 'package:app_hospital/src/modules/record/domain/use_cases/record_impl.dart';
import 'package:app_hospital/src/modules/record/presenter/cubits/consult_cubit.dart';
import 'package:app_hospital/src/modules/record/presenter/cubits/speech_cubit.dart';
import 'package:app_hospital/src/modules/record/presenter/pages/record_page.dart';
import 'package:app_hospital/src/modules/record/presenter/pages/records_patients_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SpeechModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<RecordCubit>(
      RecordCubit.new,
      config: BindConfig(
        onDispose: (bloc) => bloc.close(),
      ),
    );
    i.addSingleton<ConsultCubit>(
      ConsultCubit.new,
      config: BindConfig(
        onDispose: (bloc) => bloc.close(),
      ),
    );
    i.add(PathProviderImpl.new);
    i.addSingleton(SpeechImpl.new);
    i.addSingleton(DioClient.new);
    i.addSingleton<ConsultImpl>(
      ConsultImpl.new,
    );
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const RecordPage(),
    );
    r.child('/records_patient', child: (context) => const RecordsPatientPage());
  }
}
