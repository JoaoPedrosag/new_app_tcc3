import 'package:app_hospital/src/modules/record/record_module.dart';
import 'package:app_hospital/src/modules/splash/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => const SplashPage());
    r.module(
      '/record',
      module: SpeechModule(),
      transition: TransitionType.downToUp,
      duration: const Duration(milliseconds: 1000),
    );
  }
}
