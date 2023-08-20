import 'package:app_hospital/src/modules/speech_to_text/presenter/cubits/speech_state.dart';
import 'package:bloc/bloc.dart';

class SpeechCubit extends Cubit<SpeechState> {
  SpeechCubit() : super(InitialSpeechState());

  void startListening() {
    emit(RecordingSpeechState());
  }

  void stopListening() {}
}
