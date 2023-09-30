import 'package:app_hospital/src/modules/speech_to_text/presenter/cubits/speech_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../repository/speech_impl.dart';

class SpeechCubit extends Cubit<SpeechState> {
  final FlutterSoundRecorder _myRecorder = FlutterSoundRecorder();
  SpeechCubit() : super(InitialSpeechState()) {
    _initSpeech();
  }

  final List<String> _wordsSpeech = [];

  final bool openSession = false;

  List<String> get words => _wordsSpeech;

  final SpeechToText speechToText = SpeechToText();

  String text = '';

  final TextEditingController textEditingController = TextEditingController();

  final voiceRepository = Modular.get<SpeechImpl>();

  void _initSpeech() async {
    await _myRecorder.openRecorder();
    emit(InitialSpeechState());
  }

  // Future<void> startListening() async {
  //   if (speechToText.isListening) {
  //     await speechToText.stop();
  //     emit(InitialSpeechState());
  //     return;
  //   }
  //   await speechToText.listen(
  //     onResult: _onSpeechResult,
  //     pauseFor: const Duration(seconds: 20),
  //     listenFor: const Duration(seconds: 60),
  //     localeId: 'pt_BR',
  //     cancelOnError: true,
  //   );
  //   text = '';
  //   emit(RecordingSpeechState());
  // }

  Future<void> startRecording() async {
    if (_myRecorder.isRecording) {
      await _myRecorder.stopRecorder();
      emit(InitialSpeechState());
      return;
    }
    final String nameFile = DateTime.now().toString();
    await _myRecorder.startRecorder(
      toFile: '/data/user/0/com.example.app_hospital/app_flutter/$nameFile.wav',
      codec: Codec.defaultCodec,
    );
    print('/data/user/0/com.example.app_hospital/app_flutter/$nameFile.wav');
    emit(RecordingSpeechState());
  }

  Future<void> uploadFile() {
    return voiceRepository.uploadFile(
      path:
          '/data/user/0/com.example.app_hospital/app_flutter/2023-09-30 13:23:36.879714.wav',
      nameFile: '2023-09-30 13:23:36.879714.wav',
    );
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
    await voiceRepository.saveFile(text: text, nameFile: nameFile);

    final string = await voiceRepository.readFile(nameFile: nameFile);

    print(string);
  }

  void closeRecorder() async {
    await _myRecorder.closeRecorder();
    emit(InitialSpeechState());
  }
}
