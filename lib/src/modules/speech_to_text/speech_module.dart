import 'package:app_hospital/src/modules/speech_to_text/presenter/speech_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SpeechModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => SpeechPage());
  }
}
