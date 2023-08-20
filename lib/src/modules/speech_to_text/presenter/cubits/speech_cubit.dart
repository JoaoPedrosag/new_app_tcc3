import 'package:app_hospital/src/modules/speech_to_text/presenter/cubits/speech_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechCubit extends Cubit<SpeechState> {
  SpeechCubit() : super(InitialSpeechState()) {
    _initSpeech();
  }

  final List<String> _wordsSpeech = [];

  List<String> get words => _wordsSpeech;

  final SpeechToText speechToText = SpeechToText();

  final TextEditingController textEditingController = TextEditingController();

  void _initSpeech() async {
    final speechEnabled = await speechToText.initialize();
    if (speechEnabled) {
      emit(InitialSpeechState());
    } else {
      emit(ErrorSpeechState(
          message: 'Erro ao inicializar o reconhecimento de voz'));
    }
  }

  Future<void> startListening() async {
    await speechToText.listen(
      onResult: _onSpeechResult,
      pauseFor: const Duration(seconds: 20),
      listenFor: const Duration(seconds: 60),
      localeId: 'pt_BR',
      cancelOnError: true,
    );
    emit(RecordingSpeechState());
  }

  void stopListening() async {
    await speechToText.stop();
    emit(InitialSpeechState());
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      textEditingController.text += "${result.recognizedWords} ";
      textEditingController.selection = TextSelection.fromPosition(
          TextPosition(offset: textEditingController.text.length));

      _wordsSpeech.add(result.recognizedWords);
      emit(RecognizedSpeechState(text: result.recognizedWords));
    }
  }

  void clearText() {
    textEditingController.clear();
    emit(ClearSpeechState());
  }
}
