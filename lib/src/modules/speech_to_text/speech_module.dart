import 'package:app_hospital/src/modules/speech_to_text/presenter/cubits/speech_cubit.dart';
import 'package:app_hospital/src/modules/speech_to_text/presenter/speech_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SpeechModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<SpeechCubit>(
      SpeechCubit.new,
      config: BindConfig(
        onDispose: (bloc) => bloc.close(),
      ),
    );
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => SpeechPage());
  }
}
