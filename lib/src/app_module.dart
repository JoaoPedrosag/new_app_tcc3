import 'package:app_hospital/src/modules/recording/recording_module.dart';
import 'package:app_hospital/src/modules/records/records_module.dart';
import 'package:app_hospital/src/modules/splash/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => const SplashPage());
    r.module(
      '/recording',
      module: RecordingModule(),
      transition: TransitionType.downToUp,
      duration: const Duration(milliseconds: 700),
    );
    r.module(
      '/records',
      module: RecordsModule(),
      transition: TransitionType.downToUp,
      duration: const Duration(milliseconds: 700),
    );
  }
}
