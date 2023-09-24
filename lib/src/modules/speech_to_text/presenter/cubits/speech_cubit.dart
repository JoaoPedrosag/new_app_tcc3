import 'package:app_hospital/src/modules/speech_to_text/presenter/cubits/speech_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../repository/speech_impl.dart';

class SpeechCubit extends Cubit<SpeechState> {
  SpeechCubit() : super(InitialSpeechState()) {
    _initSpeech();
  }

  final List<String> _wordsSpeech = [];

  final bool openSession = false;

  List<String> get words => _wordsSpeech;

  final SpeechToText speechToText = SpeechToText();

  final saveFile = Modular.get<SpeechImpl>();

  String text = '';

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
    if (speechToText.isListening) {
      await speechToText.stop();
      emit(InitialSpeechState());
      return;
    }
    await speechToText.listen(
      onResult: _onSpeechResult,
      pauseFor: const Duration(seconds: 20),
      listenFor: const Duration(seconds: 60),
      localeId: 'pt_BR',
      cancelOnError: true,
    );
    text = '';
    emit(RecordingSpeechState());
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      text += "${result.recognizedWords} ";
      textEditingController.text += "${result.recognizedWords} ";
      textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: textEditingController.text.length),
      );

      _wordsSpeech.add(result.recognizedWords);
      emit(RecognizedSpeechState(text: result.recognizedWords));
    } else {
      text = "${result.recognizedWords} ";
      emit(RecordingSpeechState());
    }
  }

  void clearText() {
    textEditingController.clear();
    emit(ClearSpeechState());
  }

  void saveText() async {
    final text = textEditingController.text;
    final nameFile = DateTime.now().toString();
    await saveFile.saveFile(text: text, nameFile: nameFile);

    final string = await saveFile.readFile(nameFile: nameFile);

    print(string);
  }
}
